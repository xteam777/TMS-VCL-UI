unit AdvOpenGLX;

// Cross-platform OpenGL Interface
// by LI Qingrui

interface

uses
{$IFDEF MSWINDOWS}
  Windows,
{$ELSE}
  LibC, XLib, Types,
{$ENDIF}
  AdvOpenGLUtil, OpenGL;

const
{$IFDEF MSWINDOWS}
  opengl32 = 'OpenGL32.DLL';
  glu32 = 'GLU32.DLL';
  glut = 'GLUT32.DLL';
{$ELSE}
  opengl32 = 'libGL.so.1'; // please make link to valid LIBName/Version
  glu32 = 'libGLU.so';
  glut = 'libglut.so';
{$ENDIF}

type
  // ----------- GL types ----------------------------

  GLenum      = UINT;
  TGLenum     = GLenum;
  PGLenum     = ^TGLenum;

  GLboolean   = ByteBool;
  TGLboolean  = GLboolean;
  PGLboolean  = ^TGLboolean;

  GLbitfield  = UINT;
  TGLbitfield = GLbitfield;
  PGLbitfield = ^TGLbitfield;

  GLbyte      = ShortInt;
  TGLbyte     = GLbyte;
  PGLbyte     = ^TGLbyte;

  GLshort     = SmallInt;
  TGLshort    = GLshort;
  PGLshort    = ^TGLshort;

  GLsizei     = Integer;
  TGLsizei    = GLsizei;
  PGLsizei    = ^TGLsizei;

  GLushort    = Word;
  TGLushort   = GLushort;
  PGLushort   = ^TGLushort;

  GLuint      = Cardinal;
  TGLuint     = GLuint;
  PGLuint     = ^TGLuint;

  GLclampf    = Single;
  TGLclampf   = GLclampf;
  PGLclampf   = ^TGLclampf;

  GLclampd    = Double;
  TGLclampd   = GLclampd;
  PGLclampd   = ^TGLclampd;

  // ----------- GLU types ----------------------------

  GLUNurbs = record end;
  TGLUNurbs = GLUNurbs;

  GLUQuadric = record end;
  TGLUQuadric = GLUQuadric;

  GLUTesselator = record end;
  TGLUTesselator = GLUTesselator;

  PGLUNurbs = ^TGLUNurbs;
  PGLUQuadric = ^TGLUQuadric;
  PGLUTesselator = ^TGLUTesselator;

  // backwards compatibility
  GLUNurbsObj = GLUNurbs;
  GLUQuadricObj = GLUQuadric;
  GLUTesselatorObj = GLUTesselator;
  GLUTriangulatorObj = GLUTesselator;

  PGLUNurbsObj = PGLUNurbs;
  PGLUQuadricObj = PGLUQuadric;
  PGLUTesselatorObj = PGLUTesselator;
  PGLUTriangulatorObj = PGLUTesselator;

  // Callback function prototypes
  // GLUQuadricCallback
  TGLUQuadricErrorProc = procedure(errorCode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}

  // GLUTessCallback
  TGLUTessBeginProc = procedure(AType: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  TGLUTessEdgeFlagProc = procedure(Flag: TGLboolean); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  TGLUTessVertexProc = procedure(VertexData: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  TGLUTessEndProc = procedure; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  TGLUTessErrorProc = procedure(ErrNo: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  TGLUTessCombineProc = procedure(Coords: PGLdouble; VertexData: Pointer; Weight: PGLfloat; var OutData: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  TGLUTessBeginDataProc = procedure(AType: TGLEnum; UserData: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  TGLUTessEdgeFlagDataProc = procedure(Flag: TGLboolean; UserData: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  TGLUTessVertexDataProc = procedure(VertexData: Pointer; UserData: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  TGLUTessEndDataProc = procedure(UserData: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  TGLUTessErrorDataProc = procedure(ErrNo: TGLEnum; UserData: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  TGLUTessCombineDataProc = procedure(Coords: PGLdouble; VertexData: Pointer; Weight: PGLfloat; var OutData: Pointer; UserData: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}

  // GLUNurbsCallback
  TGLUNurbsErrorProc = procedure(ErrorCode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}

const
{  EXT_bgra }
  GL_BGR_EXT_2 = $80E0;
  GL_BGRA_EXT_2 = $80E1;

// ----------- GL Functions ----------------------------

procedure glAccum(op: TGLuint; value: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glAlphaFunc(func: TGLEnum; ref: TGLclampf); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
function glAreTexturesResident(n: TGLsizei; Textures: PGLuint; residences: PGLboolean): TGLboolean; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glArrayElement(i: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glBegin(mode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glBindTexture(target: TGLEnum; texture: TGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glBitmap(width: TGLsizei; height: TGLsizei; xorig, yorig: TGLfloat; xmove: TGLfloat; ymove: TGLfloat; bitmap: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glBlendFunc(sfactor: TGLEnum; dfactor: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glCallList(list: TGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glCallLists(n: TGLsizei; atype: TGLEnum; lists: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glClear(mask: TGLbitfield); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glClearAccum(red, green, blue, alpha: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glClearColor(red, green, blue, alpha: TGLclampf); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glClearDepth(depth: TGLclampd); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glClearIndex(c: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glClearStencil(s: TGLint ); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glClipPlane(plane: TGLEnum; equation: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3b(red, green, blue: TGLbyte); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3bv(v: PGLbyte); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3d(red, green, blue: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3dv(v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3f(red, green, blue: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3fv(v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3i(red, green, blue: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3iv(v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3s(red, green, blue: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3sv(v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3ub(red, green, blue: TGLubyte); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3ubv(v: PGLubyte); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3ui(red, green, blue: TGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3uiv(v: PGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3us(red, green, blue: TGLushort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor3usv(v: PGLushort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4b(red, green, blue, alpha: TGLbyte); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4bv(v: PGLbyte); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4d(red, green, blue, alpha: TGLdouble ); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4dv(v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4f(red, green, blue, alpha: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4fv(v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4i(red, green, blue, alpha: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4iv(v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4s(red, green, blue, alpha: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4sv(v: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4ub(red, green, blue, alpha: TGLubyte); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4ubv(v: PGLubyte); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4ui(red, green, blue, alpha: TGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4uiv(v: PGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4us(red, green, blue, alpha: TGLushort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColor4usv(v: PGLushort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColorMask(red, green, blue, alpha: TGLboolean); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColorMaterial(face: TGLEnum; mode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColorPointer(size: TGLint; atype: TGLEnum; stride: TGLsizei; data: pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glCopyPixels(x, y: TGLint; width, height: TGLsizei; atype: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glCopyTexImage1D(target: TGLEnum; level: TGLint; internalFormat: TGLEnum; x, y: TGLint; width: TGLsizei; border: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glCopyTexImage2D(target: TGLEnum; level: TGLint; internalFormat: TGLEnum; x, y: TGLint; width, height: TGLsizei; border: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glCopyTexSubImage1D(target: TGLEnum; level, xoffset, x, y: TGLint; width: TGLsizei); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glCopyTexSubImage2D(target: TGLEnum; level, xoffset, yoffset, x, y: TGLint; width, height: TGLsizei); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glCullFace(mode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glDeleteLists(list: TGLuint; range: TGLsizei); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glDeleteTextures(n: TGLsizei; textures: PGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glDepthFunc(func: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glDepthMask(flag: TGLboolean); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glDepthRange(zNear, zFar: TGLclampd); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glDisable(cap: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glDisableClientState(aarray: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glDrawArrays(mode: TGLEnum; first: TGLint; count: TGLsizei); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glDrawBuffer(mode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glDrawElements(mode: TGLEnum; count: TGLsizei; atype: TGLEnum; indices: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glDrawPixels(width, height: TGLsizei; format, atype: TGLEnum; pixels: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEdgeFlag(flag: TGLboolean); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEdgeFlagPointer(stride: TGLsizei; data: pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEdgeFlagv(flag: PGLboolean); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEnable(cap: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEnableClientState(aarray: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEnd; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEndList; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEvalCoord1d(u: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEvalCoord1dv(u: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEvalCoord1f(u: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEvalCoord1fv(u: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEvalCoord2d(u: TGLdouble; v: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEvalCoord2dv(u: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEvalCoord2f(u, v: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEvalCoord2fv(u: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEvalMesh1(mode: TGLEnum; i1, i2: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEvalMesh2(mode: TGLEnum; i1, i2, j1, j2: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEvalPoint1(i: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glEvalPoint2(i, j: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glFeedbackBuffer(size: TGLsizei; atype: TGLEnum; buffer: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glFinish; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glFlush; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glFogf(pname: TGLEnum; param: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glFogfv(pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glFogi(pname: TGLEnum; param: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glFogiv(pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glFrontFace(mode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glFrustum(left, right, bottom, top, zNear, zFar: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
function glGenLists(range: TGLsizei): TGLuint; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGenTextures(n: TGLsizei; textures: PGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetBooleanv(pname: TGLEnum; params: PGLboolean); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetClipPlane(plane: TGLEnum; equation: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetDoublev(pname: TGLEnum; params: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
function glGetError: TGLuint; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetFloatv(pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetIntegerv(pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetLightfv(light, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetLightiv(light, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetMapdv(target, query: TGLEnum; v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetMapfv(target, query: TGLEnum; v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetMapiv(target, query: TGLEnum; v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetMaterialfv(face, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetMaterialiv(face, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetPixelMapfv(map: TGLEnum; values: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetPixelMapuiv(map: TGLEnum; values: PGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetPixelMapusv(map: TGLEnum; values: PGLushort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetPointerv(pname: TGLEnum; var params); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetPolygonStipple(mask: PGLubyte); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
function glGetString(name: TGLEnum): PChar; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetTexEnvfv(target, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetTexEnviv(target, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetTexGendv(coord, pname: TGLEnum; params: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetTexGenfv(coord, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetTexGeniv(coord, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetTexImage(target: TGLEnum; level: TGLint; format, atype: TGLEnum; pixels: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetTexLevelParameterfv(target: TGLEnum; level: TGLint; pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetTexLevelParameteriv(target: TGLEnum; level: TGLint; pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetTexParameterfv(target, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetTexParameteriv(target, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glHint(target, mode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glIndexMask(mask: TGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glIndexPointer(atype: TGLEnum; stride: TGLsizei; data: pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glIndexd(c: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glIndexdv(c: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glIndexf(c: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glIndexfv(c: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glIndexi(c: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glIndexiv(c: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glIndexs(c: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glIndexsv(c: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glIndexub(c: TGLubyte); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glIndexubv(c: PGLubyte); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glInitNames; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glInterleavedArrays(format: TGLEnum; stride: TGLsizei; data: pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
function glIsEnabled(cap: TGLEnum): TGLboolean; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
function glIsList(list: TGLuint): TGLboolean; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
function glIsTexture(texture: TGLuint): TGLboolean; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLightModelf(pname: TGLEnum; param: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLightModelfv(pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLightModeli(pname: TGLEnum; param: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLightModeliv(pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLightf(light, pname: TGLEnum; param: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLightfv(light, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLighti(light, pname: TGLEnum; param: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLightiv(light, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLineStipple(factor: TGLint; pattern: TGLushort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLineWidth(width: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glListBase(base: TGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLoadIdentity; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLoadMatrixd(m: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLoadMatrixf(m: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLoadName(name: TGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glLogicOp(opcode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMap1d(target: TGLEnum; u1, u2: TGLdouble; stride, order: TGLint; points: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMap1f(target: TGLEnum; u1, u2: TGLfloat; stride, order: TGLint; points: PGLfloat);   {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMap2d(target: TGLEnum; u1, u2: TGLdouble; ustride, uorder: TGLint; v1, v2: TGLdouble; vstride,
  vorder: TGLint; points: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMap2f(target: TGLEnum; u1, u2: TGLfloat; ustride, uorder: TGLint; v1, v2: TGLfloat; vstride,
  vorder: TGLint; points: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMapGrid1d(un: TGLint; u1, u2: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMapGrid1f(un: TGLint; u1, u2: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMapGrid2d(un: TGLint; u1, u2: TGLdouble; vn: TGLint; v1, v2: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMapGrid2f(un: TGLint; u1, u2: TGLfloat; vn: TGLint; v1, v2: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMaterialf(face, pname: TGLEnum; param: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMaterialfv(face, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMateriali(face, pname: TGLEnum; param: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMaterialiv(face, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMatrixMode(mode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMultMatrixd(m: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMultMatrixf(m: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glNewList(list: TGLuint; mode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glNormal3b(nx, ny, nz: TGLbyte); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glNormal3bv(v: PGLbyte); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glNormal3d(nx, ny, nz: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glNormal3dv(v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glNormal3f(nx, ny, nz: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glNormal3fv(v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glNormal3i(nx, ny, nz: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glNormal3iv(v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glNormal3s(nx, ny, nz: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glNormal3sv(v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glNormalPointer(atype: TGLEnum; stride: TGLsizei; data: pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glOrtho(left, right, bottom, top, zNear, zFar: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPassThrough(token: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPixelMapfv(map: TGLEnum; mapsize: TGLsizei; values: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPixelMapuiv(map: TGLEnum; mapsize: TGLsizei; values: PGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPixelMapusv(map: TGLEnum; mapsize: TGLsizei; values: PGLushort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPixelStoref(pname: TGLEnum; param: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPixelStorei(pname: TGLEnum; param: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPixelTransferf(pname: TGLEnum; param: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPixelTransferi(pname: TGLEnum; param: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPixelZoom(xfactor, yfactor: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPointSize(size: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPolygonMode(face, mode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPolygonOffset(factor, units: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPolygonStipple(mask: PGLubyte); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPopAttrib; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPopClientAttrib; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPopMatrix; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPopName; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPrioritizeTextures(n: TGLsizei; textures: PGLuint; priorities: PGLclampf); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPushAttrib(mask: TGLbitfield); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPushClientAttrib(mask: TGLbitfield); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPushMatrix; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glPushName(name: TGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos2d(x, y: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos2dv(v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos2f(x, y: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos2fv(v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos2i(x, y: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos2iv(v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos2s(x, y: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos2sv(v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos3d(x, y, z: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos3dv(v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos3f(x, y, z: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos3fv(v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos3i(x, y, z: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos3iv(v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos3s(x, y, z: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos3sv(v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos4d(x, y, z, w: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos4dv(v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos4f(x, y, z, w: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos4fv(v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos4i(x, y, z, w: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos4iv(v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos4s(x, y, z, w: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRasterPos4sv(v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glReadBuffer(mode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glReadPixels(x, y: TGLint; width, height: TGLsizei; format, atype: TGLEnum; pixels: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRectd(x1, y1, x2, y2: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRectdv(v1, v2: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRectf(x1, y1, x2, y2: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRectfv(v1, v2: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRecti(x1, y1, x2, y2: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRectiv(v1, v2: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRects(x1, y1, x2, y2: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRectsv(v1, v2: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
function glRenderMode(mode: TGLEnum): TGLint; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRotated(angle, x, y, z: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glRotatef(angle, x, y, z: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glScaled(x, y, z: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glScalef(x, y, z: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glScissor(x, y: TGLint; width, height: TGLsizei); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glSelectBuffer(size: TGLsizei; buffer: PGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glShadeModel(mode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glStencilFunc(func: TGLEnum; ref: TGLint; mask: TGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glStencilMask(mask: TGLuint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glStencilOp(fail, zfail, zpass: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord1d(s: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord1dv(v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord1f(s: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord1fv(v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord1i(s: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord1iv(v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord1s(s: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord1sv(v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord2d(s, t: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord2dv(v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord2f(s, t: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord2fv(v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord2i(s, t: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord2iv(v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord2s(s, t: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord2sv(v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord3d(s, t, r: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord3dv(v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord3f(s, t, r: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord3fv(v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord3i(s, t, r: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord3iv(v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord3s(s, t, r: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord3sv(v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord4d(s, t, r, q: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord4dv(v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord4f(s, t, r, q: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord4fv(v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord4i(s, t, r, q: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord4iv(v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord4s(s, t, r, q: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoord4sv(v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexCoordPointer(size: TGLint; atype: TGLEnum; stride: TGLsizei; data: pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexEnvf(target, pname: TGLEnum; param: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexEnvfv(target, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexEnvi(target, pname: TGLEnum; param: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexEnviv(target, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexGend(coord, pname: TGLEnum; param: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexGendv(coord, pname: TGLEnum; params: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexGenf(coord, pname: TGLEnum; param: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexGenfv(coord, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexGeni(coord, pname: TGLEnum; param: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexGeniv(coord, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexImage1D(target: TGLEnum; level, internalformat: TGLint; width: TGLsizei; border: TGLint; format,
  atype: TGLEnum; pixels: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexImage2D(target: TGLEnum; level, internalformat: TGLint; width, height: TGLsizei; border: TGLint;
  format, atype: TGLEnum; Pixels:Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexParameterf(target, pname: TGLEnum; param: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexParameterfv(target, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexParameteri(target, pname: TGLEnum; param: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexParameteriv(target, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexSubImage1D(target: TGLEnum; level, xoffset: TGLint; width: TGLsizei; format, atype: TGLEnum;
  pixels: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexSubImage2D(target: TGLEnum; level, xoffset, yoffset: TGLint; width, height: TGLsizei; format,
  atype: TGLEnum; pixels: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTranslated(x, y, z: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTranslatef(x, y, z: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex2d(x, y: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex2dv(v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex2f(x, y: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex2fv(v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex2i(x, y: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex2iv(v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex2s(x, y: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex2sv(v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex3d(x, y, z: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex3dv(v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex3f(x, y, z: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex3fv(v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex3i(x, y, z: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex3iv(v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex3s(x, y, z: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex3sv(v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex4d(x, y, z, w: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex4dv(v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex4f(x, y, z, w: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex4fv(v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex4i(x, y, z, w: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex4iv(v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex4s(x, y, z, w: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertex4sv(v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glVertexPointer(size: TGLint; atype: TGLEnum; stride: TGLsizei; data: pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glViewport(x, y: TGLint; width, height: TGLsizei); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;

// GL 1.2
procedure glDrawRangeElements(mode: TGLEnum; Astart, Aend: TGLuint; count: TGLsizei; Atype: TGLEnum;
  indices: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glTexImage3D(target: TGLEnum; level: TGLint; internalformat: TGLEnum; width, height, depth: TGLsizei;
  border: TGLint; format: TGLEnum; Atype: TGLEnum; pixels: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;

// GL 1.2 ARB imaging
procedure glBlendColor(red, green, blue, alpha: TGLclampf); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glBlendEquation(mode: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColorSubTable(target: TGLEnum; start, count: TGLsizei; format, Atype: TGLEnum; data: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glCopyColorSubTable(target: TGLEnum; start: TGLsizei; x, y: TGLint; width: TGLsizei); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColorTable(target, internalformat: TGLEnum; width: TGLsizei; format, Atype: TGLEnum;
  table: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glCopyColorTable(target, internalformat: TGLEnum; x, y: TGLint; width: TGLsizei); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColorTableParameteriv(target, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glColorTableParameterfv(target, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetColorTable(target, format, Atype: TGLEnum; table: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetColorTableParameteriv(target, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetColorTableParameterfv(target, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glConvolutionFilter1D(target, internalformat: TGLEnum; width: TGLsizei; format, Atype: TGLEnum;
  image: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glConvolutionFilter2D(target, internalformat: TGLEnum; width, height: TGLsizei; format, Atype: TGLEnum;
  image: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glCopyConvolutionFilter1D(target, internalformat: TGLEnum; x, y: TGLint; width: TGLsizei); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glCopyConvolutionFilter2D(target, internalformat: TGLEnum; x, y: TGLint; width, height: TGLsizei); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetConvolutionFilter(target, internalformat, Atype: TGLEnum; image: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glSeparableFilter2D(target, internalformat: TGLEnum; width, height: TGLsizei; format, Atype: TGLEnum; row,
  column: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetSeparableFilter(target, format, Atype: TGLEnum; row, column, span: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glConvolutionParameteri(target, pname: TGLEnum; param: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glConvolutionParameteriv(target, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glConvolutionParameterf(target, pname: TGLEnum; param: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glConvolutionParameterfv(target, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetConvolutionParameteriv(target, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetConvolutionParameterfv(target, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glHistogram(target: TGLEnum; width: TGLsizei; internalformat: TGLEnum; sink: TGLboolean); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glResetHistogram(target: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetHistogram(target: TGLEnum; reset: TGLboolean; format, Atype: TGLEnum; values: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetHistogramParameteriv(target, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetHistogramParameterfv(target, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glMinmax(target, internalformat: TGLEnum; sink: TGLboolean); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glResetMinmax(target: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetMinmax(target: TGLEnum; reset: TGLboolean; format, Atype: TGLEnum; values: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetMinmaxParameteriv(target, pname: TGLEnum; params: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;
procedure glGetMinmaxParameterfv(target, pname: TGLEnum; params: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external opengl32;

// GL utility functions and procedures
function gluErrorString(errCode: TGLEnum): PChar; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
function gluGetString(name: TGLEnum): PChar; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluOrtho2D(left, right, bottom, top: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluPerspective(fovy, aspect, zNear, zFar: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluPickMatrix(x, y, width, height: TGLdouble; viewport: TVector4i); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluLookAt(eyex, eyey, eyez, centerx, centery, centerz, upx, upy, upz: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
function gluProject(objx, objy, objz: TGLdouble; modelMatrix: TMatrix4d; projMatrix: TMatrix4d; viewport: TVector4i;
  winx, winy, winz: PGLdouble): TGLint; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
function gluUnProject(winx, winy, winz: TGLdouble; modelMatrix: TMatrix4d; projMatrix: TMatrix4d; viewport: TVector4i;
  objx, objy, objz: PGLdouble): TGLint; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
function gluScaleImage(format: TGLEnum; widthin, heightin: TGLint; typein: TGLEnum; datain: Pointer; widthout,
  heightout: TGLint; typeout: TGLEnum; dataout: Pointer): TGLint; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
function gluBuild1DMipmaps(target: TGLEnum; components, width: TGLint; format, atype: TGLEnum;
  data: Pointer): TGLint; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
function gluBuild2DMipmaps(target: TGLEnum; components, width, height: TGLint; format, atype: TGLEnum;
  Data: Pointer): TGLint; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
function gluNewQuadric: PGLUquadric; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluDeleteQuadric(state: PGLUquadric); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluQuadricNormals(quadObject: PGLUquadric; normals: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluQuadricTexture(quadObject: PGLUquadric; textureCoords: TGLboolean); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluQuadricOrientation(quadObject: PGLUquadric; orientation: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluQuadricDrawStyle(quadObject: PGLUquadric; drawStyle: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluCylinder(quadObject: PGLUquadric; baseRadius, topRadius, height: TGLdouble; slices,
  stacks: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluDisk(quadObject: PGLUquadric; innerRadius, outerRadius: TGLdouble; slices, loops: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluPartialDisk(quadObject: PGLUquadric; innerRadius, outerRadius: TGLdouble; slices, loops: TGLint;
  startAngle, sweepAngle: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluSphere(quadObject: PGLUquadric; radius: TGLdouble; slices, stacks: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluQuadricCallback(quadObject: PGLUquadric; which: TGLEnum; fn: TGLUQuadricErrorProc); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
function gluNewTess: PGLUtesselator; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluDeleteTess(tess: PGLUtesselator); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluTessBeginPolygon(tess: PGLUtesselator; polygon_data: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluTessBeginContour(tess: PGLUtesselator); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluTessVertex(tess: PGLUtesselator; coords: TVector3d; data: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluTessEndContour(tess: PGLUtesselator); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluTessEndPolygon(tess: PGLUtesselator); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluTessProperty(tess: PGLUtesselator; which: TGLEnum; value: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluTessNormal(tess: PGLUtesselator; x, y, z: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluTessCallback(tess: PGLUtesselator; which: TGLEnum; fn: Pointer); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluGetTessProperty(tess: PGLUtesselator; which: TGLEnum; value: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
function gluNewNurbsRenderer: PGLUnurbs; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluDeleteNurbsRenderer(nobj: PGLUnurbs); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluBeginSurface(nobj: PGLUnurbs); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluBeginCurve(nobj: PGLUnurbs); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluEndCurve(nobj: PGLUnurbs); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluEndSurface(nobj: PGLUnurbs); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluBeginTrim(nobj: PGLUnurbs); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluEndTrim(nobj: PGLUnurbs); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluPwlCurve(nobj: PGLUnurbs; count: TGLint; points: PGLfloat; stride: TGLint; atype: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluNurbsCurve(nobj: PGLUnurbs; nknots: TGLint; knot: PGLfloat; stride: TGLint; ctlarray: PGLfloat; order: TGLint; atype: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluNurbsSurface(nobj: PGLUnurbs; sknot_count: TGLint; sknot: PGLfloat; tknot_count: TGLint; tknot: PGLfloat; s_stride, t_stride: TGLint; ctlarray: PGLfloat; sorder, torder: TGLint; atype: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluLoadSamplingMatrices(nobj: PGLUnurbs; modelMatrix, projMatrix: TMatrix4f; viewport: TVector4i); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluNurbsProperty(nobj: PGLUnurbs; aproperty: TGLEnum; value: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluGetNurbsProperty(nobj: PGLUnurbs; aproperty: TGLEnum; value: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluNurbsCallback(nobj: PGLUnurbs; which: TGLEnum; fn: TGLUNurbsErrorProc); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluBeginPolygon(tess: PGLUtesselator); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluNextContour(tess: PGLUtesselator; atype: TGLEnum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;
procedure gluEndPolygon(tess: PGLUtesselator); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF} external glu32;

//-------- GL Extensions ----------------

var
  GL_ARB_multitexture,
  GL_EXT_separate_specular_color,
  GL_EXT_texture_filter_anisotropic,
  GL_ARB_texture_compression,
  GL_EXT_texture_edge_clamp: boolean;

const

  // GL_ARB_texture_compression
  GL_COMPRESSED_ALPHA_ARB                    = $84E9;
  GL_COMPRESSED_LUMINANCE_ARB                = $84EA;
  GL_COMPRESSED_LUMINANCE_ALPHA_ARB          = $84EB;
  GL_COMPRESSED_INTENSITY_ARB                = $84EC;
  GL_COMPRESSED_RGB_ARB                      = $84ED;
  GL_COMPRESSED_RGBA_ARB                     = $84EE;
  GL_TEXTURE_COMPRESSION_HINT_ARB            = $84EF;
  GL_TEXTURE_IMAGE_SIZE_ARB                  = $86A0;
  GL_TEXTURE_COMPRESSED_ARB                  = $86A1;
  GL_NUM_COMPRESSED_TEXTURE_FORMATS_ARB      = $86A2;
  GL_COMPRESSED_TEXTURE_FORMATS_ARB          = $86A3;

  // GL_EXT_separate_specular_color
  GL_LIGHT_MODEL_COLOR_CONTROL_EXT           = $81F8;
  GL_SINGLE_COLOR_EXT                        = $81F9;
  GL_SEPARATE_SPECULAR_COLOR_EXT             = $81FA;

  // GL_EXT_texture_filter_anisotropic
  GL_TEXTURE_MAX_ANISOTROPY_EXT              = $84FE;
  GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT          = $84FF;

  // GL_EXT_texture_edge_clamp
  GL_CLAMP_TO_EDGE_EXT                       = $812F;

  // GL_ARB_multisample
  GL_MULTISAMPLE_ARB                         = $809D;
  GL_SAMPLE_ALPHA_TO_COVERAGE_ARB            = $809E;
  GL_SAMPLE_ALPHA_TO_ONE_ARB                 = $809F;
  GL_SAMPLE_COVERAGE_ARB                     = $80A0;
  GL_SAMPLE_BUFFERS_ARB                      = $80A8;
  GL_SAMPLES_ARB                             = $80A9;
  GL_SAMPLE_COVERAGE_VALUE_ARB               = $80AA;
  GL_SAMPLE_COVERAGE_INVERT_ARB              = $80AB;
  GL_MULTISAMPLE_BIT_ARB                     = $20000000;

var
  // ARB_multitexture
  glMultiTexCoord1dARB: procedure(target: TGLenum; s: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord1dVARB: procedure(target: TGLenum; v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord1fARBP: procedure(target: TGLenum; s: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord1fVARB: procedure(target: TGLenum; v: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord1iARB: procedure(target: TGLenum; s: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord1iVARB: procedure(target: TGLenum; v: PGLInt); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord1sARBP: procedure(target: TGLenum; s: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord1sVARB: procedure(target: TGLenum; v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord2dARB: procedure(target: TGLenum; s, t: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord2dvARB: procedure(target: TGLenum; v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord2fARB: procedure(target: TGLenum; s, t: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord2fvARB: procedure(target: TGLenum; v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord2iARB: procedure(target: TGLenum; s, t: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord2ivARB: procedure(target: TGLenum; v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord2sARB: procedure(target: TGLenum; s, t: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord2svARB: procedure(target: TGLenum; v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord3dARB: procedure(target: TGLenum; s, t, r: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord3dvARB: procedure(target: TGLenum; v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord3fARB: procedure(target: TGLenum; s, t, r: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord3fvARB: procedure(target: TGLenum; v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord3iARB: procedure(target: TGLenum; s, t, r: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord3ivARB: procedure(target: TGLenum; v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord3sARB: procedure(target: TGLenum; s, t, r: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord3svARB: procedure(target: TGLenum; v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord4dARB: procedure(target: TGLenum; s, t, r, q: TGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord4dvARB: procedure(target: TGLenum; v: PGLdouble); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord4fARB: procedure(target: TGLenum; s, t, r, q: TGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord4fvARB: procedure(target: TGLenum; v: PGLfloat); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord4iARB: procedure(target: TGLenum; s, t, r, q: TGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord4ivARB: procedure(target: TGLenum; v: PGLint); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord4sARB: procedure(target: TGLenum; s, t, r, q: TGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glMultiTexCoord4svARB: procedure(target: TGLenum; v: PGLshort); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glActiveTextureARB: procedure(target: TGLenum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
  glClientActiveTextureARB: procedure(target: TGLenum); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}

//-------- Platform Support -------------

{$IFDEF MSWINDOWS}
type
  HGLRC = THandle;

function wglGetProcAddress(ProcName: PChar): Pointer; stdcall; external opengl32;
{$ENDIF}

{$IFDEF LINUX}
const
  GLX_USE_GL                                        = 1; 
  GLX_BUFFER_SIZE                                   = 2; 
  GLX_LEVEL                                         = 3; 
  GLX_RGBA                                          = 4; 
  GLX_DOUBLEBUFFER                                  = 5; 
  GLX_STEREO                                        = 6; 
  GLX_AUX_BUFFERS                                   = 7; 
  GLX_RED_SIZE                                      = 8; 
  GLX_GREEN_SIZE                                    = 9; 
  GLX_BLUE_SIZE                                     = 10; 
  GLX_ALPHA_SIZE                                    = 11; 
  GLX_DEPTH_SIZE                                    = 12;
  GLX_STENCIL_SIZE                                  = 13;
  GLX_ACCUM_RED_SIZE                                = 14;
  GLX_ACCUM_GREEN_SIZE                              = 15;
  GLX_ACCUM_BLUE_SIZE                               = 16;
  GLX_ACCUM_ALPHA_SIZE                              = 17;

  // Error codes returned by glXGetConfig:
  GLX_BAD_SCREEN                                    = 1;
  GLX_BAD_ATTRIBUTE                                 = 2;
  GLX_NO_EXTENSION                                  = 3;
  GLX_BAD_VISUAL                                    = 4;
  GLX_BAD_CONTEXT                                   = 5;
  GLX_BAD_VALUE                                     = 6;
  GLX_BAD_ENUM                                      = 7;

type
  GLXContext     = THandle; //Pointer;
  GLXPixmap      = XID;
  GLXDrawable    = XID;

function glXChooseVisual(dpy: PDisplay; screen: TGLint; attribList: PGLint): PXVisualInfo; cdecl; external opengl32;
function glXCreateContext(dpy: PDisplay; vis: PXVisualInfo; shareList: GLXContext; direct: TGLboolean): GLXContext; cdecl; external opengl32;
procedure glXDestroyContext(dpy: PDisplay; ctx: GLXContext); cdecl; external opengl32;
function glXMakeCurrent(dpy: PDisplay; drawable: GLXDrawable; ctx: GLXContext): TGLboolean; cdecl; external opengl32;
procedure glXCopyContext(dpy: PDisplay; src: GLXContext; dst: GLXContext; mask: TGLuint); cdecl; external opengl32;
procedure glXSwapBuffers(dpy: PDisplay; drawable: GLXDrawable); cdecl; external opengl32;
function glXCreateGLXPixmap(dpy: PDisplay; visual: PXVisualInfo; pixmap: Pixmap): GLXPixmap; cdecl; external opengl32;
procedure glXDestroyGLXPixmap(dpy: PDisplay; pixmap: GLXPixmap); cdecl; external opengl32;
function glXQueryExtension(dpy: PDisplay; errorb: PGLInt; event: PGLInt): TGLboolean; cdecl; external opengl32;
function glXQueryVersion(dpy: PDisplay; maj: PGLInt; min: PGLINT): TGLboolean; cdecl; external opengl32;
function glXIsDirect(dpy: PDisplay; ctx: GLXContext): TGLboolean; cdecl; external opengl32;
function glXGetConfig(dpy: PDisplay; visual: PXVisualInfo; attrib: TGLInt; value: PGLInt): TGLInt; cdecl; external opengl32;
function glXGetCurrentContext: GLXContext; cdecl; external opengl32;
function glXGetCurrentDrawable: GLXDrawable; cdecl; external opengl32;
procedure glXWaitGL; cdecl; external opengl32;
procedure glXWaitX; cdecl; external opengl32;
procedure glXUseXFont(font: Font; first: TGLInt; count: TGLInt; list: TGLint); cdecl; external opengl32;

 wglCreatePbufferARB    = (PFNWGLCREATEPBUFFERARBPROC)wglGetProcAddress("wglCreatePbufferARB");
 wglGetPbufferDCARB     = (PFNWGLGETPBUFFERDCARBPROC)wglGetProcAddress("wglGetPbufferDCARB");
 wglReleasePbufferDCARB = (PFNWGLRELEASEPBUFFERDCARBPROC)wglGetProcAddress("wglReleasePbufferDCARB");
 wglDestroyPbufferARB   = (PFNWGLDESTROYPBUFFERARBPROC)wglGetProcAddress("wglDestroyPbufferARB");
        wglQueryPbufferARB     = (PFNWGLQUERYPBUFFERARBPROC)wglGetProcAddress("wglQueryPbufferARB");

        wglGetPixelFormatAttribivARB = (PFNWGLGETPIXELFORMATATTRIBIVARBPROC)wglGetProcAddress("wglGetPixelFormatAttribivARB");
        wglGetPixelFormatAttribfvARB = (PFNWGLGETPIXELFORMATATTRIBFVARBPROC)wglGetProcAddress("wglGetPixelFormatAttribfvARB");
        wglChoosePixelFormatARB      = (PFNWGLCHOOSEPIXELFORMATARBPROC)wglGetProcAddress("wglChoosePixelFormatARB");
{$ENDIF}

//-------- Helper Functions ----------------

procedure LoadGLExtensions;

implementation

procedure LoadGLExtensions;
var buffer: string;
begin
  Buffer := glGetString(GL_EXTENSIONS);
  GL_ARB_texture_compression := Pos('GL_ARB_texture_compression', Buffer) > 0;
  GL_EXT_separate_specular_color := Pos('GL_EXT_separate_specular_color', Buffer) > 0;
  GL_EXT_texture_filter_anisotropic := Pos('GL_EXT_texture_filter_anisotropic', Buffer) > 0;
  GL_EXT_texture_edge_clamp := Pos('GL_EXT_texture_edge_clamp', Buffer) > 0;
  GL_ARB_multitexture := Pos('GL_ARB_multitexture', Buffer) > 0;
{$IFDEF MSWINDOWS}
  if GL_ARB_multitexture then
  begin
    glMultiTexCoord1dARB := wglGetProcAddress('glMultiTexCoord1dARB');
    glMultiTexCoord1dVARB := wglGetProcAddress('glMultiTexCoord1dVARB');
    glMultiTexCoord1fARBP := wglGetProcAddress('glMultiTexCoord1fARBP');
    glMultiTexCoord1fVARB := wglGetProcAddress('glMultiTexCoord1fVARB');
    glMultiTexCoord1iARB := wglGetProcAddress('glMultiTexCoord1iARB');
    glMultiTexCoord1iVARB := wglGetProcAddress('glMultiTexCoord1iVARB');
    glMultiTexCoord1sARBP := wglGetProcAddress('glMultiTexCoord1sARBP');
    glMultiTexCoord1sVARB := wglGetProcAddress('glMultiTexCoord1sVARB');
    glMultiTexCoord2dARB := wglGetProcAddress('glMultiTexCoord2dARB');
    glMultiTexCoord2dvARB := wglGetProcAddress('glMultiTexCoord2dvARB');
    glMultiTexCoord2fARB := wglGetProcAddress('glMultiTexCoord2fARB');
    glMultiTexCoord2fvARB := wglGetProcAddress('glMultiTexCoord2fvARB');
    glMultiTexCoord2iARB := wglGetProcAddress('glMultiTexCoord2iARB');
    glMultiTexCoord2ivARB := wglGetProcAddress('glMultiTexCoord2ivARB');
    glMultiTexCoord2sARB := wglGetProcAddress('glMultiTexCoord2sARB');
    glMultiTexCoord2svARB := wglGetProcAddress('glMultiTexCoord2svARB');
    glMultiTexCoord3dARB := wglGetProcAddress('glMultiTexCoord3dARB');
    glMultiTexCoord3dvARB := wglGetProcAddress('glMultiTexCoord3dvARB');
    glMultiTexCoord3fARB := wglGetProcAddress('glMultiTexCoord3fARB');
    glMultiTexCoord3fvARB := wglGetProcAddress('glMultiTexCoord3fvARB');
    glMultiTexCoord3iARB := wglGetProcAddress('glMultiTexCoord3iARB');
    glMultiTexCoord3ivARB := wglGetProcAddress('glMultiTexCoord3ivARB');
    glMultiTexCoord3sARB := wglGetProcAddress('glMultiTexCoord3sARB');
    glMultiTexCoord3svARB := wglGetProcAddress('glMultiTexCoord3svARB');
    glMultiTexCoord4dARB := wglGetProcAddress('glMultiTexCoord4dARB');
    glMultiTexCoord4dvARB := wglGetProcAddress('glMultiTexCoord4dvARB');
    glMultiTexCoord4fARB := wglGetProcAddress('glMultiTexCoord4fARB');
    glMultiTexCoord4fvARB := wglGetProcAddress('glMultiTexCoord4fvARB');
    glMultiTexCoord4iARB := wglGetProcAddress('glMultiTexCoord4iARB');
    glMultiTexCoord4ivARB := wglGetProcAddress('glMultiTexCoord4ivARB');
    glMultiTexCoord4sARB := wglGetProcAddress('glMultiTexCoord4sARB');
    glMultiTexCoord4svARB := wglGetProcAddress('glMultiTexCoord4svARB');
    glActiveTextureARB := wglGetProcAddress('glActiveTextureARB');
    glClientActiveTextureARB := wglGetProcAddress('glClientActiveTextureARB');
  end;
{$ENDIF}
end;

end.

