package starlingview
{
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import gameapi.statics.Static_Config;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;

	/**
	 * starling 初始器
	 * @author zhouhua
	 * 
	 */	
	public class StarlingIniter 
	{
		
		public static var design_width:int;
		public static var design_height:int;
		
		public static var screen_width:int;
		
		public static var screen_height:int;
		
		public static var screen_diffwidth:int;
		public static var screen_diffheight:int;

		/**
		 *根据机器分辨率缩放主容器 
		 */		
		public static var screenmain_scale:Number;
		
		public static var noscaleAlignMode:String;
		
		
		
		public static var NoScale_Top:String="top"; 
		public static var NoScale_Bottom:String="bottom"; 
		public static var NoScale_Center:String="center"; 
		
		
		public function StarlingIniter(instage:Stage,starlingcontext:Class,backfun:Function)
		{
			super();
			
			initStarling(instage,starlingcontext);
			
			backRootfun=backfun;
			
			design_width=Static_Config.DESIGNWIDTH;
			//			design_width=640
			design_height=Static_Config.DESIGNHEIGHT;
		
			screen_width=Starling.current.nativeStage.fullScreenWidth;
			screen_height=Starling.current.nativeStage.fullScreenHeight;
			
			
			
			screenmain_scale=Math.floor(screen_width/design_width)
			
				if(screenmain_scale==0){
					var scaleh:Number=screen_height/design_height;
					var scalew:Number=screen_width/design_width;
					
					screenmain_scale=Math.min(scaleh,scalew);
				}
				
			if(screenmain_scale==1){
				screen_diffwidth=((screen_width-(design_width*1))/2)	;;
				screen_diffheight=((screen_height-(design_height*1))/2);	;
			}
			else if(screenmain_scale>1){
			screen_diffwidth=((screen_width-(design_width*screenmain_scale))/2)	;
			screen_diffheight=((screen_height-(design_height*screenmain_scale))/2);	
				
			}
			else if(screenmain_scale<1){
			/*screen_diffwidth=((design_width-screen_width)*screenmain_scale)/2	;
			screen_diffheight=((design_height-screen_height)*screenmain_scale)/2;	*/
			}
			noscaleAlignMode=NoScale_Center;
			
		}
		
		
		
		
		
		 
		 
		private var gameinstance:StarlingGameContext;
		private var gameoldstage:Stage
		private function initStarling(instage:Stage,starlingcontext:Class):void
		{
			// TODO Auto Generated method stub
			gameoldstage=instage;
//			_starling = new Starling(starlingcontext, instage,null,null,"software","baselineConstrained"); //for xp desktop
			_starling = new Starling(starlingcontext, instage,null,null,"auto","auto");
			_starling.showStats = false;
			_starling.autoSkip=null;
			
			_starling.antiAliasing=0;
			_starling.enableErrorChecking= Capabilities.isDebugger;
			_starling.start();
			
			
			_starling.addEventListener(starling.events.Event.ROOT_CREATED,onRootcreat)
			_starling.addEventListener(Event.RESIZE,onResize);
			/*var rect:Rectangle=RectangleUtil.fit(
				new Rectangle(0, 0, design_width, design_height),
				new Rectangle(0, 0, gameoldstage.fullScreenWidth, gameoldstage.fullScreenHeight),
				ScaleMode.SHOW_ALL);*/
//			Starling.current.viewPort =new Rectangle(0, 0, gameoldstage.fullScreenWidth, gameoldstage.fullScreenHeight); 
//			Starling.current.viewPort=new Rectangle(0, 0, 960, 640);
			
		}		
		
		
		private function onResize(event:Event, size:Point):void
		{
			Starling.current.viewPort = RectangleUtil.fit(
				new Rectangle(0, 0, gameoldstage.stageWidth, gameoldstage.stageHeight),
				new Rectangle(0, 0, size.x, size.y),
				ScaleMode.SHOW_ALL);
		}
		
		/**
		 *starling 底层启动完毕 
		 * @param e
		 * 
		 */		
		private function onRootcreat(e:starling.events.Event):void
		{
			// TODO Auto Generated method stub
			
			_starling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootcreat);
			gameinstance=StarlingGameContext.instance;
//			sStarling.current.contentScaleFactor=
//			Starling.contentScaleFactor=
			trace(Starling.current.viewPort,Starling.current.contentScaleFactor,Starling.contentScaleFactor);
			
			Starling.current.stage.stageWidth=screen_width;
			Starling.current.stage.stageHeight=screen_height;
			
		/*	var centx:int=(screen_width-design_width)/2;
			var centy:int=(screen_height-design_height)/2;*/
			
			var myresult:Rectangle=new Rectangle();
			Starling.current.viewPort = RectangleUtil.fit(
				new Rectangle(0, 0, screen_width, screen_height),
				new Rectangle(0, 0, screen_width, screen_height),
				ScaleMode.NONE,true,myresult);
			trace(myresult);
			 
			//			var scalx:Number=2056/960	;
//			var scaly:Number=1536/640;
			/*var scalx:Number=854/960	;
			var scaly:Number=480/640;
			
			var minscal:Number=Math.min(scalx,scaly);*/
			
//			Starling.current.viewPort
//			=new Rectangle(0,0,360*minscal,140*minscal)
			if(backRootfun!=null){
					backRootfun()
				}
				 
		}
		
		
		
		
		
		
		private var backRootfun:Function;

		private var _starling:Starling;
		
	
		
		
		public static function getCurrentStageRootPoint():Point
		{
			// TODO Auto Generated method stub
			
			var centx:int;
			var centy:int;
			
			if(noscaleAlignMode==NoScale_Center){
				centx=(StarlingIniter.screen_width-StarlingIniter.design_width)/2;
				centy=(StarlingIniter.screen_height-StarlingIniter.design_height)/2;
				
				centx=Math.abs(centx);
				centy=Math.abs(centy);
				
			}
			else if(noscaleAlignMode==NoScale_Top){
				centx=(StarlingIniter.screen_width-StarlingIniter.design_width)/2;
				centy=0;
			}
			else if(noscaleAlignMode==NoScale_Bottom){
				centx=(StarlingIniter.screen_width-StarlingIniter.design_width)/2;
				centy=(StarlingIniter.screen_height-StarlingIniter.design_height);
			}
			
			var pt:Point=new Point(centx,centy);
			
			
			return pt;
		}
		
		
		
	}
}