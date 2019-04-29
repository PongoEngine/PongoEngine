package perdita.model;

class Column
{
	public var width(default, null) :Int;
	public var isOpen(default, null) :Bool;
	public var isLeft(default, null) :Bool;
	public var isActive :Bool;
	public var windows(default, null) :Array<WindowContent>;

	public function new(windows :Array<WindowContent>, isLeft :Bool):Void 
	{
		this.width = 400;
		this.isOpen = true;
		this.isLeft = isLeft;
		this.isActive = false;
		this.windows = windows;
	}

	public function stretchBy(val :Int) : Bool
	{
		var dist = this.isLeft ? val : val * -1;
		this.width += dist;
		this.isOpen = true;

		if(this.width < COLLAPSING_WIDTH) {
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

	public function close() : Void
	{
		this.width = MIN_WIDTH;
		this.isOpen = false;
	}

	public function open(width :Int) : Void
	{
		this.width = width;
		this.isOpen = true;
	}

	public static inline var MIN_WIDTH :Int = 16;
	public static inline var COLLAPSING_WIDTH :Int = 120;
}