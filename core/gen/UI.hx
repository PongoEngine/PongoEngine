package gen;

using iqua.Html;
using gen.UI;
import iqua.VirtualNode;
import iqua.Architecture;
import gen.GenUpdate;
import gen.GenModel;

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

        var innerConent = [
            arch.div([CLASS("column-collapser barrier")], null),
            content,
            arch.h1([CLASS("column-collapser toggler"), ON_CLICK(ToggleColumn(column))], "⋮")
        ];
        if(column.isLeft) {
            innerConent.reverse();
        }

        return arch.div([CLASS("column flex-row border-right border-left" + openClass)], innerConent);
    }

    public static function bottom(arch:Architecture<GenModel, GenMsg>, bottom :WindowContent, children :Array<VirtualNode>):VirtualNode {
        var openClass = bottom.isOpen ? " open" : " closed";
        return arch.div([CLASS("bottom-row border-top" + openClass)], [arch.collapsingWindow(bottom, children)]);
    }
}
