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

class Dialog
{
    public static function Alert(button :Button) : RenderFunction<GenModel, GenMsg> 
    {
        return div([], []);
    }

    public static function Simple(button :Button) : RenderFunction<GenModel, GenMsg> 
    {
        return div([], []);
    }

    public static function Confirmation(button :Button) : RenderFunction<GenModel, GenMsg> 
    {
        return div([], []);
    }

    public static function Fullscreen(button :Button) : RenderFunction<GenModel, GenMsg> 
    {
        return div([], []);
    }
}