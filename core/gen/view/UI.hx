package gen.view;

import iqua.Html.*;
import gen.update.GenMsg;
import gen.model.GenModel;
import gen.model.Column;
import gen.model.Button;
import gen.model.Text;
import gen.model.WindowContent;
import iqua.RenderFunction;

class UI {
    public static function collapsingWindow(window :WindowContent, children :Array<RenderFunction<GenModel, GenMsg>>) : RenderFunction<GenModel, GenMsg> 
    {
        var heightClass = window.isOpen ? " open" : "";
        var arrow = window.isOpen ? "▼ " : "▶ ";

        var content = window.isOpen ? 
            [
                h1([CLASS("collapse-title"), ON_CLICK(ToggleWindow(window))], arrow + window.title),
                div([], children)
            ] : [h1([CLASS("collapse-title"), ON_CLICK(ToggleWindow(window))], arrow + window.title)];

        return div([CLASS("collapse border-bottom" + heightClass)], content);
    }

    public static function column(column :Column, children :Array<RenderFunction<GenModel, GenMsg>>) : RenderFunction<GenModel, GenMsg> 
    {
        var openClass = column.isOpen ? " open" : " closed";
        var content = column.isOpen 
            ? div([CLASS("flex-column column-content border-left border-right")], children)
            : div([], []);
        var leftClass = column.isLeft ? " left" : "";
        var activeClass = column.isActive ? " active" : "";

        var innerConent = [
            h1([CLASS("column-collapser toggler" + activeClass), MOUSE_DOWN(column,StretchColumn), ON_DBL_CLICK(ToggleColumn(column))], "⋮"),
            content,
            div([CLASS("column-collapser barrier")], [])
        ];
        if(column.isLeft) {
            innerConent.reverse();
        }

        return div([CLASS("column flex-row border-right border-left" + openClass + leftClass), STYLE({width: column.width + "px"})], innerConent);
    }

    public static function bottom(bottom :WindowContent, children :Array<RenderFunction<GenModel, GenMsg>>) : RenderFunction<GenModel, GenMsg> 
    {
        var openClass = bottom.isOpen ? " open" : " closed";
        return div([CLASS("bottom-row border-top" + openClass)], [collapsingWindow(bottom, children)]);
    }

    public static function pushButton(button :Button, children :Array<RenderFunction<GenModel, GenMsg>>) : RenderFunction<GenModel, GenMsg> 
    {
        var activeClass = button.isActive ? " active" : "";
        return div([CLASS("button" + activeClass), ON_CLICK(ToggleButton(button))], children);
    }

    public static function inputText(text :Text) : RenderFunction<GenModel, GenMsg> 
    {
        return input([VALUE(text.data), ON_INPUT(text, TextInput)]);
    }
}
