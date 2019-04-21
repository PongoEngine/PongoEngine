package gen;

class GenModel 
{
	public var columnLeft :Column;
	public var columnRight :Column;
	public var bottom :WindowContent;

	public var stretchableColumn :Column;
	public var activePoint :Point;

	public function new():Void 
	{
		this.columnLeft = new Column([
			new WindowContent("wl1"),
			new WindowContent("wl2"),
			new WindowContent("wl3")
		], true);
		this.columnRight = new Column([
			new WindowContent("wr1"),
			new WindowContent("wr2")
		], false);
		this.bottom = new WindowContent("Bottom");
		this.activePoint = new Point();
		this.stretchableColumn = null;
	}
}

class Column
{
	public var width(default, null) :Int;
	public var isOpen(default, null) :Bool;
	public var isLeft(default, null) :Bool;
	public var windows(default, null) :Array<WindowContent>;

	public function new(windows :Array<WindowContent>, isLeft :Bool):Void 
	{
		this.width = 400;
		this.isOpen = true;
		this.isLeft = isLeft;
		this.windows = windows;
	}

	public function stretchBy(val :Int) : Bool
	{
		var dist = this.isLeft ? val : val * -1;
		this.width += dist;
		this.isOpen = true;

		if(this.width > MAX_WIDTH) {
			this.width = MAX_WIDTH;
			return false;
		}
		else if(this.width < COLLAPSING_WIDTH) {
			this.isOpen = false;
		}
		return true;
	}

	public function checkWidth() : Void
	{
		if(this.width < COLLAPSING_WIDTH) {
			this.width = MIN_WIDTH;
		}
	}

	public function toggleColumn() : Void
	{
		if(this.isOpen) {
			this.width = MIN_WIDTH;
			this.isOpen = false;
		}
		else {
			this.width = MAX_WIDTH;
			this.isOpen = true;
		}
	}

	public static inline var MIN_WIDTH :Int = 16;
	public static inline var MAX_WIDTH :Int = 400;
	public static inline var COLLAPSING_WIDTH :Int = 120;
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

class Point
{
	public var x :Int;
	public var y :Int;

	public function new() : Void
	{
		this.x = 0;
		this.y = 0;
	}
}