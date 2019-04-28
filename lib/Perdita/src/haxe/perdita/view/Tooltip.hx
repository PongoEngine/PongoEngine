package perdita.view;

import towser.Html.*;
import towser.RenderFunction;

class Tooltip
{
    public static function tooltip<Model, Msg>(tip :String) :RenderFunction<Model, Msg>
    {
        return div([CLASS("perdita-tooltip perdita-fade-in")], [span([], tip)]);
    }
}