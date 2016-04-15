package nl.pw.apps.data {
	
	public class SearchSettings
	{
		public static const STYLE_NORMAL:String = "normal";
		public static const STYLE_INSET:String = "inset";

		public function SearchSettings()
		{
		}

		public var isSelectable:Boolean = true;
		public var hasElasticEdges:Boolean = true;
		public var style:String = STYLE_NORMAL;
	}
}
