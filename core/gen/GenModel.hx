package gen;

class GenModel 
{
	public var columnLeft :Column;
	public var columnRight :Column;
	public var bottom :WindowContent;

	public function new():Void 
	{
		this.columnLeft = new Column([
			new WindowContent("wl1"),
			new WindowContent("wl2"),
			new WindowContent("wl3")
		], true);
		this.columnRight = new Column([
			new WindowContent("wr1"),
			new WindowContent("wr2"),
			new WindowContent("wr3"),
			new WindowContent("wr4"),
			new WindowContent("wr5")
		], false);
		this.bottom = new WindowContent("Bottom");

	}
}

class Column
{
	public var isOpen :Bool;
	public var isLeft :Bool;
	public var windows :Array<WindowContent>;

	public function new(windows :Array<WindowContent>, isLeft :Bool):Void 
	{
		this.isOpen = true;
		this.isLeft = isLeft;
		this.windows = windows;
	}
}

class WindowContent
{
	public var title :String;
	public var isOpen :Bool;

	public function new(title :String):Void 
	{
		this.title = title;
		this.isOpen = true;
	}
}