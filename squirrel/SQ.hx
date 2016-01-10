package squirrel;

import squirrel.SQVM;

@:keep
@:include('linc_squirrel.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('squirrel'))
#end
extern class SQ {

// Squirrel API

    @:native('SQ_FAILED')
    static function FAILED(n:Int) : Bool;

    @:native('SQ_SUCCEEDED')
    static function SUCCEEDED(n:Int) : Bool;

// Virtual Machine

    @:native('sq_close')
    static function close(v:HSQUIRRELVM) : Void;

    // @:native('sq_geterrorfunc')
    // static function geterrorfunc(v:HSQUIRRELVM) : SQPRINTFUNCTION;

    @:native('sq_getforeignptr')
    static function getforeignptr(v:HSQUIRRELVM) : SQUserPointer;

    // @:native('sq_getprintfunc')
    // static function getprintfunc(v:HSQUIRRELVM) : SQPRINTFUNCTION;

    @:native('sq_getversion')
    static function getversion() : Int;

    @:native('sq_getvmstate')
    static function getvmstate(v:HSQUIRRELVM) : Int;

    @:native('sq_move')
    static function move(dest:HSQUIRRELVM, src:HSQUIRRELVM, idx:Int) : Void;

    @:native('sq_newthread')
    static function newthread(friendvm:HSQUIRRELVM, initialstacksize:Int) : HSQUIRRELVM;

    @:native('sq_open')
    static function open(initialstacksize:Int) : HSQUIRRELVM;

    @:native('sq_pushconsttable')
    static function pushconsttable(v:HSQUIRRELVM) : Void;

    @:native('sq_pushregistrytable')
    static function pushregistrytable(v:HSQUIRRELVM) : Void;

    @:native('sq_pushroottable')
    static function pushroottable(v:HSQUIRRELVM) : Void;

    @:native('sq_setconsttable')
    static function setconsttable(v:HSQUIRRELVM) : Void;

    @:native('sq_seterrorhandler')
    static function seterrorhandler(v:HSQUIRRELVM) : Void;

    @:native('sq_setforeignptr')
    static function setforeignptr(v:HSQUIRRELVM, p:SQUserPointer) : Void;

    @:native('linc::squirrel::setprintfunc')
    static function _setprintfunc(v:HSQUIRRELVM, f:cpp.Callable<String->Int>) : Void;

    static inline function setprintfunc(v:HSQUIRRELVM) : Void {
        _setprintfunc(v, cpp.Callable.fromStaticFunction(SQ_helper.print_function));
    }

    @:native('sq_setroottable')
    static function setroottable(v:HSQUIRRELVM) : Void;

    @:native('sq_suspendvm')
    static function suspendvm(v:HSQUIRRELVM) : SQRESULT;

    @:native('sq_wakeupvm')
    static function wakeupvm(v: HSQUIRRELVM, resumedret:Bool, retval:Bool, raiseerror:Bool, throwerror:Bool) : SQRESULT;



// Compiler

    // @:native('sq_compile')
    // static function compile(v:HSQUIRRELVM, read:HSQLEXREADFUNC , p:SQUserPointer, sourcename:String, raiseerror:Bool) : SQRESULT;

    @:native('sq_compilebuffer')
    static function compilebuffer(v:HSQUIRRELVM, s:String , size:Int, sourcename:String, raiseerror:Bool) : SQRESULT;

    @:native('sq_enabledebuginfo')
    static function enabledebuginfo(v:HSQUIRRELVM, enable:Bool) : Void;

    @:native('sq_notifyallexceptions')
    static function notifyallexceptions(v:HSQUIRRELVM, enable:Bool) : Void;

    @:native('linc::squirrel::setcompilererrorhandler')
    static function setcompilererrorhandler(v:HSQUIRRELVM) : Void;


// Stack Operations

    @:native('sq_cmp') 
    static function cmp(v:HSQUIRRELVM) : Int;

    @:native('sq_gettop')
    static function gettop(v:HSQUIRRELVM) : Int;

    @:native('sq_pop')
    static function pop(v:HSQUIRRELVM, nelemstopop:Int) : Void;

    @:native('sq_poptop')
    static function poptop(v:HSQUIRRELVM) : Void;

    @:native('sq_push')
    static function push(v:HSQUIRRELVM, idx:Int) : Void;

    @:native('sq_remove')
    static function remove(v:HSQUIRRELVM, idx:Int) : Void;

    @:native('sq_reservestack')
    static function reservestack(v:HSQUIRRELVM, nsize:Int) : SQRESULT;

    @:native('sq_settop')
    static function settop(v:HSQUIRRELVM, v:Int) : Void;


// Object creation and handling

    @:native('sq_bindenv')
    static function bindenv(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_createinstance')
    static function createinstance(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('linc::squirrel::getbool')
    static function getbool(v:HSQUIRRELVM, idx:Int) : Bool;

    @:native('linc::squirrel::getbyhandle')
    static function getbyhandle(v:HSQUIRRELVM, idx:Int, handle:HSQMEMBERHANDLE) : SQRESULT;

    @:native('linc::squirrel::getclosureinfo')
    static function getclosureinfo(v:HSQUIRRELVM, idx:Int) : SQClosureInfo;

    @:native('sq_getclosurename')
    static function getclosurename(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('linc::squirrel::getfloat')
    static function getfloat(v:HSQUIRRELVM, idx:Int) : Float;

    @:native('sq_gethash')
    static function gethash(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_getinstanceup')
    static function getinstanceup(v:HSQUIRRELVM, idx:Int, up:SQUserPointer, typetag:SQUserPointer) : SQRESULT;

    @:native('linc::squirrel::getinteger')
    static function getinteger(v:HSQUIRRELVM, idx:Int) : Int;

    @:native('linc::squirrel::getmemberhandle')
    static function getmemberhandle(v:HSQUIRRELVM, idx:Int) : HSQMEMBERHANDLE;

    @:native('sq_getscratchpad')
    static function getscratchpad(v:HSQUIRRELVM, minsize:Int) : SQRESULT;

    @:native('sq_getsize')
    static function getsize(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('linc::squirrel::getstring')
    static function getstring(v:HSQUIRRELVM, idx:Int) : String;

    @:native('sq_getthread')
    static function getthread(v:HSQUIRRELVM, idx:Int, v:HSQUIRRELVM) : SQRESULT;

    @:native('sq_gettype')
    static function gettype(v:HSQUIRRELVM, idx:Int) : SQObjectType;

    @:native('sq_gettypetag')
    static function gettypetag(v:HSQUIRRELVM, idx:Int, typetag:SQUserPointer) : SQRESULT;

    @:native('sq_getuserdata')
    static function getuserdata(v:HSQUIRRELVM, idx:Int, p:SQUserPointer, typetag:SQUserPointer) : SQRESULT;
    
    @:native('linc::squirrel::getuserpointer')
    static function getuserpointer(v:HSQUIRRELVM, idx:Int) : SQUserPointer;

    @:native('sq_newarray')
    static function newarray(v:HSQUIRRELVM, sq_getsize:Int) : Void;

    @:native('sq_newclass')
    static function newclass(v:HSQUIRRELVM, hasbase:Bool) : Void;

    // @:native('sq_newclosure')
    // static function newclosure(v:HSQUIRRELVM, func:HSQFUNCTION, nfreevars:Int) : Void;

    @:native('sq_newtable')
    static function newtable(v:HSQUIRRELVM) : Void;

    @:native('sq_newuserdata')
    static function newuserdata(v:HSQUIRRELVM, size:Int) : Void;

    @:native('sq_pushbool')
    static function pushbool(v:HSQUIRRELVM, b:Bool) : Void;

    @:native('sq_pushfloat')
    static function pushfloat(v:HSQUIRRELVM, f:Float) : Void;

    @:native('sq_pushinteger')
    static function pushinteger(v:HSQUIRRELVM, n:Int) : Void;

    @:native('sq_pushnull')
    static function pushnull(v:HSQUIRRELVM) : Void;

    @:native('sq_pushstring')
    static function pushstring(v:HSQUIRRELVM, s:String, len:Int) : Void;

    @:native('sq_pushuserpointer')
    static function pushuserpointer(v:HSQUIRRELVM, p:SQUserPointer) : Void;

    @:native('linc::squirrel::setbyhandle')
    static function setbyhandle(v:HSQUIRRELVM, idx:Int, handle:HSQMEMBERHANDLE) : SQRESULT;

    @:native('sq_setclassudsize')
    static function setclassudsize(v:HSQUIRRELVM, idx:Int, udsize:Int) : SQRESULT;

    @:native('sq_setinstanceup')
    static function setinstanceup(v:HSQUIRRELVM, idx:Int, up:SQUserPointer) : SQRESULT;

    @:native('sq_setnativeclosurename')
    static function setnativeclosurename(v:HSQUIRRELVM, idx:Int, name:String) : SQRESULT;

    @:native('sq_setparamscheck')
    static function setparamscheck(v:HSQUIRRELVM, nparamscheck:Int, typemask:String) : SQRESULT;

    // @:native('sq_setreleasehook')
    // static function setreleasehook(v:HSQUIRRELVM, idx:Int, hook:SQRELEASEHOOK) : Void;

    @:native('sq_settypetag')
    static function settypetag(v:HSQUIRRELVM, idx:Int, typetag:SQUserPointer) : SQRESULT;

    @:native('sq_tobool')
    static function tobool(v:HSQUIRRELVM, idx:Int,  b:Bool) : Void; // TODO

    @:native('sq_tostring')
    static function tostring(v:HSQUIRRELVM, idx:Int) : Void;

    @:native('sq_typeof')
    static function typeof(v:HSQUIRRELVM, idx:Int) : SQObjectType;


// Calls

    @:native('sq_call')
    static function call(v:HSQUIRRELVM, params:Int, retval:Bool, raiseerror:Bool) : SQRESULT;

    @:native('sq_getcallee')
    static function getcallee(v:HSQUIRRELVM) : SQRESULT;

    @:native('sq_getlasterror')
    static function getlasterror(v:HSQUIRRELVM) : SQRESULT;

    @:native('linc::squirrel::getlocal')
    static function getlocal(v:HSQUIRRELVM, level:UInt, nseq:UInt) : String;

    @:native('sq_reseterror')
    static function reseterror(v:HSQUIRRELVM) : Void;

    @:native('sq_resume')
    static function resume(v:HSQUIRRELVM, retval:Bool, raiseerror:Bool) : SQRESULT;

    @:native('sq_throwerror')
    static function throwerror(v:HSQUIRRELVM, err:String) : SQRESULT; // TODO

    @:native('sq_throwobject')
    static function throwobject(v:HSQUIRRELVM) : SQRESULT;



// Objects manipulation

    @:native('sq_arrayappend')
    static function arrayappend(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_arrayinsert')
    static function arrayinsert(v:HSQUIRRELVM, idx:Int, destpos:Int) : SQRESULT;

    @:native('sq_arraypop')
    static function arraypop(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_arrayremove')
    static function arrayremove(v:HSQUIRRELVM, idx:Int, itemidx:Int) : SQRESULT;

    @:native('sq_arrayresize')
    static function arrayresize(v:HSQUIRRELVM, idx:Int, newsize:Int) : SQRESULT;

    @:native('sq_arrayreverse')
    static function arrayreverse(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_clear')
    static function clear(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_clone')
    static function clone(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_createslot')
    static function createslot(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_deleteslot')
    static function deleteslot(v:HSQUIRRELVM, idx:Int, pushval:Bool) : SQRESULT;

    @:native('sq_get')
    static function get(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_getattributes')
    static function getattributes(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_getclass')
    static function getclass(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_getdelegate')
    static function getdelegate(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_getfreevariable')
    static function getfreevariable(v:HSQUIRRELVM, idx:Int, nval:Int) : SQRESULT;

    @:native('sq_getweakrefval')
    static function getweakrefval(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_instanceof') // TODO: return bool from cpp
    static function instanceof(v:HSQUIRRELVM) : Bool;

    @:native('sq_newmember')
    static function newmember(v:HSQUIRRELVM, idx:Int, bstatic:Bool) : SQRESULT;

    @:native('sq_newslot')
    static function newslot(v:HSQUIRRELVM, idx:Int, bstatic:Bool) : SQRESULT;

    @:native('sq_next')
    static function next(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_rawdeleteslot')
    static function rawdeleteslot(v:HSQUIRRELVM, idx:Int, pushval:Bool) : SQRESULT;

    @:native('sq_rawget')
    static function rawget(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_rawnewmember')
    static function rawnewmember(v:HSQUIRRELVM, idx:Int, bstatic:Bool) : SQRESULT;

    @:native('sq_rawset')
    static function rawset(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_set')
    static function set(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_setattributes')
    static function setattributes(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_setdelegate')
    static function setdelegate(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('sq_setfreevariable')
    static function setfreevariable(v:HSQUIRRELVM, idx:Int, nval:Int) : SQRESULT;

    @:native('sq_weakref')
    static function weakref(v:HSQUIRRELVM, idx:Int) : SQRESULT;


// Bytecode serialization

    // @:native('sq_readclosure')
    // static function readclosure(v:HSQUIRRELVM, readf:SQREADFUNC, up:SQUserPointer) : SQRESULT;

    // @:native('sq_writeclosure')
    // static function writeclosure(v:HSQUIRRELVM, writef:SQWRITEFUNC, up:SQUserPointer) : SQRESULT;


// Raw object handling

    @:native('sq_addref')
    static function addref(v:HSQUIRRELVM, po:HSQOBJECT) : Void;

    @:native('sq_getobjtypetag')
    static function getobjtypetag(o:HSQOBJECT, typetag:SQUserPointer) : Void;

    @:native('sq_getrefcount')
    static function getrefcount(v:HSQUIRRELVM, po:HSQOBJECT) : UInt;

    @:native('linc::squirrel::getstackobj')
    static function getstackobj(v:HSQUIRRELVM, idx:Int) : HSQOBJECT;

    @:native('linc::squirrel::objtobool')
    static function objtobool(po:HSQOBJECT) : Bool;

    @:native('sq_objtofloat')
    static function objtofloat(po:HSQOBJECT) : Float;

    @:native('sq_objtointeger')
    static function objtointeger(po:HSQOBJECT) : Int;

    @:native('linc::squirrel::objtostring')
    static function objtostring(po:HSQOBJECT) : String;

    @:native('sq_objtouserpointer')
    static function objtouserpointer(po:HSQOBJECT) : SQUserPointer;

    @:native('sq_pushobject')
    static function pushobject(v:HSQUIRRELVM, po:HSQOBJECT) : Void;

    @:native('linc::squirrel::hx_sq_release')
    static function release(v:HSQUIRRELVM, po:HSQOBJECT) : Bool;

    @:native('sq_resetobject')
    static function resetobject(po:HSQOBJECT) : Void;


// Garbage Collector

    // runs the garbage collector and returns the number of reference cycles found(and deleted)
    @:native('sq_collectgarbage')
    static function collectgarbage(v:HSQUIRRELVM) : Int;

    // runs the garbage collector and pushes an array in the stack containing all unreachable object found. If no
    // unreachable object is found, null is pushed instead. This function is meant to help debugging reference cycles.
    @:native('sq_resurrectunreachable')
    static function resurrectunreachable(v:HSQUIRRELVM) : SQRESULT;


// Debug interface

    @:native('linc::squirrel::getfunctioninfo') // is it works ?
    static function getfunctioninfo(v:HSQUIRRELVM, level:Int) : SQFunctionInfo;

    @:native('sq_setdebughook')
    static function setdebughook(v:HSQUIRRELVM) : Void;

    // @:native('sq_setnativedebughook')
    // static function setnativedebughook(v:HSQUIRRELVM, hook:SQDEBUGHOOK) : Void;

    @:native('linc::squirrel::stackinfos')
    static function stackinfos(v:HSQUIRRELVM, level:Int) : SQStackInfos;




// unofficial API helpers

    static inline function init_callbacks(vm:HSQUIRRELVM) : Void {
        SQ.set_callbacks_function(cpp.Callable.fromStaticFunction(SQ_helper.callback_handler));
    }


    // register callback function
    // nparams : 
    // 1 = 0 arguments;
    // typemask : 
    // The types are expressed as follows: 
    // 'o' null, 'i' integer, 'f' float, 'n' integer or float, 's' string, 
    // 't' table, 'a' array, 'u' userdata, 'c' closure and nativeclosure, 'g' generator, 
    // 'p' userpointer, 'v' thread, 'x' instance(class instance), 'y' class, 'b' bool. and '.' any type. 
    // The symbol '|' can be used as 'or' to accept multiple types on the same parameter.
    // first must be 't' = function
    static inline function register(vm:HSQUIRRELVM, fname:String, f:Dynamic, nparams:Int = 0, typemask:String = null) : Bool {
        if(Type.typeof(f) == Type.ValueType.TFunction){
            SQ_helper.callbacks.set(fname, f);
            SQ.add_callback_function(vm, fname, nparams, typemask);
            return true;
        }
        return false;
    }

    // remove callback function
    static inline function unregister(vm:HSQUIRRELVM, fname:String) : Void {
        SQ_helper.callbacks.remove(fname);
        SQ.remove_callback_function(vm, fname);
    }

    // clear callbacks 
    static inline function clear_callbacks(vm:HSQUIRRELVM) : Void {
        for (fname in SQ_helper.callbacks.keys()) {
            SQ.remove_callback_function(vm, fname);
            SQ_helper.callbacks.remove(fname);
        }
    }

    @:native('linc::squirrel::set_callbacks_function')
    static function set_callbacks_function(f:cpp.Callable<HSQUIRRELVM->String->Int>) : Void;

    @:native('linc::squirrel::add_callback_function')
    static function add_callback_function(vm:HSQUIRRELVM, name:String, nparams:Int, typemask:String) : Void;

    @:native('linc::squirrel::remove_callback_function')
    static function remove_callback_function(vm:HSQUIRRELVM, name:String) : Void;


} //SQ

@:allow(squirrel.SQ)
@:include('linc_squirrel.h')
private class SQ_helper {

    public static var callbacks:Map<String, Dynamic> = new Map();

    public static inline function print_function(str:String):Int {
        // SQdebug.trace("SQ print: " + str);
        SQdebug.trace(str);
        return 0;
    }


    public static inline function callback_handler(vm:HSQUIRRELVM, fname:String):Int {
        var cbf = callbacks.get(fname);

        if(cbf == null) {
            return 0;
        }

        var nargs:Int = SQ.gettop(vm); // 1 = {} 2... = args
        var args:Array<Dynamic> = [];

        for (i in 1...nargs) {
            args.push(SQ_Convert.sq_value_to_haxe(vm, i + 1));
        }

        var ret:Dynamic = null;
        
        switch (nargs) { // 1 = function with no parameters
            case 1:
                ret = cbf();
            case 2:
                ret = cbf(args[0]);
            case 3:
                ret = cbf(args[0], args[1]);
            case 4:
                ret = cbf(args[0], args[1], args[2]);
            case 5:
                ret = cbf(args[0], args[1], args[2], args[3]);
            case 6:
                ret = cbf(args[0], args[1], args[2], args[3], args[4]);
            default:
                throw("> 5 arguments is not supported");
        }

        if(ret != null){
            SQ_Convert.haxe_value_to_sq(vm, ret);
        }

        // return the number of results
        return 1;
    } //callback_handler


}

class SQdebug {
    public static dynamic function trace( v : String, ?inf:haxe.PosInfos) : Void {  // set your custom trace
        trace(v);
    }
}


@:include('linc_squirrel.h') @:native("SQObjectValue")
private extern class SQObjectValue {}

@:include('linc_squirrel.h') 
@:native("::cpp::Reference<SQObject>")
private extern class SQObject {
    var _type:SQObjectType;
    var _unVal:SQObjectValue;
}
typedef HSQOBJECT = SQObject;

@:include('linc_squirrel.h') 
@:native('::cpp::Reference<SQUserPointer>')
extern class SQUserPointer {}

typedef SQClosureInfo = {
    nparams:UInt,
    nfreevars:UInt
}

typedef SQFunctionInfo = {
    funcid:SQUserPointer,
    name:String,
    source:String
}

typedef SQStackInfos = {
    funcname:String,
    source:String,
    line:Int
}

typedef HSQMEMBERHANDLE = {
    _static:Bool,
    _index:Int
}

typedef SQRESULT = Int;

@:enum
abstract SQObjectType(Int)
from Int to Int {

    var OT_NULL             = 0x00000001 | 0x01000000;
    var OT_INTEGER          = 0x00000002 | 0x04000000 | 0x01000000;
    var OT_FLOAT            = 0x00000004 | 0x04000000 | 0x01000000;
    var OT_BOOL             = 0x00000008 | 0x01000000;
    var OT_STRING           = 0x00000010 | 0x08000000;
    var OT_TABLE            = 0x00000020 | 0x08000000 | 0x02000000;
    var OT_ARRAY            = 0x00000040 | 0x08000000;
    var OT_USERDATA         = 0x00000080 | 0x08000000 | 0x02000000;
    var OT_CLOSURE          = 0x00000100 | 0x08000000;
    var OT_NATIVECLOSURE    = 0x00000200 | 0x08000000;
    var OT_GENERATOR        = 0x00000400 | 0x08000000;
    var OT_USERPOINTER      = 0x00000800 | 0x08000000;
    var OT_THREAD           = 0x00001000 | 0x08000000;
    var OT_FUNCPROTO        = 0x00002000 | 0x08000000;
    var OT_CLASS            = 0x00004000 | 0x08000000;
    var OT_INSTANCE         = 0x00008000 | 0x08000000 | 0x02000000;
    var OT_WEAKREF          = 0x00010000 | 0x08000000;
    var OT_OUTER            = 0x00020000 | 0x08000000;

} //SQObjectType
