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

unit AdvChartJSONWriter;

{$I TMSDEFS.inc}

{$IFDEF WEBLIB}
{$DEFINE LCLWEBLIB}
{$ENDIF}

{$IFDEF LCLLIB}
{$DEFINE LCLWEBLIB}
{$ENDIF}

{$INLINE ON}{$R-}{$Q-}

interface

uses
  {$IFNDEF LCLWEBLIB}
  Generics.Collections,
  {$ENDIF}
  Classes, SysUtils, AdvChartTypes;

type
  TAdvChartJSONStreamWriter = class
  private
  var
    FStream: TStream;
    FWriteStream: TStringStream;
  public
    constructor Create(AStream: TStream);
    destructor Destroy; override;
    procedure Write(const Value: string);
  end;

  TAdvChartJSONWriter = class
  public
    type
      ECannotWriteName = class(Exception)
      public
        constructor Create;
      end;
      EMultipleRootNotAllowed = class(Exception)
      public
        constructor Create;
      end;
      EObjectOrArrayExpected = class(Exception)
      public
        constructor Create;
      end;
      EInvalidNesting = class(Exception)
      public
        constructor Create;
      end;
      EMissingValue = class(Exception)
      public
        constructor Create;
      end;
      ETooManyDepthLevels = class(Exception)
      public
        constructor Create;
      end;
      EEmptyJson = class(Exception)
      public
        constructor Create;
      end;
      EEmptyName = class(Exception)
      public
        constructor Create;
      end;
  private
    type
      TAdvChartJSONScope = (jscEmptyDocument, jscEmptyArray, jscEmptyObject, jscNonEmptyDocument,
        jscNonEmptyArray, jscNonEmptyObject, jscDanglingName);
    const
      MaxStackSize = 255;
  private
    FWriter: TAdvChartJSONStreamWriter;
    FStack: array[0..MaxStackSize] of TAdvChartJSONScope;
    FStackSize: integer;
    FIndent: string;
    FSeparator: string;
    FDeferredName: string;
    FClosed: boolean;
    procedure SetIndentLength(const Value: integer);
    function GetIndentLength: integer;
    function OpenItem(const Empty: TAdvChartJSONScope; const OpenBracket: string): TAdvChartJSONWriter;
    function CloseItem(const Empty, NonEmpty: TAdvChartJSONScope; const CloseBracket: string): TAdvChartJSONWriter;
    procedure PushScope(const Scope: TAdvChartJSONScope); inline;
    function PeekScope: TAdvChartJSONScope; inline;
    procedure ReplaceTop(const Scope: TAdvChartJSONScope); inline;
    procedure WriteDeferredName; inline;
    procedure InternalWriteString(const Value: string);
    procedure NewLine; inline;
    procedure BeforeName;
    procedure BeforeValue(const Root: boolean);
  public
    constructor Create(const AStream: TStream);
    destructor Destroy; override;
    function WriteBeginArray: TAdvChartJSONWriter;
    function WriteEndArray: TAdvChartJSONWriter;
    function WriteBeginObject: TAdvChartJSONWriter;
    function WriteEndObject: TAdvChartJSONWriter;
    function WriteName(const Name: string): TAdvChartJSONWriter;
    function WriteString(const Value: string): TAdvChartJSONWriter;
    function WriteRawString(const Value: string): TAdvChartJSONWriter;
    function WriteBoolean(const Value: boolean): TAdvChartJSONWriter;
    function WriteNull: TAdvChartJSONWriter;
    function WriteDouble(const Value: double): TAdvChartJSONWriter;
    function WriteInteger(const Value: Int64): TAdvChartJSONWriter;
    procedure Close;
    property IndentLength: integer read GetIndentLength write SetIndentLength;
  end;

implementation

uses
  AdvChartUtils;

resourcestring
  ErrInvalidString = 'The file contains a string that can''t be encoded in UTF-8';

procedure RaiseErrInvalidString;
begin
  raise Exception.Create(ErrInvalidString);
end;

{ TAdvChartJSONWriter }

procedure TAdvChartJSONWriter.BeforeName;
begin
  case PeekScope of
    TAdvChartJSONScope.jscNonEmptyObject: FWriter.Write(',');
    TAdvChartJSONScope.jscEmptyObject: ;
  else
    raise ECannotWriteName.Create;
  end;
  NewLine;
  ReplaceTop(TAdvChartJSONScope.jscDanglingName);
end;

procedure TAdvChartJSONWriter.BeforeValue(const Root: boolean);
begin
  case PeekScope of
    TAdvChartJSONScope.jscNonEmptyDocument:
      raise EMultipleRootNotAllowed.Create;
    TAdvChartJSONScope.jscEmptyDocument:
      begin
        if not Root then
           raise EObjectOrArrayExpected.Create;
        ReplaceTop(TAdvChartJSONScope.jscNonEmptyDocument);
      end;
    TAdvChartJSONScope.jscEmptyArray:
      begin
        ReplaceTop(TAdvChartJSONScope.jscNonEmptyArray);
        NewLine;
      end;
    TAdvChartJSONScope.jscNonEmptyArray:
      begin
        FWriter.Write(',');
        NewLine;
      end;
    TAdvChartJSONScope.jscDanglingName:
      begin
        FWriter.Write(FSeparator);
        ReplaceTop(TAdvChartJSONScope.jscNonEmptyObject);
      end;
  else
    raise EInvalidNesting.Create;
  end;
end;

function TAdvChartJSONWriter.CloseItem(const Empty, NonEmpty: TAdvChartJSONScope;
  const CloseBracket: string): TAdvChartJSONWriter;
var
  Context: TAdvChartJSONScope;
begin
  Context := PeekScope;
  if not (Context in [Empty, NonEmpty]) then
    raise EInvalidNesting.Create;
  if FDeferredName <> '' then
    raise EMissingValue.Create;
  Dec(FStackSize);
  if Context = NonEmpty then
    NewLine;
  FWriter.Write(CloseBracket);
  Result := Self;
end;

procedure TAdvChartJSONWriter.Close;
begin
  if (FStackSize > 1) or ((FStackSize = 1) and (PeekScope <> TAdvChartJSONScope.jscNonEmptyDocument)) then
    raise EInvalidNesting.Create;
  FClosed := true;
end;

constructor TAdvChartJSONWriter.Create(const aStream: TStream);
begin
  inherited Create;
  FWriter := TAdvChartJSONStreamWriter.Create(aStream);
  FSeparator := ':';
  PushScope(TAdvChartJSONScope.jscEmptyDocument);
end;

destructor TAdvChartJSONWriter.Destroy;
begin
  FWriter.Free;
  inherited;
end;

procedure TAdvChartJSONWriter.NewLine;
var
  I: integer;
begin
  if FIndent <> '' then
  begin
    FWriter.Write(#13#10);
    for I := 1 to FStackSize - 1 do
      FWriter.Write(FIndent);
  end;
end;

function TAdvChartJSONWriter.OpenItem(const Empty: TAdvChartJSONScope;
  const OpenBracket: string): TAdvChartJSONWriter;
begin
  BeforeValue(true);
  PushScope(Empty);
  FWriter.Write(OpenBracket);
  Result := Self;
end;

function TAdvChartJSONWriter.PeekScope: TAdvChartJSONScope;
begin
  if FStackSize = 0 then
    raise EEmptyJson.Create;
  Result := FStack[FStackSize - 1];
end;

procedure TAdvChartJSONWriter.PushScope(const Scope: TAdvChartJSONScope);
begin
  if FStackSize > MaxStackSize then
    raise ETooManyDepthLevels.Create;
  FStack[FStackSize] := Scope;
  Inc(FStackSize);
end;

procedure TAdvChartJSONWriter.ReplaceTop(const Scope: TAdvChartJSONScope);
begin
  if FStackSize = 0 then
    raise EEmptyJson.Create;
  FStack[FStackSize - 1] := Scope;
end;

procedure TAdvChartJSONWriter.SetIndentLength(const Value: integer);
begin
  if Value <= 0 then
  begin
    FIndent := '';
    FSeparator := ':';
  end else
  begin
    FIndent := StringOfChar(#32, Value);
    FSeparator := ': ';
  end;
end;

function TAdvChartJSONWriter.GetIndentLength: integer;
begin
  Result := Length(FIndent);
end;

procedure TAdvChartJSONWriter.InternalWriteString(const Value: string);
begin
  FWriter.Write('"');
  FWriter.Write(TAdvChartUtils.EscapeString(Value));
  FWriter.Write('"');
end;

function TAdvChartJSONWriter.WriteString(const Value: string): TAdvChartJSONWriter;
begin
  WriteDeferredName;
  BeforeValue(false);
  InternalWriteString(Value);
  Result := Self;
end;

function TAdvChartJSONWriter.WriteEndArray: TAdvChartJSONWriter;
begin
  Result := CloseItem(TAdvChartJSONScope.jscEmptyArray, TAdvChartJSONScope.jscNonEmptyArray, ']');
end;

function TAdvChartJSONWriter.WriteEndObject: TAdvChartJSONWriter;
begin
  Result := CloseItem(TAdvChartJSONScope.jscEmptyObject, TAdvChartJSONScope.jscNonEmptyObject, '}');
end;

function TAdvChartJSONWriter.WriteBeginArray: TAdvChartJSONWriter;
begin
  WriteDeferredName;
  Result := OpenItem(TAdvChartJSONScope.jscEmptyArray, '[');
end;

function TAdvChartJSONWriter.WriteBeginObject: TAdvChartJSONWriter;
begin
  WriteDeferredName;
  Result := OpenItem(TAdvChartJSONScope.jscEmptyObject, '{');
end;

function TAdvChartJSONWriter.WriteBoolean(const Value: boolean): TAdvChartJSONWriter;
begin
  WriteDeferredName;
  BeforeValue(false);
  if Value then
    FWriter.Write('true')
  else
    FWriter.Write('false');
    Result := Self;
end;

procedure TAdvChartJSONWriter.WriteDeferredName;
begin
  if FDeferredName <> '' then
  begin
    BeforeName;
    InternalWriteString(FDeferredName);
    FDeferredName := '';
  end;
end;

function TAdvChartJSONWriter.WriteDouble(const Value: double): TAdvChartJSONWriter;
begin
  WriteDeferredName;
  BeforeValue(false);
  FWriter.Write(FloatToStr(Value));
  Result := Self;
end;

function TAdvChartJSONWriter.WriteName(const Name: string): TAdvChartJSONWriter;
begin
  if Name = '' then
    raise EEmptyName.Create;
  if FDeferredName <> '' then
    raise EMissingValue.Create;
  if FStackSize = 0 then
    raise EEmptyJson.Create;
  FDeferredName := Name;
  Result := Self;
end;

function TAdvChartJSONWriter.WriteNull: TAdvChartJSONWriter;
begin
  WriteDeferredName;
  BeforeValue(false);
  FWriter.Write('null');
  Result := Self;
end;

function TAdvChartJSONWriter.WriteRawString(const Value: string): TAdvChartJSONWriter;
begin
  WriteDeferredName;
  BeforeValue(false);
  FWriter.Write('"');
  FWriter.Write(Value);
  FWriter.Write('"');
  Result := Self;
end;

function TAdvChartJSONWriter.WriteInteger(const Value: Int64): TAdvChartJSONWriter;
begin
  WriteDeferredName;
  BeforeValue(false);
  FWriter.Write(IntToStr(Value));
  Result := Self;
end;

{ TAdvChartJSONStreamWriter }

constructor TAdvChartJSONStreamWriter.Create(aStream: TStream);
begin
  FStream := aStream;
  FWriteStream := TStringStream.Create(''{$IFDEF WEBLIB}, TEncoding.Ansi{$ENDIF});
end;

destructor TAdvChartJSONStreamWriter.Destroy;
begin
  try
    FWriteStream.Position := 0;
    FStream.CopyFrom(FWritestream, FWriteStream.Size);
  finally
    FWriteStream.Free;
  end;
  inherited;
end;

procedure TAdvChartJSONStreamWriter.Write(const Value: string);
begin
  FWriteStream.WriteString(Value);
end;

{ TAdvChartJSONWriter.ECannotWriteName }

constructor TAdvChartJSONWriter.ECannotWriteName.Create;
begin
  inherited Create('Cannot write name in current Json scope');
end;

{ TAdvChartJSONWriter.EMultipleRootNotAllowed }

constructor TAdvChartJSONWriter.EMultipleRootNotAllowed.Create;
begin
  inherited Create('Multiple root values not allowed');
end;

{ TAdvChartJSONWriter.EObjectOrArrayExpected }

constructor TAdvChartJSONWriter.EObjectOrArrayExpected.Create;
begin
  inherited Create('Object or array expected as top-level value');
end;

{ TAdvChartJSONWriter.EInvalidNesting }

constructor TAdvChartJSONWriter.EInvalidNesting.Create;
begin
  inherited Create('Invalid nesting. Not all arrays/objects were properly closed.');
end;

{ TAdvChartJSONWriter.EMissingValue }

constructor TAdvChartJSONWriter.EMissingValue.Create;
begin
  inherited Create('Json value missing');
end;

{ TAdvChartJSONWriter.ETooManyDepthLevels }

constructor TAdvChartJSONWriter.ETooManyDepthLevels.Create;
begin
  inherited Create('Maximum level of nested structured reached.');
end;

{ TAdvChartJSONWriter.EEmptyJson }

constructor TAdvChartJSONWriter.EEmptyJson.Create;
begin
  inherited Create('Json is still empty. Cannot perform operation.');
end;

{ TAdvChartJSONWriter.EEmptyName }

constructor TAdvChartJSONWriter.EEmptyName.Create;
begin
  inherited Create('Cannot write empty name');
end;

end.
