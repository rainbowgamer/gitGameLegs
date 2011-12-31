package gamelegs
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import Ds.HashMap;
	
	import R2Command.Robert2Command;
	
	import R2Event.Robert2CommandEvent;
	
	import gamelegs.utils.ClassUtils;
	
	

	public class GameLegs
	{
		public function GameLegs()
		{
		}
		
		public static function init():void{
		
			map_inject=new HashMap();
			map_mediator=new HashMap();
			map_command=new HashMap();
			map_function=new HashMap();
			
			mapCachedInjectobj=new HashMap();
			
			map_displaymediator=new HashMap();
			
			
			mediatorClassDict=new Dictionary();
			
			initCommandPool();
			
			eventDispFunDict={};
			
			isInited=true;
		}
		private static var poolcommands:Array;
		
		private static function initCommandPool():void
		{
			// TODO Auto Generated method stub
			
			poolcommands=[];
			
			/*for (var i:int = 0; i < 10; i++) 
			{
				var comm:Robert2Command=new Robert2Command(null);
				
				poolcommands.push(comm);
				
			}*/
			
		}
		
		public static var evedisp:EventDispatcher;
		public static var context:Context;
		
		private static var map_inject:HashMap;
		private static var map_mediator:HashMap;
		private static var map_command:HashMap;
		private static var map_function:HashMap;
		
		private static var map_displaymediator:HashMap;
		
		/**
		 *添加要注册的类 及对像 
		 * @param injectClass
		 * @param singClassObj
		 * 
		 */		
		public static function addinject(injectClass:Class, singClassObj:Object):void
		{
			// TODO Auto Generated method stub
			
			mapay_inject=null;
			
			var classname:String=ClassUtils.getShortClassName(injectClass);
			
			map_inject.add(classname,singClassObj);
		}
		
		public static function getinjectwithshortname(keyname:String):Object{
			
			var classinstance:Object=map_inject.getValue(keyname);
			
			return classinstance;
		}
		
		private static var mapay_inject:Array
		
		private static var mapCachedInjectobj:HashMap;
		
		public static var isInited:Boolean;
		
		
		public static function injectinto(toInjectobj:Object):void{
		
			var keys:Array;
			if(mapay_inject){
				keys=mapay_inject
			}
			else{
				keys=map_inject.getKeys();
				mapay_inject=keys;
			}
			var keylen:int=keys.length;
			var i:int;
			for (i = 0; i < keylen; i++) 
			{
				var keyname:String=keys[i];
				var injectname:String="inj_"+keyname;
				
				if(toInjectobj.hasOwnProperty(injectname)){
					
					var savedinjectObj:Object=getinjectwithshortname(keyname);
					if(mapCachedInjectobj.containsKey(savedinjectObj)){
						
					}
					else{
						injectinto(savedinjectObj);
						mapCachedInjectobj.add(savedinjectObj,true);
					}
					
					
					toInjectobj[injectname]=savedinjectObj;
				}
				
			}
			
			
			
		}
		
		public static function addMediator(displayClass:Class, mediatorClass:Class,aliasname:String):void
		{
			// TODO Auto Generated method stub
			var classname:String=ClassUtils.getShortClassName(displayClass);
			
			if(aliasname!=null){
				classname+="."+aliasname;
			}
			
			map_mediator.add(classname,mediatorClass);
			
		}
		/**
		 *为每一个类型的mediator 类保存一个实例 重复的就会覆盖 
		 */		
		private static var mediatorClassDict:Dictionary;
		
		/**
		 *注册或取回mediator 
		 * @param displayobject
		 * @return 
		 * 
		 */		
		public static function getStarlingMediator(displayobject:Object,aliasname:String=null):MediatorStarlingBase{
			
			var med:*;
			
			
			
				med=map_displaymediator.getValue(displayobject);
			
			
			if(med)return med;
			
			var classname:String;
			classname=ClassUtils.getShortClassName(displayobject);
			
			if(classname=="SwfMovieClip"){
				classname="SwfSprite"
			}
			else if(classname=="SwfImage"){
				return null;
			}
			
			if(aliasname==null){
				
			}
			else{
				classname+="."+aliasname;
			}
			var classobj:Class=map_mediator.getValue(classname);
			
			
			
			if(classobj){
				
				
				med=new classobj();
				
				mediatorClassDict[classobj]=med;
				
				injectinto(med);
				
				med.viewbase=displayobject;
				
				map_displaymediator.add(displayobject,med);
			}
			
			
			return med;
			
		}
		
		
		
		
		
		/**
		 *注册或取回mediator 
		 * @param displayobject
		 * @return 
		 * 
		 */		
		public static function getMediator(displayobject:DisplayObject):MediatorStage2D{
		
			var med:MediatorStage2D;
			 
			med=map_displaymediator.getValue(displayobject);
			
			if(med)return med;
			
			var classname:String=ClassUtils.getShortClassName(displayobject);
			
			
			var classobj:Class=map_mediator.getValue(classname);
			
			if(classobj){
				
				med=new classobj();
				
				injectinto(med);
				
				
				med.viewbase=displayobject;
				
				map_displaymediator.add(displayobject,med);
			}
			
			
			return med;
		
		}
		
		/**
		 *移除事件侦听 
		 * @param EventType
		 * @param EventFunction
		 * 
		 */		
		public static function removeEventFunction(EventType:String, EventFunction:Function):void
		{
			var eventay:Array
			eventay=map_function.getValue(EventType);
			var funindex:int=eventay.indexOf(EventFunction)
			if(funindex>=0){
				eventay.splice(funindex,1);
			}
			
		}
		
		
		/**
		 *添加事件侦听 
		 * @param EventType
		 * @param EventFunction
		 * 
		 */		
		public static function addEventFunction(EventType:String, EventFunction:Function):void
		{
			var eventay:Array
			if(map_function.containsKey(EventType)==false){
				eventay=[];
				map_function.add(EventType,eventay);
			}
			else{
				eventay=map_function.getValue(EventType);
			}
			if(eventay.indexOf(EventFunction)==-1){
				eventay.push(EventFunction);
			}
			
			registerEventDisp(EventType,receiveFunction);
			
			/*if(evedisp.hasEventListener(EventType)==false&&funay.indexOf(EventFunction)==-1){
				funay.push(EventFunction)
			}
			else{
				trace("exist fun",EventType)
			}
			*/
			
		}
		private static var eventDispFunDict:Object;
		
		
		/**
		 *注册的全局事件回调 
		 * @param event
		 * 
		 */		
		protected static function receiveFunction(e:Robert2CommandEvent):void
		{
			// TODO Auto-generated method stub
//			var etype:String=e.type;//.toUpperCase();
			e.stopImmediatePropagation();
			var functionay:Array=map_function.getValue(e.type);
			
			if(functionay!=null){
				
				for (var i:int = 0; i < functionay.length; i++) 
				{
					var commandclass:Function=functionay[i];
					
					commandclass(e);
				}
			}
			else{
				
				trace("未注册的方法:",e.type)
			}
			
		}
		
		public static function addCommand(EventType:String, CommandClass:Class):void
		{
			// TODO Auto Generated method stub
			var saveEventType:String=EventType.toUpperCase();
			
			var eventay:Array
			if(map_command.containsKey(saveEventType)==false){
				eventay=[];
				
				map_command.add(saveEventType,eventay);
			}
			else{
				eventay=map_command.getValue(saveEventType);
			}
			if(eventay.indexOf(CommandClass)==-1){
				eventay.push(CommandClass);
			}
			
			addinject(CommandClass,null);
			registerEventDisp(EventType,receiveEvent);
//			evedisp.addEventListener(EventType,receiveEvent);
		}
		
		
		
		/**
		 *防止 事件注册和command注册 重复 
		 * @param eventype
		 * @param func
		 * 
		 */		
		private static function registerEventDisp(eventype:String,func:Function):void{
		
		
			var funay:Array	=eventDispFunDict[eventype];
			
			if(funay==null){
				funay=[];
				eventDispFunDict[eventype]=funay;
			}
			//			if(evedisp.hasEventListener(EventType)==false){
			if(funay.indexOf(func)==-1){
				funay.push(func);
				evedisp.addEventListener(eventype,func);
			}
			//			}
		}
		
		
		
		
		public static function receiveEvent(e:Robert2CommandEvent):void{
		
			var etype:String=e.type.toUpperCase();
			
			var classay:Array=map_command.getValue(etype);
			
			var commandclass:Class
			
			if(classay!=null){
				
				var classlen:int=classay.length;
				var i:int
				for ( i= 0; i <classlen ; i++) 
				{
					commandclass=classay[i];
					
					var commandobject:Robert2Command=new commandclass(null);
//						poolcommands.shift();
					
					commandobject.initeve(e.clone() as Robert2CommandEvent);
					
					injectinto(commandobject);
					
					commandobject.execute();
					
					commandobject.proccSevent();
					
					commandobject.dispose();
					
//					poolcommands.push(commandobject);
					
					
				}
				
			
				
				
			}
			else{
			
				trace("未注册的事件:",etype)
			}
			
			
			
			
		
		}
		
		
		/**
		 *增加别名的注入类 
		 * @param injectname
		 * @param singClassobj
		 * 
		 */		
		public static function addinjectAlians(injectname:String, singClassobj:Object):void
		{
			// TODO Auto Generated method stub
			map_inject.add(injectname,singClassobj);
		}
		
		/**
		 *取得某个类型med的一个实例 
		 * @param medclass
		 * @return 
		 * 
		 */		
		public static function getMediatorByClass(medclass:Class):*
		{
			// TODO Auto Generated method stub
			var med:*=mediatorClassDict[medclass];
			return med;
		}
	}
}