package squirrel;

import squirrel.SQ;
import squirrel.SQVM;

class SQ_Convert{

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
                SQ.pushfloat(vm, cast(val, Float));
            case Type.ValueType.TClass(String):
                // trace("TClass(String)");
                SQ.pushstring(vm, cast(val, String), -1);
            case Type.ValueType.TClass(Array):
                // trace("TClass(Array)");
                haxe_array_to_sq(vm, val);
            case Type.ValueType.TObject:
                // trace("TObject"); // {}
                haxe_object_to_sq(vm, val);
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

        switch(SQ.gettype(vm, sv)) {
            case OT_NULL: // done
                hv = null;
                // trace("null\n");
            case OT_BOOL:
                hv = SQ.getbool(vm, sv);
                // trace("bool\n");
            case OT_INTEGER:
                hv = SQ.getinteger(vm, sv);
                // trace("integer\n");
            case OT_FLOAT:
                hv = SQ.getfloat(vm, sv);
                // trace("float\n");
            case OT_STRING: // done
                hv = SQ.getstring(vm, sv);
                // trace("string\n");
            case OT_TABLE:
                // hv = null;
                hv = sq_table_to_haxe(vm);
                // trace("table\n");
            case OT_ARRAY:
                hv = sq_array_to_haxe(vm);
                // trace("array\n");
            case OT_USERDATA:
                hv = null;
                // trace("userdata\n");
            case OT_CLOSURE:
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
            case OT_CLASS:
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

    public static inline function getObjType(ot:SQObjectType) {
        switch(ot) {
            case OT_NULL:
                trace("null\n");
            case OT_BOOL:
                trace("bool\n");
            case OT_INTEGER:
                trace("integer\n");
            case OT_FLOAT:
                trace("float\n");
            case OT_STRING:
                trace("string\n");
            case OT_TABLE:
                trace("table\n");
            case OT_ARRAY:
                trace("array\n");
            case OT_USERDATA:
                trace("userdata\n");
            case OT_CLOSURE:
                trace("closure(function)\n");
            case OT_NATIVECLOSURE:
                trace("native closure(C function)\n");
            case OT_GENERATOR:
                trace("generator\n");
            case OT_USERPOINTER:
                trace("userpointer\n");
            case OT_CLASS:
                trace("class\n");
            case OT_INSTANCE:
                trace("instance\n");
            case OT_WEAKREF:
                trace("weak reference\n");
            default:
                trace("return value not supported\n");
        }
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

    public static function sq_table_to_haxe(vm:HSQUIRRELVM):Anon {
        var obj:Anon = Anon.create(); // {}

        SQ.pushnull(vm);
        while(SQ.SUCCEEDED(SQ.next(vm,-2))) {
            // here -1 is the value and -2 is the key

            if(SQ.gettype(vm, -2) != OT_NULL) {
                obj.add(Std.string(sq_value_to_haxe(vm, -2)), sq_value_to_haxe(vm, -1));
            }

            SQ.pop(vm,2); //pops key and val before the next iteration
        }
        SQ.pop(vm,1); //pops the null iterator

        return obj;
    }

}

// Anon_obj from hxcpp
@:include('hxcpp.h')
@:native('hx::Anon')
extern class Anon {

    @:native('hx::Anon_obj::Create')
    public static function create() : Anon;

    @:native('hx::Anon_obj::Add')
    public function add(k:String, v:Dynamic):Void;

}