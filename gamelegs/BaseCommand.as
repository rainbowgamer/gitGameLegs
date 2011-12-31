package gamelegs
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import R2Event.Robert2CommandEvent;

	public class BaseCommand
	{
		public var evetype:String;
		public var evedata:*;
		public var eve:Robert2CommandEvent;
		
		public var inj_IEventDispatcher:IEventDispatcher;
		
		public var isinjected:Boolean;
		
		public function BaseCommand(e:Robert2CommandEvent=null)
		{
			if(e!=null){
				initeve(e);
			}
			
		}
		
		
		public function execute():void{
		
			
			
		}
		
		public function proccSevent():void
		{
			// TODO Auto Generated method stub
			if(eve.sEvents&&eve.sEvents.length>0){
				
				_proccSevent();
			}
		}		
		
		
		private function _proccSevent():void
		{
			// TODO Auto Generated method stub
			var eveay:Array=eve.sEvents;
			var len:int=eveay.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				var re:Robert2CommandEvent=eveay[i];
				
				GameLegs.evedisp.dispatchEvent(re);
				
				
			}
			eve.sEvents=null;
		}
		
		public function initeve(e:Robert2CommandEvent):void
		{
			// TODO Auto Generated method stub
			eve=e;
			evetype=e.type;
			evedata=e["data"];
			
			inj_IEventDispatcher=GameLegs.evedisp;
		}
		
		public function dispose():void{
		
		}
		
			
	}
}