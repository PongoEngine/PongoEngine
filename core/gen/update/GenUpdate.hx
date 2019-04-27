package gen.update;

import gen.model.GenModel;
import gen.model.Point;
import gen.model.FloatingWindow;

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
				updatePoint(model.activePoint, e.pageX, e.pageY);
				checkForColumn(model);
				true;
			case GlobalDown(e):
				updatePoint(model.activePoint, e.pageX, e.pageY);
				true;
			case StretchColumn(column,e):
				column.isActive = true;
				model.stretchableColumn = column;
				true;
			case ToggleButton(button):
				button.isActive = !button.isActive;
				true;
			case TextInput(text, str):
				text.data = str;
				true;
			case SelectWindow(window, updateDimensions, e):
				e.stopPropagation();
				updatePoint(model.activePoint, e.pageX, e.pageY);
				model.selectedFloater = window;
				model.selectedFloater.isUpdatingWidth = updateDimensions;
				true;
		}
	}

	public static inline function updatePoint(point :Point, x :Int, y :Int) : Void
	{
		point.x = x;
		point.y = y;
	}

	public static inline function moveFloater(activePoint :Point, window:FloatingWindow, x :Int, y :Int) : Void
	{
		var mX = x - activePoint.x;
		var mY = y - activePoint.y;
		updatePoint(activePoint, x, y);
		if(window.isUpdatingWidth) {
			window.dimensions.x += mX;
			window.dimensions.y += mY;
		}
		else {
			window.position.x += mX;
			window.position.y += mY;
		}
	}

	public static inline function stretchColumn(model:GenModel, x :Int, y :Int) : Bool
	{
		if(model.stretchableColumn != null) {
			var mX = x - model.activePoint.x;
			updatePoint(model.activePoint, x, y);

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