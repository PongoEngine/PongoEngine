package engine.model;

import perdita.model.Textfield;
import nosey.definition.DType;

class TypedTextField extends Textfield
{
    public var type (default, null) : DType;

    public function new(label :String, value :String, isValid :Bool, type :DType) : Void
    {
        super(label, value, isValid);
        this.type = type;
    }

}