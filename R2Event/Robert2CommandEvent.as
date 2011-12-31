package R2Event
{
	import flash.events.Event;
	
	public class Robert2CommandEvent extends Event
	{
		public var data:*;
		public function Robert2CommandEvent(type:String, data:*=null)
		{
			super(type);
			this.data=data;
		}
		
		public var sEvents:Array;
		
		override public function clone():Event
		{
			// TODO Auto Generated method stub
			var re:Robert2CommandEvent=new Robert2CommandEvent(this.type,data);
			re.sEvents=this.sEvents;
			return re;
		}
		
		
		
		
	}
}