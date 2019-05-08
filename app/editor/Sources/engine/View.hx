package engine;

import towser.Html.*;
import towser.RenderFunction;
import engine.Model;
import engine.Update.GenMsg;
import perdita.Perdita.*;

class View
{
    public static function view(model:Model) : RenderFunction<Model, GenMsg>
	{
		var disableSelect = model.selectedFloater != null ? " disable-user-select" : "";
		return div([CLASS("full-screen" + disableSelect), MOUSE_DOWN(GlobalDown), MOUSE_UP(GlobalUp), MOUSE_MOVE(GlobalMove)], [
			div([CLASS("nav-bar color-container-darker border-bottom")], [
				span([ON_CLICK(SAVE)], "SAVE")
			]),
			div([CLASS("main-content flex-row")], [
				drawer(StretchColumn, ToggleColumn, model.drawerLeft, [
					div([CLASS("border-bottom color-container-darkest models")], [
						roooots(model.lineItem)
					])
				]),
				div([STYLE({width: "100%", height: "100%"}), CLASS("flex-column")], [
					div([CLASS("game-window")], [
						canvas([ID("khanvas"), WIDTH("1366"), HEIGHT("768"), TABINDEX("-1")])
					])
				])
			]),
			div([], [for (f in model.floaters) window(SelectWindow, f, [

			])])
		]);
	}

	public static function roooots(item:TreeItem) : RenderFunction<Model, GenMsg>
	{
		var c = switch item.content {
			case EMPTY: [];
			case CHILDREN(children): [for(item in children) roooots(item)];
			case COMPONENT(text): [textfield(TextInput, text)];
		}

		return lineItem(ToggleLineItem, item, div([CLASS("line-item")], [
			span([CLASS("color-container-darker")], "+"),
			span([CLASS("color-container-darker")], "-"),
			span([CLASS("color-container-darker")], "↑"),
			span([CLASS("color-container-darker")], "↓")
		]), c);
	}
}