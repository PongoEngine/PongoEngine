package engine.model;

import perdita.model.util.UUID.WindowId;
import perdita.model.util.UUID.DrawerId;
import perdita.model.util.PointerPosition;

enum ActiveItem
{
    Drawer(id :DrawerId, position :PointerPosition);
    Window(id :WindowId, position :PointerPosition);
    None;
}