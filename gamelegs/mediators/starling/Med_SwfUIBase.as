package gamelegs.mediators.starling
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.setTimeout;
	
	import R2Event.Robert2CommandEvent;
	
	import gameapi.configs.GameConfig_UIlist;
	import gameapi.statics.Static_Event;
	import gameapi.statics.Static_Type;
	
	import lzm.starling.swf.Swf;
	import lzm.starling.swf.display.SwfImage;
	import lzm.starling.swf.display.SwfMovieClip;
	import lzm.starling.swf.display.SwfSprite;
	
	import mediators.base.MediatorSGameBase;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.TextureSmoothing;
	
	import starlingview.StarlingGameLegsSpriteBase;
	
	import utils.AlignType;
	import utils.ConfigDataHelper;
	
	import viewsStarling.base.SwfUIBaseForGameLegs;
	import viewsStarling.extendUI.UIExtendList;
	
	public class Med_SwfUIBase extends Med_GameBase
	{
		
		
		public function Med_SwfUIBase()
		{
			super();
		}
		
	
		
		
		
		
		public var isviewloading:Boolean;
		
		
		[Inject]
		public var inj_view:DisplayObjectContainer;
		
		protected var inviewChild_SwfMovieClip:SwfMovieClip;
		
		
		
		
		
		
		/**
		 *传入的swf模块,用于资源存取 
		 */		
		public var inSwf:Swf;
		
		/**
		 *传入当前UI的SWF模块 
		 * @param swfname
		 * @param swf
		 * 
		 */		
		protected function initSwf(swfname:String,swf:Swf):void{
		
			inSwf=swf;
		
		}
		
		override protected function initData():void
		{
			// TODO Auto Generated method stub
			super.initData();
			
			
			swfUIChildTable=new Object();
			despDict=new Dictionary();
			skipChildMediators=[];
			defaultflatten=false;
		}
		
		
		
		
		
		override public function initialize():void
		{
			// TODO Auto Generated method stub
			super.initialize();

			
			
			if(this.viewid!=null){
				viewbase.name=this.viewid;
			}
			
			
			if(this.binited==false){
				setTimeout(loadSWFView,1)
			}
			else{
				setTimeout(afterViewInited,1);
			}
			
			
		}
		
		
		
		
		
		
		
		/**
		 *加载swf及子元件mov到scen 
		 * 
		 */		
		private function loadSWFView():void{
			
			if(viewid==null)return;
			if(isviewloading)return;
			
			isviewloading=true;
			dispEventType(Static_Event.EVENT_LZM_SWF_LOAD,
				[Static_Type.SWFUI_LOAD_TOVIEWID,viewid,inj_view,initSwf]);
		}
		
		
		
		override public function initViewEvent():void
		{
			// TODO Auto Generated method stub
			super.initViewEvent();
			
			addViewListener(TouchEvent.TOUCH,onTouchEvent);
			
			addViewListener(Static_Event.EVENT_VIEW_INITED,onViewInited);
			
			
			
		}
		
		override protected function onAddToStage(e:Event):void
		{
			// TODO Auto Generated method stub
			super.onAddToStage(e);
			
			initViewEvent()
			
		}
		
		override protected function onRemoveStage(e:Event):void
		{
			// TODO Auto Generated method stub
			if(bMovingChild)return;
			
			super.onRemoveStage(e);
			
//			removeViewListeners();
			
			removeViewListerner();
		}
		
		protected function removeViewListerner():void
		{
			// TODO Auto Generated method stub
			
		}		
		
		override protected function afterinit():void
		{
			// TODO Auto Generated method stub
//			super.afterinit();
			
//			binited=true;
			
			
		}
		
		/**
		 *得到当前所处的模块id 
		 * @return 
		 * 
		 */		
		protected function getParentModuleid():String{
		
			
			var moduleparent:Med_ScenUIBase=getModuleParent();
			
			
			if(moduleparent){
				return (moduleparent as Med_ScenUIBase).moduleid;
			}
			
			return null
		
		}
		
				
			
		
		
		
		
		
		
		
		
		protected function onViewInited(e:Event):void
		{
			// TODO Auto Generated method stub
			
			this.isviewloading=false;
			
			afterViewInited();
			
		}
		
		
		
		
		
		
		 public function afterViewInited():void
		{
			// TODO Auto Generated method stub
			
			 inviewChild_SwfMovieClip=(inj_view as SwfUIBaseForGameLegs).inview as SwfMovieClip;
			 if(inviewChild_SwfMovieClip.name==null){
				 inviewChild_SwfMovieClip.name=this.viewid+"_inview"
			 }
			 
			syncViewChild(inviewChild_SwfMovieClip as SwfSprite)
			
			
			
			if(defaultflatten){
				(inj_view as SwfUIBaseForGameLegs).flatten();
			}
			
			super.afterinit();
			
		}
		 
		 
		 
		 
		 
		public var defaultflatten:Boolean;
		 
		
		
		
		
		
		
		
		/**
		 *触摸事件 
		 * @param e
		 * 
		 */		
		protected function onTouchEvent(e:TouchEvent):void
		{
			// TODO Auto Generated method stub
			/*var mytouch:Touch=e.getTouch(kaisyx,TouchPhase.ENDED);
			
			if(mytouch){
			
			trace("start")
			
			dispEventType(Static_Event.EVENT_SCEN_CHANGE,
			[Static_Type.VIEW_SCENFADEIN,Static_Type.VIEW_UIMAIN])
			
			}*/
			
			for (var i:int = 0; i < e.touches.length; i++) 
			{
				var touch:Touch=e.touches[i];
				
				if(touch.phase!=TouchPhase.BEGAN)continue;
				var touchtarget:DisplayObject=touch.target;
				
				
				if(touchtarget.name&&(touchtarget.name.indexOf("button_")==0||touchtarget.name.indexOf("btn_")==0)){
					if(touchtarget is SwfMovieClip){
						(touchtarget as SwfMovieClip).loop=false;
						(touchtarget as SwfMovieClip).gotoAndPlay(2);
					}
				
				}
				
			}
			
			
			
		}		
		
		
		
		
		
		
		
		
		/**
		 *如果是有swfmovieid的会接收创建事件 
		 * @param e
		 * 
		 */		
		private function onCreateView(e:Robert2CommandEvent):void
		{
			// TODO Auto Generated method stub
			/*if(this.swfmovieid==null)return;
			
			
			if(e.data[0]==this.swfassetid&&e.data[1]==this.swfmovieid){
			
				creatSWFUI();
			}*/
			
			
			
		}		
		
		
		
		protected var aligntype:int;
		
		/**
		 *有错误的子对像组 
		 */		
		private var errorChildkeys:Array;
		
		override protected function onData_Change(e:Robert2CommandEvent):void
		{
			// TODO Auto Generated method stub
			
			if(bChildViewSynced==false)return;
//			if(inj_view.stage==null)return;
//			if(inj_view.visible==false)return;
			
			super.onData_Change(e);
		}
		
		
		
		
		
		/**
		 *当前显示对像是否己经同步过所有子对像 
		 */		
		protected var bChildViewSynced:Boolean;
		
		
		private var cachedMedpoole:Dictionary;
		
		protected function syncViewChild(swfUI:SwfSprite):void
		{
			// TODO Auto Generated method stub
			errorChildkeys=[];
			
			cachedMedpoole=new Dictionary();
			
			if(swfUI is SwfMovieClip){
				var swfmov:SwfMovieClip=swfUI as SwfMovieClip;
				var movframes:int=swfmov.totalFrames;
				var maskframe:int=50;
				maskframe=Math.min(maskframe,movframes);
				
				for (var i:int = 0; i < maskframe; i++) 
				{
					swfmov.gotoAndStop(i);
					_syncViewChildFrame(swfmov);
					
				}
				
				swfmov.gotoAndStop(0,false);
			
			}
			else{
				_syncViewChildFrame(swfUI);
			}
			
			cachedMedpoole=null;
			
			bChildViewSynced=true;
			
			
		}		
		
		/**
		 *保存所有的传入资源的子对像 
		 */		
		protected var swfUIChildTable:Object;
		
		
		/**
		 *查找传入的swf对像内的显示对像 
		 * @param name
		 * @return 
		 * 
		 */		
		public function getSwfUIChildByName(name:String):DisplayObject{
		
//			var disp:DisplayObject;
			
			if(swfUIChildTable.hasOwnProperty(name)){
				return swfUIChildTable[name];
			}
			
			return null;
		
		}
		
		
		/**
		 *给某一侦检查 
		 * @param swfUI
		 * 
		 */		
		private function _syncViewChildFrame(swfUI:SwfSprite,usecache:Boolean=true):void
		{
			// TODO Auto Generated method stub
			var despay:Array=__despSwfUI(swfUI,usecache);
			
			
			
			for (var i:int = 0; i < despay.length; i++) 
			{
				var despobj:Object=despay[i];
				
				 
				
				var child:DisplayObject=swfUI.getChildByName(despobj.name);
				if(child==null)continue;
				if(cachedMedpoole[child]==true){
					child.name;
					continue;
				}
				cachedMedpoole[child]=true;
				
				
			/*	if((child==null)&&(usecache==true)){
				
					_syncViewChildFrame(swfUI,false);
					return;
				}
				else */
					
				if(child==null){
					
					continue;
				}
				
				if(child is SwfMovieClip){
					
					(child as SwfMovieClip).gotoAndStop(0);
//					(child as SwfMovieClip).flatten();
				}
				else if(child is SwfImage){
					
//					(child as SwfImage).smoothing=TextureSmoothing.NONE;
					(child as SwfImage).touchable=false;
				}
				
				if(despobj.name=="")continue;
				if(skipChildMediators.indexOf(despobj.name)>=0)continue;
				swfUIChildTable[despobj.name]=child;
				
				
				
				
				
				if(this.hasOwnProperty(despobj.name)){
					
					this[despobj.name]=child;
				}
				else{
					if(errorChildkeys.indexOf(despobj.name)==-1){
						if(despobj.name.indexOf("num")!=0){
							errorChildkeys.push(despobj.name);
							trace("[Warning]=========("+despobj.name+")==========("+getQualifiedClassName(child)+")<==== 父对像(*"+child.parent.name+")Mediator里不包含的 子对像 ,可能是没有写入或者是需要跳过的_类型")
						
						}
					}
					else{
						continue;
					}
					
					continue;
				}
				
				if(child is TextField){
					child.visible=false;
				}
				if(despobj.name==null)continue;
				if(despobj.name.indexOf("_")==0)continue;
				
				if((despobj.name.indexOf("button_")==0)||(despobj.name.indexOf("btn_")==0)){
					if(despobj is SwfMovieClip){
						despobj["stop"]();
					}
					(child as Sprite).touchable=true;
					(child as Sprite).touchGroup=true;
					
					continue;
				}
				if(despobj.name.indexOf("mask_")==0){
					(child as Sprite).touchable=false;
					(child as Sprite).touchGroup=true;
					
					continue;
				}
				
				if(despobj.name.indexOf("img_")==0)continue;
				if(child is TextField)continue;
				if(child is SwfImage)continue;
				
				if(despobj.name.indexOf("numdouble")>0)continue;
				if(despobj.name.indexOf("num")==0)continue;
//				if(despobj.name.indexOf("comp_")!=0)continue;
				
					getChildMediator(child);
				
			}
		}
		
		/**
		 *可以手动指定本mediator 不处理的子对像 
		 */		
		protected var skipChildMediators:Array;
		
		
		/**
		 *得到子元件的mediator 
		 * @param disp
		 * 
		 */		
		protected function getChildMediator(disp:DisplayObject):void{
		
				if(this.viewid==null){
					throw new Error("类的Viewid 还没有值:"+getQualifiedClassName(this));
				}
				 
				var aliname:String=[disp.name.replace("comp_","")].join(".");
				
				if(errorChildkeys.indexOf(aliname)>=0)return;
				
				var medinst:Object=getViewMediator(disp,aliname);
				
				if(medinst==null){
					errorChildkeys.push(aliname);	
					try
					{
					
						trace("查找对像:("+aliname+") 的mediator失败, class:",disp,"Parentname:",disp.parent.name+"<="+disp.parent.parent["classLink"],"没有生成的Mediator 或 是未设为 _私有! ");
					} 
					catch(error:Error) 
					{
						
						trace("查找对像:("+aliname+") 的mediator失败, class:",disp,"Parentname:",disp.parent["classLink"]);		
					}
				}
				else{
					
					if(medinst is MediatorSGameBase){
					
						(medinst as MediatorSGameBase).parentMediator=this;
					
					}
					
					if(medinst is Med_SWFUIChildBase){
//						medinst[inSwf]=inSwf;
					}
				}
		}
		
		
		
		/**
		 *切换显示对像或动画的显示状态 
		 * @param disp
		 * @param visible
		 * @param frameindex
		 * @param stopchild
		 * 
		 */		
		protected function switch_child(disp:DisplayObject, visible:Boolean, frameindex:int, stopchild:Boolean,touchchildenable:Boolean=true):void
		{
			// TODO Auto Generated method stub
			if(disp==null){
				trace("[WARN]"+viewid+"中找到己删除的元件");
				return;
			}
			
			disp.visible=visible;
			
			if(disp is SwfMovieClip){
				if(stopchild){
					(disp as SwfMovieClip).stop(stopchild)
				}
				else{
					(disp as SwfMovieClip).gotoAndStop(frameindex,true);
					
				}
			}
			if(disp as Sprite){
				(disp as Sprite).touchGroup=!touchchildenable;
			}
			
		}	
		
		
		private static var despDict:Dictionary;
		
		/**
		 * 
		 * @param disp
		 * @return 
		 * 
		 */		
		private static function despSwfUI(indisp:DisplayObjectContainer,usecache:Boolean):Array{
			
			var outay:Array=[];
			
			var dispswf:SwfMovieClip=indisp as SwfMovieClip;
			if(dispswf){
				var dispchildsobj:Object=dispswf.getDisplayobjects();
				var dispdict:Object={};
				
				for each(var dispay:Array in dispchildsobj){
					var selfayobj:Object={};
					for (var i:int = 0; i < dispay.length; i++) 
					{
						var child:DisplayObject=dispay[i] as DisplayObject;
						
						var childobj:Object={};
						
						if(child is SwfMovieClip){
							
							childobj.type="SwfMovieClip";
						}
						else if(child is SwfSprite){
							
							childobj.type="SwfSprite";
						}
						else  if(child is Image){
							
							childobj.type="Image";
						}
						else  if(child is TextField){
							
							childobj.type="TextField";
						}
						else {
							
							childobj.type="NA";
						}
						
						
						
						if(dispdict[child.name]==null){
							
							
							if(child.name!=null&&child.name!=""){
								dispdict[child.name]=true;
							}
						}
						else{
							
							/*if(selfayobj[child.name]!=null){
								continue;
							}
							selfayobj[child.name]=child;*/
							if(child.name!=null&&child.name!=""){
								
								trace("[Error]在同一侦内出现两次的元件("+child.name+")	in parent:("+indisp.name+"),可能是美术起名重复或元件重叠 会导致Draw升级 或者是新机制带来的bug!")
							}
							
							
						}
						
						childobj.name=child.name;
						
						outay.push(childobj);
						
					}
					selfayobj={};
				}
			
			}
			else{
				outay=__despSwfUI(indisp,true);
			}
			return outay;
		}
			
		/**
		 * 
		 * @param disp
		 * @return 
		 * 
		 */		
		private static function __despSwfUI(disp:DisplayObjectContainer,usecache:Boolean):Array{
			
			if(disp.hasOwnProperty("classLink")&&usecache){
			
				/*var dictay:Array=despDict[disp["classLink"]];
				
				if(dictay){
					return dictay;
				}*/
				
			}
			
			var dispnum:int=disp.numChildren;
			
			var outay:Array=[];
			var dispdict:Object={};
			
			for (var i:int = 0; i < dispnum; i++) 
			{
				var child:DisplayObject=disp.getChildAt(i);
				
				var childobj:Object={};
				
				if(child is SwfMovieClip){
					
					childobj.type="SwfMovieClip";
				}
				else if(child is SwfSprite){
					
					childobj.type="SwfSprite";
				}
				else  if(child is Image){
					
					childobj.type="Image";
				}
				else  if(child is TextField){
					
					childobj.type="TextField";
				}
				else {
					
					childobj.type="NA";
				}
				if(dispdict[child.name]==null){
					if(child.name!=null&&child.name!=""){
						dispdict[child.name]=true;
					}
				}
				else{
					if(child.name!=null&&child.name!=""){
						
						trace("[Error]在同一侦内出现两次的元件("+child.name+"in parent:"+disp.name+"),可能是美术起名重复或元件重叠 会导致Draw升级!")
					}
					
					
				}
				
				childobj.name=child.name;
				
				outay.push(childobj);
			}
			outay["classLink"]=disp["classLink"];
//			despDict[disp["classLink"]]=outay;
			
			
			return outay;
		}
		
		
		
		
		protected function layoutSwfUI():void{
			 
			if(aligntype==AlignType.leftTop){
//				var getbound:Rectangle=swfUI.getBounds(inj_view);
				inj_view.x=0//(Static_Config.DESIGNWIDTH-swfUI.width)/2+getbound.x;
				inj_view.y=0//(Static_Config.DESIGNHEIGHT-swfUI.height)/2+getbound.y;
			} 
			  
			  
		}
		
		public var bgmusicid:String;
		
		public function sound_playbg():void{
		
			if(bgmusicid){
				dispEventType(Static_Event.EVENT_SOUNDCHANGE,[Static_Type.SOUNDCHANGE_PLAYBG,bgmusicid]);
			}
				
				
		}
		
		public function sound_playeffect(musicid:String):void{
		
			dispEventType(Static_Event.EVENT_SOUNDCHANGE,[Static_Type.SOUNDCHANGE_PLAYEFFECT,musicid]);
			
			
		}
		
		
		
		
		
		
		
		
		
		
		
		/*
		override protected function addViewListener(EventType:String, EventCallFunction:Function):void
		{
			// TODO Auto Generated method stub
			super.addViewListener(EventType, EventCallFunction);
		}
		
		override public function afterinitEvent():void
		{
			// TODO Auto Generated method stub
			super.afterinitEvent();
			
			
			
			
		}*/
		
		/**
		 *生成一个list 坐标可换 
		 * @param swfid
		 * @param listid
		 * @param replaceitem
		 * @return 
		 * 
		 */		
		protected function init_UIExtendList(swfid:String,listid:String,parent:DisplayObjectContainer,replaceitem:DisplayObject=null):UIExtendList
		{
			// TODO Auto Generated method stub
			
			var outlist:UIExtendList=res_getList(swfid,listid);
			if(replaceitem){
				
				outlist.x=replaceitem.x;
				outlist.y=replaceitem.y;
				
			}
			parent.addChild(outlist);
			
			return outlist;
		}		
		
		
		
		
		/**
		 *生成一个列表 
		 * @param packswfid 列表所需资源swf
		 * @param listid 列表配置id
		 * @return 
		 * 
		 */		
		protected function res_getList(packswfid:String,listid:String):UIExtendList{
			
			var list:UIExtendList
			list=new UIExtendList();
			list.listid=listid;
			list.inj_Swf=inj_Model_GameData.manResource.getSwfByName(packswfid);
			
			var dataconfig:Object=GameConfig_UIlist;
			
			var listconfig:Object=ConfigDataHelper.getKeyArrayObject(dataconfig.dataObjects,dataconfig.keylist,dataconfig.fieldlist,listid);
			
			
			list.setData(listconfig);
			
			return list;
		}	
		
		/**
		 *得到己加载的swf里的显示资源 
		 * @param swfpack
		 * @param resname
		 * @return 
		 * 
		 */		
		protected function res_getSwfDisplay(swfpack:String, resname:String):DisplayObject
		{
			// TODO Auto Generated method stub
			var swf:Swf=inj_Model_GameData.manResource.getSwfByName(swfpack);
			var disp:DisplayObject=swf.createDisplayObject(resname);
			return disp;
		}		
		
		
		
		
		/**
		 *把当前的swf  inviewChild_SwfMovieClip 从top移除
		 * 
		 */		
		protected function hideSwfChildFromTop():void
		{
			// TODO Auto Generated method stub
			//			inviewChild_SwfMovieClip.visible=false;
			
			dispDataChange_Event(Static_Type.UIEFFECT_REMOVEWINDOW,[inviewChild_SwfMovieClip]);
			
		}
		
		
	}
}