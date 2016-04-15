package nl.pw.apps.screens 
{
	import feathers.controls.ImageLoader;
	import feathers.controls.Alert;
	import feathers.controls.Label;
	import feathers.data.ListCollection;
	import feathers.controls.PanelScreen;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.TextArea;
	import feathers.layout.VerticalLayout;
	import feathers.system.DeviceCapabilities;
	import feathers.events.FeathersEventType;
	import flash.net.URLRequest;
	import nl.pw.apps.data.ModelInstance;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	
	import starling.events.Event;
	import starling.display.DisplayObject;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Dave Woertman
	 */
	[Event(name = "complete", type = "starling.events.Event")]
	
	public class BookDetailScreen extends PanelScreen
	{
		private var _model:ModelInstance = ModelInstance.getInstance();
		private var ownerTextField:Label;
		private var titleTextField:Label;
		private var subtitleTextField:Label;
		private var authorTextField:Label;
		private var barcodeTextField:Label;
		private var summaryTextField:Label;
		private var descriptionTextField:TextField;
		private var bookImage:Image;
		private var bookImageLoader:ImageLoader;
		private var bookLoanBtn:Button;
		private var bookAddBtn:Button;
		private var bookBuyBtn:Button;
		
		public function BookDetailScreen() 
		{
			super();
			
		}
		
		override protected function initialize():void{
			super.initialize();
			
			 
			this.title = "Details of the book";

			var layout:VerticalLayout = new VerticalLayout();	
			layout.gap = 10;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			
			this.layout = layout;
			
			this.headerFactory = this.customHeaderFactory;

			//this screen doesn't use a back button on tablets because the main
			//app's uses a split layout
			if(!DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				this.backButtonHandler = this.onBackButton;
			}
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInCompleteHandler);			
			
			var loader:ImageLoader = new ImageLoader();
			 loader.source = _model.selectedBook.imageXL_URL;
			 loader.addEventListener( Event.COMPLETE, loader_completeHandler );
			this.addChild(loader);
			
			
			this.ownerTextField = new Label();
			this.ownerTextField.text = "Owner: " + (_model.selectedBook.owner != "" ? _model.selectedBook.owner : "<no owner yet>");
			this.addChild(ownerTextField);
			
			this.titleTextField = new Label();
			this.titleTextField.text = "Title: " + _model.selectedBook.title;
			this.addChild(titleTextField);
			
			if(_model.selectedBook.subtitle != ""){
				this.subtitleTextField = new Label();
				this.subtitleTextField.text = "Subtitle: " + _model.selectedBook.subtitle;
				this.addChild(subtitleTextField);
			}
			
			this.authorTextField = new Label();
			this.authorTextField.text = "Author: " + _model.selectedBook.author;
			this.addChild(authorTextField);
			
			this.barcodeTextField = new Label();
			this.barcodeTextField.text = "Barcode: " + _model.selectedBook.barcodeEAN;
			this.addChild(barcodeTextField);
			
			this.summaryTextField = new Label();
			this.summaryTextField.text = "Summary: " + _model.selectedBook.summary;
			this.addChild(summaryTextField);
			
			this.descriptionTextField = new TextField(this.stage.stageWidth,250,_model.selectedBook.shortDescription);
			this.descriptionTextField.fontSize = 20;
			
			this.addChild(descriptionTextField);
			
			this.bookLoanBtn = new Button();
			this.bookLoanBtn.label = "I want to loan this book!";
			this.bookLoanBtn.addEventListener(Event.TRIGGERED, loanBookHandler);
			this.addChild(bookLoanBtn);
			
			this.bookAddBtn = new Button();
			this.bookAddBtn.label = "I also have this book!";
			this.bookAddBtn.addEventListener(Event.TRIGGERED, addBookHandler);
			this.addChild(bookAddBtn);
			
			this.bookBuyBtn = new Button();
			this.bookBuyBtn.label = "I want to buy the book.";
			this.bookBuyBtn.addEventListener(Event.TRIGGERED, buyBookHandler);
			this.addChild(bookBuyBtn);
		}
		
		private function loanBookHandler(e:Event):void 
		{
			var alert:Alert = Alert.show("Do you want to request loaning this book from the owner by e-mail?","Are you sure?", new ListCollection(
			[
				{ label: "Yes", triggered: yesLoanButton_triggeredHandler },
				{ label: "No", triggered: noButton_triggeredHandler }
			]) );
		}
		private function addBookHandler(e:Event):void 
		{
			var alert:Alert = Alert.show("Do you want to add this book to your own catalogue?","Are you sure?", new ListCollection(
			[
				{ label: "Yes", triggered: yesAddButton_triggeredHandler },
				{ label: "No", triggered: noButton_triggeredHandler }
			]) );
		}
		private function buyBookHandler(e:Event):void 
		{
			var url:URLRequest = new URLRequest(_model.selectedBook.bol_URL);
			//open the build in browser....
		}
		
		private function noButton_triggeredHandler(e:Event):void 
		{
			//do nothing
		}
		
		private function yesLoanButton_triggeredHandler(e:Event):void 
		{
			//Implement loaning a book....
			//Go back to the overview
		}
		private function yesAddButton_triggeredHandler(e:Event):void 
		{
			//Implement adding book to catalogue
		}
		
		
		
		private function loader_completeHandler(e:Event):void 
		{
			removeEventListener(e);
			this.bookImage.addEventListener
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