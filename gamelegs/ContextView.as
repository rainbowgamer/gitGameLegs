package gamelegs
{ 
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;

	public class ContextView
	{
		
		/**
		 *隐藏的初始化专用层 
		 */		
		private var hideSprite:Sprite;
		
		public function ContextView(dispcont:DisplayObjectContainer)
		{
			view=dispcont;
			
			hideSprite=new Sprite();
			
			hideSprite.visible=false;
			
			view.addChild(hideSprite);
			
			view.addEventListener(Event.ADDED,onChildAdded);
		}
		
		protected function onChildAdded(event:Event):void
		{
			// TODO Auto-generated method stub
			event.stopPropagation();
			
			var addedChild:DisplayObject=event.target as DisplayObject;
			
			trace("ContextView addChild:",addedChild,addedChild.name);
			
			GameLegs.getMediator(addedChild);
			
			
		}
		
		public var view:DisplayObjectContainer;
		
		public function addHideView(backScen:DisplayObject):void
		{
			// TODO Auto Generated method stub
			hideSprite.addChild(backScen);
		}
	}
}