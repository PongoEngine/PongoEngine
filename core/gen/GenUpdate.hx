package gen;

import gen.GenModel;

class GenUpdate {
	public static function update(msg:GenMsg, model:GenModel):GenModel {
		switch msg {
			case NoOp:
				trace("noOp");
			case Ham(str):
				trace(str);
			case ToggleWindow(window):
				window.isOpen = !window.isOpen;
		}
		return model;
	}
}

enum GenMsg {
	NoOp;
	Ham(str:String);
	ToggleWindow(window :WindowContent);
}
