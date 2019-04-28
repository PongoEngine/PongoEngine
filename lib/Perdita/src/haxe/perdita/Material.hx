package perdita;

import towser.Html.*;
import towser.Attribute;
import towser.RenderFunction;
import perdita.model.Textfield;

class Material
{
    public static function tooltip<Model, Msg>(tip :String) :RenderFunction<Model, Msg>
    {
        return div([CLASS("perdita-tooltip perdita-fade-in")], [span([], tip)]);
    }

    public static function textFieldFilled<Model, Msg>(msg :String -> Msg, field :Textfield) :RenderFunction<Model, Msg>
    {
        var filledClass = field.value == "" ? "" : " filled";
        return div([CLASS("perdita-textfield-filled" + filledClass)], [
            input([ON_INPUT(msg), VALUE(new String(field.value))]),
            span([], field.label)
        ]);
    }

    public static function textFieldOutlined<Model, Msg>(field :Textfield) :RenderFunction<Model, Msg>
    {
        return div([], [
            input([])
        ]);
    }
}