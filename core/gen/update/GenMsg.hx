package gen.update;

import gen.model.Column;
import gen.model.WindowContent;

enum GenMsg {
	NoOp;
	ToggleWindow(window :WindowContent);
	ToggleColumn(column :Column);
	GlobalMove(data:Dynamic, x :Int, y :Int);
	GlobalUp(data:Dynamic, x :Int, y :Int);
	GlobalDown(data:Dynamic, x :Int, y :Int);
	StretchColumn(data:Column, x :Int, y :Int);
}
