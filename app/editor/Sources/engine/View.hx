package engine;

import engine.model.TypedTextField;
import nosey.EditorClass;
import towser.html.Lazy;
import perdita.Perdita.*;
import perdita.model.Textfield;
import towser.html.Attributes.*;
import towser.html.Events.*;
import towser.html.Html.*;
import towser.RenderFunction;
import engine.model.Model;
import engine.model.TreeItem;
import engine.update.GenMsg;
using nosey.TypingData;
import nosey.definition.DVariable;

class View
{
    public static function view(model:Model) : RenderFunction<Model, GenMsg>
	{
		var disableSelect = model.activeItem != None ? " disable-user-select" : "";
		return div([class_("full-screen" + disableSelect), tabindex("-2"), onkeydown(GLOBAL_KEY_DOWN), onkeyup(GLOBAL_KEY_UP), onmousedown(GlobalDown), onmouseup(GlobalUp), onmousemove(GlobalMove)], [
			div([class_("nav-bar color-container-darker border-bottom")], [
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
				showLameHuman(model)
			])])
		]);
	}

	public static function showLameHuman(model :Model) : RenderFunction<Model, GenMsg>
	{
		var lameHuman :EditorClass = model.typingData.getClass("game.LameHuman");
		return return div([], [
			div([], lameHuman.variables.map(function(v) {
				return textfield(TypedTextInput.bind(v.type), getField(v, model));
			}))
		]);
	}

	public static function getField(variable :DVariable, model :Model) : Textfield
	{
		var id = "comp_" + variable.name;
		var type = switch variable.type {
			case TYPE(module, params): module;
			case FUNC(vals): "Function";
		}
		if(!model.textFields.exists(id)) {
			model.textFields.set(id, new TypedTextField(variable.name + " : " + type, "", variable.type));
		}
		return model.textFields.get(id);
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