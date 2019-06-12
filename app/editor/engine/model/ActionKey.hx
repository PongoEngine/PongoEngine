package engine.model;

@:enum
abstract ActionKey(String) from String {
	var Command = "Meta";
	var S = "s";
	var R = "r";
	var J = "j";
}