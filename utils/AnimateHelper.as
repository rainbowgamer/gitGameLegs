package utils
{
	import flash.utils.setTimeout;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.text.TextField;

	public class AnimateHelper
	{
		public function AnimateHelper()
		{
		}
		
		public static function showinfo(txtf:TextField,dispview:DisplayObject,info:String,intime:int=500,showtime:int=2500,outtime:int=500):void
		{
			// TODO Auto Generated method stub
			txtf.text=info
			dispview.visible=true;
			dispview.alpha=0;
			
			
			function hideStage():void{
				
				
				dispview.alpha=1;
				
				var eff2:Tween=new Tween(dispview,intime/1000);
				
				eff2.animate("alpha",0);
				
				eff2.onComplete=function():void{
					
				}
				
				Starling.juggler.add(eff2);
				
				
			}
			
			
			
			
			
			var eff:Tween=new Tween(dispview,outtime/1000);
			
			eff.animate("alpha",1);
			
			eff.onComplete=function():void{
				
				setTimeout(hideStage,showtime)
			}
			
			Starling.juggler.add(eff);
			
			
			
		}		
		
		
		
	}
}