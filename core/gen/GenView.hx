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
				arch.h1([ON_CLICK(Ham("hello"))], "Game Editor")
			]),
			arch.div([CLASS("main-content group")], [
				arch.div([CLASS("game-window")], [
				]),
                arch.div([CLASS("column border-left")], [
					arch.div([CLASS("flex")], [
						for (window in model.windows) arch.collapsingWindow(window, [])
                    ])
				])
			])
		]);
	}
}
