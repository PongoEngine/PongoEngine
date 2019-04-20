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

    public static function columnLeft(arch:Architecture<GenModel, GenMsg>, column :Column, children :Array<VirtualNode>):VirtualNode {
        var openClass = column.isOpen ? " open" : " closed";
        var content = column.isOpen 
            ? arch.div([CLASS("flex-column column-content border-left")], children)
            : null;

        var arrow = column.isOpen ? "▶" : "◀";
        return arch.div([CLASS("column flex-row border-right" + openClass)], [
            arch.h1([CLASS("column-collapser"), ON_CLICK(ToggleColumn(column))], arrow),
            content
        ]);
    }

    public static function columnRight(arch:Architecture<GenModel, GenMsg>, column :Column, children :Array<VirtualNode>):VirtualNode {
        var openClass = column.isOpen ? " open" : " closed";
        var content = column.isOpen 
            ? arch.div([CLASS("flex-column column-content border-right")], children)
            : null;

        var arrow = column.isOpen ? "◀" : "▶";
        return arch.div([CLASS("column flex-row border-left" + openClass)], [
            content,
            arch.h1([CLASS("column-collapser"), ON_CLICK(ToggleColumn(column))], arrow)
        ]);
    }
}
