package gen.update;

import gen.model.Column;
import gen.model.Button;
import gen.model.WindowContent;
import gen.model.Text;

enum GenMsg {
	ToggleWindow(window :WindowContent);
	ToggleColumn(column :Column);
	ToggleButton(button :Button);
	TextInput(data :Text, str :String);
	GlobalMove(data:Dynamic, x :Int, y :Int);
	GlobalUp(data:Dynamic, x :Int, y :Int);
	GlobalDown(data:Dynamic, x :Int, y :Int);
	StretchColumn(data:Column, x :Int, y :Int);
}
