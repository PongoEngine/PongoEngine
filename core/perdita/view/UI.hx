package perdita.view;

import towser.Html.*;
import perdita.update.PerditaMsg;
import perdita.model.PerditaModel;
import perdita.model.Column;
import perdita.model.Button;
import perdita.model.Text;
import perdita.model.FloatingWindow;
import perdita.model.WindowContent;
import towser.RenderFunction;

class UI {
    public static function collapsingWindow(window :WindowContent, children :Array<RenderFunction<PerditaMsg, PerditaMsg>>) : RenderFunction<PerditaMsg, PerditaMsg> 
    {
        var heightClass = window.isOpen ? " open" : "";
        var arrow = window.isOpen ? "▼ " : "▶ ";

        var content = window.isOpen ? 
            [
                h1([CLASS("collapse-title"), ON_CLICK(ToggleWindow(window))], arrow + window.title),
                div([], children)
            ] : [h1([CLASS("collapse-title"), ON_CLICK(ToggleWindow(window))], arrow + window.title)];

        return div([CLASS("collapse color-container-lighter border-bottom" + heightClass)], content);
    }

    public static function column(column :Column, children :Array<RenderFunction<PerditaMsg, PerditaMsg>>) : RenderFunction<PerditaMsg, PerditaMsg> 
    {
        var openClass = column.isOpen ? " open" : " closed";
        var content = column.isOpen 
            ? div([CLASS("flex-column column-content color-container border-left border-right")], children)
            : div([], []);
        var leftClass = column.isLeft ? " left" : "";
        var activeClass = column.isActive ? " active" : "";

        var innerConent = [
            h1([CLASS("column-collapser toggler color-actionable" + activeClass), MOUSE_DOWN(StretchColumn.bind(column)), ON_DBL_CLICK(ToggleColumn(column))], "⋮"),
            content,
            div([CLASS("column-collapser barrier")], [])
        ];
        if(column.isLeft) {
            innerConent.reverse();
        }

        return div([CLASS("column color-container flex-row border-right border-left" + openClass + leftClass), STYLE({width: column.width + "px"})], innerConent);
    }

    public static function bottom(bottom :WindowContent, children :Array<RenderFunction<PerditaMsg, PerditaMsg>>) : RenderFunction<PerditaMsg, PerditaMsg> 
    {
        var openClass = bottom.isOpen ? " open" : " closed";
        return div([CLASS("bottom-row border-top" + openClass), ID("bottom")], [collapsingWindow(bottom, children)]);
    }

    public static function pushButton(button :Button, children :Array<RenderFunction<PerditaMsg, PerditaMsg>>) : RenderFunction<PerditaMsg, PerditaMsg> 
    {
        var activeClass = button.isActive ? " active" : "";
        return div([CLASS("button color-actionable" + activeClass), ON_CLICK(ToggleButton(button))], children);
    }

    public static function inputText(text :Text) : RenderFunction<PerditaMsg, PerditaMsg> 
    {
        return input([
            CLASS("input-text color-actionable"), 
            VALUE(text.data), 
            ON_INPUT(TextInput.bind(text))
        ]);
    }

    public static function floater(floatingWindow :FloatingWindow, children :Array<RenderFunction<PerditaMsg, PerditaMsg>>) : RenderFunction<PerditaMsg, PerditaMsg> 
    {
        return div([
            CLASS("hover-window color-container"), 
            MOUSE_DOWN(SelectWindow.bind(floatingWindow, false)),
            STYLE({
                left: floatingWindow.position.x + "px", 
                top: floatingWindow.position.y + "px",
                width: floatingWindow.dimensions.x + "px",
                height: floatingWindow.dimensions.y + "px"
            })
        ], [
            div([CLASS("hover-window-bar color-container-darker border-bottom")], []),
            div([CLASS("flex-column")], children),
            div([
                CLASS("hover-window-resizer color-container-lighter border-left border-top"),
                MOUSE_DOWN(SelectWindow.bind(floatingWindow, true))
            ], [])
        ]);
    }
}
