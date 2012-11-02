package com.alyssanicoll.view{
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class MyTextField extends TextField{
		
		private var _myFormat:TextFormat;
		
		//this is setting the styles for my textFields
		public function MyTextField(){
			super();
			
			this.x = 500;
			this.y = 300;
			this.width = 600;
			this.height = 26;
			this.textColor = 0x2d2d2d;
			this.wordWrap = true;
			
			_myFormat = new TextFormat;
			_myFormat.font = "Helvetica";
			_myFormat.size = 20;
			
			this.defaultTextFormat = _myFormat;
		}
	}
}