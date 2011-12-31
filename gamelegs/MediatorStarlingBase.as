package gamelegs
{
	
	
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import R2Event.Robert2CommandEvent;
	
	import gamelegs.mediators.starling.Med_ScenUIBase;
	
	import mediators.base.MediatorSGameBase;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;

	public class MediatorStarlingBase
	{
		public function MediatorStarlingBase()
		{
			evedisp=GameLegs.evedisp;
		}
		
		protected var evedisp:EventDispatcher;
		
		private var _viewbase:Sprite;
		
		/**
		 *组件初始化完成 
		 */		
		protected var binited:Boolean;
		
		public function initialize():void{
			
			
			
			initData();
			
			initContextEvent();
			
			initViewEvent();
			
//			setTimeout(afterinit,1);
			afterinit()
			
		}
		
		protected function afterinit():void
		{
			binited=true;	
			
			refushContMediatorOrderData(null);
			
		}
		
		
		protected function initData():void
		{
			// TODO Auto Generated method stub
			mediatorDispChildOrignData=new Dictionary();
		}
		
		public function get viewbase():Sprite
		{
			return _viewbase;
		}

		public function set viewbase(value:Sprite):void
		{
			_viewbase = value;
			
			this["inj_view"]=_viewbase;
			
			initialize();
		}
		
		
		public function initContextEvent():void{
			
			
		}
		
		public function initViewEvent():void{
			
			
			addViewListener(Event.ADDED_TO_STAGE,onAddToStage);
			addViewListener(Event.REMOVED_FROM_STAGE,onRemoveStage);
			
		}
		
		protected function onRemoveStage(e:Event):void
		{
			// TODO Auto Generated method stub
//			trace("onRemoveStage")
		}
		
		/**
		 *通常注册事件时己经在stage上 
		 * @param e
		 * 
		 */		
		protected function onAddToStage(e:Event):void
		{
			// TODO Auto Generated method stub
//			trace("onAddToStage")
		}
		
		/**
		 *父级mediator 
		 */		
		public var parentMediator:MediatorSGameBase;
		
		
		public function getViewMediator(childdisp:DisplayObject,aliasname:String=null):MediatorStarlingBase{
			
			
			
			return GameLegs.getStarlingMediator(childdisp,aliasname);
			
		}
		
		/**
		 *添加context事件侦听 
		 * @param EventType
		 * @param EventCallFun
		 * 
		 */		
		protected function addContextListener(EventType:String, EventCallFun:Function):void
		{
			// TODO Auto Generated method stub
			//			EventType=EventType.toUpperCase();
			GameLegs.addEventFunction(EventType,EventCallFun);
		}
		
		/**
		 * 移除context事件侦听
		 * @param EventType
		 * @param EventCallFun
		 * 
		 */		
		protected function removeContextListener(EventType:String, EventCallFun:Function):void
		{
			// TODO Auto Generated method stub
			//			EventType=EventType.toUpperCase();
			GameLegs.removeEventFunction(EventType,EventCallFun);
		}
		
		/**
		 *media 处理显示对像上传的事件 
		 * @param EventType
		 * @param EventCallFunction
		 * 
		 */		
		protected function addViewListener(EventType:String, EventCallFunction:Function):void
		{
			// TODO Auto Generated method stub
			_viewbase.addEventListener(EventType,EventCallFunction);
		}
		
		/**
		 *显示对像的事件移除 
		 * @param EventType
		 * @param EventCallFunction
		 * 
		 */		
		protected function removeViewListener(EventType:String, EventCallFunction:Function):void
		{
			
			_viewbase.removeEventListener(EventType,EventCallFunction);
		}
		
		/**
		 *显示对像的事件侦听全部移除 
		 * 
		 */		
		protected function removeViewListeners():void
		{
			_viewbase.removeEventListeners();
			
		}
		
		
		protected function dispEvent(e:Robert2CommandEvent):void{
			
			evedisp.dispatchEvent(e);
		}
		
		public function dispEventType(evetype:String,data:Array,delay:int=0):void{
		
			var ve:Robert2CommandEvent=new Robert2CommandEvent(evetype,data);
			if(delay==0){
				dispEvent(ve);
			}
			else{
				setTimeout(dispEvent,delay,ve);
			}
		}
		
		/**
		 *遍历上层找到顶级parent 的模块
		 * @return 
		 * 
		 */		
		public function getModuleParent():Med_ScenUIBase
		{
			// TODO Auto Generated method stub
			
			
			var parent:MediatorSGameBase=this.parentMediator as MediatorSGameBase;
			
			if(parent==null)return null;
			
			if(parent is Med_ScenUIBase) return parent as Med_ScenUIBase;
			
			
			var loopparent:Med_ScenUIBase=parent.getModuleParent() ;
			
			
			return loopparent;
		}
		
		
		
		
		private var mediatorDispChildOrignData:Dictionary
		
		private var mediatorDispOrignOrder:Array;
		
		
		public function getMediatorDispChild(meddispid:String):DisplayObject{
			
			var thisDisp:DisplayObject=this[meddispid];
			if(thisDisp==null)return null;
			var dataobj:Object=mediatorDispChildOrignData[thisDisp];
			if(dataobj==null){
				
				dataobj=copyDispOrignData(thisDisp);
				mediatorDispChildOrignData[thisDisp]=dataobj;
				
			}
			return thisDisp;
			
		}
		
		private  static function copyDispOrignData(thisDisp:DisplayObject):Object
		{
			// TODO Auto Generated method stub
			var dataobj:Object={};
			
			dataobj.x=thisDisp.x;
			dataobj.y=thisDisp.y;
			dataobj.parent=thisDisp.parent;
			
			
			return dataobj;
		}
		
		private static function setDispOrignData(meddisp:DisplayObject, dataobj:Object):void
		{
			// TODO Auto Generated method stub
			var parent:DisplayObjectContainer=dataobj.parent;
			var lastindex:int=dataobj.lastindex;
			
			parent.addChild(meddisp);
			
		}		
		
		protected function resortMediatorOrder(forceback:Boolean):void{
			
			for (var i:int = 0; i < mediatorDispOrignOrder.length; i++) 
			{
				var child:DisplayObject=mediatorDispOrignOrder[i];
				
				if(forceback&&child.parent!=viewbase){
					viewbase.addChildAt(child,i);
				}
				else{
					if(child.parent==viewbase){
						viewbase.addChildAt(child,i);
					}
				
				}
				
				
				
			}
			
		}
		
		protected function refushContMediatorOrderData(cont:DisplayObjectContainer):void{
			
			mediatorDispOrignOrder=[];
			
			if(cont==null){
				cont=viewbase
			}
			
			for (var i:int = 0; i < cont.numChildren; i++) 
			{
				var child:DisplayObject=cont.getChildAt(i);
				
				mediatorDispOrignOrder.push(child);
				
			}
			
			
			
		}
		
		protected function setMediatorDispChildBack(meddisp:DisplayObject):void{
			
			var dataobj:Object=mediatorDispChildOrignData[meddisp];
			
			setDispOrignData(meddisp,dataobj);
			
		}
		
		protected function setViewToStagePoint(disp:DisplayObject, stagex:int, stagey:int):void
		{
			// TODO Auto Generated method stub
			var pt:Point=new Point(stagex,stagey);
			
			pt=disp.globalToLocal(pt);
			
			disp.x=pt.x;
			disp.y=pt.y;
			
		}		
		
	}
}