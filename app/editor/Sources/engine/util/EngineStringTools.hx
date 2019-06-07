package engine.util;

class EngineStringTools
{
    public static function parseInt(str :String) : String
    {
        var val = Std.parseInt(str) + "";
        return (val == "null" || val == "NaN")
            ? str
            : val;
    }

    public static function parseFloat(str :String) : String
    {
        var val = Std.parseFloat(str) + "";
        return (val == "null" || val == "NaN")
            ? str
            : val;
    }
}