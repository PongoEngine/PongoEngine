package gen.model;

class FloatingWindow
{
    public var position :Point;
    public var dimensions :Point;
    public var isUpdatingWidth :Bool;

	public function new() : Void
	{
        this.position = new Point();
        this.dimensions = new Point(300, 300);
        this.isUpdatingWidth = false;
	}
}