package engine.model;

import perdita.model.Window;
import perdita.model.Drawer;
import perdita.model.AccordianItem;
import perdita.model.util.PointerPosition;
import perdita.model.Textfield;

class Model 
{
	public var drawerLeft :Drawer;
	public var activePoint :PointerPosition;
	public var stretchableColumn :Drawer;
	public var selectedFloater :Window;
	public var floaters: Array<Window>;
	public var accordianItems: Array<AccordianItem>;
	public var lineItem :TreeItem;
	public var activeKeys :Map<ActionKey, ActionKey>;

	public function new():Void 
	{
		this.drawerLeft = new Drawer(true);
		this.activePoint = new PointerPosition();
		this.stretchableColumn = null;
		this.lineItem = new TreeItem(true);

		this.accordianItems = [
		];

		this.floaters = [
			new Window()
		];

		this.selectedFloater = null;
		this.activeKeys = new Map<ActionKey, ActionKey>();
	}

	public static function fromSave(save :Model) : Model
	{
		save.activeKeys = new Map<ActionKey, ActionKey>();
		return save;
	}
}