package gen;

import gen.GenModel;

class GenUpdate {
	public static function update(msg:GenMsg, model:GenModel):GenModel {
		switch msg {
			case NoOp:
				trace("noOp");
			case ToggleWindow(window):
				window.isOpen = !window.isOpen;
			case ToggleColumn(column):
				column.isOpen = !column.isOpen;
			case SayHello(data):
				trace("Hello!");
		}
		return model;
	}
}

enum GenMsg {
	NoOp;
	ToggleWindow(window :WindowContent);
	ToggleColumn(column :Column);
	SayHello(data :Dynamic);
}
