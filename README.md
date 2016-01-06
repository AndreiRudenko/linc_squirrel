# linc/Squirrel
Haxe/hxcpp @:native bindings for [Squirrel](https://squirrel-lang.org/).

This is a [linc](http://snowkit.github.io/linc/) library.

---

This library works with the Haxe cpp target only.

---

### Example usage

See test/Test.hx

Be sure to read the Squirrel documentation
http://squirrel-lang.org/doc/squirrel3.html
http://wiki.squirrel-lang.org/

```haxe
import squirrel.SQ;
import squirrel.SQstd;

class Example {

    static function main() {

        var v:HSQUIRRELVM = SQ.open(1024);
        SQ.pushroottable(v); 
        SQstd.seterrorhandlers(v); 
        SQ.setprintfunc(v); 

        SQstd.dofile(v, "script.nut", false, true);

        SQ.pushroottable(v);
        SQ.pushstring(v, "foo", -1);
        SQ.get(v,-2);
        SQ.pushroottable(v); 
        SQ.pushinteger(v, 1);
        SQ.pushfloat(v, 2.0);
        SQ.pushstring(v, "three", -1);
        SQ.call(v, 4, false, true);
        SQ.pop(v, 2); 

        SQ.pop(v, 1);
        SQ.close(v);
    }

}
```