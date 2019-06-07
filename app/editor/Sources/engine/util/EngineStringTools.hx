package engine.util;

class EngineStringTools
{
    public static function isInt(str :String) : Bool
    {
        var val = Std.parseInt(str) + "";
        return (val == "null" || val == "NaN")
            ? false
            : true;
    }

    public static function isFloat(str :String) : Bool
    {
        var val = Std.parseFloat(str) + "";
        return (val == "null" || val == "NaN")
            ? false
            : true;
    }
}