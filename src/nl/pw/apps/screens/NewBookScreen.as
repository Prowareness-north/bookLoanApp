package nl.pw.apps.screens 
{
	import feathers.controls.Alert;
	import feathers.controls.PanelScreen;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.TextInput;
	import nl.pw.apps.barcode.BarcodeInstance;
	import nl.pw.apps.data.BolComService;
	
	import feathers.layout.AnchorLayout;
	import feathers.layout.VerticalLayout;
	import feathers.system.DeviceCapabilities;
	import feathers.events.FeathersEventType;
	import feathers.core.PopUpManager;
	
	
	import starling.events.Event;
	import starling.display.DisplayObject;
	import starling.core.Starling;
	
	
	/**
	 * ...
	 * @author Dave Woertman
	 */
	
	[Event(name = "showBarcodeReader", type = "starling.events.Event")]
	[Event(name = "showBookDetails", type = "starling.events.Event")]
	
	public class NewBookScreen extends PanelScreen
	{
		
		private var barcodeInput:TextInput;
		private var submitBtn:Button;
		private var scanBtn:Button;
		private var alert:PopupPanelScreen;
		
		private var barcode:BarcodeInstance = BarcodeInstance.getInstance();
		
		public static const SHOW_BARCODE_READER:String = "showBarcodeReader";
		public static const SHOW_BOOK_DETAILS:String = "showBookDetails";
		
		public function NewBookScreen() 
		{
			super();
			
		}
		
		override protected function initialize():void{
			super.initialize();
			
			this.title = "Add a new book now";
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.gap = 10;
			this.layout = layout;	
			
			this.headerFactory = this.customHeaderFactory;

			//this screen doesn't use a back button on tablets because the main
			//app's uses a split layout
			if(!DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				this.backButtonHandler = this.onBackButton;
			}
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInCompleteHandler);			
			
			//add a screen where to enter a barcode manually or scan it....
			barcodeInput = new TextInput();
			barcodeInput.text = "9789082347708";
			this.addChild(barcodeInput);
			submitBtn = new Button();
			submitBtn.label = "Submit manual barcode";
			submitBtn.addEventListener(Event.TRIGGERED, submitBtn_handler);
			this.addChild(submitBtn);
			scanBtn = new Button();
			scanBtn.addEventListener(Event.TRIGGERED, scanBtn_handler);
			scanBtn.label = "Scan barcode with camera";
			scanBtn.paddingTop = 20;
			this.addChild(scanBtn);
			
		}
		
		private function submitBtn_handler(e:Event):void 
		{
			if (barcodeInput.text == "") {
				this.alert = new PopupPanelScreen("No barcode to search for....");
				this.alert.title = "Error";
				this.alert.closeButtonBool = true;
				PopUpManager.addPopUp(this.alert);
			}else {
				var bolcomService:BolComService = new BolComService();
				bolcomService.searchBarcode(barcodeInput.text,this);
			}
		}
		
		private function scanBtn_handler(e:Event):void 
		{
			this.dispatchEventWith(SHOW_BARCODE_READER);
		}
		
		
		
		private function customHeaderFactory():Header
		{
			var header:Header = new Header();
			//this screen doesn't use a back button on tablets because the main
			//app's uses a split layout
			if(!DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				var backButton:Button = new Button();
				backButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_BACK_BUTTON);
				backButton.label = "Back";
				backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);
				header.leftItems = new <DisplayObject>
				[
					backButton
				];
			}

			return header;
		}
		
		private function okButton_triggeredHandler(e:Event):void 
		{
			e.currentTarget.removeEventListeners();
		}

		private function onBackButton():void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}
		

		private function transitionInCompleteHandler(event:Event):void
		{
			//when transition is cmpleted
		}
		
		private function backButton_triggeredHandler(event:Event):void
		{
			this.onBackButton();
		}
		
		
	}

}