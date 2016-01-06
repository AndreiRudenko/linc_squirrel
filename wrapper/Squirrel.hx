package wrapper;

import squirrel.SQ;
import squirrel.SQstd;
import squirrel.SQVM;
import squirrel.SQ_Convert;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

class Squirrel {
    
    public var vm(default, null):HSQUIRRELVM;

    /**
     * Creates a new Squirrel vm state
     */
    public function new(?initsize:Int){
        create(initsize);
    }

    /**
     * Close Squirrel vm state
     */
    public function close(){
        _close(vm);
    }

    /**
     * Create Squirrel vm state
     * initsize : the size of the stack in slots(number of objects)
     */
    public function create(initsize:Int = 1024){
        if(vm != null) close();
        vm = _create(initsize);
    }

    /**
     * Get the version string from Squirrel
     */
    public static var version(get, never):Int;
    private inline static function get_version():Int {
        return SQ.getversion();
    }

    /**
     * Loads Squirrel libraries (io, math, blob, system, string)
     * @param libs An array of library names to load
     */
    public function loadLibs(?libs:Array<String>):Void {
        if(libs == null) libs = ["io","blob","math","system","string"]; 

        SQ.pushroottable(vm);
        for (l in libs) {
            switch (l) {
                case "io":
                    SQstd.register_iolib(vm);
                case "blob":
                    SQstd.register_bloblib(vm);
                case "math":
                    SQstd.register_mathlib(vm);
                case "system":
                    SQstd.register_systemlib(vm);
                case "string":
                    SQstd.register_stringlib(vm);
            }
        }

        SQ.poptop(vm);
    }

    // set global variable
    public function setVar(vname:String, v:Dynamic):Void {
        SQ.pushroottable(vm);
        SQ.pushstring(vm, vname, -1);
        SQ_Convert.haxe_value_to_sq(vm, v);
        SQ.createslot(vm, -3);
        SQ.poptop(vm);
    }

    // get global variable
    public function getVar(vname:String):Dynamic {
        var hv:Dynamic = null;
        SQ.pushroottable(vm); //pushes the global table
        SQ.pushstring(vm,vname,-1);
        if(SQ.SUCCEEDED(SQ.get(vm,-2))) { //gets the field 'foo' from the global table
            hv = SQ_Convert.sq_value_to_haxe(vm, -1);
            SQ.poptop(vm);
        }
        SQ.poptop(vm);

        return hv;
    }

    // delete global variable
    public function deleteVar(vname:String):Void {
        SQ.pushroottable(vm);
        SQ.pushstring(vm,vname,-1);
        SQ.deleteslot(vm, -2, false);
        SQ.poptop(vm);
    }

    // set callback function
    public function setFunction(fname:String, f:Dynamic, nparams:Int = 0, typemask:String = null):Bool {
        return SQ.register(vm, fname, f, nparams, typemask);
    }

    // remove callback function
    public function removeFunction(fname:String):Void {
        SQ.unregister(vm, fname);
    }

    /**
     * Runs a Squirrel script
     * @param script The Squirrel script to run in a string
     * @param retVal if true return script result
     * @return return the result from the Squirrel script or null
     */
    public function execute(script:String, retVal:Bool = false):Dynamic {
        var hv:Dynamic = null;
        var oldtop:Int = SQ.gettop(vm);

        SQ.compilebuffer(vm, script, script.length, "compile", true); // <- very slow

        SQ.pushroottable(vm);

        if(SQ.FAILED(SQ.call(vm,1,retVal,true))){
            SQ.getlasterror(vm);
            trace("\nSQ EXECUTE ERROR [" + SQ.getstring(vm, -1) + "]");
        } else if(retVal){
            hv = SQ_Convert.sq_value_to_haxe(vm, -1);
        }

        SQ.settop(vm, oldtop);

        return hv;
    }

    /**
     * Calls a previously loaded lua function
     * @param fname The lua function name (globals only)
     * @param args A single argument or array of arguments
     * @param retVal if true return script result
     * @return return the result from the Squirrel script or null
     */
    public function call(fname:String, args:Dynamic, retVal:Bool = false):Dynamic { // if retVal == false then 20% faster 

        var hv:Dynamic = null;
        var oldtop:Int = SQ.gettop(vm);

        SQ.pushroottable(vm);
        SQ.pushstring(vm, fname, -1);
        if(SQ.SUCCEEDED(SQ.get(vm, -2))){
            SQ.pushroottable(vm);

            if(args == null){
                if(SQ.FAILED(SQ.call(vm, 1, retVal, true))){
                    SQ.getlasterror(vm);
                    trace("\nSQ FUNCTION CALL ERROR [" + SQ.getstring(vm, -1) + "]");
                } else if(retVal){
                    hv = SQ_Convert.sq_value_to_haxe(vm, -1);
                }
            } else {
                if(Std.is(args, Array)){
                    var nargs:Int = 1;
                    var arr:Array<Dynamic>;
                    arr = cast args;
                    for (a in arr) {
                        if(SQ_Convert.haxe_value_to_sq(vm, a)){
                            nargs++;
                        }
                    }
                    if(SQ.FAILED(SQ.call(vm, nargs, retVal, true))){
                        SQ.getlasterror(vm);
                        trace("\nSQ FUNCTION CALL ERROR [" + SQ.getstring(vm, -1) + "]");
                    } else if(retVal){
                        hv = SQ_Convert.sq_value_to_haxe(vm, -1);
                    }
                } else {
                    if(SQ_Convert.haxe_value_to_sq(vm, args)){

                        if(SQ.FAILED(SQ.call(vm, 2, retVal, true))){
                            SQ.getlasterror(vm);
                            trace("\nSQ FUNCTION CALL ERROR [" + SQ.getstring(vm, -1) + "]");
                        } else if(retVal){
                            hv = SQ_Convert.sq_value_to_haxe(vm, -1);
                        }
                    } else {
                        trace('unknown type!');
                    }
                }
            }
        } else {
            SQ.getlasterror(vm);
            trace("\nSQ FUNCTION CALL ERROR [" + SQ.getstring(vm, -1) + "]");
        }

        SQ.settop(vm, oldtop);

        return hv;
    }

    /**
     * Runs a Squirrel file
     * @param path The path of the Squirrel file to run
     */
    public function doFile(path:String):Bool {
        SQ.pushroottable(vm);
        var ret:Bool = SQ.SUCCEEDED(SQstd.dofile(vm, path, false, true));
        if(!ret){
            SQ.getlasterror(vm);
            trace("\nSQ DOFILE ERROR [" + SQ.getstring(vm, -1) + "]");
            SQ.poptop(vm);
        }
        SQ.poptop(vm);
        return ret;
    }

    /**
     * Convienient way to run a Squirrel script in Haxe without loading any libraries
     * @param script The Squirrel script to run in a string
     * @return The result from the Squirrel script in Haxe
     */
    public static function run(script:String, retVal:Bool = false):Dynamic {
        var sq:Squirrel = new Squirrel();
        var ret:Dynamic = sq.execute(script, retVal);
        sq.close();
        return ret;
    }
    /**
     * Convienient way to run a Squirrel file in Haxe without loading any libraries
     * @param script The path of the Squirrel file to run
     */
    public static function runFile(path:String):Bool {
        var sq:Squirrel = new Squirrel();
        var ret:Bool = sq.doFile(path);
        sq.close();
        return ret;
    }


// helpers

    public static inline function stackDump(vm:HSQUIRRELVM){
        var top:Int = SQ.gettop(vm);
        trace("---------------- Stack Dump ----------------");
        // trace("top = " + top);
        while(top > 0){
            trace( top + " " + SQ_Convert.sq_value_to_haxe(vm, top));
            top--;
        }
        trace("---------------- Stack Dump Finished ----------------");
    }

    function _create(initsize:Int):HSQUIRRELVM {
        // trace('create new Squirrel VM');
        var _vm:HSQUIRRELVM = SQ.open(initsize);

        SQ.pushroottable(_vm); //push the root table(were the globals of the script will be stored)

        SQstd.seterrorhandlers(_vm); //registers the default error handlers
        SQ.setprintfunc(_vm); //sets the print function

        SQ.init_callbacks(_vm); // init callbacks

        SQ.poptop(_vm); //pops the root table
        return _vm;
    }

    function _close(_vm:HSQUIRRELVM){
        if(_vm == null) return;
        // trace('close Squirrel VM');

        // SQ.pop(_vm,1); //pops the root table 
        SQ.settop(vm, 0);
        SQ.close(_vm);  
        _vm = null;
    }

}
