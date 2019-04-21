package gen;

using iqua.Html;
using gen.UI;
import iqua.VirtualNode;
import iqua.Architecture;
import gen.GenUpdate;

class GenView {
	public static function view(arch:Architecture<GenModel, GenMsg>, model:GenModel):VirtualNode {
		return arch.div([CLASS("full-screen"), MOUSE_DOWN(null,GlobalDown), MOUSE_UP(null,GlobalUp), MOUSE_MOVE(null,GlobalMove)], [
			arch.div([CLASS("nav-bar border-bottom")], [
				arch.h1([], "Game Editor")
			]),
			arch.div([CLASS("main-content flex-row")], [
				arch.column(model.columnLeft ,[for (window in model.columnLeft.windows) arch.collapsingWindow(window, [])]),
				arch.div([CLASS("woah flex-column")], [
					arch.div([CLASS("game-window")], []),
					arch.bottom(model.bottom, [])
				]),
				arch.column(model.columnRight ,[for (window in model.columnRight.windows) arch.collapsingWindow(window, [])]),
			])
		]);
	}
}