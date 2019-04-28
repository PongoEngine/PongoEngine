package perdita;

import towser.Html.*;
import towser.Attribute;
import towser.RenderFunction;
import perdita.model.Textfield;
import perdita.model.Tab;

class Material
{
    public static function fixedTab<Model, Msg>(tab :Tab) :RenderFunction<Model, Msg>
    {
        return div([CLASS("m-tab-fixed")], [span([], tab.value)]);
    }

    public static function scrollableTab<Model, Msg>(tab :Tab) :RenderFunction<Model, Msg>
    {
        return div([CLASS("m-tab-scrollable")], [span([], tab.value)]);
    }

    //------------ TEXTFIELDS -----------

    public static function textFieldFilled<Model, Msg>(msg :String -> Msg, field :Textfield) :RenderFunction<Model, Msg>
    {
        var filledClass = field.value == "" ? "" : " filled";
        return div([CLASS("m-textfield-filled" + filledClass)], [
            input([ON_INPUT(msg), VALUE(new String(field.value))]),
            span([], field.label)
        ]);
    }

    public static function textFieldOutlined<Model, Msg>(msg :String -> Msg, field :Textfield) :RenderFunction<Model, Msg>
    {
        var filledClass = field.value == "" ? "" : " filled";
        return div([CLASS("m-textfield-outlined" + filledClass)], [
            input([ON_INPUT(msg), VALUE(new String(field.value))]),
            span([], field.label)
        ]);
    }

    //------------ TOOLTIP -----------

    public static function tooltip<Model, Msg>(tip :String) :RenderFunction<Model, Msg>
    {
        return div([CLASS("m-tooltip m-fade-in")], [span([], tip)]);
    }
}