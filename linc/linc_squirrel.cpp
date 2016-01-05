#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#define SQUSEDOUBLE

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

#include <hxcpp.h>

#include "./linc_squirrel.h"

namespace linc {

    namespace squirrel {

        SQFloat getfloat(HSQUIRRELVM vm, SQInteger sv){
            SQFloat ret;
            sq_getfloat(vm, sv, &ret);
            return ret;
        }
        
        SQBool getbool(HSQUIRRELVM vm, SQInteger sv){
            SQBool b = 0;
            sq_getbool(vm, sv, &b);
            return b != 0 ? true : false;
        }

        SQInteger getinteger(HSQUIRRELVM vm, SQInteger sv){
            SQInteger ret;
            sq_getinteger(vm, sv, &ret);
            return ret;
        }

        ::String getstring(HSQUIRRELVM vm, SQInteger sv){
            const SQChar* ret;
            sq_getstring(vm, sv, &ret);
            return ::String(ret);
        }

       	void printfunc(HSQUIRRELVM v, const SQChar *s, ...) { 
            va_list arglist; 
            va_start(arglist, s); 
            vprintf(s, arglist); 
            va_end(arglist); 
        } 

		void setprintfunc(HSQUIRRELVM v) {
			sq_setprintfunc(v, printfunc, printfunc);
		}

        // callbacks

        static SqCallbackFN event_fn = 0;
        static SQInteger sqCallback(HSQUIRRELVM vm){
            // printf("SQCallback!!!");
            SQStackInfos si;
            sq_stackinfos( vm, 0, &si );
            return event_fn(vm, ::String(si.funcname));
        }

        void set_callbacks_function(SqCallbackFN fn){
            event_fn = fn;
        }

        void add_callback_function(HSQUIRRELVM vm, const char *fname, SQInteger nparams, const SQChar *typemask) {
            sq_pushroottable(vm);
            sq_pushstring(vm, fname, -1);
            sq_newclosure(vm, sqCallback, 0); //create a new function
            sq_setparamscheck(vm, nparams, typemask);
            sq_setnativeclosurename(vm, -1, fname ); // this will be returned by sq_stackinfos
            sq_createslot(vm, -3);
            sq_poptop(vm); //pops the root table
        }

        void remove_callback_function(HSQUIRRELVM vm, const char *fname) {
            sq_pushroottable(vm);
            sq_pushstring(vm, fname, -1);
            sq_deleteslot(vm, -2, false);
            sq_poptop(vm);
        }


    } //squirrel

} //linc