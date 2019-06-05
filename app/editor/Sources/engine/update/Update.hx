package engine.update;

import haxe.Json;
import js.Browser;
import towser.Towser;
using perdita.model.Window;
using perdita.model.Drawer;
using perdita.model.AccordianItem;
using perdita.model.util.PointerPosition;
import engine.model.ActionKey;
import engine.model.Model;
using engine.model.TreeItem;
import js.Browser.window as W;
import haxe.Serializer;

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
						towser.model = new Model();
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
				model.activePoint.update(e.pageX, e.pageY);
				if(model.selectedFloater != null) {
					if(model.selectedFloater.isUpdatingWidth) {
						model.selectedFloater.resizeTo(model.activePoint.x, model.activePoint.y);
					}
					else {
						model.selectedFloater.moveBy(model.activePoint.x_changed, model.activePoint.y_changed);
					}
				}
				if(model.stretchableColumn != null) {
					model.stretchableColumn.stretchBy(model.activePoint.x_changed);
				}
			case GlobalUp(e):
				if(model.selectedFloater != null) {
					model.selectedFloater.isUpdatingWidth = false;
					model.selectedFloater = null;
				}
				model.activePoint.update(e.pageX, e.pageY);
				if(model.stretchableColumn != null) {
					model.stretchableColumn.checkWidth();
					model.stretchableColumn.isActive = false;
					model.stretchableColumn = null;
				}
			case GlobalDown(e):
				model.activePoint.update(e.pageX, e.pageY);
			case StretchColumn(column,e):
				column.isActive = true;
				model.stretchableColumn = column;
			case ToggleButton(button):
				button.isActive = !button.isActive;
			case TextInput(text, e):
				text.value = untyped e.target.value;
			case SelectWindow(window, updateDimensions, e):
				e.stopPropagation();
				model.activePoint.update(e.pageX, e.pageY);
				model.selectedFloater = window;
				model.selectedFloater.isUpdatingWidth = updateDimensions;
				model.floaters.remove(window);
				model.floaters.push(window);
			case ToggleLineItem(item, _):
				item.isExpanded = !item.isExpanded;
			case AddTreeItem(item, e):
				var newItem = new TreeItem(true, model.nextId++);
				item.addChild(newItem);
			case DeleteTreeItem(item, e):
				var parent = TreeItem.getMatches(model.lineItem, item.parentId)[0];
				if(parent != null) {
					parent.removeChild(item);
				}
		}
		return true;
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

	public static function download(filename :String, text :String) : Void
	{
		var pom = Browser.document.createElement('a');
		pom.setAttribute('href', 'data:text/plain;charset=utf-8,' + text.urlEncode());
		pom.setAttribute('download', filename);

		if (Browser.document.createEvent != null) {
			var event = Browser.document.createEvent('MouseEvents');
			event.initEvent('click', true, true);
			pom.dispatchEvent(event);
		}
		else {
			pom.click();
		}
	}
}