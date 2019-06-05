package engine.model;

import perdita.model.Window;
import perdita.model.Drawer;
import perdita.model.AccordianItem;
import perdita.model.util.PointerPosition;

import haxe.Serializer;
import haxe.Unserializer;

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
	public var nextId :Int;

	@:keep
	function hxSerialize(s:Serializer) {
		s.serialize(drawerLeft);
		s.serialize(activePoint);
		s.serialize(stretchableColumn);
		s.serialize(selectedFloater);
		s.serialize(floaters);
		s.serialize(accordianItems);
		s.serialize(lineItem);
		s.serialize(activeKeys);
		s.serialize(nextId);
	}

	@:keep
	function hxUnserialize(u:Unserializer) {
		drawerLeft = u.unserialize();
		activePoint = u.unserialize();
		stretchableColumn = u.unserialize();
		selectedFloater = u.unserialize();
		floaters = u.unserialize();
		accordianItems = u.unserialize();
		lineItem = u.unserialize();
		activeKeys = u.unserialize();
		nextId = u.unserialize();
	}

	public function new():Void 
	{
		this.drawerLeft = new Drawer(true);
		this.activePoint = new PointerPosition();
		this.stretchableColumn = null;
		this.nextId = 0;
		this.lineItem = new TreeItem(true, this.nextId++);
		this.accordianItems = [];
		this.floaters = [new Window()];
		this.selectedFloater = null;
		this.activeKeys = new Map<ActionKey, ActionKey>();
	}
}