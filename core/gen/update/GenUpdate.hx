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
			case GlobalMove(x,y):
				if(model.selectedFloater != null) {
					moveFloater(model.activePoint, model.selectedFloater, x, y);
				}
				stretchColumn(model, x, y);
				true;
			case GlobalUp(x,y):
				if(model.selectedFloater != null) {
					model.selectedFloater = null;
				}
				updatePoint(model.activePoint, x, y);
				checkForColumn(model);
				true;
			case GlobalDown(x,y):
				updatePoint(model.activePoint, x, y);
				true;
			case StretchColumn(column,x,y):
				column.isActive = true;
				model.stretchableColumn = column;
				true;
			case ToggleButton(button):
				button.isActive = !button.isActive;
				true;
			case TextInput(text, str):
				text.data = str;
				true;
			case SelectWindow(window,x,y):
				model.selectedFloater = window;
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
		window.position.x += mX;
		window.position.y += mY;
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