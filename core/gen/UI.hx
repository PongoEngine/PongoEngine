package gen;

using iqua.Html;
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
        var borderClass = column.isLeft ? " border-right" : " border-left";
        var openClass = column.isOpen ? " open" : "";
        var content = column.isOpen 
            ? [arch.div([CLASS("flex-column")], children)]
            : [];

        return arch.div([CLASS("column" + borderClass + openClass)], content);
    }
}
