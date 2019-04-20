package gen;

class GenUpdate {
	public static function update(msg:GenMsg, model:GenModel):GenModel {
		switch msg {
			case NoOp:
				trace("noOp");
			case Ham(str):
				trace(str);
		}
		return model;
	}
}

enum GenMsg {
	NoOp;
	Ham(str:String);
}
