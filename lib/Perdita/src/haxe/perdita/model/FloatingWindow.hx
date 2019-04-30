package perdita.model;

import js.Browser.window;

class FloatingWindow
{
    public var position :Point;
    public var dimensions :Point;
    public var isUpdatingWidth :Bool;

	public function new() : Void
	{
        this.position = new Point(400, 100);
        this.dimensions = new Point(900, 700);
        this.isUpdatingWidth = false;
	}

    public function resizeTo(x :Int, y :Int) : Void
    {
        var width = (x - this.position.x) + 6;
        var height = y - this.position.y + 6;

        this.dimensions.x = Std.int(Math.max(60, width));
        this.dimensions.y = Std.int(Math.max(80, height));
    }

    public function moveBy(x :Int, y :Int) : Void
    {
        var nX = this.position.x + x;
        var nY = this.position.y + y;
        this.position.x = Std.int(Math.max(0, nX));
        this.position.y = Std.int(Math.max(0, nY));

        if(this.position.x + this.dimensions.x > window.innerWidth) {
            this.position.x = Std.int(window.innerWidth - this.dimensions.x);
        }

        if(this.position.y + this.dimensions.y > window.innerHeight) {
            this.position.y = Std.int(window.innerHeight - this.dimensions.y);
        }
    }
}