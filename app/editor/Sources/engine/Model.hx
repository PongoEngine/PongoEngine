package engine;

import perdita.model.Textfield;
import perdita.model.Window;
import perdita.model.Drawer;
import perdita.model.AccordianItem;
import perdita.model.Toggle;
import perdita.model.util.Point;
import perdita.model.util.PointerPosition;

class Model 
{
	public var columnLeft :Drawer;
	public var columnRight :Drawer;
	public var button1 :Toggle;
	public var button2 :Toggle;

	public var stretchableColumn :Drawer;
	public var activePoint :PointerPosition;
	public var text :Textfield;
	public var text2 :Textfield;
	public var selectedFloater :Window;
	public var floaters: Array<Window>;
	public var windows: Array<AccordianItem>;

	public function new():Void 
	{
		this.columnLeft = new Drawer(true);
		this.columnRight = new Drawer(false);
		this.activePoint = new PointerPosition();
		this.stretchableColumn = null;

		this.windows = [
			new AccordianItem("wl1"),
			// new AccordianItem("wl2"),
			// new AccordianItem("wl3")
		];

		this.button1 = new Toggle(true);
		this.button2 = new Toggle(false);
		this.text = new Textfield("Position", "");
		this.text2 = new Textfield("Volume", "");

		this.floaters = [
			// new Window()
		];

		this.selectedFloater = null;
	}
}