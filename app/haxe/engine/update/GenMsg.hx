package engine.update;

import towser.html.Event.KeyboardEvent;
import towser.html.Event.MouseEvent;
import towser.html.Event.InputEvent;
using perdita.model.Textfield;
using perdita.model.Window;
using perdita.model.Drawer;
using perdita.model.Toggle;
using perdita.model.AccordianItem;
using perdita.model.LineItem;
import engine.model.TreeItem;
import nosey.definition.DType;

enum GenMsg {
	GLOBAL_KEY_DOWN(e :KeyboardEvent);
	GLOBAL_KEY_UP(e :KeyboardEvent);
	SAVE(e :MouseEvent);
	ToggleLineItem(lineItem :LineItem, e :MouseEvent);
	ToggleWindow(window :AccordianItem);
	ToggleColumn(column :Drawer, e :MouseEvent);
	ToggleButton(button :Toggle);
	TextInput(data :Textfield, str :InputEvent);
	OnFileLoad(e :InputEvent);
	TypedTextInput(type :DType, data :Textfield, str :InputEvent);
	GlobalMove(e :MouseEvent);
	GlobalUp(e :MouseEvent);
	GlobalDown(e :MouseEvent);
	StretchColumn(data:Drawer, e :MouseEvent);
	SelectWindow(data:Window, updateDimensions :Bool, e:MouseEvent);
	AddTreeItem(item :TreeItem, e :MouseEvent);
	DeleteTreeItem(item :TreeItem, e :MouseEvent);
	UpdateTreeItemText(field :Textfield, e :InputEvent);
}