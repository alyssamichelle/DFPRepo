package com.alyssanicoll.view {
	
	import com.alyssanicoll.model.MyVO;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class ProductWrapper extends ProductWrapperBase {
		
		private var _keyword:String;
		private var _vo:MyVO;
		private var _imageLoader:Loader;
	
		public function ProductWrapper() {
			super();
//			this.x = 200;
		}
		
		// Sets VO from display() in View
		public function set vo(value:MyVO):void { 
			_vo = value;
			textF2.text = _vo.product + " : " + _vo.description;
			_imageLoader = new Loader();
			
			// If _vo.imageURL exists with something in it other than an empty string then
			if(_vo.imageURL != null && _vo.imageURL != "") {
				
				// Load the image and add a complete event listener
				_imageLoader.load(new URLRequest(_vo.imageURL));
				_imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoad);
				_imageLoader.scaleX = _imageLoader.scaleY = .75;
			}
		}
		
		// Responds to _imageLoader event complete
		private function onImageLoad(event:Event):void {
			this.imageHolder.addChild(_imageLoader);	
		}
		
		// Sets the keyword for our product wrapper and puts it in a text field
		public function set keyword(value:String):void {
			_keyword = value;
			textF1.text = _keyword;
		}

	}
}