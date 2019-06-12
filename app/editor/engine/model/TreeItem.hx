package engine.model;

import perdita.model.util.UUID.LineItemId;
import perdita.model.LineItem;
import perdita.model.Textfield;

class TreeItem extends LineItem
{
	public var content :TreeContent;
	public var field :Textfield;
	public var parentId :LineItemId;

	public function new(isExpanded :Bool, name :String, id :LineItemId) : Void
	{
		super(isExpanded, id);
		this.content = EMPTY;
		this.field = new Textfield("Entity Name", name, true);
		this.parentId = new LineItemId("");
	}

	public static function getItem(root :TreeItem, id :LineItemId) : TreeItem
	{
		if(root.id == id) {
			return root;
		}

		switch root.content {
			case CHILDREN(children): {
				for(c in children) {
					var item = getItem(c, id);
					if(item != null) return item;
				}
			}
			case _:
		}
		return null;
	}

	public static function addChild(parent :TreeItem, child :TreeItem) : TreeItem
	{
		child.parentId = parent.id;
		switch parent.content {
			case CHILDREN(children):
				children.push(child);
			case _:
				parent.content = CHILDREN([child]);
		}
		return parent;
	}

	public static function removeChild(parent :TreeItem, child :TreeItem) : TreeItem
	{
		switch parent.content {
			case CHILDREN(children):
				if(children.remove(child)) {
					child.parentId = new LineItemId("");
				}
			case COMPONENT(text):
			case EMPTY:
		}
		return parent;
	}

	public static function setTextField(item :TreeItem, textField :Textfield) : TreeItem
	{
		item.content = COMPONENT(textField);
		return item;
	}

	public function clear() : TreeItem
	{
		this.content = EMPTY;
		return this;
	}
}