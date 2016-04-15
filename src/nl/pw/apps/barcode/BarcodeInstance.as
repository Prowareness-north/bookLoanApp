package nl.pw.apps.barcode 
{
	import com.myflashlab.air.extensions.barcode.Barcode;
	/**
	 * ...
	 * @author Dave Woertman
	 */
	public final class BarcodeInstance extends Barcode
	{
		private static var _instance:BarcodeInstance;
		
		public function BarcodeInstance() 
		{
			super();
			
			if (_instance) {
						throw new Error("Singleton...Use getInstance instead");
				}
				_instance = this;
		}
		
		public static function getInstance():BarcodeInstance {
			if (!_instance) {
					new BarcodeInstance();
			}
			return _instance;
		}
		
	}

}