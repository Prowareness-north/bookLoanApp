package nl.pw.apps.screens 
{
	import feathers.controls.PanelScreen;
	import flash.filesystem.File;
	import nl.pw.apps.barcode.BarcodeInstance;
	import nl.pw.apps.data.BolComService;
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	import starling.events.Event;
	import feathers.core.PopUpManager;
	import nl.pw.apps.screens.PopupPanelScreen;
	
	import com.myflashlab.air.extensions.barcode.Barcode;
	import com.myflashlab.air.extensions.barcode.BarcodeEvent;
	/**
	 * ...
	 * @author Dave Woertman
	 */
	[Event(name = "complete", type = "starling.events.Event")]
	 
	public class BarcodeReaderScreen extends PanelScreen
	{
		public var barcode:BarcodeInstance = BarcodeInstance.getInstance();
		private var alert:PopupPanelScreen;
		
		public function BarcodeReaderScreen() 
		{
			trace('screen initialized through constructor');
			super.initialize();
			barcode.addEventListener(BarcodeEvent.RESULT, onResult);
			barcode.addEventListener(BarcodeEvent.CANCEL, onCancel);

			if (barcode.isSupported())
			{
				
				barcode.open([Barcode.EAN13], File.applicationDirectory.resolvePath("barcode_beep.mp3"), true, "Cancel");
				// to read only the selected barcode types. use an array to read one or more barcodes
				//_ex.open([Barcode.QR], File.applicationDirectory.resolvePath("com_doitflash_barcode_beep.mp3"), true, "Cancel");

				// to read all barcodes supported by the extension. read documentations to know which barcodes are supported.
				
			}
			else
			{
				this.alert = new PopupPanelScreen("is not Supported: " + barcode.isSupported());
				this.alert.title = "Error";
				this.alert.closeButtonBool = true;
				PopUpManager.addPopUp(this.alert);
			}
		}
		
	
		private function onCancel(e:BarcodeEvent):void
		{
			this.alert = new PopupPanelScreen("No barcode scanned");
			this.alert.title = "Camera stopped";
			this.alert.closeButtonBool = true;
			PopUpManager.addPopUp(this.alert);
			this.dispatchEventWith(Event.COMPLETE);
			
		}

		private function onResult(e:BarcodeEvent):void
		{
			if (e.param.type == "org.gs1.EAN-13") {
				//Do a search at Bol.com to get the latest info about the book/product.
				var bolcomService:BolComService = new BolComService();
				bolcomService.searchBarcode(e.param.data, this);
				
				this.dispatchEventWith(Event.COMPLETE);
			}
			
		}
		private function backButton_triggeredHandler(event:Event):void
			{
				this.dispatchEventWith(Event.COMPLETE);
			}
			
		}

}