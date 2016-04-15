package nl.pw.apps.screens 
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.PickerList;
	import feathers.controls.ToggleSwitch;
	import feathers.data.ListCollection;
	import nl.pw.apps.data.SearchSettings;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.DisplayObject;
	import starling.events.Event;

	[Event(name="complete",type="starling.events.Event")]

	public class SearchSettingsScreen extends PanelScreen
	{
		public function SearchSettingsScreen()
		{
			super();
		}

		public var settings:SearchSettings;

		private var _list:List;

		private var _stylePicker:PickerList;
		private var _isSelectableToggle:ToggleSwitch;
		private var _hasElasticEdgesToggle:ToggleSwitch;

		override public function dispose():void
		{
			//icon and accessory display objects in the list's data provider
			//won't be automatically disposed because feathers cannot know if
			//they need to be used again elsewhere or not. we need to dispose
			//them manually.
			this._list.dataProvider.dispose(disposeItemAccessory);

			//never forget to call super.dispose() because you don't want to
			//create a memory leak!
			super.dispose();
		}

		override protected function initialize():void
		{
			//never forget to call super.initialize()
			super.initialize();

			this.title = "Search Settings";

			this.layout = new AnchorLayout();

			this._stylePicker = new PickerList();
			this._stylePicker.dataProvider = new ListCollection(new <String>
			[
				SearchSettings.STYLE_NORMAL,
				SearchSettings.STYLE_INSET
			]);
			this._stylePicker.typicalItem = SearchSettings.STYLE_NORMAL;
			this._stylePicker.listProperties.typicalItem = SearchSettings.STYLE_NORMAL;
			this._stylePicker.selectedItem = this.settings.style;
			this._stylePicker.addEventListener(Event.CHANGE, stylePicker_changeHandler);

			this._isSelectableToggle = new ToggleSwitch();
			this._isSelectableToggle.isSelected = this.settings.isSelectable;
			this._isSelectableToggle.addEventListener(Event.CHANGE, isSelectableToggle_changeHandler);

			this._hasElasticEdgesToggle = new ToggleSwitch();
			this._hasElasticEdgesToggle.isSelected = this.settings.hasElasticEdges;
			this._hasElasticEdgesToggle.addEventListener(Event.CHANGE, hasElasticEdgesToggle_changeHandler);

			this._list = new List();
			this._list.isSelectable = false;
			this._list.dataProvider = new ListCollection(
			[
				{ label: "Group Style", accessory: this._stylePicker },
				{ label: "isSelectable", accessory: this._isSelectableToggle },
				{ label: "hasElasticEdges", accessory: this._hasElasticEdgesToggle },
			]);
			this._list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this._list.clipContent = false;
			this._list.autoHideBackground = true;
			this.addChild(this._list);

			this.headerFactory = this.customHeaderFactory;

			this.backButtonHandler = this.onBackButton;
		}

		private function customHeaderFactory():Header
		{
			var header:Header = new Header();
			var doneButton:Button = new Button();
			doneButton.label = "Done";
			doneButton.addEventListener(Event.TRIGGERED, doneButton_triggeredHandler);
			header.rightItems = new <DisplayObject>
			[
				doneButton
			];
			return header;
		}

		private function disposeItemAccessory(item:Object):void
		{
			DisplayObject(item.accessory).dispose();
		}

		private function onBackButton():void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}

		private function doneButton_triggeredHandler(event:Event):void
		{
			this.onBackButton();
		}

		private function stylePicker_changeHandler(event:Event):void
		{
			this.settings.style = this._stylePicker.selectedItem as String;
		}

		private function isSelectableToggle_changeHandler(event:Event):void
		{
			this.settings.isSelectable = this._isSelectableToggle.isSelected;
		}

		private function hasElasticEdgesToggle_changeHandler(event:Event):void
		{
			this.settings.hasElasticEdges = this._hasElasticEdgesToggle.isSelected;
		}
	}
}
