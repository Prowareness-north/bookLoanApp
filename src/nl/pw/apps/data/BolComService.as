package nl.pw.apps.data 
{
	
	import feathers.controls.PanelScreen;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import JSON;
	import nl.pw.apps.screens.PopupPanelScreen;
	import nl.pw.apps.screens.NewBookScreen;
	import nl.pw.apps.Settings;
	import nl.pw.apps.data.ModelInstance;
	
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	import feathers.core.PopUpManager;
	
	/**
	 * ...
	 * @author Dave Woertman
	 */
	public class BolComService 
	{
		private var searchBarcodeURL:URLRequest ;
		private var searchBarcodeURLParams:URLVariables;
		private var searchBarcodeURLLoader:URLLoader;
		private var settings:Settings = Settings.getInstance();
		private var _model:ModelInstance = ModelInstance.getInstance();
		
		private var _referenceScreen:PanelScreen;
		
		private var alert:PopupPanelScreen;
		
		public static const SHOW_BOOK_DETAILS:String = "showBookDetails";
		
		public function BolComService() 
		{
			
			
		}
		
		public function searchBarcode(barcode:String,refScreen:PanelScreen):void {	
			this._referenceScreen = refScreen;
			
			this.searchBarcodeURL = new URLRequest(settings.bolComOpenAPI_URL);
			this.searchBarcodeURL.method = URLRequestMethod.GET;
			//The URL parameters filled
			this.searchBarcodeURLParams = new URLVariables();
			this.searchBarcodeURLParams.q = barcode;
			this.searchBarcodeURLParams.format = settings.bolComOpenAPIformat;
			this.searchBarcodeURLParams.apikey = settings.bolComOpenAPIKey;
			this.searchBarcodeURLParams.limit = 4;
			this.searchBarcodeURLParams.offset = 0;
			this.searchBarcodeURLParams.country = "NL";
			
			this.searchBarcodeURL.data = this.searchBarcodeURLParams;
			//create a loader and the event handlers
			this.searchBarcodeURLLoader = new URLLoader(this.searchBarcodeURL);
			this.searchBarcodeURLLoader.addEventListener(Event.COMPLETE, completeHandler);
			this.searchBarcodeURLLoader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			this.searchBarcodeURLLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			
		}
		
		private function errorHandler(e:Event):void 
		{
			this.alert = new PopupPanelScreen("HTPP or Security error found");
			this.alert.title = "ERROR";
			this.alert.closeButtonBool = true;
			PopUpManager.addPopUp(this.alert);
		}
		
		private function completeHandler(e:Event):void 
		{
			
			var obj:Object;
			
			if (e.target.data != null) {
				obj = JSON.parse(e.target.data);
				if (obj.totalResultSize == 1) {
					/*
					this.alert = new PopupPanelScreen("Completed " + obj.products[0].title);
					this.alert.title = "Success";
					this.alert.closeButtonBool = true;
					PopUpManager.addPopUp(this.alert);
					*/
					selectBookFromJSON(obj.products[0]);
					//How to fire an event that triggers the details screen to show....
					trace(_referenceScreen.screenID.toString());
					if(_referenceScreen.screenID.toString() == "newBook"){
						_referenceScreen.dispatchEventWith(NewBookScreen.SHOW_BOOK_DETAILS, true);
					}else if (_referenceScreen.screenID == "barcodeReader") {
						_referenceScreen.dispatchEventWith(NewBookScreen.SHOW_BOOK_DETAILS, true);
					}
				}else if (obj.totalResultSize == 0) {
					this.alert = new PopupPanelScreen("No books found on Bol.com website");
					this.alert.title = "Error";
					this.alert.closeButtonBool = true;
					PopUpManager.addPopUp(this.alert);
				}else {
					this.alert = new PopupPanelScreen("Found multiple books with this barcode/text");
					this.alert.title = "Error";
					this.alert.closeButtonBool = true;
					PopUpManager.addPopUp(alert);
				}
				
			}
		}
		
		private function selectBookFromJSON(obj:Object):void 
		{
			this._model.selectedBook = new BookVO();
			this._model.selectedBook.title = obj["title"];
			this._model.selectedBook.summary = obj["summary"];
			this._model.selectedBook.shortDescription = obj["shortDescription"];
			this._model.selectedBook.author = obj["specsTag"];
			this._model.selectedBook.barcodeEAN = obj["ean"];
			this._model.selectedBook.bookId = obj["id"];
			this._model.selectedBook.bol_URL = obj["urls"][1]["value"];
			this._model.selectedBook.imageXS_URL = obj["images"][0]["url"];
			this._model.selectedBook.imageS_URL = obj["images"][1]["url"];
			this._model.selectedBook.imageM_URL = obj["images"][2]["url"];
			this._model.selectedBook.imageL_URL = obj["images"][3]["url"];
			this._model.selectedBook.imageXL_URL = obj["images"][4]["url"];
		}
		
	}

}