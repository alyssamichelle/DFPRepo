package {
	
	import com.alyssanicoll.events.SearchEvent;
	import com.alyssanicoll.model.ESHAModel;
	import com.alyssanicoll.model.MyVO;
	import com.alyssanicoll.model.SuperMarketModel;
	import com.alyssanicoll.view.View;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	public class MainController extends Sprite {
		
		private var _eshaProduct:String;
		private var _superProduct:String;
		private var _view:View;
		private var _eshaModel:ESHAModel;
		private var _superMarketModel:SuperMarketModel;
		private var _keyword:String;
		
		public function MainController() {
			//instatiates view
			
			_view = new View(this.stage);
			_view.addEventListener(SearchEvent.SEARCH_SUBMIT , onSubmit);
			addChild(_view);
			
			//no scaling for the stage, and positioned in the top left
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			//editing the menu that pops up on right click with this function
			editRightClick();
		}
		
		//being called in the constructor
		private function editRightClick():void {
			var cm:ContextMenu = new ContextMenu();
			cm.hideBuiltInItems();
			var mItem:ContextMenuItem = new ContextMenuItem("Copyright @2012 Alyssa Nicoll" , true);
			mItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, copyrightCLICK);
			cm.customItems.push(mItem);
			this.contextMenu = cm;
		}
		
		//being called in editRightClick function, it links up my site to the copyright
		private function copyrightCLICK(event:ContextMenuEvent):void {
			var uRequest:URLRequest =  new URLRequest("http://www.alyssanicoll.com");
			navigateToURL(uRequest, "_blank");
		}
		
		//when a search is submitted, keyword is given to both models and events are fired
		private function onSubmit(event:SearchEvent):void {
			_view.keyword = event.keyword;
			
			//Load data from ESHA
			_eshaModel = new ESHAModel();
			_eshaModel.doSearch(event.keyword);
			_eshaModel.addEventListener(Event.COMPLETE , onJSONComplete);
			
			//Load data from SuperMarket API
			_superMarketModel = new SuperMarketModel();
			_superMarketModel.doSearch(event.keyword);
			_superMarketModel.addEventListener(Event.COMPLETE, onXMLComplete);
		}
		
		// Responds to SuperMarketModel Complete Event
		private function onXMLComplete(event:Event):void {
			var tmp:Array = _view.VOArray;
			tmp[0] = _superMarketModel.voArray;
			_view.VOArray = tmp;
		}
		
		//Responds to ESHA Complete Event
		private function onJSONComplete(event:Event):void {
			var tmp:Array = _view.VOArray;
			tmp[1] = _eshaModel.voArray;
			_view.VOArray = tmp;
		}
	}
}