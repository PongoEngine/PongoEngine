package gen;

class GenModel 
{
	public var windows :Array<WindowContent>;

	public function new():Void 
	{
		this.windows = [
			new WindowContent("Hello"),
			new WindowContent("World"),
			new WindowContent("Cheese")
		];
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