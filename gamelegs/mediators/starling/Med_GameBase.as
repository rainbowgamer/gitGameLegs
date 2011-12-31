package gamelegs.mediators.starling
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import R2Event.Robert2CommandEvent;
	
	import application.context.RuntimeConfig;
	
	import gameapi.configs.GameConfig_UItext;
	import gameapi.statics.Static_Event;
	import gameapi.statics.Static_Type;
	
	import gamelegs.GameLegs;
	import gamelegs.MediatorStarlingBase;
	
	import mediators.base.MediatorSGameBase;
	
	import modules.datamodules.Data_Utils;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import starlingview.StarlingGameLegsSpriteBase;
	
	import utils.ConfigDataHelper;
	
	import viewsStarling.base.SwfUIBaseForGameLegs;
	
	public class Med_GameBase extends MediatorSGameBase
	{
		public function Med_GameBase()
		{
			super();
			
			initStatic();
			
		}
		
		private function initStatic():void
		{
			// TODO Auto Generated method stub
			if(initUIDict==null){
				initUIDict=new Dictionary();
			}
		}
		/**
		 *一个视图资源的id 
		 */		
		public var viewid:String;
		
		/**
		 *注册事件类型 
		 */		
		private var regDataChangTypes:Array;
		
		/**
		 *注册的只执行一次的事件 
		 */		
		private var regDataChangRunOnceTypes:Array;
		
		/**
		 *只运行一次的事件的回调方法 
		 */		
		private var regDataChangRunOnceFunsDict:Object;
		
		
		
		override protected function initData():void
		{
			// TODO Auto Generated method stub
			regDataChangTypes=[];
			regDataChangRunOnceTypes=[];
			regDataChangRunOnceFunsDict=new Object();
			super.initData();
			
			
			gameModeldatautil=inj_Model_GameData.datautils;
			
		}
		
		/**
		 *方便游戏数据转换的工具类 
		 */		
		protected var gameModeldatautil:Data_Utils;
		
		/**
		 *注册事件侦听 
		 * @param eventype
		 * @param runonce 是否只运行一次
		 * 
		 */		
		protected function regDataChangedEventHookType(eventype:String,runonce:Boolean=false):void{
			
			if(runonce==false){
			
				if(regDataChangTypes.indexOf(eventype)==-1){
					regDataChangTypes.push(eventype);
				}
				
			}
			else{
				if(regDataChangRunOnceTypes.indexOf(eventype)==-1){
					regDataChangRunOnceTypes.push(eventype);
				}
			
			}
			
		}
		
		/**
		 *删除事件侦听 
		 * @param eventype
		 * @param runonce
		 * 
		 */		
		protected function removeDataChangedEventHookType(eventype:String,runonce:Boolean=false):void{
				var index:int
			
			if(runonce==false){
				
				if(eventype==null){
					regDataChangTypes=[];
				}
				
				
				index=regDataChangTypes.indexOf(eventype);
				if(index>=0){
					regDataChangTypes.splice(index,1);
				}
				
			}
			else{
				
				if(eventype==null){
					regDataChangRunOnceTypes=[];
				}
				
				index=regDataChangRunOnceTypes.indexOf(eventype);
				if(index>=0){
					regDataChangRunOnceTypes.splice(index,1);
					regDataChangRunOnceFunsDict[eventype]=null;
				}
			}
			
		}
		
		
		override public function initContextEvent():void
		{
			// TODO Auto Generated method stub
			super.initContextEvent();
			
			//			addContextListener(Static_Event.EVENT_VIEWMODULE_CREATE,onCreateView)
			addContextListener(Static_Event.EVENT_VIEW_CHANGE,onView_Change);
			addContextListener(Static_Event.EVENT_DATA_CHANGE,onData_Change);
			
		}
		
		override protected function onAddToStage(e:Event):void
		{
			// TODO Auto Generated method stub
			super.onAddToStage(e);
			
			initContextEvent();
			
		}
		
		override public function set viewbase(value:Sprite):void
		{
			// TODO Auto Generated method stub
			super.viewbase = value;
			
			
			
		}
		
		
		/**
		 *当前是否只是移动层次,不清理注册事件 
		 */		
		public var bMovingChild:Boolean;
		
		
		
		
		override protected function onRemoveStage(e:Event):void
		{
			// TODO Auto Generated method stub
			//			trace("onRemoveStage")
			if(bMovingChild)return;
			removeContextListener(Static_Event.EVENT_VIEW_CHANGE,onView_Change);
			removeContextListener(Static_Event.EVENT_DATA_CHANGE,onData_Change);
			
			
		}
		
		
		private function onView_Change(e:Robert2CommandEvent):void
		{
			// TODO Auto Generated method stub
			var eventviewid:String=e.data[0];
			
			if(eventviewid==this.viewid){
				
				
				doDirectViewChangeEvent(e.data);
				
			}
		}	
		
		/**
		 *处理本视图元件的事件, 注意数据是原始数据 包含了	[0]元件id 
		 * 进入本方法的事件是己经过滤过的
		 * @param data
		 * 
		 */		
		protected function doDirectViewChangeEvent(dataay:Array):void
		{
			// TODO Auto Generated method stub
			
		}		
		/**
		 *当事件触发时 
		 * @param e
		 * 
		 */		
		protected function onData_Change(e:Robert2CommandEvent):void
		{
			// TODO Auto Generated method stub
//			var eventtype:String=e.data[0];
//			var regtype:String=e.data[1];
			if(binited==false)return;
			
			if(regDataChangTypes.indexOf(e.data[0])!=-1)
			{
				doRegisteredDataChangeEvent(e.data[0],e.data);
			}
			else if(regDataChangRunOnceTypes.indexOf(e.data[0])!=-1){
			
				var callfun:Function=regDataChangRunOnceFunsDict[e.data[0]];
				if(callfun!=null){
					if(callfun.length==0){		//如果接收方法的参数=0 则直接调用
						callfun();
					}
					else{
						callfun(e.data);
					}
				}
				
				removeDataChangedEventHookType(e.data[0],true);
				
				return;
				
			}
			
			
			
			
		}
		
		override public function initialize():void
		{
			// TODO Auto Generated method stub
			if(viewid==null){
				viewid=viewbase.name;
			}
			super.initialize();
			
		}
		
		
		
		/**
		 *处理注册过的事件类型 
		 * @param regtype
		 * @param dataay
		 * 
		 */		
		protected function doRegisteredDataChangeEvent(regtype:String, dataay:Array):void
		{
			// TODO Auto Generated method stub
			
		}	
		
		
		/**
		 *设置是否可点击 
		 * @param selfenable
		 * @param groupenable
		 * 
		 */		
		public function settouchEanble(selfenable:Boolean,singlegroup:Boolean):void{
			
			viewbase.touchable=selfenable;
			viewbase.touchGroup=singlegroup
		
		}
		
		
		/**
		 *向viewbase增加一个显示子对像 通用元件id生成 
		 * @param mcid
		 * @return 
		 * 
		 */		
		protected function addUImcto_inj_view(mcid:String):SwfUIBaseForGameLegs{
			
			
			var uimc:SwfUIBaseForGameLegs=new SwfUIBaseForGameLegs();
			(viewbase as SwfUIBaseForGameLegs).addChildByName(uimc,mcid);
			return uimc;
		}
		
		private static var initUIDict:Dictionary;
		
		
		/**
		 *初始化外部的ui子元件 
		 * 并自动加入viewbase显示对像下
		 * 自动根据uiid 搜索相应的 swfsprite.mediator
		 * 
		 */		
		protected function load_initUI_byID(UIid:String,packid:String,mcid:String,backuifun:Function,blacktopscreen:Boolean=true):void
		{
			// TODO Auto Generated method stub
			
			var uichild:DisplayObject=this[UIid];
			
			if(uichild==null){
				
				if(initUIDict[UIid]){
				
					this[UIid]=initUIDict[UIid];
					
					backuifun(null);
					
					return;
				}
				else{
				
					
					if(blacktopscreen){
						showTopScreenBlack();
					}
					
					var backload:Function=function(backui:DisplayObject):void{
						
						addLogger("SWF UI 加载完成");
						
						initUIDict[UIid]=backui;
					
						backuifun(backui);
					
					}
					
					addLogger("开始加载SWF UI",packid,mcid,UIid);
					loadSwfUIBackToInstance(packid,mcid,UIid,backload)
				
				}
			}
				
			else{
				backuifun(null);
			}
			
		}	
		
		protected function addLogger(...args):void{
			var logstr:String=args.join("\t");
			if(RuntimeConfig.showAssertVerb){
				trace("============== ["+getTimer()+"]:"+logstr+"	=======================================")
			}
		
		}
		
		/**
		 *初始化一个swf_mc ui 并设置this的相应属性  mcinstname
		 * @param swfid
		 * @param mcid
		 * @param mcinstname
		 * @param backfun
		 * 
		 */		
		protected function loadSwfUIBackToInstance(swfid:String,mcid:String,mcinstname:String,backfun:Function):void{
			
			var backthis:*=this;
			var backmcfun:Function=function(backswfdisp:Sprite):void{
				addLogger("swfui loadSwfUIBackToInstance end")
				backthis[mcinstname]=backswfdisp;
				
				backfun(backswfdisp);
				
			}
			
			addLogger("swfui loadSwfUIBackToInstance start")
			loadSwfUIBackToMediator(swfid,mcid,backmcfun);
		}
		
		
		
		
		
		/**
		 *加载swf_mc并且初始化mediator 
		 * @param swfpackid
		 * @param mcid
		 * @param backmcfun
		 * 
		 */		
		protected function loadSwfUIBackToMediator(swfpackid:String,mcid:String, backmcfun:Function):void
		{
			// TODO Auto Generated method stub
			
			var backmcmedfun:Function=function(backswfdisp:Sprite):void{
				backswfdisp.visible=false;
				backswfdisp.name=mcid;
				if(viewbase is StarlingGameLegsSpriteBase){
					(viewbase as StarlingGameLegsSpriteBase).addChildByName(backswfdisp,mcid);
					addLogger("swfui SWFUI_LOAD_BACK to Addchild end!")
				}
				backmcfun(backswfdisp);
				
				
			}
			
			addLogger("swfui SWFUI_LOAD_BACK to Addchild start")
			dispEventType(Static_Event.EVENT_LZM_SWF_LOAD,
				[Static_Type.SWFUI_LOAD_BACK,swfpackid,mcid,backmcmedfun]);
			
			
			
		}		
		
		
		
		
		/**
		 *把显示子元件丢入顶层 
		 * @param child
		 * 
		 */		
		protected function addChildToTop(child:DisplayObject):void
		{
			// TODO Auto Generated method stub
			/*if(child.visible==false){
			child.visible=true;
			}*/
			
			dispEventType(Static_Event.EVENT_DATA_CHANGE,[Static_Type.UIEFFECT_ADDWINDOW,child]);	
		}
		
		/**
		 *可能有加载,先黑屏等待 
		 * 
		 */		
		protected function showTopScreenBlack(...args):void
		{
			// TODO Auto Generated method stub
			dispEventType(Static_Event.EVENT_DATA_CHANGE,[Static_Type.UIEFFECT_SHOWBLACK]);	
		}
		
		
		/**
		 *显示一个弹窗口  及 相关参数数组 
		 * @param confirmtype
		 * @param confirmargs
		 * 
		 */		
		protected function showConfirm(confirmtype:String,confirmargs:Array):void{
			
			
			confirmargs.unshift(confirmtype)
			confirmargs.unshift(Static_Type.UIEFFECT_SHOWDIALOG)
			
			
			dispEventType(Static_Event.EVENT_DATA_CHANGE,
				confirmargs)
			
		}
		
		/**
		 *切换到某个场景去 
		 * @param scenid
		 * 
		 */		
		protected function switch_scen(scenid:String):void
		{
			// TODO Auto Generated method stub
			dispEventType(Static_Event.EVENT_SCEN_CHANGE,
				[Static_Type.VIEW_SCENSWITCH,scenid],1)
		}	
		
		
		/**
		 *向服务端发送请求 
		 * @param request_type
		 * @param eventdata
		 * 
		 */		
		protected function send_Request2Server(request_type:String, eventdata:Array,backFun:Function=null):void
		{
			// TODO Auto Generated method stub
			eventdata.unshift(request_type);
			
			if(backFun!=null){
				regDataChangeRunOnce(request_type,backFun);
				
			}
			
			
			
			dispEventType(Static_Event.EVENT_COMMU_CLIENT2SERVER,eventdata);
			
		}	
		
		/**
		 *注册一次性调用 
		 * @param regtype
		 * @param fun
		 * 
		 */		
		protected function regDataChangeRunOnce(regtype:String,fun:Function):void{
			regDataChangRunOnceFunsDict[regtype]=fun;	
			regDataChangedEventHookType(regtype,true);
		}
		
		
		/**
		 *发送数据事件 
		 * @param dataargs
		 * 
		 */		
		protected function send_DataChangeEvent(dataargs:Array):void
		{
			// TODO Auto Generated method stub
			dispEventType(Static_Event.EVENT_DATA_CHANGE,dataargs);
		}		
		
		
		protected var currentBgimgId:String;
		
		/**
		 *更新背景图纹理,后回调 
		 * @param imageid
		 * @param backfun
		 * 
		 */		
		protected function replaceBg(imageid:String,backfun:Function):void{
			trace("replaceBg:",imageid);
			currentBgimgId=imageid;
			dispDataChange_Event(Static_Type.UIEFFECT_LOADBGIMAGE,[imageid,backfun]);
		}
		 
		
		/**
		 *发送UI datachange 事件 
		 * @param eventtype
		 * @param args
		 * 
		 */		
		public function dispDataChange_Event(dataChangeType:String,args:Array=null):void{
			
			if(args==null){
				args=[];
			}
			
			args.unshift(dataChangeType);
			
			dispEventType(Static_Event.EVENT_DATA_CHANGE,args);
		}	
		
		
		
		protected function loadMediatorDispIn(medClass:Class,medDispid:String,x:int,y:int,isAbs:Boolean=false,afterDataEventType:String=null,afterEventarg:Array=null):DisplayObject{
			
			var dispMedchild:DisplayObject=getSingleMediatorDisp(medClass,medDispid);
			
			if(dispMedchild==null)return null;
			
			if(this.hasOwnProperty(medDispid)){
			
				this[medDispid]=dispMedchild;
				
			}
			
			viewbase.addChild(dispMedchild);
			
			if(isAbs){
				dispMedchild.x=x;
				dispMedchild.y=y;
			}
			else{
				dispMedchild.x+=x;
				dispMedchild.y+=y;
			}
			
			
			if(afterDataEventType){
				
				dispDataChange_Event(afterDataEventType,afterEventarg);
			}
			
			return dispMedchild;
		}
		
		
		private function getSingleMediatorDisp(medclass:Class, dispid:String):DisplayObject
		{
			// TODO Auto Generated method stub
			var med:MediatorStarlingBase=GameLegs.getMediatorByClass(medclass);
			
			var disp:DisplayObject=med.getMediatorDispChild(dispid)
			
			return disp;
		}	
		
		
		
		
		
		
		/**
		 *初始化并更新一个textfield 使用配置表参数 
		 * @param keyTextid
		 * @param intxt
		 * 
		 */		
		protected function init_UITextfield( intxt:TextField):void
		{
			// TODO Auto Generated method stub
			intxt.visible=true;
			var txtviewid:String=viewid.replace(".","_")
			var keyTextid:String=intxt.name+"_in_"+txtviewid;
			
			var keyobjvalue:Array=GameConfig_UItext.dataObjects[keyTextid];
			var txtkeyobjvalue:Array=keyobjvalue.concat();
			txtkeyobjvalue.unshift(keyTextid);
			var keyobj:Object=ConfigDataHelper.buildObjectItem(txtkeyobjvalue,GameConfig_UItext.fieldlist);
			
			intxt.height;
			intxt.width;
			 
			if(keyobj["height"]!=0){
				intxt.height=keyobj["height"]; //不先设置高度,文字就会不显示
			}
			if(keyobj["width"]!=0){
				intxt.width=keyobj["width"]; //不先设置高度,文字就会不显示
			}
			
			keyobj["color"]=paraseColor(keyobj["color"]);
			 
//			trace("init_UITextfield new width:",intxt.width,"new height:",intxt.height);
			
			for (var key:* in keyobj) 
			{
				var value:*=keyobj[key];
				
				if(key=="x"||key=="y"){
					
					intxt[key]+=value;
				}
				else if(key=="height"||key=="width"){
					
				}
				else{
					if(intxt.hasOwnProperty(key)){
						intxt[key]=value;
					}
				} 
				 
			}
			intxt.height;
			intxt.width;
			/*intxt.width=300
				intxt.height=300;*/
			  
			intxt.visible=true;
//			intxt.border=true;
		} 
		
		private function paraseColor(colorstr:String):Object
		{
			// TODO Auto Generated method stub
			var ucolor:uint=uint(colorstr);
			
			
			return ucolor;
		}		   
		
		/**
		 *加载一张大图并add到一个父容器中 
		 * @param imgid
		 * @param backparent
		 * @param backimagefun
		 * 
		 */		
		protected function loadBigImagToParent(imgid:String,backparent:DisplayObjectContainer,backimagefun:Function):void{
			
			
			var backfun:Function=function(text:Texture):void{
				
				var img:Image=new Image(text);
				if(backparent!=null){
					backparent.addChild(img);
				}
				
				backimagefun(img);
				
			}
			
			inj_Model_GameData.manResource.loadbigimagetexture(imgid,backfun);
			
		}
		
	}
}