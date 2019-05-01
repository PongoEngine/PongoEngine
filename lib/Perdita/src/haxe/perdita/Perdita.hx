package perdita;

import towser.Html.*;
import towser.Html;
import towser.Attribute;
import towser.RenderFunction;
import perdita.model.Textfield;
import perdita.model.WindowContent;
import perdita.model.Column;
import perdita.model.Button;
import perdita.model.Text;
import perdita.model.FloatingWindow;
import js.html.MouseEvent;

class Perdita
{
    public static function textFieldOutlined<Model, Msg>(msg :Textfield -> String -> Msg, field :Textfield) :RenderFunction<Model, Msg>
    {
        var filledClass = field.value == "" ? "" : " filled";
        return div([CLASS("m-textfield-outlined" + filledClass)], [
            input([ON_INPUT(msg.bind(field)), VALUE(new String(field.value))]),
            span([], field.label)
        ]);
    }

    public static function collapsingWindow<Model, Msg>(toggleWindow :WindowContent -> Msg, window :WindowContent, children :Array<RenderFunction<Model, Msg>>) : RenderFunction<Model, Msg> 
    {
        var heightClass = window.isOpen ? " open" : "";
        var arrow = window.isOpen ? "▼ " : "▶ ";

        var content = window.isOpen ? 
            [
                h1([CLASS("collapse-title"), ON_CLICK(toggleWindow(window))], arrow + window.title),
                div([], children)
            ] : [h1([CLASS("collapse-title"), ON_CLICK(toggleWindow(window))], arrow + window.title)];

        return div([CLASS("collapse color-container-lighter border-bottom" + heightClass)], content);
    }

    public static function column<Model, Msg>(stretchColumn :Column -> MouseEvent -> Msg, toggleColumn :Column -> Msg, column :Column, children :Array<RenderFunction<Model, Msg>>) : RenderFunction<Model, Msg> 
    {
        var openClass = column.isOpen ? " open" : " closed";
        var content = column.isOpen 
            ? div([CLASS("flex-column column-content color-container border-left border-right")], children)
            : div([], []);
        var leftClass = column.isLeft ? " left" : "";
        var activeClass = column.isActive ? " active" : "";

        var innerConent = [
            h1([CLASS("column-collapser toggler color-actionable" + activeClass), MOUSE_DOWN(stretchColumn.bind(column)), ON_DBL_CLICK(toggleColumn(column))], "⋮"),
            content,
            div([CLASS("column-collapser barrier")], [])
        ];
        if(column.isLeft) {
            innerConent.reverse();
        }

        return div([
            CLASS("column color-container flex-row border-right border-left" + openClass + leftClass), 
            STYLE({width: column.width + "px"})
        ], innerConent);
    }

    public static function toggle<Model, Msg>(toggleButton :Button -> Msg, button :Button) : RenderFunction<Model, Msg> 
    {
        var attrs = [TYPE("checkbox")];
        if(button.isActive) {
            attrs.push(ATTR("checked", true));
        }
        return label([CLASS("switch")], [
            input(attrs),
            span([],"")
        ]);
    }

    public static function floater<Model, Msg>(selectWindow :FloatingWindow -> Bool -> MouseEvent -> Msg, floatingWindow :FloatingWindow, children :Array<RenderFunction<Model, Msg>>) : RenderFunction<Model, Msg> 
    {
        return div([
            CLASS("hover-window color-container"), 
            MOUSE_DOWN(selectWindow.bind(floatingWindow, false)),
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
                MOUSE_DOWN(selectWindow.bind(floatingWindow, true))
            ], [])
        ]);
    }
}