package gen.model;

import perdita.model.FloatingWindow;
import perdita.model.Column;
import perdita.model.WindowContent;
import perdita.model.Button;
import perdita.model.Point;
import perdita.model.Text;

class GenModel 
{
	public var columnLeft :Column;
	public var columnRight :Column;
	public var bottom :WindowContent;
	public var button1 :Button;
	public var button2 :Button;

	public var stretchableColumn :Column;
	public var activePoint :Point;
	public var text :Text;
	public var selectedFloater :FloatingWindow;
	public var floaters: Array<FloatingWindow>;

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

		this.button1 = new Button(true);
		this.button2 = new Button(false);
		this.text = new Text("Hello");

		this.floaters = [
			new FloatingWindow(),
			new FloatingWindow()
		];

		this.selectedFloater = null;
	}
}