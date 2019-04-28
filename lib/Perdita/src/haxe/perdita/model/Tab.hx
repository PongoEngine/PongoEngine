package perdita.model;

class Tab
{
	public var isActive :Bool;
	public var value :String;

	public function new(isActive :Bool, value :String) : Void
	{
		this.isActive = isActive;
		this.value = value;
	}
}