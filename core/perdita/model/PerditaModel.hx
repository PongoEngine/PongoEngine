package perdita.model;

class PerditaModel
{
    public var stretchableColumn :Column;
	public var activePoint :Point;
	public var selectedFloater :FloatingWindow;
	public var floaters: Array<FloatingWindow>;

    public function new() : Void
    {
        this.stretchableColumn = null;
        this.activePoint = new Point();
        this.selectedFloater = null;
        this.floaters = new Array<FloatingWindow>();
    }
}