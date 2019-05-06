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
			]),
			div([CLASS("main-content flex-row")], [
				drawer(StretchColumn, ToggleColumn, model.drawerLeft, [
					lineItem(model.lineItem, [for(item in model.lineItem.children) lineItem(item, [])])
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

	public static function lineItem(lineItem :LineItem, children :Array<RenderFunction<Model, GenMsg>>) : RenderFunction<Model, GenMsg>
	{
		return div([CLASS("line-item")], [
			span([CLASS("line-item-toggle"), ON_CLICK(ToggleLineItem(lineItem))], (lineItem.isExpanded ? "-" : "+")),
			span([CLASS("line-item-title")], lineItem.title),
			lineItem.isExpanded ? div([CLASS("line-item-children")], children) : span([], "")
		]);
	}
}