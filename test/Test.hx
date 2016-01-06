import squirrel.SQ;
import squirrel.SQstd;
import squirrel.SQVM;

class Test {

    static function main() {
        callFunction();
        testCallback();
    }

    static function callFunction() {
        trace("Test calling Function");

        var v:HSQUIRRELVM = SQ.open(1024); //creates a VM with initial stack size 1024
        trace("Create Squirrel VM");
        trace("version: " + SQ.getversion());
        SQ.pushroottable(v); //push the root table(were the globals of the script will be stored)
        SQstd.seterrorhandlers(v); //registers the default error handlers
        SQ.setprintfunc(v); //sets the print function

        // do stuff
        SQstd.dofile(v, "script.nut", false, true); // load compile and run script

        // this is equivalent to the following Squirrel code
        // foo(1,2.0,”three”);
        SQ.pushroottable(v);
        SQ.pushstring(v, "foo", -1);
        SQ.get(v,-2); //get the function from the root table
        SQ.pushroottable(v); //’this’ (function environment object)
        SQ.pushinteger(v, 1);
        SQ.pushfloat(v, 2.0);
        SQ.pushstring(v, "three", -1);
        SQ.call(v, 4, false, true);
        SQ.pop(v, 2); //pops the roottable and the function


        SQ.pop(v, 1); //pops the root table
        SQ.close(v);
        trace("Close Squirrel VM\n");
    }

    static function testCallback() {
        trace("Test Callbacks");
        
        var v:HSQUIRRELVM = SQ.open(1024); //creates a VM with initial stack size 1024
        trace("Create Squirrel VM");
        trace("version: " + SQ.getversion());
        SQ.pushroottable(v); //push the root table(were the globals of the script will be stored)
        SQstd.seterrorhandlers(v); //registers the default error handlers
        SQ.setprintfunc(v); //sets the print function

        // do stuff
        SQ.init_callbacks(v); // unofficial API
        SQ.register( // unofficial API
            v,
            "callback", 
            function (a:Float) { 
                trace("Called callback(), a = " + a); 
                return a;
            },
            2, // arguments number: 1 = 0, 2 = 1 arg.
            "tn" // typecheck: first must be table 't', 'n' = number(Float/Int)
        );

        SQ.pushroottable(v);
        SQ.pushstring(v, "callback", -1);
        SQ.get(v,-2); //get the function from the root table
        SQ.pushroottable(v); //’this’ (function environment object)
        SQ.pushfloat(v, 2.0);
        SQ.call(v, 2, false, true);
        SQ.pop(v, 2); //pops the roottable and the function

        SQ.unregister(v, "callback");  // unofficial API

        SQ.pop(v, 1); //pops the root table
        SQ.close(v);
        trace("Close Squirrel VM\n");
    }



}