package squirrel;

@:native("SQVM")
@:include('linc_squirrel.h')
extern private class SQVM {}
typedef HSQUIRRELVM = cpp.Pointer<SQVM>;
