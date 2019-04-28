package gen.view.components;

import towser.Html.*;
import gen.update.GenMsg;
import gen.model.GenModel;
import gen.model.Column;
import gen.model.Button;
import gen.model.Text;
import gen.model.FloatingWindow;
import gen.model.WindowContent;
import towser.RenderFunction;

class Chip
{
    public static function Input(button :Button) : RenderFunction<GenModel, GenMsg> 
    {
        return div([], []);
    }

    public static function Choice(button :Button) : RenderFunction<GenModel, GenMsg> 
    {
        return div([], []);
    }

    public static function Filter(button :Button) : RenderFunction<GenModel, GenMsg> 
    {
        return div([], []);
    }

    public static function Action(button :Button) : RenderFunction<GenModel, GenMsg> 
    {
        return div([], []);
    }
}