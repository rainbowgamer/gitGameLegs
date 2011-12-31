package R2Command
{
	import R2Event.Robert2CommandEvent;
	
	import flash.events.Event;
	
	import gamelegs.BaseCommand;
	
	public class Robert2Command extends BaseCommand
	{
		
		public function Robert2Command(e:Robert2CommandEvent)
		{
			super(e);
			
		
		}
		
		
		public function proccSEvent():void{
		
		
		}
		
		public function dispatchCommandEvent(e:Robert2CommandEvent):void{
		
			inj_IEventDispatcher.dispatchEvent(e);
		}
		
		
	}
}