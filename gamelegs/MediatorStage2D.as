package gamelegs
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	import R2Event.Robert2CommandEvent;
	

	public class MediatorStage2D 
	{
		
		
		protected var evedisp:EventDispatcher;
		
		
		
		protected var _viewbase:EventDispatcher;
		
		public function MediatorStage2D()
		{
			
			evedisp=GameLegs.evedisp;
		}
		
		public function initialize():void{
			var sp:EventDispatcher=_viewbase;
			sp.addEventListener(Event.REMOVED_FROM_STAGE,onReStage)
			sp.addEventListener(Event.REMOVED,onRemove)
		
				
			initContextEvent();
			
			initViewEvent();
		}
		
		public function initContextEvent():void{
		
		
		}
		
		public function initViewEvent():void{
			
			
		}
		
		
		
		protected function addContextListener(EventType:String, EventCallFun:Function):void
		{
			// TODO Auto Generated method stub
//			EventType=EventType.toUpperCase();
			GameLegs.addEventFunction(EventType,EventCallFun);
		}
		
		
		protected function addViewListener(EventType:String, EventCallFunction:Function):void
		{
			// TODO Auto Generated method stub
			_viewbase.addEventListener(EventType,EventCallFunction);
		}
		
		public function destroy():void
		{
			
		}
		
		public function postDestroy():void
		{
			
		}
		
		protected function removeViewListener(EventType:String, EventCallFun:Function):void
		{
			// TODO Auto Generated method stub
			
		}
		
		
		protected function dispatch(se:Robert2CommandEvent):void
		{
			// TODO Auto Generated method stub
			GameLegs.evedisp.dispatchEvent(se);
		}

		public function get viewbase():EventDispatcher
		{
			return _viewbase;
		}

		public function set viewbase(value:EventDispatcher):void
		{
			_viewbase = value;
			
			this["inj_view"]=_viewbase;
			
			initialize();
			
			regViewEvent();
			
		}
		
		private function regViewEvent():void
		{
			// TODO Auto Generated method stub
			var sp:EventDispatcher=_viewbase;
			
			sp.addEventListener(Event.ADDED_TO_STAGE,onStage);
			sp.addEventListener(Event.ADDED,onAdded)
			
		}		
		
		protected function onRemove(event:Event):void
		{
			// TODO Auto-generated method stub
			event.stopPropagation();
			trace(_viewbase["name"],"onRemove child:",event.target.name)
		}
		
		protected function onReStage(event:Event):void
		{
			// TODO Auto-generated method stub
//			trace(_viewbase.name,"onReStage")
			remViewEvent()
		}
		
		protected function onAdded(event:Event):void
		{
			// TODO Auto-generated method stub
//			trace("onAdded 									start:",getTimer())
			event.stopPropagation();
			
			var addedChild:DisplayObject=event.target as DisplayObject;
			
//			trace("Mediator addchild:",addedChild,addedChild.name);
			
			GameLegs.getMediator(addedChild);
//			trace("onAdded 									stop:",getTimer())
			
		}
		
		protected function onStage(event:Event):void
		{
			// TODO Auto-generated method stub
			
			
			
		}
		
		private function remViewEvent():void{
			var sp:EventDispatcher=_viewbase;
			
			sp.removeEventListener(Event.ADDED_TO_STAGE,onStage);
			sp.removeEventListener(Event.ADDED,onAdded)
			sp.removeEventListener(Event.REMOVED_FROM_STAGE,onReStage)
			sp.removeEventListener(Event.REMOVED,onRemove)
		
		}
		
		

	}
}