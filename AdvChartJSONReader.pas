{********************************************************************}
{                                                                    }
{ written by TMS Software                                            }
{            copyright (c) 2017 - 2021                               }
{            Email : info@tmssoftware.com                            }
{            Web : http://www.tmssoftware.com                        }
{                                                                    }
{ The source code is given as is. The author is not responsible      }
{ for any possible damage done due to the use of this code.          }
{ The complete source code remains property of the author and may    }
{ not be distributed, published, given or sold in any form as such.  }
{ No parts of the source code can be included in any other component }
{ or application without written authorization of the author.        }
{********************************************************************}

unit AdvChartJSONReader;

{$I TMSDEFS.inc}

{$IFDEF WEBLIB}
{$DEFINE LCLWEBLIB}
{$ENDIF}

{$IFDEF LCLLIB}
{$DEFINE LCLWEBLIB}
{$ENDIF}

{$SCOPEDENUMS ON}
{$INLINE ON}{$R-}{$Q-}

interface

uses
  {$IFNDEF LCLWEBLIB}
  Generics.Collections,
  {$ENDIF}
  Classes, SysUtils, AdvChartTypes;

type
  TAdvChartJSONStreamReader = class
  public
    type
      EInvalidJsonInput = class(Exception)
      public
        constructor Create;
      end;
      EInternalError = class(Exception)
      public
        constructor Create;
      end;
      EEndOfInputReached = class(Exception)
      public
        constructor Create;
      end;
  private
  var
    FStream: TStream;
    FReadStream: TStringStream;
  public
    constructor Create(const aStream: TStream);
    destructor Destroy; override;
    function NextChar: char; inline;
    function PeekChar: char; inline;
    function ReadChar: char; inline;
    procedure Backup(const {%H-}c: char);
    procedure MoveNext(const Count: integer = 1); inline;
    function Eof: boolean; inline;
  end;

  TAdvChartJSONToken = (jstoBeginObject, jstoEndObject, jstoBeginArray, jstoEndArray,
    jstoName, jstoBoolean, jstoNull, jstoText, jstoNumber, jstoEOF);

  TAdvChartJSONReader = class
  private
    type
      TAdvChartJSONState = (jstNone, jstBeginObject, jstEndObject, jstBeginArray, jstEndArray, jstTrue, jstFalse,
        jstNull, jstDoubleQuoted, jstBuffered, jstDoubleQuotedName, jstInt64, jstNumber, jstEOF);
      TAdvChartJSONNumberState = (jnstNone, jnstSign, jnstDigit, jnstDecimal, jnstFraction, jnstExpE, jnstExpSign, jnstExpDigit);
      TAdvChartJSONScope = (jscEmptyDocument, jscEmptyArray, jscEmptyObject, jscNonEmptyDocument,
        jscNonEmptyArray, jscNonEmptyObject, jscDanglingName);
  public
    type
      EInvalidStateException = class(Exception)
      public
        constructor Create(const AState: TAdvChartJSONState);
      end;
      EUnterminatedArray = class(Exception)
      public
        constructor Create;
      end;
      EUnterminatedObject = class(Exception)
      public
        constructor Create;
      end;
      ENameExpected = class(Exception)
      public
        constructor Create;
      end;
      EColonExpected = class(Exception)
      public
        constructor Create;
      end;
      EReaderClosed = class(Exception)
      public
        constructor Create;
      end;
      EMultipleRootNotAllowed = class(Exception)
      public
        constructor Create;
      end;
      EExpectedValue = class(Exception)
      public
        constructor Create;
      end;
      EObjectOrArrayExpected = class(Exception)
      public
        constructor Create;
      end;
      ETooManyDepthLevels = class(Exception)
      public
        constructor Create;
      end;
      EInvalidEscaped = class(Exception)
      public
        constructor Create;
      end;
    const
      MaxNumberBuffer = 255;
      MaxStackSize = 255;
  private
    FReader: TAdvChartJSONStreamReader;
    FStack: array[0..MaxStackSize] of TAdvChartJSONScope;
    FStackSize: integer;
    FPeeked: TAdvChartJSONState;
    FPeekedInt64: Int64;
    FPeekedNumber: array[0..MaxNumberBuffer] of Char;
    FPeekedString: string;
    function NextPeek: TAdvChartJSONState; inline;
    procedure CheckState(const State: TAdvChartJSONState); inline;
    procedure SkipChar;
    function IsLiteral(C: Char): boolean;
    function IsDigit(C: Char): boolean; inline;
    function DoPeek: TAdvChartJSONState;
    procedure PushScope(const Scope: TAdvChartJSONScope);
    function NextNonWhitespace: Char;
    function ReadChar: Char;
    function PeekKeyword: TAdvChartJSONState;
    function PeekNumber: TAdvChartJSONState;
    function InternalReadQuoted(const BuildString: boolean): string;
    function ReadQuoted: string;
    procedure SkipQuoted;
  private
    function SkipWhitespaceUntilEnd: boolean;
  public
    constructor Create(const AStream: TStream);
    destructor Destroy; override;
    procedure ReadBeginArray;
    procedure ReadEndArray;
    procedure ReadBeginObject;
    procedure ReadEndObject;
    function PeekName: string;
    function ReadName: string;
    function ReadString: string;
    function ReadBoolean: boolean;
    function ReadDouble: double;
    function ReadInt64: Int64;
    function ReadInteger: integer;
    procedure SkipValue;
    procedure ReadNull;
    function HasNext: boolean;
    function Peek: TAdvChartJSONToken;
    function IsNull: boolean;
    function Eof: boolean;
  end;

implementation

uses
  AdvChartUtils;

const
  Wspace: Set of byte = [$20, $A, $D, $9, $C];

{$IFNDEF LCLLIB}
const
  FPC_FULLVERSION = 0;
{$ENDIF}

function ArrayOfCharToString(AArray: array of char): string;
{$IFDEF WEBLIB}
var
  I: Integer;
{$ENDIF}
begin
  {$IFDEF WEBLIB}
  Result := '';
  for I := 0 to Length(AArray) - 1 do
  begin
    if AArray[I] = #0 then
      Break;

    Result := Result + AArray[I];
  end;
  {$ENDIF}
  {$IFNDEF WEBLIB}
  Result := string(AArray);
  {$ENDIF}
end;

{ TAdvChartJSONReader }

constructor TAdvChartJSONReader.Create(const aStream: TStream);
begin
  inherited Create;
  FReader := TAdvChartJSONStreamReader.Create(aStream);
  FPeeked := TAdvChartJSONState.jstNone;
  FStack[0] := TAdvChartJSONScope.jscEmptyDocument;
  FStackSize := 1;
end;

destructor TAdvChartJSONReader.Destroy;
begin
  FReader.Free;
  inherited;
end;

function TAdvChartJSONReader.Eof: boolean;
begin
  Result := (Peek = TAdvChartJSONToken.jstoEOF);
end;

function TAdvChartJSONReader.Peek: TAdvChartJSONToken;
begin
  case NextPeek of
    TAdvChartJSONState.jstBeginObject:
      Result := TAdvChartJSONToken.jstoBeginObject;

    TAdvChartJSONState.jstEndObject:
      Result := TAdvChartJSONToken.jstoEndObject;

    TAdvChartJSONState.jstBeginArray:
      Result := TAdvChartJSONToken.jstoBeginArray;

    TAdvChartJSONState.jstEndArray:
      Result := TAdvChartJSONToken.jstoEndArray;

    TAdvChartJSONState.jstDoubleQuotedName:
      Result := TAdvChartJSONToken.jstoName;

    TAdvChartJSONState.jstTrue,
    TAdvChartJSONState.jstFalse:
      Result := TAdvChartJSONToken.jstoBoolean;

    TAdvChartJSONState.jstNull:
      Result := TAdvChartJSONToken.jstoNull;

    TAdvChartJSONState.jstDoubleQuoted,
    TAdvChartJSONState.jstBuffered:
      Result := TAdvChartJSONToken.jstoText;

    TAdvChartJSONState.jstInt64,
    TAdvChartJSONState.jstNumber:
      Result := TAdvChartJSONToken.jstoNumber;

    TAdvChartJSONState.jstEOF:
      Result := TAdvChartJSONToken.jstoEOF;
  else
    Assert(false);
    Result := TAdvChartJSONToken.jstoEOF;
  end;
end;

function TAdvChartJSONReader.PeekKeyword: TAdvChartJSONState;
begin
  case FReader.PeekChar of
    't', 'T':
      begin
        FReader.MoveNext;
        case FReader.NextChar of
          'r', 'R': case FReader.NextChar of
            'u', 'U': case FReader.NextChar of
              'e', 'E':
                if FReader.EOF or not IsLiteral(FReader.PeekChar) then
                  Exit(TAdvChartJSONState.jstTrue);
            end;
          end;
        end;
      end;
    'f', 'F':
      begin
        FReader.MoveNext;
        case FReader.NextChar of
          'a', 'A': case FReader.NextChar of
            'l', 'L': case FReader.NextChar of
              's', 'S': case FReader.NextChar of
                'e', 'E':
                  if FReader.EOF or not IsLiteral(FReader.PeekChar) then
                    Exit(TAdvChartJSONState.jstFalse);
              end;
            end;
          end;
        end;
      end;
    'n', 'N':
      begin
        FReader.MoveNext;
        case FReader.NextChar of
          'u', 'U': case FReader.NextChar of
            'l', 'L': case FReader.NextChar of
              'l', 'L':
                if FReader.EOF or not IsLiteral(FReader.PeekChar) then
                  Exit(TAdvChartJSONState.jstNull);
            end;
          end;
        end;
      end;
  else
    Exit(TAdvChartJSONState.jstNone);
  end;
  raise EExpectedValue.Create;
end;

function TAdvChartJSONReader.PeekName: string;
var
  p: Int64;
begin
  p := FReader.FReadStream.Position;
  Result := ReadQuoted;
  FReader.FReadStream.Position := p;
end;

function TAdvChartJSONReader.PeekNumber: TAdvChartJSONState;
const
  MinIncompleteInteger = Low(Int64) div 10;
var
  Last: TAdvChartJSONNumberState;
  Negative: boolean;
  FitsInInt64: boolean;
  Value: Int64;
  NewValue: Int64;
  C: Char;
  BufIndex: integer;
begin
  C := FReader.PeekChar;
  if (C <> '-') and not IsDigit(C) then
    Exit(TAdvChartJSONState.jstNone);

  Negative := false;
  FitsInInt64 := true;
  Last := TAdvChartJSONNumberState.jnstNone;
  BufIndex := 0;
  Value := -1;
  repeat
    if BufIndex >= MaxNumberBuffer then
      raise EExpectedValue.Create;
    C := FReader.NextChar;
    FPeekedNumber[BufIndex] := C;
    Inc(BufIndex);
    case C of
      '-':
        if Last = TAdvChartJSONNumberState.jnstNone then
        begin
          Negative := true;
          Last := TAdvChartJSONNumberState.jnstSign;
          Continue;
        end
        else
        if Last = TAdvChartJSONNumberState.jnstExpE then
        begin
          Last := TAdvChartJSONNumberState.jnstExpSign;
          Continue;
        end
        else
          raise EExpectedValue.Create;
      '+':
        if Last = TAdvChartJSONNumberState.jnstExpE then
        begin
          Last := TAdvChartJSONNumberState.jnstExpSign;
          Continue;
        end
        else
          raise EExpectedValue.Create;
      'e', 'E':
        if Last in [TAdvChartJSONNumberState.jnstDigit, TAdvChartJSONNumberState.jnstFraction] then
        begin
          Last := TAdvChartJSONNumberState.jnstExpE;
          Continue;
        end
        else
          raise EExpectedValue.Create;
      '.':
        if Last = TAdvChartJSONNumberState.jnstDigit then
        begin
          Last := TAdvChartJSONNumberState.jnstDecimal;
          Continue;
        end
        else
          raise EExpectedValue.Create;
    else
      if not IsDigit(C) then
        if not IsLiteral(C) then
        begin
          FReader.Backup(C);
          Dec(BufIndex);
          Break;
        end
        else
          raise EExpectedValue.Create;

      if Last in [TAdvChartJSONNumberState.jnstSign, TAdvChartJSONNumberState.jnstNone] then
      begin
        Value := -(Ord(C) - 48);
        Last := TAdvChartJSONNumberState.jnstDigit
      end
      else
      if Last = TAdvChartJSONNumberState.jnstDigit then
      begin
        if Value = 0 then
          raise EExpectedValue.Create;
        NewValue := Value * 10 - (Ord(C) - 48);
        FitsInInt64 := FitsInInt64 and (
            (Value > MinIncompleteInteger)
             or ((Value = MinIncompleteInteger) and (NewValue < Value))
          );
        Value := NewValue;
      end
      else
      if Last = TAdvChartJSONNumberState.jnstDecimal then
        Last := TAdvChartJSONNumberState.jnstFraction
      else
      if Last in [TAdvChartJSONNumberState.jnstExpE, TAdvChartJSONNumberState.jnstExpSign] then
        Last := TAdvChartJSONNumberState.jnstExpDigit;
    end;
  until false;

  if (Last = TAdvChartJSONNumberState.jnstDigit) and FitsInInt64 and ((Value <> Low(Int64)) or Negative) then
  begin
    if Negative then
      FPeekedInt64 := Value
    else
      FPeekedInt64 := -Value;
    Exit(TAdvChartJSONState.jstInt64);
  end
  else
  if Last in [TAdvChartJSONNumberState.jnstDigit, TAdvChartJSONNumberState.jnstFraction, TAdvChartJSONNumberState.jnstExpDigit] then
  begin
    FPeekedNumber[BufIndex] := #0;
    Exit(TAdvChartJSONState.jstNumber);
  end
  else
    raise EExpectedValue.Create;
end;

procedure TAdvChartJSONReader.PushScope(const Scope: TAdvChartJSONScope);
begin
  if FStackSize > MaxStackSize then
    raise ETooManyDepthLevels.Create;
  FStack[FStackSize] := Scope;
  Inc(FStackSize);
end;

function TAdvChartJSONReader.HasNext: boolean;
begin
  Result := not (NextPeek in [TAdvChartJSONState.jstEndObject, TAdvChartJSONState.jstEndArray]);
end;

function TAdvChartJSONReader.IsDigit(C: Char): boolean;
begin
  Result := (C <= #255) and CharIsNumber(C);
end;

function TAdvChartJSONReader.IsLiteral(C: Char): boolean;
begin
  Result := not TAdvChartUtils.CharInSet(C, TAdvChartUtils.CreateCharSet('/\;#{}[]:,'' '#13#10#12#9));
end;

function TAdvChartJSONReader.IsNull: boolean;
begin
  Result := (Peek = TAdvChartJSONToken.jstoNull);
end;

function TAdvChartJSONReader.NextNonWhitespace: Char;
var
  s: Char;
  p: Int64;
begin
  p := FReader.FReadStream.Position;
  Result := #0;
  s := ReadChar;
  repeat
    if (s > #32) or not (Ord(s) in Wspace) then
    begin
      FReader.FReadStream.Position := p;
      Exit(s);
    end;

    s := ReadChar;
  until FReader.Eof;
  FReader.FReadStream.Position := p;
end;

function TAdvChartJSONReader.NextPeek: TAdvChartJSONState;
begin
  if FPeeked = TAdvChartJSONState.jstNone then
    FPeeked := DoPeek;
  Result := FPeeked;
end;

procedure TAdvChartJSONReader.SkipQuoted;
begin
  InternalReadQuoted(false);
end;

procedure TAdvChartJSONReader.SkipValue;
var
  Count: integer;
begin
  Count := 0;
  repeat
    case NextPeek of
      TAdvChartJSONState.jstBeginArray:
        begin
          PushScope(TAdvChartJSONScope.jscEmptyArray);
          Inc(Count);
        end;
      TAdvChartJSONState.jstBeginObject:
        begin
          PushScope(TAdvChartJSONScope.jscEmptyObject);
          Inc(Count);
        end;
      TAdvChartJSONState.jstEndArray, TAdvChartJSONState.jstEndObject:
        begin
          Dec(FStackSize);
          Dec(Count);
        end;
      TAdvChartJSONState.jstDoubleQuoted, TAdvChartJSONState.jstDoubleQuotedName:
        SkipQuoted;
    end;
    FPeeked := TAdvChartJSONState.jstNone;
  until Count <= 0;
end;

procedure TAdvChartJSONReader.SkipChar;
begin
  FReader.MoveNext;
  while Ord(FReader.PeekChar) in Wspace do
    FReader.MoveNext;
end;

function TAdvChartJSONReader.DoPeek: TAdvChartJSONState;
var
  FPeekStack: TAdvChartJSONScope;
  C: Char;
begin
  FPeekStack := FStack[FStackSize - 1];
  if FPeekStack = TAdvChartJSONScope.jscEmptyArray then
    FStack[FStackSize - 1] := TAdvChartJSONScope.jscNonEmptyArray
  else
  if FPeekStack = TAdvChartJSONScope.jscNonEmptyArray then
  begin
    C := NextNonWhitespace;
    case C of
      ']':
        begin
          SkipChar;
          FPeeked := TAdvChartJSONState.jstEndArray;
          Exit(FPeeked);
        end;
      ',':
         SkipChar;
    else
      raise EUnterminatedArray.Create;
    end;
  end
  else
  if FPeekStack in [TAdvChartJSONScope.jscEmptyObject, TAdvChartJSONScope.jscNonEmptyObject] then
  begin
    FStack[FStackSize - 1] := TAdvChartJSONScope.jscDanglingName;
    if FPeekStack = TAdvChartJSONScope.jscNonEmptyObject then
    begin
      C := NextNonWhitespace;
      case C of
        '}':
          begin
            while Ord(FReader.PeekChar) in Wspace do
              FReader.MoveNext;

            SkipChar;
            FPeeked := TAdvChartJSONState.jstEndObject;
            Exit(FPeeked);
          end;
        ',': SkipChar;
      else
        raise EUnterminatedObject.Create;
      end;
    end;
    C := NextNonWhitespace;
    case C of
      '"':
        begin
          SkipChar;
          FPeeked := TAdvChartJSONState.jstDoubleQuotedName;
          Exit(FPeeked);
        end;
      '}':
        if FPeekStack <> TAdvChartJSONScope.jscNonEmptyObject then
        begin
          SkipChar;
          FPeeked := TAdvChartJSONState.jstEndObject;
          Exit(FPeeked);
        end else
          raise ENameExpected.Create;
    else
      raise ENameExpected.Create;
    end;
  end
  else
  if FPeekStack = TAdvChartJSONScope.jscDanglingName then
  begin
    FStack[FStackSize - 1] := TAdvChartJSONScope.jscNonEmptyObject;
    C := NextNonWhitespace;
    if C = ':' then
      SkipChar
    else
      raise EColonExpected.Create;
  end
  else
  if FPeekStack = TAdvChartJSONScope.jscEmptyDocument then
    FStack[FStackSize - 1] := TAdvChartJSONScope.jscNonEmptyDocument
  else
  if FPeekStack = TAdvChartJSONScope.jscNonEmptyDocument then
  begin
    if SkipWhitespaceUntilEnd then
    begin
      FPeeked := TAdvChartJSONState.jstEOF;
      Exit(FPeeked);
    end else
      raise EMultipleRootNotAllowed.Create;
  end;

  C := NextNonWhitespace;
  case C of
    ']':
      if FPeekStack = TAdvChartJSONScope.jscEmptyArray then
      begin
        SkipChar;
        FPeeked := TAdvChartJSONState.jstEndArray;
        Exit(FPeeked);
      end else
        raise EExpectedValue.Create;
    '"':
      begin
        if FStackSize = 1 then
          raise EObjectOrArrayExpected.Create;
        SkipChar;
        FPeeked := TAdvChartJSONState.jstDoubleQuoted;
        Exit(FPeeked);
      end;
    '[':
      begin
        SkipChar;
        FPeeked := TAdvChartJSONState.jstBeginArray;
        Exit(FPeeked);
      end;
    '{':
      begin
        SkipChar;
        FPeeked := TAdvChartJSONState.jstBeginObject;
        Exit(FPeeked);
      end;
  end;

  if FStackSize = 1 then
    raise EObjectOrArrayExpected.Create;

  Result := PeekKeyword;
  if Result <> TAdvChartJSONState.jstNone then
    Exit;
  Result := PeekNumber;
  if Result <> TAdvChartJSONState.jstNone then
    Exit;
  raise EExpectedValue.Create;
end;

function TAdvChartJSONReader.SkipWhitespaceUntilEnd: boolean;
var
  s: Char;
  p: Int64;
begin
  p := FReader.FReadStream.Position;
  Result := True;
  s := ReadChar;
  repeat
    if (s > #32) or not (Ord(s) in Wspace) then
    begin
      FReader.FReadStream.Position := p;
      Exit(false);
    end;

    s := ReadChar;
  until FReader.Eof;
  FReader.FReadStream.Position := p;
end;

procedure TAdvChartJSONReader.CheckState(const State: TAdvChartJSONState);
begin
  if NextPeek <> State then
    raise EInvalidStateException.Create(State);
end;

procedure TAdvChartJSONReader.ReadBeginArray;
begin
  CheckState(TAdvChartJSONState.jstBeginArray);
  PushScope(TAdvChartJSONScope.jscEmptyArray);
  FPeeked := TAdvChartJSONState.jstNone;
end;

procedure TAdvChartJSONReader.ReadEndArray;
begin
  CheckState(TAdvChartJSONState.jstEndArray);
  Dec(FStackSize);
  FPeeked := TAdvChartJSONState.jstNone;
end;

function TAdvChartJSONReader.ReadBoolean: boolean;
begin
  case NextPeek of
    TAdvChartJSONState.jstTrue:
      Result := True;
    TAdvChartJSONState.jstFalse:
      Result := False;
  else
    raise EInvalidStateException.Create(TAdvChartJSONState.jstTrue);
  end;
  FPeeked := TAdvChartJSONState.jstNone;
end;

function TAdvChartJSONReader.ReadChar: Char;
begin
  Result := FReader.ReadChar;
end;

function TAdvChartJSONReader.ReadDouble: double;
begin
  case NextPeek of
    TAdvChartJSONState.jstInt64:
      begin
        FPeeked := TAdvChartJSONState.jstNone;
        Exit(FPeekedInt64);
      end;
    TAdvChartJSONState.jstNumber:
      begin
        if TryStrToFloat(ArrayOfCharToString(FPeekedNumber), Result) then
        begin
          FPeeked := TAdvChartJSONState.jstNone;
          Exit;
        end else
          FPeekedString := ArrayOfCharToString(FPeekedNumber);
      end;
    TAdvChartJSONState.jstDoubleQuoted:
      FPeekedString := ReadQuoted;
    TAdvChartJSONState.jstBuffered: ;
  else
    raise EInvalidStateException.Create(TAdvChartJSONState.jstNumber);
  end;

  FPeeked := TAdvChartJSONState.jstBuffered;
  Result := StrToFloat(FPeekedString);
  FPeekedString := '';
  FPeeked := TAdvChartJSONState.jstNone;
end;

function TAdvChartJSONReader.ReadInt64: Int64;
var
  AsDouble: double;
begin
  case NextPeek of
    TAdvChartJSONState.jstInt64:
      begin
        FPeeked := TAdvChartJSONState.jstNone;
        Exit(FPeekedInt64);
      end;
    TAdvChartJSONState.jstNumber:
      begin
        if TryStrToInt64(ArrayOfCharToString(FPeekedNumber), Result) then
        begin
          FPeeked := TAdvChartJSONState.jstNone;
          Exit;
        end else
          FPeekedString := ArrayOfCharToString(FPeekedNumber);
      end;
    TAdvChartJSONState.jstDoubleQuoted:
      begin
        FPeekedString := ReadQuoted;
        if TryStrToInt64(FPeekedString, Result) then
        begin
          FPeeked := TAdvChartJSONState.jstNone;
          Exit;
        end;
      end;
    TAdvChartJSONState.jstBuffered: ;
  else
    raise EInvalidStateException.Create(TAdvChartJSONState.jstInt64);
  end;

  FPeeked := TAdvChartJSONState.jstBuffered;
  AsDouble := StrToFloat(FPeekedString);
  Result := Round(AsDouble);
  if AsDouble <> Result then
    raise EInvalidStateException.Create(TAdvChartJSONState.jstInt64);
  FPeekedString := '';
  FPeeked := TAdvChartJSONState.jstNone;
end;

function TAdvChartJSONReader.ReadInteger: integer;
var
  AsDouble: double;
begin
  case NextPeek of
    TAdvChartJSONState.jstInt64:
      begin
        Result := Integer(FPeekedInt64);
        if Result <> FPeekedInt64 then
          raise EInvalidStateException.Create(TAdvChartJSONState.jstInt64);
        FPeeked := TAdvChartJSONState.jstNone;
        Exit;
      end;
    TAdvChartJSONState.jstNumber:
      begin
        if TryStrToInt(ArrayOfCharToString(FPeekedNumber), Result) then
        begin
          FPeeked := TAdvChartJSONState.jstNone;
          Exit;
        end else
          FPeekedString := ArrayOfCharToString(FPeekedNumber);
      end;
    TAdvChartJSONState.jstDoubleQuoted:
      begin
        FPeekedString := ReadQuoted;
        if TryStrToInt(FPeekedString, Result) then
        begin
          FPeeked := TAdvChartJSONState.jstNone;
          Exit;
        end;
      end;
    TAdvChartJSONState.jstBuffered: ;
  else
    raise EInvalidStateException.Create(TAdvChartJSONState.jstInt64); // todo
  end;

  FPeeked := TAdvChartJSONState.jstBuffered;
  AsDouble := StrToFloat(FPeekedString);
  Result := Round(AsDouble);
  if AsDouble <> Result then
    raise EInvalidStateException.Create(TAdvChartJSONState.jstInt64);
  FPeekedString := '';
  FPeeked := TAdvChartJSONState.jstNone;
end;

function TAdvChartJSONReader.ReadName: string;
begin
  CheckState(TAdvChartJSONState.jstDoubleQuotedName);
  FPeeked := TAdvChartJSONState.jstNone;
  Result := ReadQuoted;
end;

procedure TAdvChartJSONReader.ReadNull;
begin
  CheckState(TAdvChartJSONState.jstNull);
  FPeeked := TAdvChartJSONState.jstNone;
end;

procedure TAdvChartJSONReader.ReadBeginObject;
begin
  CheckState(TAdvChartJSONState.jstBeginObject);
  PushScope(TAdvChartJSONScope.jscEmptyObject);
  FPeeked := TAdvChartJSONState.jstNone;
end;

procedure TAdvChartJSONReader.ReadEndObject;
begin
  CheckState(TAdvChartJSONState.jstEndObject);
  Dec(FStackSize);
  FPeeked := TAdvChartJSONState.jstNone;
end;

function TAdvChartJSONReader.ReadQuoted: string;
begin
  Result := InternalReadQuoted(true);
end;

function TAdvChartJSONReader.InternalReadQuoted(const BuildString: boolean): string;
var
  pc, c: String;
  s: string;
begin
  Result := '';
  s := '';
  pc := '';
  while not FReader.Eof do
  begin
    c := ReadChar;
    if (c = '"') and (pc <> '\') then
      Break
    else
      s := s + c;

    pc := c;
  end;

  if BuildString then
    Result := s;
end;

function TAdvChartJSONReader.ReadString: string;
begin
  case NextPeek of
    TAdvChartJSONState.jstDoubleQuoted:
      Result := ReadQuoted;
    TAdvChartJSONState.jstInt64:
      Result := IntToStr(FPeekedInt64);
    TAdvChartJSONState.jstNumber:
      Result := ArrayOfCharToString(FPeekedNumber);
    TAdvChartJSONState.jstBuffered:
      Result := FPeekedString;
  else
    raise EInvalidStateException.Create(TAdvChartJSONState.jstDoubleQuoted);
  end;
  FPeeked := TAdvChartJSONState.jstNone;

  Result := TAdvChartUtils.UnescapeString(Result);
end;

{ TAdvChartJSONStreamReader }

constructor TAdvChartJSONStreamReader.Create(const aStream: TStream);
begin
  FStream := aStream;
  FReadStream := TStringStream.Create(''{$IFDEF WEBLIB}, TEncoding.Ansi{$ENDIF});
  FReadStream.CopyFrom(FStream, FStream.Size);
  FReadStream.Position := 0;
end;

destructor TAdvChartJSONStreamReader.Destroy;
begin
  FReadStream.Free;
  inherited;
end;

function TAdvChartJSONStreamReader.NextChar: char;
begin
  if (Eof) then
    raise EEndOfInputReached.Create;
  Result := ReadChar;
end;

function TAdvChartJSONStreamReader.PeekChar: char;
var
  p: Int64;
begin
  p := FReadStream.Position;
  Result := ReadChar;
  FReadStream.Position := p;
end;

function TAdvChartJSONStreamReader.ReadChar: char;
var
  i: Integer;
  s: string;
begin
  Result := #0;
  {$IFDEF ZEROSTRINGINDEX}
  i := 0;
  {$ELSE}
  i := 1;
  {$ENDIF}
  if FReadStream.Position < FReadStream.Size then
  begin
    s := FReadStream.ReadString(1);
    {$IFNDEF WEBLIB}
    {$HINTS OFF}
    {$WARNINGS OFF}
    {$IFDEF LCLLIB}
    {$IF FPC_FULLVERSION = 30200}
    //BUG IN TStringStream in FPC 3.2
    FReadStream.Position := FReadStream.Position + 1;
    {$IFEND}
    {$ENDIF}
    {$HINTS ON}
    {$WARNINGS ON}
    {$ENDIF}
    if (s <> '') {$IFDEF WEBLIB} and Assigned(s) {$ENDIF} then
      Result := s[i]
  end;
end;

procedure TAdvChartJSONStreamReader.Backup(const c: char);
begin
  FReadStream.Position := FReadStream.Position - 1;
end;

procedure TAdvChartJSONStreamReader.MoveNext(const Count: integer = 1);
begin
  FReadStream.Position := FReadStream.Position + Count;
end;

function TAdvChartJSONStreamReader.Eof: boolean;
begin
  Result := FReadStream.Position = FReadStream.Size;
end;

{ TAdvChartJSONReader.EInvalidStateException }

constructor TAdvChartJSONReader.EInvalidStateException.Create(const AState: TAdvChartJSONState);
begin
  inherited CreateFmt('Invalid Json parser state. Expected state: %d', [Ord(AState)]);
end;

{ TAdvChartJSONReader.EUnterminatedArray }

constructor TAdvChartJSONReader.EUnterminatedArray.Create;
begin
  inherited Create('Unterminated array');
end;

{ TAdvChartJSONReader.EUnterminatedObject }

constructor TAdvChartJSONReader.EUnterminatedObject.Create;
begin
  inherited Create('Unterminated object');
end;

{ TAdvChartJSONReader.ENameExpected }

constructor TAdvChartJSONReader.ENameExpected.Create;
begin
  inherited Create('Name expected');
end;

{ TAdvChartJSONReader.EColonExpected }

constructor TAdvChartJSONReader.EColonExpected.Create;
begin
  inherited Create('Colon expected');
end;

{ TAdvChartJSONReader.EReaderClosed }

constructor TAdvChartJSONReader.EReaderClosed.Create;
begin
  inherited Create('Reader already closed');
end;

{ TAdvChartJSONReader.EMultipleRootNotAllowed }

constructor TAdvChartJSONReader.EMultipleRootNotAllowed.Create;
begin
  inherited Create('Multiple root values not allowed');
end;

{ TAdvChartJSONReader.EExpectedValue }

constructor TAdvChartJSONReader.EExpectedValue.Create;
begin
  inherited Create('Value expected but invalid character found');
end;

{ TAdvChartJSONReader.EObjectOrArrayExpected }

constructor TAdvChartJSONReader.EObjectOrArrayExpected.Create;
begin
  inherited Create('Object or array expected as top-level value');
end;

{ TAdvChartJSONReader.ETooManyDepthLevels }

constructor TAdvChartJSONReader.ETooManyDepthLevels.Create;
begin
  inherited Create('Maximum level of nested structured reached.');
end;

{ TAdvChartJSONStreamReader.EInvalidJsonInput }

constructor TAdvChartJSONStreamReader.EInvalidJsonInput.Create;
begin
  inherited Create('Invalid JSON Input');
end;

{ TAdvChartJSONStreamReader.EInternalError }

constructor TAdvChartJSONStreamReader.EInternalError.Create;
begin
  inherited Create('JSON stream reader internal error');
end;

{ TAdvChartJSONStreamReader.EEndOfInputReached }

constructor TAdvChartJSONStreamReader.EEndOfInputReached.Create;
begin
  inherited Create('End of JSON input reached.');
end;

{ TAdvChartJSONReader.EInvalidEscaped }

constructor TAdvChartJSONReader.EInvalidEscaped.Create;
begin
  inherited Create('Invalid escaped sequence');
end;

end.
