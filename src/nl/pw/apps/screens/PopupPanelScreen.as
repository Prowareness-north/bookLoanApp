package nl.pw.apps.screens 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import feathers.layout.VerticalLayout;
	import starling.events.Event;
	import feathers.core.PopUpManager;
	/**
	 * ...
	 * @author Dave Woertman
	 */
	public class PopupPanelScreen extends PanelScreen
	{
		private var messageText:Label;
		private var closeButton:Button;
		public var closeButtonBool:Boolean = true;
		
		public function PopupPanelScreen(message:String) 
		{
			super();
			
			var layout:VerticalLayout = new VerticalLayout();	
			layout.gap = 10;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			
			this.layout = layout;
			//add a message
			this.messageText = new Label();
			this.messageText.text = message;
			this.addChild(messageText);
			
			if (closeButtonBool) {
				this.closeButton = new Button();
				this.closeButton.label = "OK, close";
				this.closeButton.addEventListener(Event.TRIGGERED, closeHandler);
				this.addChild(closeButton);
			}
		}
		
		private function closeHandler(e:Event):void 
		{
			PopUpManager.removePopUp(this);
		}
		
	}

}