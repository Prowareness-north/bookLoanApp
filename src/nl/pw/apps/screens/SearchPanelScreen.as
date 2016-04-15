package nl.pw.apps.screens{

	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.data.HierarchicalCollection;
	import feathers.events.FeathersEventType;
	import nl.pw.apps.data.BookVO;
	import nl.pw.apps.data.ModelInstance;
	import nl.pw.apps.data.SearchSettings;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.system.DeviceCapabilities;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;

	[Event(name = "complete", type = "starling.events.Event")]
	[Event(name = "showSettings", type = "starling.events.Event")]
	[Event(name = "showBookDetails", type = "starling.events.Event")]
	

	public class SearchPanelScreen extends PanelScreen
	{
		public static const SHOW_SETTINGS:String = "showSettings";
		public static const SHOW_BOOK_DETAILS:String = "showBookDetails";

		public function SearchPanelScreen()
		{
			super();
		}

		public var settings:SearchSettings;
		private var _model:ModelInstance;
		private var bookVO:BookVO;
		private var _list:GroupedList;

		override protected function initialize():void
		{
			//never forget to call super.initialize()
			super.initialize();

			this.title = "Books within Prowareness";
			this.bookVO = new BookVO();
			this._model = ModelInstance.getInstance();
			this.layout = new AnchorLayout();

			
			
			this._list = new GroupedList();
			if(this.settings.style == SearchSettings.STYLE_INSET)
			{
				this._list.styleNameList.add(GroupedList.ALTERNATE_STYLE_NAME_INSET_GROUPED_LIST);
			}
			this._list.dataProvider = new HierarchicalCollection(this._model.searchBooks);
			this._list.typicalItem = bookVO;
			this._list.isSelectable = this.settings.isSelectable;
			this._list.hasElasticEdges = this.settings.hasElasticEdges;
			this._list.clipContent = false;
			this._list.autoHideBackground = true;
			this._list.itemRendererFactory = function():IGroupedListItemRenderer
			{
				var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();

				//enable the quick hit area to optimize hit tests when an item
				//is only selectable and doesn't have interactive children.
				renderer.isQuickHitAreaEnabled = true;

				renderer.labelField = "title";
				renderer.accessoryField = "subtitle";
				renderer.iconSourceField = "imageS_URL";
				
				return renderer;
			};
			this._list.addEventListener(Event.CHANGE, list_changeHandler);
			this._list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this.addChildAt(this._list, 0);

			this.headerFactory = this.customHeaderFactory;

			//this screen doesn't use a back button on tablets because the main
			//app's uses a split layout
			if(!DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				this.backButtonHandler = this.onBackButton;
			}

			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInCompleteHandler);
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
			var settingsButton:Button = new Button();
			settingsButton.label = "Settings";
			settingsButton.addEventListener(Event.TRIGGERED, settingsButton_triggeredHandler);
			header.rightItems = new <DisplayObject>
			[
				settingsButton
			];
			return header;
		}
		
		private function onBackButton():void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}

		private function transitionInCompleteHandler(event:Event):void
		{
			this._list.revealScrollBars();
		}
		
		private function backButton_triggeredHandler(event:Event):void
		{
			this.onBackButton();
		}

		private function settingsButton_triggeredHandler(event:Event):void
		{
			this.dispatchEventWith(SHOW_SETTINGS);
		}

		private function list_changeHandler(event:Event):void
		{
			trace("GroupedList change:", this._list.selectedGroupIndex, this._list.selectedItemIndex);
			//this._model.selectedBook = BookVO(this._list.selectedItem);
			this.dispatchEventWith(SHOW_BOOK_DETAILS);
		}
	}
}