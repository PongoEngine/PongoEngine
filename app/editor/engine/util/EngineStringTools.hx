package engine.util;

class EngineStringTools
{
    public static function isInt(str :String) : Bool
    {
        for(i in 0...str.length) {
            var char = str.charAt(i);
            if(isDot(char) || !isNumber(char)) {
                return false;
            }
        }

        return true;
    }

    public static function isFloat(str :String) : Bool
    {
        var dotCount = 0;
        for(i in 0...str.length) {
            var char = str.charAt(i);
            if(isDot(char)) {
                dotCount++;
            }
            if(!isNumber(char) || dotCount == 2) {
                return false;
            }
        }

        return true;
    }

    public static inline function isNumber(str :String) : Bool
    {
        return str == "0" || str == "1" || str == "2" || str == "3" ||
            str == "4" || str == "5" || str == "6" || str == "7" ||
            str == "8" || str == "9" || str == "0" || str == ".";
    }

    public static inline function isDot(str :String) : Bool
    {
        return str == ".";
    }
}