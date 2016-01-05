import squirrel.SQ;
import squirrel.SQstd;
import wrapper.Squirrel;

class Test {

    static function main() {
    	var squirrel:Squirrel = new Squirrel();
        squirrel.loadLibs();

        // SQ_helper.stackDump(squirrel.vm);

        trace("Squirrel version : " + Squirrel.version);
    	trace("Float precision : " + squirrel.getVar("_floatsize_"));

        trace(squirrel.execute('return true', true));
        trace(squirrel.execute('return false', true));
        trace(squirrel.execute('return 123', true));
        trace(squirrel.execute('return 12.57', true));
        trace(squirrel.execute('return "this is string"', true));
        trace(squirrel.execute('return [1, 3.5, 123, "some string", [754, 12.23, "some string"]]', true));
        trace(squirrel.execute('return {a = 123, b = "some text", c = 53.67, d = [1,2,3,4]}', true));

        // callbacks
        squirrel.setFunction(
            "callBack", 
            function (a:Float) { 
                trace("haxe callBack!!!"); 
                trace(a); 
                return a;
            },
            2, // ?arguments : 1 = 0 arg, 2 = 1 arg;
            "ts" // ?typecheck : first must be table 't'
        );

        squirrel.doFile("script.nut");

        squirrel.execute('test()'); // cant return function result
        
        trace(squirrel.call('test', null, true));
        trace(squirrel.call('test2', 845, true));
        trace(squirrel.call('test2', {"a" : 423.5}, true));
        trace(squirrel.call('test2', [12], true));

        squirrel.setVar("testvar", 1.618 );
        trace(squirrel.getVar("testvar"));
        squirrel.deleteVar("testvar");

        squirrel.removeFunction("callBack");

        // SQ_helper.stackDump(squirrel.vm);

    	squirrel.close();

    }

}