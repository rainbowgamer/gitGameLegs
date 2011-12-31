package utils
{
	import lzm.starling.swf.display.SwfImage;
	
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	/**
	 *触摸事件工具类 
	 * @author rainbowgamer
	 * 
	 */
	public class TouchUtils
	{
		public function TouchUtils()
		{
		}
		
		public var touchTarget:DisplayObject;
		
		public var touchPhase:String;
		
		public var touchBackFun:Function;
		
		public var autorelease:Boolean;
		
		public var disposed:Boolean;
		
		private var onTouchFun:Function;
		
		
		public static function regTouceEvent(target:DisplayObject,touchPhase:String,touchFun:Function,autorelease:Boolean=false):TouchUtils{
		
			var tu:TouchUtils=new TouchUtils();
			tu.touchTarget=target;
			tu.touchPhase=touchPhase;
			tu.touchBackFun=touchFun;
			
			tu.autorelease=autorelease;
		
			
			var onTouchFun:Function=function(e:TouchEvent):void{
				
				var t:Touch=e.getTouch(target,touchPhase);
				
				if(t){
					
					var touchrelease:Boolean=tu.touchBackFun(t);
					
					if(touchrelease&&tu.autorelease&&tu.disposed==false){
							
						tu.dispose(onTouchFun);
					}
					else{
						tu.onTouchFun=onTouchFun;
						
					}
					
				}
				
			}
				
			tu.onTouchFun=onTouchFun;
			
			target.addEventListener(TouchEvent.TOUCH,onTouchFun);
			
			
			return tu;
		
		}
		
		public function dispose(onTouchFun:Function=null):void{
		
			if(onTouchFun){
				this.touchTarget.removeEventListener(TouchEvent.TOUCH,onTouchFun)
			}
			else{
			
				this.touchTarget.removeEventListener(TouchEvent.TOUCH,this.onTouchFun)
			}
				
			this.touchTarget=null;
			this.touchBackFun=null;
			this.touchPhase=null;
			this.disposed=true;	
				
		}
		
		/**
		 *转换触控对像到可识别 
		 * @param target
		 * @return 
		 * 
		 */		
		public static function getTouchTarget(target:DisplayObject):DisplayObject{
		
			var outtouch:DisplayObject;
			
			if(target is SwfImage){
			
				outtouch=target.parent as DisplayObject;	
			}
			else{
				outtouch=target;
			}
			return outtouch;
		}
		
		
		/**
		 *检查是否点到了所需的按钮 
		 * @param target
		 * @param touchedname
		 * @return 
		 * 
		 */		
		public static function isTouchTargetInName(target:DisplayObject,touchedname:String):Boolean{
		
			var touchobjname:String=getTouchTargetName(target);
			
			if(touchobjname==touchedname){
			 
				return true;
			}
		
			return false;
		}
		
		
		
		/**
		 *得到事件对像名 
		 * @param target
		 * @return 
		 * 
		 */		
		public static function getTouchTargetName(target:DisplayObject):String{
		
			var touchobj:DisplayObject=getTouchTarget(target);
			
			return touchobj.name;
			
		}
		
		
		
		
	}
}