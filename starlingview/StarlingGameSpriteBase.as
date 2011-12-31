package starlingview
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class StarlingGameSpriteBase extends Sprite
	{
		public function StarlingGameSpriteBase()
		{
			super();
		}
		
		public function dispatchEventType(etype:String):void{
			
			var se:Event=new Event(etype);
			
			dispatchEvent(se);
		}
	}
}