package perdita;

import towser.Html.*;
import towser.Svg.*;
import towser.Attribute;
import towser.RenderFunction;
import perdita.model.Textfield;
import perdita.model.Tab;

class Material
{
    public static function textFieldOutlined<Model, Msg>(msg :String -> Msg, field :Textfield) :RenderFunction<Model, Msg>
    {
        var filledClass = field.value == "" ? "" : " filled";
        return div([CLASS("m-textfield-outlined" + filledClass)], [
            input([ON_INPUT(msg), VALUE(new String(field.value))]),
            span([], field.label)
        ]);
    }
}