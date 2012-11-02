package com.alyssanicoll.model {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class ESHAModel extends EventDispatcher {
		public static const APIKEY:String = "5z7jqqmgktmuew3vnthe3aaf";
		private var _jsonLoader:URLLoader;
		private var _myData:Object;
		private var _voArray:Array;
		
		public function ESHAModel(target:IEventDispatcher=null) {
			super(target);
		}
		
		// Loading the JSON from the API
		public function doSearch(keyword:String, pageNum:uint = 1):void {
			_jsonLoader = new URLLoader();
			var url:String = "http://api.esha.com/foods?apikey=" + APIKEY + "&query=" + keyword 
			+ "&extras=url_l,url_s&per_page=10&page=" + pageNum + "&format=rest";
			_jsonLoader.addEventListener(Event.COMPLETE, onLoad);
			_jsonLoader.load(new URLRequest(url));
		}
		
		// Responds to _jsonLoader, parses the JSON into VO when fully loaded and then places them in an array
		private function onLoad(event:Event):void {
			_myData = JSON.parse(_jsonLoader.data);
			_voArray = [];
			
			for each(var item:Object in _myData.items) {
				var eshaVO:MyVO = new MyVO();
				eshaVO.product = item.product;
				eshaVO.description = item.description;
				_voArray.push(eshaVO);
			}
			var event:Event = new Event(Event.COMPLETE);
			dispatchEvent(event);
		}
		
		// This allows the controller to access the _voArray
		public function get voArray():Array {
			return _voArray;
		}
	}
}