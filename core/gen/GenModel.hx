package gen;

class GenModel 
{
	public var columnLeft :Column;
	public var columnRight :Column;

	public var windowsLeft :Array<WindowContent>;
	public var windowsRight :Array<WindowContent>;

	public function new():Void 
	{
		this.columnLeft = new Column(true);
		this.columnRight = new Column(false);

		this.windowsLeft = [
			new WindowContent("wl1"),
			new WindowContent("wl2"),
			new WindowContent("wl3")
		];

		this.windowsRight = [
			new WindowContent("wr1"),
			new WindowContent("wr2"),
			new WindowContent("wr3"),
			new WindowContent("wr4"),
			new WindowContent("wr5")
		];
	}
}

class Column
{
	public var isOpen :Bool;
	public var isLeft :Bool;

	public function new(isLeft :Bool):Void 
	{
		this.isLeft = isLeft;
		this.isOpen = true;
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