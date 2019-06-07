package engine.model;

import perdita.model.Textfield;
import nosey.definition.DType;

class TypedTextField extends Textfield
{
    public var type (default, null) : DType;

    public function new(label :String, value :String, type :DType) : Void
    {
        super(label, value);
        this.type = type;
    }

}