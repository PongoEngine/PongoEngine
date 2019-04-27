package gen.model;

class FloatingWindow
{
    public var position :Point;
    public var dimensions :Point;

	public function new() : Void
	{
        this.position = new Point();
        this.dimensions = new Point(300, 300);
	}
}