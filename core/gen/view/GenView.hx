package gen.view;

using iqua.Html;
import iqua.Lazy;
using gen.view.UI;
import iqua.VirtualNode;
import iqua.Architecture;
import gen.update.GenMsg;
import gen.model.GenModel;

class GenView {
	public static function view(arch:Architecture<GenModel, GenMsg>, model:GenModel):VirtualNode {
		return arch.div([CLASS("full-screen"), MOUSE_DOWN(null,GlobalDown), MOUSE_UP(null,GlobalUp), MOUSE_MOVE(null,GlobalMove)], [
			arch.div([CLASS("nav-bar border-bottom")], [
				arch.pushButton(model.button1, [arch.p([], "Hello")])
			]),
			arch.div([CLASS("main-content flex-row")], [
				arch.column(model.columnLeft ,[for (window in model.columnLeft.windows) arch.collapsingWindow(window, [
					
				])]),
				arch.div([CLASS("woah flex-column")], [
					arch.div([CLASS("game-window")], []),
					arch.bottom(model.bottom, [
						arch.pushButton(model.button2, [arch.p([], "Hello")]),
						arch.inputText(model.text),
						Lazy.lazy1("regTest", cool)(arch, model.text.data)
					])
				]),
				arch.column(model.columnRight ,[for (window in model.columnRight.windows) arch.collapsingWindow(window, [

				])]),
			])
		]);
	}

	public static function cool(arch:Architecture<GenModel, GenMsg>, str :String):VirtualNode {
		return arch.p([], str);
	}
	
}