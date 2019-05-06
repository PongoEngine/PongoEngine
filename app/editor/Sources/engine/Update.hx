package engine;

import perdita.model.Textfield;
import perdita.model.Window;
import perdita.model.Drawer;
import perdita.model.Toggle;
import perdita.model.AccordianItem;
import engine.Model;
import js.html.MouseEvent;

class Update {
	public static function update(msg:GenMsg, model:Model):Bool {
		switch msg {
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
			case TextInput(text, str):
				text.value = str;
			case SelectWindow(window, updateDimensions, e):
				e.stopPropagation();
				model.activePoint.update(e.pageX, e.pageY);
				model.selectedFloater = window;
				model.selectedFloater.isUpdatingWidth = updateDimensions;
				model.floaters.remove(window);
				model.floaters.push(window);
			case ToggleLineItem(item):
				item.isExpanded = !item.isExpanded;
		}
		return true;
	}
}

enum GenMsg {
	ToggleLineItem(lineItem :LineItem);
	ToggleWindow(window :AccordianItem);
	ToggleColumn(column :Drawer);
	ToggleButton(button :Toggle);
	TextInput(data :Textfield, str :String);
	GlobalMove(e :MouseEvent);
	GlobalUp(e :MouseEvent);
	GlobalDown(e :MouseEvent);
	StretchColumn(data:Drawer, e :MouseEvent);
	SelectWindow(data:Window, updateDimensions :Bool, e:MouseEvent);
}