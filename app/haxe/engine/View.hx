package engine;

import perdita.Perdita.*;
import towser.html.Attributes.*;
import towser.html.Events.*;
import towser.html.Html.*;
import towser.RenderFunction;
import engine.model.Model;
import engine.model.TreeItem;
import engine.update.GenMsg;

class View
{
    public static function view(model:Model) : RenderFunction<Model, GenMsg>
	{
		var disableSelect = model.activeItem != None ? " disable-user-select" : "";
		return div([class_("full-screen" + disableSelect), tabindex("-2"), onkeydown(GLOBAL_KEY_DOWN), onkeyup(GLOBAL_KEY_UP), onmousedown(GlobalDown), onmouseup(GlobalUp), onmousemove(GlobalMove)], [
			div([class_("nav-bar color-container-darker border-bottom")], [
				label([class_("nav-button")], [
					text("save"),
					input([class_("nav-hidden"), type("file")])
				]),
				label([class_("nav-button")], [
					text("load"),
					input([class_("nav-hidden"), type("file"), oninput(OnFileLoad), accept(".js")])
				])
			]),
			div([class_("main-content flex-row")], [
				drawer(StretchColumn, ToggleColumn, model.drawerLeft, [
					div([class_("border-bottom color-container-darkest models")], [
						roooots(model.lineItem)
					])
				]),
				div([style({width: "100%", height: "100%"}), class_("flex-column")], [
					div([class_("game-window")], [
						canvas([id("khanvas"), width("1366"), height("768"), tabindex("-1"), onkeydown(GLOBAL_KEY_DOWN), onkeyup(GLOBAL_KEY_UP)], [])
					])
				])
			]),
			div([], [for (f in model.windows) window(SelectWindow, f, [
			])])
		]);
	}

	public static function roooots(item:TreeItem) : RenderFunction<Model, GenMsg>
	{
		var c = switch item.content {
			case EMPTY: [];
			case CHILDREN(children): [for(item in children) roooots(item)];
			case COMPONENT(text_): [textfield(TextInput, text_)];
		}

		var lineView = div([class_("full-width")], [
			div([class_("line-item group")], [
				div([class_("float-left line-item-text")], [textfield(UpdateTreeItemText, item.field)]),
				div([class_("float-left")], [
					span([class_("color-container-darker line-item-button"), onclick(AddTreeItem.bind(item))], [text("+")]),
					span([class_("color-container-darker line-item-button"), onclick(DeleteTreeItem.bind(item)),], [text("x")])
				])
			])
		]);

		return lineItem(ToggleLineItem, item, lineView, c);
	}
}