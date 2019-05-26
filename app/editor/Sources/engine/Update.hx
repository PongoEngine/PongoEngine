package engine;

import towser.html.Event.KeyboardEvent;
import towser.html.Event.MouseEvent;
import towser.html.Event.InputEvent;
import perdita.model.Textfield;
import perdita.model.Window;
import perdita.model.Drawer;
import perdita.model.Toggle;
import perdita.model.AccordianItem;
import perdita.model.LineItem;
import engine.Model;
import js.Browser.window as W;
import haxe.Serializer;

class Update {
	public static function update(msg:GenMsg, model:Model):Bool {
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
					case NoOp:
				}
				
			case GLOBAL_KEY_UP(e):
				e.preventDefault();
				handleKey(e.key, model, false);
			case SAVE(e):
				var s = Serializer.run(model);
				W.localStorage.setItem("appState", s);
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
				trace(e);
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
			case _:
		}
	}

	public static function operation(lastKey :ActionKey, keys:Map<ActionKey, ActionKey>) : Operation
	{
		if((lastKey == S && keys.exists(S) && keys.exists(Command))) {
			return SaveState;
		}
		else if((lastKey == R && keys.exists(R) && keys.exists(Command))) {
			return RefreshBrowser;
		}
		else {
			return NoOp;
		}
	}
}

enum GenMsg {
	GLOBAL_KEY_DOWN(e :KeyboardEvent);
	GLOBAL_KEY_UP(e :KeyboardEvent);
	SAVE(e :MouseEvent);
	ToggleLineItem(lineItem :LineItem, e :MouseEvent);
	ToggleWindow(window :AccordianItem);
	ToggleColumn(column :Drawer, e :MouseEvent);
	ToggleButton(button :Toggle);
	TextInput(data :Textfield, str :InputEvent);
	GlobalMove(e :MouseEvent);
	GlobalUp(e :MouseEvent);
	GlobalDown(e :MouseEvent);
	StretchColumn(data:Drawer, e :MouseEvent);
	SelectWindow(data:Window, updateDimensions :Bool, e:MouseEvent);
}

enum Operation {
	RefreshBrowser;
	SaveState;
	NoOp;
}