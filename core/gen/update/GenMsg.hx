package gen.update;

import gen.model.FloatingWindow;
import gen.model.Column;
import gen.model.Button;
import gen.model.WindowContent;
import gen.model.Text;
import js.html.MouseEvent;

enum GenMsg {
	ToggleWindow(window :WindowContent);
	ToggleColumn(column :Column);
	ToggleButton(button :Button);
	TextInput(data :Text, str :String);
	GlobalMove(e :MouseEvent);
	GlobalUp(e :MouseEvent);
	GlobalDown(e :MouseEvent);
	StretchColumn(data:Column, e :MouseEvent);
	SelectWindow(data:FloatingWindow, updateDimensions :Bool, e:MouseEvent);
}
