package gamelegs
{
	import flash.events.EventDispatcher;
	import flash.utils.setTimeout;

	public class Context extends EventDispatcher
	{
		public var logLevel:uint;
		
		
		public function Context()
		{
		}
		
		public function afterInitializing(callbackfun:Function):void{
		
			setTimeout(callbackfun,50);
		}
		
		public function install(module:*):Context{
		
			return this;
		}
		
		public var contextview:ContextView;
		
		
		public function configure(config:*):Context{
		
			if(config is Class){
				var initClass:Object=new config();
				
				if(initClass is GameLegsConfig){
//					(init as GameLegsConfig).
					map_Command=initClass["map_Command"]
						
				}
				
			}
			
			if(config is ContextView){
				contextview=config as ContextView;
				
			}
			
			return this;
		}
		
		public var map_Command:Function;
		
		public var map_Mediator:Function;
		
		
	}
}