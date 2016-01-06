package squirrel;

import squirrel.SQ;

@:include('linc_squirrel.h')
extern class SQstd {

// The Input/Output library

	// Initialization
    @:native('sqstd_register_iolib')
    static function register_iolib(v:HSQUIRRELVM) : SQRESULT;

    // File object
    // @:native('sqstd_createfile')
    // static function createfile(v:HSQUIRRELVM, file:SQFILE, own:Bool) : SQRESULT;

    // @:native('sqstd_getfile')
    // static function getfile(v:HSQUIRRELVM, idx:Int, file:SQFILE) : SQRESULT;


    // Script loading and serialization
    @:native('sqstd_loadfile')
    static function loadfile(v:HSQUIRRELVM, filename:String, printerror:Bool ) : SQRESULT;

    @:native('sqstd_dofile')
    static function dofile(v:HSQUIRRELVM, filename:String, retval:Bool, printerror:Bool ) : SQRESULT;

    @:native('sqstd_writeclosuretofile')
    static function writeclosuretofile(v:HSQUIRRELVM, filename:String) : SQRESULT;


// The Blob library

	// Initialization
    @:native('sqstd_register_bloblib')
    static function register_bloblib(v:HSQUIRRELVM) : SQRESULT;

    // Blob object
    // @:native('sqstd_getblob')
    // static function getblob(v:HSQUIRRELVM, idx:Int, ptr:SQUserPointer) : SQRESULT;

    @:native('sqstd_getblobsize')
    static function getblobsize(v:HSQUIRRELVM, idx:Int) : Int;

    // @:native('sqstd_createblob')
    // static function createblob(v:HSQUIRRELVM, size:Int) : SQUserPointer;


// The Math library

	// Initialization
    @:native('sqstd_register_mathlib')
    static function register_mathlib(v:HSQUIRRELVM) : SQRESULT;


// The System library

	// Initialization
    @:native('sqstd_register_systemlib')
    static function register_systemlib(v:HSQUIRRELVM) : SQRESULT;


// The String library

	// Initialization
    @:native('sqstd_register_stringlib')
    static function register_stringlib(v:HSQUIRRELVM) : SQRESULT;

	// Formatting
    // @:native('sqstd_format')
    // static function format(v:HSQUIRRELVM, nformatstringidx:Int, outlen:Int, output:String) : SQRESULT;

	// Regular Expessions
    // @:native('sqstd_rex_compile')
    // static function rex_compile(pattern:String, error:String) : SQRex;

    // @:native('sqstd_rex_free')
    // static function rex_free(exp:SQRex) : Void;

    // @:native('sqstd_rex_match')
    // static function rex_match(exp:SQRex, text:String) : Bool;

    // @:native('sqstd_rex_search')
    // static function rex_search(exp:SQRex, text:String, out_begin:String, out_end:String) : Bool;

    // @:native('sqstd_rex_searchrange')
    // static function rex_searchrange(exp:SQRex, text_begin:String, text_end:String, out_begin:String, out_end:String) : Bool;

    // @:native('sqstd_rex_getsubexpcount')
    // static function rex_getsubexpcount(exp:SQRex) : Int;

    // @:native('sqstd_rex_getsubexp')
    // static function rex_getsubexp(exp:SQRex, n:Int, subexp:SQRexMatch) : Int;


// The Aux library

	// Error handling

    @:native('sqstd_seterrorhandlers')
    static function seterrorhandlers(v:HSQUIRRELVM) : Void;

    @:native('sqstd_printcallstack')
    static function printcallstack(v:HSQUIRRELVM) : Void;


} //Sqstd
