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
	GlobalMove(x :Int, y :Int);
	GlobalUp(x :Int, y :Int);
	GlobalDown(x :Int, y :Int);
	StretchColumn(data:Column, x :Int, y :Int);
}
