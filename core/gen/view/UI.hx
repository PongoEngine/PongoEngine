package gen.view;

using iqua.Html;
using gen.view.UI;
import iqua.VirtualNode;
import iqua.Architecture;
import gen.GenUpdate;
import gen.model.GenModel;

class UI {
    public static function collapsingWindow(arch:Architecture<GenModel, GenMsg>, window :WindowContent, children :Array<VirtualNode>):VirtualNode {
        var heightClass = window.isOpen ? " open" : "";
        var arrow = window.isOpen ? "▼ " : "▶ ";

        var content = window.isOpen ? 
            [
                arch.h1([CLASS("collapse-title"), ON_CLICK(ToggleWindow(window))], arrow + window.title),
                arch.div([], children)
            ] : [arch.h1([CLASS("collapse-title"), ON_CLICK(ToggleWindow(window))], arrow + window.title)];

        return arch.div([CLASS("collapse border-bottom" + heightClass)], content);
    }

    public static function column(arch:Architecture<GenModel, GenMsg>, column :Column, children :Array<VirtualNode>):VirtualNode {
        var openClass = column.isOpen ? " open" : " closed";
        var content = column.isOpen 
            ? arch.div([CLASS("flex-column column-content border-left border-right")], children)
            : null;
        var leftClass = column.isLeft ? " left" : "";

        var innerConent = [
            arch.h1([CLASS("column-collapser toggler"), MOUSE_DOWN(column,StretchColumn), ON_DBL_CLICK(ToggleColumn(column))], "⋮"),
            content,
            arch.div([CLASS("column-collapser barrier")], null)
        ];
        if(column.isLeft) {
            innerConent.reverse();
        }

        return arch.div([CLASS("column flex-row border-right border-left" + openClass + leftClass), STYLE({width: column.width + "px"})], innerConent);
    }

    public static function bottom(arch:Architecture<GenModel, GenMsg>, bottom :WindowContent, children :Array<VirtualNode>):VirtualNode {
        var openClass = bottom.isOpen ? " open" : " closed";
        return arch.div([CLASS("bottom-row border-top" + openClass)], [arch.collapsingWindow(bottom, children)]);
    }

    public static function pushButton(arch:Architecture<GenModel, GenMsg>, children :Array<VirtualNode>):VirtualNode {
        return arch.div([CLASS("button")], children);
    }
}
