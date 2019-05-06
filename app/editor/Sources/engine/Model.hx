package engine;

import perdita.model.Textfield;
import perdita.model.Window;
import perdita.model.Drawer;
import perdita.model.AccordianItem;
import perdita.model.Toggle;
import perdita.model.util.PointerPosition;

class Model 
{
	public var drawerLeft :Drawer;
	public var drawerRight :Drawer;

	public var activePoint :PointerPosition;

	public var stretchableColumn :Drawer;
	public var selectedFloater :Window;
	public var floaters: Array<Window>;
	public var windows: Array<AccordianItem>;

	public function new():Void 
	{
		this.drawerLeft = new Drawer(true);
		this.drawerRight = new Drawer(false);
		this.activePoint = new PointerPosition();
		this.stretchableColumn = null;

		this.windows = [
			new AccordianItem("wl1")
		];

		this.floaters = [
		];

		this.selectedFloater = null;
	}
}