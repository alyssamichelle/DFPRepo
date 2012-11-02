package com.alyssanicoll.view{	
	
	import com.alyssanicoll.model.MyVO;
	import com.alyssanicoll.view.ProductWrapper;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	public class View2 extends Sprite{
		
		private var _VOArray:Array = [[],[]];
		private var _dailyTrackerArray:Array = [];
		private var _loader:Loader;
		private var _keyword:String;
		private var _productContainer:Sprite;
		private var _keywordContainer:Sprite;
		private var _textField:MyTextField;
		private var _yPos:uint;
		private var _glow:GlowFilter = new GlowFilter(0x2d2d2d,1,6,6,2);		
		
		public function View(){
			super();
			//used for clearing
			_productContainer = new Sprite();
			
			
			_keywordContainer = new Sprite();
			this.addChild(_productContainer);
			this.addChild(_keywordContainer);
			
			//this creates the button in the view
			createButton();
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
			var yPos:int = 100;
			for each(var item:String in _dailyTrackerArray) {
				//				trace(item);
				_textField = new MyTextField();
				_textField.text = item;
				_textField.addEventListener(MouseEvent.CLICK , onProductClick);
				_textField.y = yPos + 50;
				_productContainer.addChild(_textField);
				yPos = _textField.y;
			}
		}
		
		//Responds to _loader if an Error occurs while loading
		private function onError(event:IOErrorEvent):void {
			trace("Huston, we have a problem");
		}
		
		public function set VOArray(value:Array):void {
			_VOArray = value;
			var i:uint = 0;
			
			// This ridiculous set of if statements are checking for 0 and 1 to both have things inside them
			if(!!_VOArray[0].length && !!_VOArray[1].length) {
				
				
				// Checking to see if [0] is longer than [1]
				if(_VOArray[1].length < _VOArray[0].length) {
					
					// Doing a for loop for the amount of vo's in [0]
					// pulling URL path out of [0] and placing it in [1]
					for(i = 0; i <= (_VOArray[0].length - 1); i++) {
						
						//Make sure imageURL exists
						if(!!_VOArray[0][i].imageURL){
							_VOArray[1][i].imageURL = _VOArray[0][i].imageURL; 
							display();
						}
					}
				}
					
				else {
					
					// Doing a for loop for the amount of vo's in [1]
					// pulling URL path out of [0] and placing it in [1]
					for(i = 0; i <= (_VOArray[1].length - 1); i++) {
						_VOArray[1][i].imageURL = _VOArray[0][i].imageURL;
						display();
					}
				}
				
				//				display(); 
				//should i display this here? or inside of the for loops?
			}
		}
		
		public function get VOArray():Array {
			return _VOArray;
		}
		
		public function set keyword(value:String):void {
			_keyword = value;
		}
		
		// this function creates the product wrappers that will be stored 
		// inside of productContainer, for clearing purposes, and plugged in with VO's
		private function display():void {
			_productContainer.removeChildren();
			
			var yPos:int = 90;
			var productWrapper:ProductWrapper;
			
			for(var i:uint = 8; i < 12; i++){
				//				if(_VOArray[0][i] != undefined
				//					&& _VOArray[0][i].product != null 
				//					&& _VOArray[0][i].product != "") {
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
				//				}	
			}
		}
		
		private function onMouseOut(event:MouseEvent):void {
			event.currentTarget.filters = [];
		}
		
		private function onMouseOver(event:MouseEvent):void{
			event.currentTarget.filters = [_glow];	
		}
		
		// Responds to products being clicked on, addes those products to tracker array
		private function onProductClick(event:MouseEvent):void {
			_dailyTrackerArray.push(event.currentTarget.textF2.text);
		}
		
	}
}