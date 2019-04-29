package gen.update;

import perdita.model.FloatingWindow;
import perdita.model.Column;
import perdita.model.Button;
import perdita.model.WindowContent;
import perdita.model.Text;
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
