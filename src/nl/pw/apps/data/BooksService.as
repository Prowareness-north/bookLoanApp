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
	import nl.pw.apps.Settings;
	import nl.pw.apps.data.ModelInstance;
	import nl.pw.apps.data.BookVO;
	
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	import feathers.core.PopUpManager;
	
	/**
	 * ...
	 * @author Dave Woertman
	 */
	public class BooksService 
	{
		
		private var settings:Settings = Settings.getInstance();
		private var _model:ModelInstance = ModelInstance.getInstance();
		
		
		private var alert:PopupPanelScreen;
		
		public function BooksService() 
		{
			
			
		}
		
		public function getAllBooks():void {

			var referenceArray:Array;
			for (var i:int = 0; i <= 20; i++) {
				var book:BookVO = new BookVO();
				book.title = "Book nr " + i;
				book.barcodeEAN = "9789056379674";
				book.imageS_URL = "https://s.s-bol.com/imgbase0/imagebase/thumb/FC/1/0/5/3/1001004004993501.jpg";
				
				referenceArray = this._model.searchBooks[i].children;
				referenceArray.push(book);
			}
			
			
		}
		
	}

}