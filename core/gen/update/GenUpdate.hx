package gen.update;

import gen.model.GenModel;
import perdita.model.Point;
import perdita.model.FloatingWindow;

class GenUpdate {
	public static function update(msg:GenMsg, model:GenModel):Bool {
		return switch msg {
			case ToggleWindow(window):
				window.isOpen = !window.isOpen;
				true;
			case ToggleColumn(column):
				column.toggleColumn();
				true;
			case GlobalMove(e):
				if(model.selectedFloater != null) {
					moveFloater(model.activePoint, model.selectedFloater, e.pageX, e.pageY);
				}
				stretchColumn(model, e.pageX, e.pageY);
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
				text.data = str;
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

	public static inline function stretchColumn(model:GenModel, x :Int, y :Int) : Bool
	{
		if(model.stretchableColumn != null) {
			var mX = x - model.activePoint.x;
			model.activePoint.update(x, y);

			var success = model.stretchableColumn.stretchBy(mX);
			if(!success) {
				model.stretchableColumn.isActive = false;
				model.stretchableColumn = null;
			}
			return true;
		}
		return false;
	}

	public static inline function checkForColumn(model:GenModel) : Bool
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