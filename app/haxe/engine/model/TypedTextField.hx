package engine.model;

import perdita.model.Textfield;

class TypedTextField extends Textfield
{
    public function new(label :String, value :String, isValid :Bool, type :Dynamic) : Void
    {
        super(label, value, isValid);
    }

}