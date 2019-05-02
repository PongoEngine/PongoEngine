package engine;

import perdita.model.Textfield;
import perdita.model.FloatingWindow;
import perdita.model.Drawer;
import perdita.model.WindowContent;
import perdita.model.Button;
import perdita.model.Point;
import perdita.model.Text;

class Model 
{
	public var columnLeft :Drawer;
	public var columnRight :Drawer;
	public var bottom :WindowContent;
	public var button1 :Button;
	public var button2 :Button;

	public var stretchableColumn :Drawer;
	public var activePoint :Point;
	public var text :Textfield;
	public var text2 :Textfield;
	public var selectedFloater :FloatingWindow;
	public var floaters: Array<FloatingWindow>;
	public var windows: Array<WindowContent>;

	public function new():Void 
	{
		this.columnLeft = new Drawer(true);
		this.columnRight = new Drawer(false);
		this.bottom = new WindowContent("Bottom");
		this.activePoint = new Point();
		this.stretchableColumn = null;

		this.windows = [
			new WindowContent("wl1"),
			new WindowContent("wl2"),
			new WindowContent("wl3")
		];

		this.button1 = new Button(true);
		this.button2 = new Button(false);
		this.text = new Textfield("Position", "");
		this.text2 = new Textfield("Volume", "");

		this.floaters = [
			new FloatingWindow()
		];

		this.selectedFloater = null;
	}
}