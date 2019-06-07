package typing.definition;

import typing.definition.DType;
import typing.definition.DType.DTypeRef;

class DArg
{
    public var name (default, null):String;
    public var type (default, null):DRef<DType>;
    public var opt (default, null):Bool;
    public var value (default, null):String = "";

    public function new(name :String, opt :Bool, type :DRef<DType>) : Void
    {
        this.name = name;
        this.type = type;
        this.opt = opt;
    }

#if macro
    public static function fromArg(arg :{ t : haxe.macro.Type, opt : Bool, name : String }) : DArg
    {
        return new DArg(arg.name, arg.opt, new DTypeRef(typing.definition.DType.DTypeTools.fromType(arg.t)));
    }
#end
}