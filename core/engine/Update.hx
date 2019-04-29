package engine;

import perdita.model.Textfield;
import perdita.model.FloatingWindow;
import perdita.model.Column;
import perdita.model.Button;
import perdita.model.WindowContent;
import perdita.model.Text;
import perdita.model.Point;
import engine.Model;
import js.html.MouseEvent;

class Update {
	public static function update(msg:GenMsg, model:Model):Bool {
		return switch msg {
			case ResizeColumn(column, e):
				trace(e);
				if(!column.isActive) {
					trace(e);
				}
				// if(column.)
				true;
			case ToggleWindow(window):
				window.toggle();
			case ToggleColumn(column):
				if(column.isOpen) {
					column.close();
				}
				else {
					column.open(300);
				}
				true;
			case GlobalMove(e):
				if(model.selectedFloater != null) {
					moveFloater(model.activePoint, model.selectedFloater, e.pageX, e.pageY);
				}
				var mX = e.pageX - model.activePoint.x;
				model.activePoint.update(e.pageX, e.pageY);
				if(model.stretchableColumn != null) {
					model.stretchableColumn.stretchBy(mX);
				}
				true;
			case GlobalUp(e):
				if(model.selectedFloater != null) {
					model.selectedFloater.isUpdatingWidth = false;
					model.selectedFloater = null;
				}
				model.activePoint.update(e.pageX, e.pageY);
				checkForColumn(model);
				true;
			case GlobalDown(e):
				model.activePoint.update(e.pageX, e.pageY);
				true;
			case StretchColumn(column,e):
				column.isActive = true;
				model.stretchableColumn = column;
				true;
			case ToggleButton(button):
				model.bottom.isOpen = button.isActive;
				button.isActive = !button.isActive;
				true;
			case TextInput(text, str):
				text.value = str;
				true;
			case SelectWindow(window, updateDimensions, e):
				e.stopPropagation();
				model.activePoint.update(e.pageX, e.pageY);
				model.selectedFloater = window;
				model.selectedFloater.isUpdatingWidth = updateDimensions;

				model.floaters.remove(window);
				model.floaters.push(window);
				true;
		}
	}

	public static inline function moveFloater(activePoint :Point, window:FloatingWindow, x :Int, y :Int) : Void
	{
		var mX = x - activePoint.x;
		var mY = y - activePoint.y;
		activePoint.update(x, y);
		if(window.isUpdatingWidth) {
			window.resizeTo(x, y);
		}
		else {
			window.moveBy(mX, mY);
		}
	}

	public static inline function checkForColumn(model:Model) : Bool
	{
		if(model.stretchableColumn != null) {
			model.stretchableColumn.checkWidth();
			model.stretchableColumn.isActive = false;
			model.stretchableColumn = null;
			return true;
		}
		return false;
	}
}

enum GenMsg {
	ToggleWindow(window :WindowContent);
	ToggleColumn(column :Column);
	ResizeColumn(column :Column, val:Dynamic);
	ToggleButton(button :Button);
	TextInput(data :Textfield, str :String);
	GlobalMove(e :MouseEvent);
	GlobalUp(e :MouseEvent);
	GlobalDown(e :MouseEvent);
	StretchColumn(data:Column, e :MouseEvent);
	SelectWindow(data:FloatingWindow, updateDimensions :Bool, e:MouseEvent);
}