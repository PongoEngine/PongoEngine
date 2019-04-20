package gen;

import iqua.Html.*;
import iqua.VirtualNode;
import iqua.Architecture;
import gen.GenUpdate;

class GenView {
	public static function view(arch:Architecture<GenModel, GenMsg>, model:GenModel):VirtualNode {
		return div(arch, [], [
			div(arch, [], [
				h1(arch, [ON_CLICK(Ham("hello"))], "Initial Commit!"),
				h1(arch, [ON_CLICK(Ham("hello"))], "Initial Commit!")
			]),
		]);
	}

	public static function pixel(arch:Architecture<GenModel, GenMsg>, color:Int):VirtualNode {
		return div(arch, [CLASS("pixel"), STYLE({backgroundColor: "#000"})], []);
	}
}
