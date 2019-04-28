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

class Button
{
    public static function Text(button :Button) : RenderFunction<GenModel, GenMsg> 
    {
        return div([], []);
    }

    public static function Outline(button :Button) : RenderFunction<GenModel, GenMsg> 
    {
        return div([], []);
    }

    public static function Contained(button :Button) : RenderFunction<GenModel, GenMsg> 
    {
        return div([], []);
    }

    public static function Toggle(button :Button) : RenderFunction<GenModel, GenMsg> 
    {
        return div([], []);
    }
}