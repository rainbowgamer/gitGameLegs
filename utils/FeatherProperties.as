package  utils
{
	public class FeatherProperties
	{
		public function FeatherProperties()
		{
		}
		
		public static function set_ObjectValue(valuename:String,dataay:Array,valueobj:Object=null):Object{
		
				var obj:Object;
				if(valueobj==null){
					obj=new Object();
				}
				else{
					obj=valueobj;
				}
				var keyay:Array;
				if(valuename=="itemRendererProperties"){
					keyay="labelField,itemmc".split(",");
				}
				else if(valuename=="listlistlayout"){
					keyay="gap".split(",");
				}
				else if(valuename=="listtextFormat"){
					keyay="font,size,color".split(",");
				}
				else if(valuename=="listscrollerProperties"){
					keyay="horizontalScrollPolicy,verticalScrollPolicy".split(",");
				}
		
				
				for (var i:int = 0; i < keyay.length; i++) 
				{
					var key:String=keyay[i];
					
					obj[key]=dataay[i];
					
				}
				
				
			return obj;
		}

		
		
	}
}