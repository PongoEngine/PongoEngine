package gen.model;

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