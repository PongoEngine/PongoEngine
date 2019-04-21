package gen.model;

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