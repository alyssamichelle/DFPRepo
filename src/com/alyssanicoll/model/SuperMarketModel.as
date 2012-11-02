package com.alyssanicoll.model {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class SuperMarketModel extends EventDispatcher {
		
		public static const APIKEY:String = "43c75406f7";
		private var _xmlLoader:URLLoader;
		private var _myData:XML = new XML();
		private var _voArray:Array = [];
		
		public function SuperMarketModel(target:IEventDispatcher=null) {
			super(target);
		}

		// Loads the xml
		public function doSearch(keyword:String):void {
			_xmlLoader = new URLLoader();
			var url:String = "http://www.SupermarketAPI.com/api.asmx/SearchByProductName?APIKEY=" + APIKEY + "&ItemName=" + keyword;
			_xmlLoader.addEventListener(Event.COMPLETE, onLoad);
			_xmlLoader.load(new URLRequest(url));
		}
		
		// Responds to _xmlLoader, when the xml is loaded this parses it into VO's and places them into arrays
		private function onLoad(event:Event):void {
			var n:Namespace = new Namespace("http://www.SupermarketAPI.com");
			_myData = XML(event.currentTarget.data);
			
			for each(var xmlData:XML in _myData.n::Product) {
				var superVO:MyVO = new MyVO();
				superVO.product = xmlData.n::Itemname;
				superVO.imageURL = xmlData.n::ItemImage;
				_voArray.push(superVO);
			}
			
			// Fires an event to let the controller know our XML has 
			// finished parsing and _voArray is ready to use
			var event:Event = new Event(Event.COMPLETE);
			dispatchEvent(event);
		}
		
		// Allows the controller to access the _voArray
		public function get voArray():Array {
			return _voArray;
		}
	}
}