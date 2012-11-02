package com.alyssanicoll.view{
	
	import com.alyssanicoll.events.SearchEvent;
	
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	public class SearchForm extends SearchFormBase{
		
		private static const PROMPT:String = "What I Munched";
		private var _keyword:String;
		
		//setting the prompt text up and adding event listeners to the search input and button
		public function SearchForm(){
			super();
			searchInput.text = PROMPT;
			searchInput.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			searchInput.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			searchInput.addEventListener(KeyboardEvent.KEY_DOWN , onKeyDown);
			searchButton.addEventListener(MouseEvent.CLICK, onSubmitClick);
		}
		
		//Responds to key down on search input, calls validateForm()
		private function onKeyDown(event:KeyboardEvent):void{
			if(event.keyCode == Keyboard.ENTER){
				validateForm();
			}
		}
		
		//Responds to clicking on submit button, calls validateForm()
		private function onSubmitClick(event:MouseEvent):void	{
			validateForm();	
		}
		
		//Responds to onSubmitClick() and onKeyDown(), validates input before firing evt allowing search to happen
		private function validateForm():void{
			if(searchInput.text != "" && searchInput.text != PROMPT){
				var evt:SearchEvent = new SearchEvent(SearchEvent.SEARCH_SUBMIT);
				evt.keyword = searchInput.text;
				dispatchEvent(evt);
			}
		}
		
		//Responds to searchInput on focus, makes prompt dissappear magically
		private function onFocusIn(event:FocusEvent):void{
			if(searchInput.text == PROMPT){
				searchInput.text = "";	
			}
		}
		
		//Responds to searchInput on focus out, makes prompt reappear magically if field is blank
		private function onFocusOut(event:FocusEvent):void{
			if(searchInput.text == ""){
				searchInput.text = PROMPT;
			}
		}
	}
}