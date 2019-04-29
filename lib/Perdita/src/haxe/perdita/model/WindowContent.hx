package perdita.model;

class WindowContent
{
	public var title :String;
	public var isOpen :Bool;

	public function new(title :String):Void 
	{
		this.title = title;
		this.isOpen = true;
	}

	public function toggle() : Bool
	{
		this.isOpen = !this.isOpen;
		return true;
	}
}