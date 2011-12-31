package gamelegs.mediators.starling
{
	import R2Event.Robert2CommandEvent;
	
	import avmplus.getQualifiedClassName;
	
	import gameapi.statics.Static_Event;
	import gameapi.statics.Static_Type;
	
	import lzm.starling.swf.display.SwfMovieClip;
	import lzm.starling.swf.display.SwfSprite;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Med_SWFUIChildBase extends Med_SwfUIBase
	{
		public function Med_SWFUIChildBase()
		{
			super();
			
			
		}
		
		protected var parentModuleid:String;
		
		
		override public function initialize():void
		{
			// TODO Auto Generated method stub
//			this.binited=true;
			super.initialize();
			
			
			if(viewid==null){
			var classname:String=getQualifiedClassName(this);
			classname=classname.split("::")[1];
			
			classname=classname.replace("Med_mc_","");
				this.viewid=classname;
			}
			
//			syncViewChild(inj_view as SwfSprite);
			
			
		}
		
		override protected function afterinit():void
		{
			// TODO Auto Generated method stub
//			super.afterinit();
			this.binited=true;
			refushContMediatorOrderData(inviewChild_SwfMovieClip);
		}
		
		
		
		
		
		/**
		 *改动侦 找到对像 
		 * @param frame
		 * 
		 */		
		public function resyncMovieToFrame(frame:int):void{
		
			(inj_view as SwfMovieClip).gotoAndStop(frame);
			
			syncViewChild(inj_view as SwfSprite);
		}
		
		override public function initViewEvent():void
		{
			// TODO Auto Generated method stub
			super.initViewEvent();
			
			
		}
		
		override protected function onRemoveStage(e:Event):void
		{
			// TODO Auto Generated method stub
		
			super.onRemoveStage(e);
			
		}
		
		override protected function onAddToStage(e:Event):void
		{
			// TODO Auto Generated method stub
			super.onAddToStage(e);
		}
		
		
		
		
		
		
		/**
		 *如果是mov对像则会有 
		 */		
		public var swfmov:SwfMovieClip;
		
		override public function afterViewInited():void
		{
			// TODO Auto Generated method stub
			swfmov=inj_view as SwfMovieClip;
			inviewChild_SwfMovieClip=swfmov;
			
			syncViewChild(inj_view as SwfSprite)
			
			parentModuleid=getParentModuleid();
			
//			super.afterViewInited();
//			afterinit();
			
			if(parentModuleid==viewid){
				trace(parentMediator)
			}
		}
		
		
		/**
		 *向外发送当前显示对像的一些事件 
		 * @param childtype
		 * @param evedatas
		 * @param delay
		 * 
		 */		
		protected function dispViewUpdateEvent(childtype:String,evedatas:Array,delay:int=0):void{
			
			evedatas.unshift(childtype);
			
			dispEventType(Static_Event.EVENT_VIEW_UPDATE,evedatas
				,delay
			);
			
		}
		
		/**
		 *把当前在top层的自身显示对像去除 
		 * 
		 */			
		protected function hide_inviewChild_fromTop():void
		{
			// TODO Auto Generated method stub
			dispDataChange_Event(Static_Type.UIEFFECT_REMOVEWINDOW,[inviewChild_SwfMovieClip]);
			
		}			
		
		
		/**
		 *把当前在自身显示对像添加到top层 
		 * 
		 */			
		protected function show_inviewChild_toTop(effect:Boolean=true):void
		{
			// TODO Auto Generated method stub
			show_childto_Top(inviewChild_SwfMovieClip,effect);
			
		}	
		
		/**
		 *将一个显示对像 放入top 
		 * @param childdisp
		 * 
		 */		
		protected function show_childto_Top(childdisp:SwfMovieClip,effect:Boolean):void
		{
			// TODO Auto Generated method stub
			dispDataChange_Event(Static_Type.UIEFFECT_ADDWINDOW,[childdisp,effect]);
		}		
		
		/**
		 *如果当前面版是对话框则可以隐藏 
		 * 
		 */		
		protected function hideDialog():void{
			
			dispDataChange_Event(Static_Type.UIEFFECT_HIDEDIALOG,[viewid]);
		}
		
		/**
		 * 设置当前显示对像隐藏
		 * 
		 */		
		public function disablViewVisible():void{
		
			inj_view.visible=false;
		}
		
		/**
		 * 设置当前显示对像显示
		 * 
		 */		
		public function enableViewVisible():void{
			
			inj_view.visible=true;
		}
	}
}