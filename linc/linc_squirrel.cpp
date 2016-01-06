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

        Dynamic getclosureinfo(HSQUIRRELVM v, SQInteger idx) {
            SQUnsignedInteger nparams;
            SQUnsignedInteger nfreevars;
            sq_getclosureinfo(v, idx, &nparams, &nfreevars);

            hx::Anon out = hx::Anon_obj::Create();
            out->Add(HX_CSTRING("nparams"), (int)nparams);
            out->Add(HX_CSTRING("nfreevars"), (int)nfreevars);

            return out;
        }

        Dynamic getmemberhandle(HSQUIRRELVM v, SQInteger idx) {
            HSQMEMBERHANDLE handle;
            sq_getmemberhandle(v, idx, &handle);

            hx::Anon out = hx::Anon_obj::Create();
            out->Add(HX_CSTRING("_static"), handle._static != 0 ? true : false);
            out->Add(HX_CSTRING("_index"), handle._index);

            return out;
        }

        SQRESULT getbyhandle(HSQUIRRELVM v, SQInteger idx, Dynamic handle) {
            HSQMEMBERHANDLE h;

            h._index = handle->__FieldRef(HX_CSTRING("_index"));
            h._static = handle->__FieldRef(HX_CSTRING("_static")) != true ? 0 : 1;
            return sq_getbyhandle(v, idx, &h);
        }

        SQRESULT setbyhandle(HSQUIRRELVM v, SQInteger idx, Dynamic handle) {
            HSQMEMBERHANDLE h;

            h._index = handle->__FieldRef(HX_CSTRING("_index"));
            h._static = handle->__FieldRef(HX_CSTRING("_static")) != true ? 0 : 1;
            return sq_setbyhandle(v, idx, &h);
        }

        ::String getlocal(HSQUIRRELVM vm, SQUnsignedInteger level, SQUnsignedInteger nseq){
            const SQChar* ret = sq_getlocal(vm, level, nseq);

            if (ret == NULL) {
                return null();
            }

            return ::String(ret);
        }

        void _linc_compiler_error(HSQUIRRELVM v,const SQChar *sErr,const SQChar *sSource,SQInteger line,SQInteger column) {
            SQPRINTFUNCTION pf = sq_geterrorfunc(v);
            if(pf) {
                pf(v,_SC("%s line = (%d) column = (%d) : error %s\n"),sSource,line,column,sErr);
            }
        }

        void setcompilererrorhandler(HSQUIRRELVM vm) {
            sq_setcompilererrorhandler(vm,_linc_compiler_error);
        }


        HSQOBJECT getstackobj(HSQUIRRELVM v, SQInteger idx){
            HSQOBJECT obj;
            sq_getstackobj(v, idx, &obj);
            return obj;
        }

        SQBool objtobool(HSQOBJECT obj){
            SQBool b = sq_objtobool(&obj);
            return b != 0 ? true : false;
        }


        ::String objtostring(HSQOBJECT obj){
            const SQChar* ret = sq_objtostring(&obj);
            if (ret == NULL) {
                return null();
            }
            return ::String(ret);
        }

        SQBool hx_sq_release(HSQUIRRELVM v, HSQOBJECT obj){
            SQBool b = sq_release(v, &obj);
            return b != 0 ? true : false;
        }

        Dynamic getfunctioninfo(HSQUIRRELVM v, SQInteger idx) {
            SQFunctionInfo fi;

            if (SQ_SUCCEEDED(sq_getfunctioninfo(v, idx, &fi))){

                hx::Anon out = hx::Anon_obj::Create();

                if (fi.funcid){
                    out->Add(HX_CSTRING("funcid"), fi.funcid);
                } else {
                    out->Add(HX_CSTRING("funcid"), null());
                }

                if (fi.name){
                    out->Add(HX_CSTRING("name"), ::String(fi.name));
                } else {
                    out->Add(HX_CSTRING("name"), ::String("unknown"));
                }

                if (fi.source){
                    out->Add(HX_CSTRING("source"), ::String(fi.source));
                } else {
                    out->Add(HX_CSTRING("source"), ::String("unknown"));
                }

                return out;
            }
            return null();
        }

        Dynamic stackinfos(HSQUIRRELVM v, SQInteger idx) {
            SQStackInfos si;

            if (SQ_SUCCEEDED(sq_stackinfos(v, idx, &si))){
                hx::Anon out = hx::Anon_obj::Create();

                if (si.funcname){
                    out->Add(HX_CSTRING("funcname"), ::String(si.funcname));
                } else {
                    out->Add(HX_CSTRING("funcname"), ::String("unknown"));
                }

                if (si.source){
                    out->Add(HX_CSTRING("source"), ::String(si.source));
                } else {
                    out->Add(HX_CSTRING("source"), ::String("unknown")); 
                }

                if (si.line){
                    out->Add(HX_CSTRING("line"), si.line);
                } else {
                    out->Add(HX_CSTRING("line"), 0); 
                }

                return out;
            }
            return null();
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