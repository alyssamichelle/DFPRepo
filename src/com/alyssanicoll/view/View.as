package com.alyssanicoll.view
{
	import com.alyssanicoll.events.ScrollBarEvent;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	public class View extends Sprite
	{
		private var _VOArray:Array = [[],[]];
		private var _dailyTrackerArray:Array = [];
		private var _loader:Loader;
		private var _keyword:String;
		private var _productContainer:ScrollBox;
		private var _trackerContainer:Sprite;
		private var _textField:MyTextField;
		private var _yPos:uint;
		private var _glow:GlowFilter = new GlowFilter(0x2d2d2d,1,6,6,2);
		private var _filterOn:Boolean;
		private var _scroller:ScrollBar;
		private var _hint:HelpHint;
		
		public function View(stage:Stage){
			super();
			//used for clearing
			_scroller = new ScrollBar(stage);
			_productContainer = new ScrollBox();
			_trackerContainer = new Sprite();
			this.addChild(_productContainer);
			this.addChild(_trackerContainer);
			_productContainer.y=100;
			_productContainer.x=200;
			_scroller.y = 100;
			_scroller.x = 1110;
			_scroller.height = 518;
			_scroller.addEventListener(ScrollBarEvent.VALUE_CHANGED, onScroll);
			//this creates the button in the view
			createButton();
			
			_hint =  new HelpHint();
			_hint.x = 110;
			_hint.y = 300;
			_hint.scaleX = _hint.scaleY = .5;
		}
		
		private function onScroll(event:ScrollBarEvent):void {
			_productContainer.prc = event.scrollPercent;
		}
		
		// Creates button and gives it functionality
		private function createButton():void {
			var bar:NavBar = new NavBar();
			addChild(bar);
			
			var searchForm:SearchForm = new SearchForm();
			searchForm.x = 1000;
			searchForm.y = (bar.height - searchForm.height)/2;
			addChild(searchForm);
			
			var myButton:TrackerButton = new TrackerButton();
			myButton.mouseChildren = false;
			myButton.buttonMode = true;
			myButton.x = searchForm.x + (searchForm.width - myButton.width);;
			myButton.y = 630;
			addChild(myButton);
			myButton.addEventListener(MouseEvent.CLICK, onTrackerClick);
		}
		
		private function onTrackerClick(event:MouseEvent):void {
			// Clearing off stage for tracker list
			_productContainer.removeChildren();
			
			this.removeChild(_scroller);
			this.addChild(_hint);
			this._hint.hintText.text = "This is where items you have eaten are kept, inside your daily tracker.";
			var yPos:int = 100;
			for each(var item:String in _dailyTrackerArray) {
				_textField = new MyTextField();
				_textField.text = item;
				_textField.y = yPos + 50;
				_trackerContainer.addChild(_textField);
				yPos = _textField.y;
			}
		}
		
		//Responds to _loader if an Error occurs while loading
		private function onError(event:IOErrorEvent):void {
			trace("Huston, we have a problem");
		}
		
		public function get VOArray():Array {
			return _VOArray;
		}
		
		public function set VOArray(value:Array):void {
			_VOArray = value;
			
			// If VOArray 0 and 1 have stuff in them then go to the next line
			if (_VOArray[0].length && _VOArray[1].length) {
				// For each var i ++ until i is the length of the 1st array
				for (var i:uint = 0; i < _VOArray[0].length; i++) {
					// If VOArray 1i (i being the number that is looping = to the vo in that spot)
					// and VOArray 2i.imageURL exist then go to the next line
					if (_VOArray[1][i] && _VOArray[0][i].imageURL) {
						_VOArray[1][i].imageURL = _VOArray[0][i].imageURL;
						//If VOArray1i.product is equal to an empty string then...
						if (_VOArray[1][i].product == "" || _VOArray[1][i].product == null) {
							//make VOArray1i.product equal _VOArray0i.product
							_VOArray[1][i].product = _VOArray[0][i].product;
						}
					}
				}
				// Run the display function
				display();
			}
		}
		
		public function set keyword(value:String):void {
			_keyword = value;
		}
		
		// this function creates the product wrappers that will be stored 
		// inside of productContainer, for clearing purposes, and plugged in with VO's
		private function display():void {
			_productContainer.removeChildren();
			_trackerContainer.removeChildren();
			addChild(_scroller);
			addChild(_hint);
			_hint.hintText.text = "Click on any Product to add it to your daily tracker!";
			
			var yPos:int = 0;
			var productWrapper:ProductWrapper;
			
			// This is the meat and potatoes of my Application
			// This creates the wrappers and fills it in with info from my Vo's
			for(var i:uint = 0; i < _VOArray[1].length-1; i++) {
				productWrapper = new ProductWrapper();
				productWrapper.keyword = _keyword;
				productWrapper.vo = _VOArray[1][i];
				productWrapper.addEventListener(MouseEvent.CLICK , onProductClick);
				productWrapper.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				productWrapper.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				productWrapper.mouseChildren = false;
				productWrapper.buttonMode = true;
				_productContainer.addChild(productWrapper);
				productWrapper.y = yPos;
				yPos +=  134;
			}
		}
		
		// Takes away Glow on Mouse Out
		private function onMouseOut(event:MouseEvent):void {
			event.currentTarget.filters = [];
		}
		
		// Applies Glow to product on Hover
		private function onMouseOver(event:MouseEvent):void {
			event.currentTarget.filters = [_glow];	
		}
		
		// Responds to products being clicked on, addes those products to tracker array
		private function onProductClick(event:MouseEvent):void {
			if(this.contains(_hint)) {
				this.removeChild(_hint);
			}
			_dailyTrackerArray.push(event.currentTarget.textF2.text);
			event.currentTarget.filters = [_glow];	
			event.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
//			event.currentTarget.filterOn = true;
//			if(event.currentTarget.filterOn){
//				event.currentTarget.filters = [];	
//			}
		}
	}
}