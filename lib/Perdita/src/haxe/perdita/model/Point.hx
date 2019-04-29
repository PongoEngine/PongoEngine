package perdita.model;

class Point
{
	public var x :Int;
	public var y :Int;

	public function new(x :Int = 0, y :Int = 0) : Void
	{
		this.x = x;
		this.y = y;
	}

	public inline function update(x :Int, y :Int) : Void
	{
		this.x = x;
		this.y = y;
	}
}