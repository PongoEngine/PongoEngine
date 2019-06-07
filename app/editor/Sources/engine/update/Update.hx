package engine.update;

import perdita.model.Textfield;
import js.Browser;
import towser.Towser;
using perdita.model.Window;
using perdita.model.Drawer;
using perdita.model.AccordianItem;
using perdita.model.util.PointerPosition;
import engine.model.ActionKey;
import perdita.model.util.UUID;
import engine.model.Model;
using engine.model.TreeItem;
import js.Browser.window as W;
import haxe.Serializer;
using engine.util.EngineStringTools;

using StringTools;

class Update {
	public static function update(towser: Towser<Model, GenMsg>, msg:GenMsg, model:Model):Bool {
		switch msg {
			case GLOBAL_KEY_DOWN(e):
				handleKey(e.key, model, true);
				switch operation(e.key, model.activeKeys) {
					case RefreshBrowser: {
						js.Browser.location.reload();
						e.preventDefault();
					}
					case SaveState: {
						var s = Serializer.run(model);
						W.localStorage.setItem("appState", s);
						e.preventDefault();
					}
					case ResetState: {
						Main.loadComponents(function(data) {
							towser.model = new Model(data);
							towser.render();
						});
					}
					case NoOp:
				}
				
			case GLOBAL_KEY_UP(e):
				e.preventDefault();
				handleKey(e.key, model, false);
			case SAVE(e):
			case ToggleWindow(window):
				window.toggle();
			case ToggleColumn(column, _):
				if(column.isOpen) {
					column.close();
				}
				else {
					column.open(300);
				}
			case GlobalMove(e):
				switch model.activeItem {
					case Drawer(id, position): {
						if(id == model.drawerLeft.id) {
							position.update(e.pageX, e.pageY);
							model.drawerLeft.stretchBy(position.x_changed);
						}
					}
					case Window(id, position): {
						position.update(e.pageX, e.pageY);
						var selectedWindow = getWindow(model.windows, id);
						if(selectedWindow != null) {
							if(selectedWindow.isUpdatingWidth) {
								selectedWindow.resizeTo(position.x, position.y);
							}
							else {
								selectedWindow.moveBy(position.x_changed, position.y_changed);
							}
						}
					}
					case None:
				}
			case GlobalUp(e):
				switch model.activeItem {
					case Drawer(id, position): {
						position.update(e.pageX, e.pageY);
						if(id == model.drawerLeft.id) {
							model.drawerLeft.checkWidth();
							model.drawerLeft.isActive = false;
							model.activeItem = None;
						}
					}
					case Window(id, position): {
						var selectedWindow = getWindow(model.windows, id);
						if(selectedWindow != null) {
							selectedWindow.isUpdatingWidth = false;
							model.activeItem = None;
						}
					}
					case None:
				}
						
				
			case GlobalDown(e):
				switch model.activeItem {
					case Drawer(id, position): position.update(e.pageX, e.pageY);
					case Window(id, position): position.update(e.pageX, e.pageY);
					case None:
				}
				
			case StretchColumn(column,e):
				column.isActive = true;
				model.activeItem = Drawer(column.id, new PointerPosition(e.pageX, e.pageY));
			case ToggleButton(button):
				button.isActive = !button.isActive;
			case TextInput(text, e):
				text.value = untyped e.target.value;
			case TypedTextInput(type, text, e):
				switch type {
					case TYPE(module, params): {
						text.value = checkModule(module, untyped e.target.value);
					}
					case FUNC(vals):
				}
			case SelectWindow(window, updateDimensions, e):
				e.stopPropagation();
				window.isUpdatingWidth = updateDimensions;
				model.windows.remove(window);
				model.windows.push(window);
				model.activeItem = Window(window.id, new PointerPosition(e.pageX, e.pageY));
			case ToggleLineItem(item, _):
				item.isExpanded = !item.isExpanded;
			case AddTreeItem(item, e):
				var newItem = new TreeItem(true, "", UUID.lineItemId());
				item.addChild(newItem);
			case DeleteTreeItem(item, e):
				var parent = TreeItem.getItem(model.lineItem, item.parentId);
				if(parent != null) {
					parent.removeChild(item);
				}
			case UpdateTreeItemText(item, e):
				item.value = untyped e.target.value;
		}
		return true;
	}

	private static function checkModule(module :Module, text :String) : String
	{
		return switch module {
			case Int: text.parseInt();
			case Float: text.parseFloat();
			case String: text;
			case _: text;
		}
	}

	private static function getWindow(windows :Array<Window>, id :WindowId) : Window
	{
		for(w in windows) {
			if(w.id == id) {
				return w;
			}
		}
		return null;
	}

	public static function handleKey(key :ActionKey, model:Model, isDown :Bool) : Void
	{
		switch [key, isDown] {
			case [Command, true]: model.activeKeys.set(Command, Command);
			case [Command, false]: model.activeKeys.remove(Command);
			case [S, true]: model.activeKeys.set(S, S);
			case [S, false]: model.activeKeys.remove(S);
			case [R, true]: model.activeKeys.set(R, R);
			case [R, false]: model.activeKeys.remove(R);
			case [J, true]: model.activeKeys.set(J, J);
			case [J, false]: model.activeKeys.remove(J);
			case _:
		}
	}

	public static function operation(lastKey :ActionKey, keys:Map<ActionKey, ActionKey>) : Operation
	{
		return switch [lastKey, keys.exists(Command)] {
			case [S, true]: SaveState;
			case [R, true]: RefreshBrowser;
			case [J, true]: ResetState;
			case _: NoOp;
		}
	}
}

@:enum
abstract Module(String) from String
{
	var String = "String";
	var Float = "Float";
	var Int = "Int";
}