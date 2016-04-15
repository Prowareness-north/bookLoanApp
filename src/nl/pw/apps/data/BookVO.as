package nl.pw.apps.data 
{
	/**
	 * ...
	 * @author Dave Woertman
	 */
	public class BookVO 
	{
		public var bookId:String = "";
		public var title:String = "";
		public var subtitle:String = "";
		public var author:String = "";
		public var owner:String = "";
		public var barcodeEAN:String = "";
		public var summary:String = "";
		public var shortDescription:String = "";
		public var imageXS_URL:String = "";
		public var imageS_URL:String = "";
		public var imageM_URL:String = "";
		public var imageL_URL:String = "";
		public var imageXL_URL:String = "";
		public var bol_URL:String = "";
		//is it digital or paper book?
		public var paper_version:Boolean = true;
		public var selectedBy:String = "";
		
		public function BookVO() 
		{
			
		}
	}

}