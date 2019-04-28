package perdita.view;

import towser.Html.*;
import towser.RenderFunction;

class Snackbar
{
    public static function element<Model, Msg>(tip :String) :RenderFunction<Model, Msg>
    {
        return div([], []);
    }
}