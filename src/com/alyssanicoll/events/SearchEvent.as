package com.alyssanicoll.events
{
	import flash.events.Event;
	
	public class SearchEvent extends Event
	{
		public static const SEARCH_SUBMIT:String = "searchSubmit";
		
		public var keyword:String;
		public var pageNum:uint;
		
		public function SearchEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}