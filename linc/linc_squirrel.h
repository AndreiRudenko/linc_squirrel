#ifndef _LINC_SQUIRREL_H_
#define _LINC_SQUIRREL_H_

#define SQUSEDOUBLE

#include <hxcpp.h>

#include <stdarg.h> 
#include <stdio.h> 

#include "..\lib\SQUIRREL3\include\squirrel.h"
#include "..\lib\SQUIRREL3\include\sqstdio.h"
#include "..\lib\SQUIRREL3\include\sqstdblob.h"
#include "..\lib\SQUIRREL3\include\sqstdmath.h"
#include "..\lib\SQUIRREL3\include\sqstdsystem.h"
#include "..\lib\SQUIRREL3\include\sqstdstring.h"
#include "..\lib\SQUIRREL3\include\sqstdaux.h"

namespace linc {
    typedef ::cpp::Function < int(::cpp::Pointer<SQVM>, ::String) > SqCallbackFN;
    typedef ::cpp::Function < int(String) > HxPrintFN;

    namespace squirrel {
        extern SQFloat getfloat(HSQUIRRELVM vm, SQInteger sv);
        extern SQInteger getinteger(HSQUIRRELVM vm, SQInteger sv);
        extern ::String getstring(HSQUIRRELVM vm, SQInteger sv);
        extern bool getbool(HSQUIRRELVM vm, SQInteger sv);
		extern void setprintfunc(HSQUIRRELVM v, HxPrintFN fn);

        extern Dynamic getclosureinfo(HSQUIRRELVM v, SQInteger idx);
        extern Dynamic getmemberhandle(HSQUIRRELVM v, SQInteger idx);
        extern SQRESULT getbyhandle(HSQUIRRELVM v, SQInteger idx, Dynamic handle);
        extern SQRESULT setbyhandle(HSQUIRRELVM v, SQInteger idx, Dynamic handle);
        extern SQUserPointer getuserpointer(HSQUIRRELVM v, SQInteger idx);

        extern ::String getlocal(HSQUIRRELVM vm, SQUnsignedInteger level, SQUnsignedInteger nseq);
        extern void setcompilererrorhandler(HSQUIRRELVM vm);

        extern HSQOBJECT getstackobj(HSQUIRRELVM v, SQInteger idx);
        extern bool objtobool(HSQOBJECT po);
        extern ::String objtostring(HSQOBJECT obj);
        extern bool hx_sq_release(HSQUIRRELVM v, HSQOBJECT obj);

        extern Dynamic getfunctioninfo(HSQUIRRELVM v, SQInteger idx);
        extern Dynamic stackinfos(HSQUIRRELVM v, SQInteger idx);

        extern void set_callbacks_function(SqCallbackFN fn);
        extern void add_callback_function(HSQUIRRELVM vm, const char *fname, SQInteger nparams, const SQChar *typemask);
        extern void remove_callback_function(HSQUIRRELVM vm, const char *fname);
    } //squirrel

} //linc

#endif //_LINC_SQUIRREL_H_
