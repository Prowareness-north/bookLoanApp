package nl.pw.apps
{
	import com.myflashlab.air.extensions.barcode.Barcode;
	import com.myflashlab.air.extensions.barcode.BarcodeEvent;
	import feathers.controls.Alert;
	import feathers.controls.Drawers;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.motion.Cover;
	import feathers.motion.Reveal;
	import feathers.motion.Slide;
	import feathers.system.DeviceCapabilities;
	import feathers.themes.TopcoatLightMobileTheme;
	import nl.pw.apps.barcode.BarcodeInstance;
	import nl.pw.apps.data.SearchSettings;
	import nl.pw.apps.data.BooksService;
	import nl.pw.apps.data.EmbeddedAssets;
	import nl.pw.apps.screens.MainMenuScreen;
	import nl.pw.apps.screens.NewBookScreen;
	import nl.pw.apps.screens.BarcodeReaderScreen;
	import nl.pw.apps.screens.SearchPanelScreen;
	import nl.pw.apps.screens.SearchOwnPanelScreen;
	import nl.pw.apps.screens.BookDetailScreen;
	import nl.pw.apps.screens.WebViewScreen;
	import nl.pw.apps.screens.SearchSettingsScreen;
	

	import flash.system.Capabilities;

	import starling.core.Starling;
	import starling.events.Event;

	public class Game extends Drawers
	{
		private static const MAIN_MENU:String = "mainMenu";
		private static const NEW_BOOK:String = "newBook";
		private static const SEARCH_BOOKS:String = "searchBooks";
		private static const SEARCH_OWN_BOOKS:String = "searchOwnBooks";
		private static const BOOK_DETAILS:String = "bookDetails";
		private static const BARCODE_READER:String = "barcodeReader";
		private static const SEARCH_BOOKS_SETTINGS:String = "searchBooksSettings";
		private static const WEB_VIEW:String = "webView";

		private static const MAIN_MENU_EVENTS:Object =
		{
			showNewBook: NEW_BOOK,
			showSearchBooks: SEARCH_BOOKS,
			showSearchOwnBooks: SEARCH_OWN_BOOKS,
			showSearchBooksSettings: SEARCH_BOOKS_SETTINGS,
			showBookDetails: BOOK_DETAILS,
			showBarcodeReader: BARCODE_READER,
			showWebView: WEB_VIEW
		};
		
		public function Game()
		{
			super();
			//set up the theme right away!
			new TopcoatLightMobileTheme();
			
		}

		private var _navigator:StackScreenNavigator;
		private var _menu:MainMenuScreen;
		private var _service:BooksService = new BooksService();
		public var barcode:BarcodeInstance = BarcodeInstance.getInstance();
		
		
		override protected function initialize():void
		{
			//never forget to call super.initialize()
			super.initialize();

			EmbeddedAssets.initialize();

			this._navigator = new StackScreenNavigator();
			this.content = this._navigator;
			
			
			//First set up the books that will be displayed on the search books screen
			_service.getAllBooks();
			trace("get all books");
			
			var newBookItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(NewBookScreen);
			newBookItem.setScreenIDForPushEvent(NewBookScreen.SHOW_BARCODE_READER, BARCODE_READER);
			newBookItem.setScreenIDForPushEvent(NewBookScreen.SHOW_BOOK_DETAILS, BOOK_DETAILS);
			newBookItem.addPopEvent(Event.COMPLETE);
			this._navigator.addScreen(NEW_BOOK, newBookItem);
			trace("new book screen added");
			
			
			var searchSettings:SearchSettings = new SearchSettings();
			var searchBooksItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(SearchPanelScreen);
			searchBooksItem.setScreenIDForPushEvent(SearchPanelScreen.SHOW_SETTINGS, SEARCH_BOOKS_SETTINGS);
			searchBooksItem.setScreenIDForPushEvent(SearchPanelScreen.SHOW_BOOK_DETAILS, BOOK_DETAILS);
			searchBooksItem.addPopEvent(Event.COMPLETE);
			searchBooksItem.properties.settings = searchSettings;
			this._navigator.addScreen(SEARCH_BOOKS, searchBooksItem);
			trace("book search screen added");
			
			var searchOwnBooksItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(SearchOwnPanelScreen);
			searchOwnBooksItem.setScreenIDForPushEvent(SearchOwnPanelScreen.SHOW_SETTINGS, SEARCH_BOOKS_SETTINGS);
			searchOwnBooksItem.setScreenIDForPushEvent(SearchOwnPanelScreen.SHOW_BOOK_DETAILS, BOOK_DETAILS);
			searchOwnBooksItem.addPopEvent(Event.COMPLETE);
			searchOwnBooksItem.properties.settings = searchSettings;
			this._navigator.addScreen(SEARCH_OWN_BOOKS, searchOwnBooksItem);
			trace("Own book search screen added");
			
			var bookDetailItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(BookDetailScreen);
			bookDetailItem.addPopEvent(Event.COMPLETE);
			//custom push and pop transitions for this settings screen
			bookDetailItem.pushTransition = Cover.createCoverUpTransition();
			bookDetailItem.popTransition = Reveal.createRevealDownTransition();
			this._navigator.addScreen(BOOK_DETAILS, bookDetailItem);
			trace("bookDetails screen added");
			
			var bookBarcodeItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(BarcodeReaderScreen);
			bookBarcodeItem.addPopEvent(Event.COMPLETE);
			//custom push and pop transitions for this settings screen
			bookBarcodeItem.pushTransition = Cover.createCoverUpTransition();
			bookBarcodeItem.popTransition = Reveal.createRevealDownTransition();
			bookBarcodeItem.properties.barcode = this.barcode;
			this._navigator.addScreen(BARCODE_READER, bookBarcodeItem);
			trace("BarcodeReader screen added");
			
			var searchBooksSettingsItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(SearchSettingsScreen);
			searchBooksSettingsItem.addPopEvent(Event.COMPLETE);
			searchBooksSettingsItem.properties.settings = searchSettings;
			//custom push and pop transitions for this settings screen
			searchBooksSettingsItem.pushTransition = Cover.createCoverUpTransition();
			searchBooksSettingsItem.popTransition = Reveal.createRevealDownTransition();
			this._navigator.addScreen(SEARCH_BOOKS_SETTINGS, searchBooksSettingsItem);
			trace("search setting Screen added");

			if(Capabilities.playerType == "Desktop") //this means AIR, even for mobile
			{
				var webViewItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(WebViewScreen);
				webViewItem.addPopEvent(Event.COMPLETE);
				this._navigator.addScreen(WEB_VIEW, webViewItem);
			}

			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				//we don't want the screens bleeding outside the navigator's
				//bounds on top of a drawer when a transition is active, so
				//enable clipping.
				this._navigator.clipContent = true;
				this._menu = new MainMenuScreen();
				for(var eventType:String in MAIN_MENU_EVENTS)
				{
					this._menu.addEventListener(eventType, mainMenuEventHandler);
				}
				this._menu.height = 200;
				this.leftDrawer = this._menu;
				this.leftDrawerDockMode = Drawers.DOCK_MODE_BOTH;
			}
			else
			{
				var mainMenuItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(MainMenuScreen);
				for(eventType in MAIN_MENU_EVENTS)
				{
					mainMenuItem.setScreenIDForPushEvent(eventType, MAIN_MENU_EVENTS[eventType] as String);
				}
				this._navigator.addScreen(MAIN_MENU, mainMenuItem);
				this._navigator.rootScreenID = MAIN_MENU;
			}

			this._navigator.pushTransition = Slide.createSlideLeftTransition();
			this._navigator.popTransition = Slide.createSlideRightTransition();
		}
		

		private function mainMenuEventHandler(event:Event):void
		{
			var screenName:String = MAIN_MENU_EVENTS[event.type] as String;
			//since this navigation is triggered by an external menu, we don't
			//want to push a new screen onto the stack. we want to start fresh.
			this._navigator.rootScreenID = screenName;
		}
	}
}