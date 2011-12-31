package gamelegs
{
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	
	import lzm.starling.swf.display.SwfSprite;
	
	import modules.Model_GameData;
	import modules.manager.View_GameViewManager;
	
	import services.Service_GameControler;
	import services.Service_Sounds;

	public class GameLegsConfig
	{
		protected var dispatcher:EventDispatcher;
		
		protected var context:Context;
		
		public function GameLegsConfig()
		{
			context=GameLegs.context;
			dispatcher=GameLegs.evedisp;
			
			configure();
		}
		 
		public function configure():void
		{
			 
			 
		}
		
		
		protected var sameviewobj:Object
		
		protected function addSameViewid(viewid:String,sameviewid:String):void{
			
			sameviewobj[viewid]=sameviewid;
		}
		
		
		
		protected function initSWFUIChild(childviewids:Array):void{
			
			for (var i:int = 0; i < childviewids.length; i++) 
			{
				
				var childviewidobj:Array=childviewids[i];
				
				if(childviewids==null)continue;
				
				var viewid:String=childviewidobj.join(".");
				var mapviewid:String;
				var medclass:Class=null;
				var injectclass:Class=null;
				
				if(sameviewobj.hasOwnProperty(viewid)){
					
					mapviewid=sameviewobj[viewid];
					
					medclass=getAutoMediatorClassByViewid([mapviewid]);
					injectclass=getAutoInjectClassByViewid([mapviewid]);
					
				}
				else{
					
					medclass=getAutoMediatorClassByViewid(childviewidobj);
					
					injectclass=getAutoInjectClassByViewid(childviewidobj);
					
				}
				
				
				
				if(medclass&&injectclass){
					
					map_Mediator(injectclass,medclass,viewid);
				}
				else{
					trace("viewid 注册失败:",mapviewid)
				}
				
			}
			
			
			
			
		}
		
		/**
		 *通过viewid自动找到注入的类 
		 * @param childviewid
		 * @return 
		 * 
		 */		
		protected function getAutoInjectClassByViewid(childviewid:Array):Class
		{
			// TODO Auto Generated method stub
			
			
			return SwfSprite;
		}
		/**
		 *通过viewid名自动找mediator 
		 * @param childviewid
		 * @return 
		 * 
		 */		
		protected function getAutoMediatorClassByViewid(childviewid:Array):Class
		{
			// TODO Auto Generated method stub
			
			
			var medclass:Class
			
			var classname:String
			if(childviewid.length>=2){
				classname=["SWF",childviewid.shift(),"LIB",childviewid.shift(),childviewid.join("")].join("_");;
			}
			else{
				classname=["mc",childviewid].join("_");;
				
			}
			
			classname="mediators.starling.comps.Med_"+classname;
			
			try
			{
				medclass=getDefinitionByName(classname) as Class;
				
			} 
			catch(error:Error) 
			{
				throw new Error("需要Mediator类:"+classname);
			}
			
			
			
			
			return medclass;
		}		
		
		
		
		
		
		protected function doInject():void
		{
			// TODO Auto Generated method stub
			map_AliansInject("ContextView",context.contextview);
			map_AliansInject("IEventDispatcher",context);
			map_AliansInject("Context",context);
			
			
		}		
		
		
		
		
		
		/**
		 *注册事件到命令 
		 * @param EventType
		 * @param Command
		 * @return 
		 * 
		 */		
		public function map_Command(EventType:String,CommandClass:Class):void{
			
			
			GameLegs.addCommand(EventType,CommandClass);
		}
		
		/**
		 *注册视图代理 
		 * @param displayClass
		 * @param mediatorClass
		 * 
		 */		
		public function map_Mediator(displayClass:Class,mediatorClass:Class,aliasname:String=null):void{
			GameLegs.addMediator(displayClass,mediatorClass,aliasname);
		}
		
		/**
		 *注册别外的对像 
		 * @param injectname
		 * @param singClassobj
		 * 
		 */		
		public function map_AliansInject(injectname:String,singClassobj:Object):void{
			GameLegs.addinjectAlians(injectname,singClassobj);
		}
		
		/**
		 *注册单例,如果传空自动生成 
		 * @param param0
		 * @param param1
		 * 
		 */		
		protected function map_Inject(injectClass:Class, singClassObj:Object):void
		{
			// TODO Auto Generated method stub
			if(singClassObj==null){
				GameLegs.addinject(injectClass,new injectClass());
			}
			else{
				GameLegs.addinject(injectClass,singClassObj);
			}
			
			
		}
		
	}
}