package squirrel;

@:keep
@:include('linc_squirrel.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('squirrel'))
#end
extern class SQ {

// Squirrel API

// Virtual Machine

    @:native('sq_close')
    static function close(v:HSQUIRRELVM) : Void;

    // @:native('sq_geterrorfunc')
    // static function geterrorfunc(v:HSQUIRRELVM) : SQPRINTFUNCTION;

    // @:native('sq_getforeignptr')
    // static function getforeignptr(v:HSQUIRRELVM) : SQUserPointer;

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

    // @:native('sq_setforeignptr')
    // static function setforeignptr(v:HSQUIRRELVM, p:SQUserPointer) : Void;

    @:native('linc::squirrel::setprintfunc')
    static function setprintfunc(v:HSQUIRRELVM) : Void;

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

    // @:native('sq_setcompilererrorhandler')
    // static function sq_setcompilererrorhandler(v:HSQUIRRELVM, f:SQCOMPILERERROR) : Void;


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
    static function getbool(v:HSQUIRRELVM, idx:Int) : Bool; // TODO

    // @:native('sq_getbyhandle')
    // static function getbyhandle(v:HSQUIRRELVM, idx:Int, handle:HSQMEMBERHANDLE) : SQRESULT; // TODO

    // @:native('sq_getclosureinfo')
    // static function getclosureinfo(v:HSQUIRRELVM, idx:Int, nparams:SQUnsignedInteger, nfreevars:SQUnsignedInteger) : SQRESULT; // TODO

    @:native('sq_getclosurename')
    static function getclosurename(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('linc::squirrel::getfloat')
    static function getfloat(v:HSQUIRRELVM, idx:Int) : Float;

    @:native('sq_gethash')
    static function gethash(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    // @:native('sq_getinstanceup')
    // static function getinstanceup(v:HSQUIRRELVM, idx:Int, up:SQUserPointer, typetag:SQUserPointer) : SQRESULT;

    @:native('linc::squirrel::getinteger')
    static function getinteger(v:HSQUIRRELVM, idx:Int) : Int;

    // @:native('sq_getmemberhandle')
    // static function getmemberhandle(v:HSQUIRRELVM, idx:Int, handle:HSQMEMBERHANDLE) : SQRESULT;

    @:native('sq_getscratchpad')
    static function getscratchpad(v:HSQUIRRELVM, minsize:Int) : SQRESULT;

    @:native('sq_getsize')
    static function getsize(v:HSQUIRRELVM, idx:Int) : SQRESULT;

    @:native('linc::squirrel::getstring')
    static function getstring(v:HSQUIRRELVM, idx:Int) : String;

    // @:native('sq_getthread')
    // static function getthread(v:HSQUIRRELVM, idx:Int, v:HSQUIRRELVM) : SQRESULT;

    @:native('sq_gettype')
    static function gettype(v:HSQUIRRELVM, idx:Int) : SQObjectType;

    // @:native('sq_gettypetag')
    // static function gettypetag(v:HSQUIRRELVM, idx:Int, typetag:SQUserPointer) : SQRESULT;

    // @:native('sq_getuserdata')
    // static function getuserdata(v:HSQUIRRELVM, idx:Int, p:SQUserPointer, typetag:SQUserPointer) : SQRESULT;

    // @:native('sq_getuserpointer')
    // static function getuserpointer(v:HSQUIRRELVM, idx:Int, p:SQUserPointer) : SQRESULT;

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

    // @:native('sq_pushuserpointer')
    // static function pushuserpointer(v:HSQUIRRELVM, p:SQUserPointer) : Void;

    // @:native('sq_setbyhandle')
    // static function setbyhandle(v:HSQUIRRELVM, idx:Int, handle:HSQMEMBERHANDLE) : SQRESULT;

    @:native('sq_setclassudsize')
    static function setclassudsize(v:HSQUIRRELVM, idx:Int, udsize:Int) : SQRESULT;

    // @:native('sq_setinstanceup')
    // static function setinstanceup(v:HSQUIRRELVM, idx:Int, up:SQUserPointer) : SQRESULT;

    @:native('sq_setnativeclosurename')
    static function setnativeclosurename(v:HSQUIRRELVM, idx:Int, name:String) : SQRESULT;

    @:native('sq_setparamscheck')
    static function setparamscheck(v:HSQUIRRELVM, nparamscheck:Int, typemask:String) : SQRESULT;

    // @:native('sq_setreleasehook')
    // static function setreleasehook(v:HSQUIRRELVM, idx:Int, hook:SQRELEASEHOOK) : Void;

    // @:native('sq_settypetag')
    // static function settypetag(v:HSQUIRRELVM, idx:Int, typetag:SQUserPointer) : SQRESULT;

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

    // @:native('sq_getlocal')
    // static function getlocal(v:HSQUIRRELVM, level:SQUnsignedInteger, nseq:SQUnsignedInteger) : String;

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

    @:native('sq_instanceof')
    static function instanceof(v:HSQUIRRELVM, idx:Int) : SQRESULT;

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
    // TODO

// Raw object handling
    // TODO


// Garbage Collector

    // runs the garbage collector and returns the number of reference cycles found(and deleted)
    @:native('sq_collectgarbage')
    static function collectgarbage(v:HSQUIRRELVM) : Int;

    // runs the garbage collector and pushes an array in the stack containing all unreachable object found. If no
    // unreachable object is found, null is pushed instead. This function is meant to help debugging reference cycles.
    @:native('sq_resurrectunreachable')
    static function resurrectunreachable(v:HSQUIRRELVM) : SQRESULT;




    @:native('SQ_FAILED')
    static function FAILED(n:Int) : Bool;

    @:native('SQ_SUCCEEDED')
    static function SUCCEEDED(n:Int) : Bool;

// Debug interface
    // TODO


    // unofficial API helpers
    
    @:native('linc::squirrel::set_callbacks_function')
    static function set_callbacks_function(f:cpp.Callable<HSQUIRRELVM->String->Int>) : Void;

    @:native('linc::squirrel::add_callback_function')
    static function add_callback_function(vm:HSQUIRRELVM, name:String, nparams:Int, typemask:String) : Void;

    @:native('linc::squirrel::remove_callback_function')
    static function remove_callback_function(vm:HSQUIRRELVM, name:String) : Void;


} //SQ


class SQ_helper{

    public static var callbacks:Map<String, Dynamic> = new Map();

    public static inline function init_callbacks(vm:HSQUIRRELVM) : Void {
        SQ.set_callbacks_function(cpp.Callable.fromStaticFunction(SQ_helper.callback_handler));
    }

    // nparams : 
    // 1 = 0 arguments;
    // typemask : 
    // The types are expressed as follows: 
    // 'o' null, 'i' integer, 'f' float, 'n' integer or float, 's' string, 
    // 't' table, 'a' array, 'u' userdata, 'c' closure and nativeclosure, 'g' generator, 
    // 'p' userpointer, 'v' thread, 'x' instance(class instance), 'y' class, 'b' bool. and '.' any type. 
    // The symbol '|' can be used as 'or' to accept multiple types on the same parameter.
    // first must be 't' = function
    public static inline function add_callback(vm:HSQUIRRELVM, fname:String, f:Dynamic, nparams:Int = 0, typemask:String = null) : Bool {
        if(Type.typeof(f) == Type.ValueType.TFunction && !callbacks.exists(fname)){
            callbacks.set(fname, f);
            SQ.add_callback_function(vm, fname, nparams, typemask);
        }
        return true;
    }

    public static inline function remove_callback(vm:HSQUIRRELVM, fname:String):Bool {
        callbacks.remove(fname);
        SQ.remove_callback_function(vm, fname);
        return true;
    }

    public static inline function callback_handler(vm:HSQUIRRELVM, fname:String):Int {
        var cbf = callbacks.get(fname);

        if(cbf == null) {
            return 0;
        }

        var nparams:Int = SQ.gettop(vm); // 1 = {} 2... = params
        var args:Array<Dynamic> = [];

        for (i in 1...nparams) {
            args.push(SQConvert.sq_value_to_haxe(vm, i + 1));
        }

        var ret:Dynamic = null;
        
        switch (nparams) { // 1 = function with no parameters
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
            SQConvert.haxe_value_to_sq(vm, ret);
        }

        /* return the number of results */
        return 1;
    } //callback_handler

    public static inline function stackDump(vm:HSQUIRRELVM){
        var top:Int = SQ.gettop(vm);
        trace("---------------- Stack Dump ----------------");
        // trace("top = " + top);
        while(top > 0){
            trace( top + " " + SQConvert.sq_value_to_haxe(vm, top));
            top--;
        }
        trace("---------------- Stack Dump Finished ----------------");
    }
}
class SQConvert{

    public static function haxe_value_to_sq(vm:HSQUIRRELVM, val:Dynamic):Bool {

        switch (Type.typeof(val)) {
            case Type.ValueType.TNull:
                // trace("TNull");
                SQ.pushnull(vm);
            case Type.ValueType.TBool:
                // trace("TBool");
                SQ.pushbool(vm, cast(val, Bool));
            case Type.ValueType.TInt:
                // trace("TInt");
                SQ.pushinteger(vm, cast(val, Int));
            case Type.ValueType.TFloat:
                // trace("TFloat");
                SQ.pushfloat(vm, val);
            case Type.ValueType.TClass(String):
                // trace("TClass(String)");
                SQ.pushstring(vm, cast(val, String), -1);
            case Type.ValueType.TClass(Array):
                // trace("TClass(Array)");
                haxe_array_to_sq(vm, val);
                // return false;
            case Type.ValueType.TObject:
                // trace("TObject"); // {}
                haxe_object_to_sq(vm, val);
                // return false;
            case Type.ValueType.TFunction:
                // trace("TFunction");
                return false;
            case Type.ValueType.TEnum:
                // trace("TEnum");
                return false;
            default:
                return false;
                // trace("haxe value not supported\n");
        }
        return true;
    }

    static inline function haxe_array_to_sq(vm:HSQUIRRELVM, arr:Array<Dynamic>) {
        var size:Int = arr.length;
        SQ.newarray(vm, 0);
        for (i in 0...size) {
            if(haxe_value_to_sq(vm, arr[i])){
                SQ.arrayappend(vm, -2);  
            }
        }

    }

    static inline function haxe_object_to_sq(vm:HSQUIRRELVM, res:Dynamic) {
        SQ.newtable(vm);
        for (n in Reflect.fields(res)){
            SQ.pushstring(vm, n, -1);
            haxe_value_to_sq(vm, Reflect.field(res, n));
            SQ.newslot(vm, -3, false );
        }
    }

    public static inline function sq_value_to_haxe(vm:HSQUIRRELVM, sv:Int) {
        // trace("sq_value_to_haxe\n");

        var hv:Dynamic;

        // trace("arg %d is " + sv);
        switch(SQ.gettype(vm, sv)) {
            case OT_NULL: // done
                hv = null;
                // trace("null\n");
            case OT_BOOL: // done
                hv = SQ.getbool(vm, sv);
                // trace("bool\n");
            case OT_INTEGER: // done
                hv = SQ.getinteger(vm, sv);
                // trace("integer\n");
            case OT_FLOAT: // done
                hv = SQ.getfloat(vm, sv);
                // trace("float\n");
            case OT_STRING: // done
                hv = SQ.getstring(vm, sv);
                // trace("string\n");
            case OT_TABLE: // done
                // hv = null;
                hv = sq_table_to_haxe(vm);
                // trace("table\n");
            case OT_ARRAY: // done
                hv = sq_array_to_haxe(vm);
                // trace("array\n");
            case OT_USERDATA: // TODO
                hv = null;
                // trace("userdata\n");
            case OT_CLOSURE: // TODO
                hv = null;
                // trace("closure(function)\n");
            case OT_NATIVECLOSURE:
                hv = null;
                // trace("native closure(C function)\n");
            case OT_GENERATOR:
                hv = null;
                // trace("generator\n");
            case OT_USERPOINTER:
                hv = null;
                // trace("userpointer\n");
            case OT_CLASS: // TODO
                hv = null;
                // trace("class\n");
            case OT_INSTANCE:
                hv = null;
                // trace("instance\n");
            case OT_WEAKREF:
                hv = null;
                // trace("weak reference\n");
            default:
                hv = null;
                trace("return value not supported\n");
        }
        // trace("\n");
        return hv;
    }

    public static function sq_array_to_haxe(vm:HSQUIRRELVM):Array<Dynamic> {
        var arr:Array<Dynamic> = [];
        
        SQ.pushnull(vm);
        while(SQ.SUCCEEDED(SQ.next(vm,-2))) {
            // here -1 is the value and -2 is the key

            if(SQ.gettype(vm, -1) != OT_NULL) {
                arr.push(sq_value_to_haxe(vm, -1));
            }

            SQ.pop(vm,2); //pops key and val before the next iteration
        }
        SQ.pop(vm,1); //pops the null iterator

        return arr;
    }

    public static function sq_table_to_haxe(vm:HSQUIRRELVM):Anon_obj {
        var obj:Anon_obj = Anon_obj.create(); // {}

        SQ.pushnull(vm);
        while(SQ.SUCCEEDED(SQ.next(vm,-2))) {
            // here -1 is the value and -2 is the key

            if(SQ.gettype(vm, -2) != OT_NULL) {
                obj.Add(Std.string(sq_value_to_haxe(vm, -2)), sq_value_to_haxe(vm, -1));
            }

            SQ.pop(vm,2); //pops key and val before the next iteration
        }
        SQ.pop(vm,1); //pops the null iterator

        return obj;
    }

}

@:include('linc_squirrel.h')
@:native('::cpp::Reference<SQVM>')
private extern class SQVM {}
typedef HSQUIRRELVM = SQVM;

// Anon_obj from hxcpp
@:include('hxcpp.h')
@:native('hx::Anon')
private extern class Anon {

    @:native('hx::Anon_obj::Create')
    public static function create() : Anon_obj;

    @:native('hx::Anon_obj::Add')
    public function Add(k:String, v:Dynamic):Void;
}
typedef Anon_obj = Anon;

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
