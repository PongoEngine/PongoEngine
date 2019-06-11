package engine.model;

import perdita.model.Window;
import perdita.model.Drawer;
import perdita.model.AccordianItem;
import perdita.model.Textfield;
import perdita.model.util.UUID;
import engine.model.TreeItem;
import engine.model.TypedTextField;
import nosey.TypingData;

class Model 
{
	public var baseKey :String;
	public var drawerLeft (default, null):Drawer;
	public var windows (default, null): Array<Window>;
	public var accordianItems (default, null): Array<AccordianItem>;
	public var lineItem (default, null):TreeItem;
	public var activeKeys (default, null):Map<ActionKey, ActionKey>;
	public var activeItem :ActiveItem;
	public var typingData (default, null):TypingData;
	public var textFields (default, null):Map<String, TypedTextField>;

	public function new(typingData :TypingData):Void 
	{
		this.baseKey = "cool";
		this.drawerLeft = new Drawer(true, UUID.drawerId());
		this.lineItem = new TreeItem(true, "", UUID.lineItemId());
		this.accordianItems = [];
		this.windows = [
			new Window(UUID.windowId(), 0)
		];
		this.activeKeys = new Map<ActionKey, ActionKey>();
		this.activeItem = None;
		this.typingData = typingData;
		this.textFields = new Map<String, TypedTextField>();
	}

	public static function clearKeys(model :Model) : Model
	{
		var keys = model.activeKeys.keys();
		for(k in keys) {
			model.activeKeys.remove(k);
		}
		return model;
	}
}