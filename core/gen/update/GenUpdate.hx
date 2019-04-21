package gen.update;

import gen.model.GenModel;
import gen.model.Point;

class GenUpdate {
	public static function update(msg:GenMsg, model:GenModel):GenModel {
		switch msg {
			case ToggleWindow(window):
				window.isOpen = !window.isOpen;
			case ToggleColumn(column):
				column.toggleColumn();
			case GlobalMove(_,x,y):
				stretchColumn(model, x, y);
			case GlobalUp(_,x,y):
				checkForColumn(model);
				updatePoint(model.activePoint, x, y);
			case GlobalDown(_,x,y):
				updatePoint(model.activePoint, x, y);
			case StretchColumn(column,x,y):
				column.isActive = true;
				model.stretchableColumn = column;
			case ToggleButton(button):
				button.isActive = !button.isActive;
				trace(model.text.data);
			case TextInput(text, str):
				text.data = str;
		}
		return model;
	}

	public static inline function updatePoint(point :Point, x :Int, y :Int) : Void
	{
		point.x = x;
		point.y = y;
	}

	public static inline function stretchColumn(model:GenModel, x :Int, y :Int) : Void
	{
		if(model.stretchableColumn != null) {
			var mX = x - model.activePoint.x;
			updatePoint(model.activePoint, x, y);

			var success = model.stretchableColumn.stretchBy(mX);
			if(!success) {
				model.stretchableColumn.isActive = false;
				model.stretchableColumn = null;
			}
		}
	}

	public static inline function checkForColumn(model:GenModel) : Void
	{
		if(model.stretchableColumn != null) {
			model.stretchableColumn.checkWidth();
			model.stretchableColumn.isActive = false;
			model.stretchableColumn = null;
		}
	}
}