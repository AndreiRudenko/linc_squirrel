package squirrel;


@:include('linc_squirrel.h')
@:native('::cpp::Reference<SQVM>')
private extern class SQVM {}
typedef HSQUIRRELVM = SQVM;
