package engine;

import perdita.model.Textfield;
import perdita.model.Window;
import perdita.model.Drawer;
import perdita.model.Toggle;
import perdita.model.AccordianItem;
import perdita.model.util.Point;
import engine.Model;
import js.html.MouseEvent;

class Update {
	public static function update(msg:GenMsg, model:Model):Bool {
		switch msg {
			case ResizeColumn(column, e):
				trace(e);
				if(!column.isActive) {
					trace(e);
				}
			case ToggleWindow(window):
				window.toggle();
			case ToggleColumn(column):
				if(column.isOpen) {
					column.close();
				}
				else {
					column.open(300);
				}
			case GlobalMove(e):
				if(model.selectedFloater != null) {
					var mX = e.pageX - model.activePoint.x;
					var mY = e.pageY - model.activePoint.y;
					model.activePoint.update(e.pageX, e.pageY);
					if(model.selectedFloater.isUpdatingWidth) {
						model.selectedFloater.resizeTo(e.pageX, e.pageY);
					}
					else {
						model.selectedFloater.moveBy(mX, mY);
					}
				}
				var mX = e.pageX - model.activePoint.x;
				model.activePoint.update(e.pageX, e.pageY);
				if(model.stretchableColumn != null) {
					model.stretchableColumn.stretchBy(mX);
				}
			case GlobalUp(e):
				if(model.selectedFloater != null) {
					model.selectedFloater.isUpdatingWidth = false;
					model.selectedFloater = null;
				}
				model.activePoint.update(e.pageX, e.pageY);
				checkForColumn(model);
			case GlobalDown(e):
				model.activePoint.update(e.pageX, e.pageY);
			case StretchColumn(column,e):
				column.isActive = true;
				model.stretchableColumn = column;
			case ToggleButton(button):
				button.isActive = !button.isActive;
			case TextInput(text, str):
				text.value = str;
			case SelectWindow(window, updateDimensions, e):
				e.stopPropagation();
				model.activePoint.update(e.pageX, e.pageY);
				model.selectedFloater = window;
				model.selectedFloater.isUpdatingWidth = updateDimensions;

				model.floaters.remove(window);
				model.floaters.push(window);
		}
		return true;
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
	ToggleWindow(window :AccordianItem);
	ToggleColumn(column :Drawer);
	ResizeColumn(column :Drawer, val:Dynamic);
	ToggleButton(button :Toggle);
	TextInput(data :Textfield, str :String);
	GlobalMove(e :MouseEvent);
	GlobalUp(e :MouseEvent);
	GlobalDown(e :MouseEvent);
	StretchColumn(data:Drawer, e :MouseEvent);
	SelectWindow(data:Window, updateDimensions :Bool, e:MouseEvent);
}