package gen;

using iqua.Html;
using gen.UI;
import iqua.VirtualNode;
import iqua.Architecture;
import gen.GenUpdate;

class GenView {
	public static function view(arch:Architecture<GenModel, GenMsg>, model:GenModel):VirtualNode {
		return arch.div([CLASS("full-screen")], [
			arch.div([CLASS("nav-bar border-bottom")], [
				arch.h1([], "Game Editor")
			]),
			arch.div([CLASS("main-content flex-row")], [
				arch.column(model.columnLeft ,[for (window in model.windowsLeft) arch.collapsingWindow(window, [])]),
				arch.div([CLASS("game-window")], []),
				arch.column(model.columnRight ,[for (window in model.windowsRight) arch.collapsingWindow(window, [])]),
			])
		]);
	}
}