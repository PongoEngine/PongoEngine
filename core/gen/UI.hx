package gen;

using iqua.Html;
import iqua.VirtualNode;
import iqua.Architecture;
import gen.GenUpdate;
import gen.GenModel;

class UI {
	public static function collapsingWindow(arch:Architecture<GenModel, GenMsg>, window :WindowContent, children :Array<VirtualNode>):VirtualNode {
        var heightClass = window.isOpen ? " full-height" : "";
        var arrow = window.isOpen ? "▼ " : "▶ ";

		return arch.div([CLASS("column-item border-bottom" + heightClass)], [
            arch.h1([CLASS("column-item-text"), ON_CLICK(ToggleWindow(window))], arrow + window.title),
            arch.div([CLASS("column-item-content")], children)
        ]);
	}
}
