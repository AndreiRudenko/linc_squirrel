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
    typedef ::cpp::Function < int(::cpp::Reference<SQVM>, ::String) > SqCallbackFN;

    namespace squirrel {
        extern SQFloat getfloat(HSQUIRRELVM vm, SQInteger sv);
        extern SQInteger getinteger(HSQUIRRELVM vm, SQInteger sv);
        extern ::String getstring(HSQUIRRELVM vm, SQInteger sv);
        extern SQBool getbool(HSQUIRRELVM vm, SQInteger sv);
		extern void setprintfunc(HSQUIRRELVM v);

        extern void set_callbacks_function(SqCallbackFN fn);
        extern void add_callback_function(HSQUIRRELVM vm, const char *fname, SQInteger nparams, const SQChar *typemask);
        extern void remove_callback_function(HSQUIRRELVM vm, const char *fname);
    } //squirrel

} //linc

#endif //_LINC_SQUIRREL_H_
