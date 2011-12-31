package utils
{
	
	/**
	 *配置文件数据助手 
	 * @author zhouhua
	 * 
	 */
	public class ConfigDataHelper
	{
		public function ConfigDataHelper()
		{
		}
		
		/**
		 *得到一条数据的key-v对像 
		 * @param clientdataay
		 * @param fieldid
		 * @return 
		 * 
		 */		
		public static function buildObjectItem(clientdataay:Array, fieldid:Array):Object
		{
			var outobj:Object={};
			for (var j:int = 0; j < fieldid.length; j++) 
			{
				var key:String=fieldid[j];
				outobj[key]=clientdataay[j];
			}
			
			return outobj
		}
		
		
		
		/**
		 *把数组和字段名组 组合成对像数组  得到多条数据的kv对像
		 * @param clientdataay
		 * @param fieldid
		 * @return 
		 * 
		 */		
		public static function buildObjectArray(clientdataay:Array, fieldid:Array):Array
		{
			// TODO Auto Generated method stub
			var outay:Array=[];
			
			for (var i:int = 0; i < clientdataay.length; i++) 
			{
				var clientline:Array=clientdataay[i];
				var outobj:Object=buildObjectItem(clientline,fieldid);
				
				outay.push(outobj);
			}
			
			return outay;
		}
		
		
		/**
		 *得到转换后的keyobj listay 
		 * @param potions
		 * @param keylist
		 * @return 
		 * 
		 */		
		public static function buildKeyObjectArray(dataobjs:Object, keylist:Array,pushheadkey:Boolean):Array
		{
			// TODO Auto Generated method stub
			var output:Array=[];
			
			for (var i:int = 0; i < keylist.length; i++) 
			{
				var key:*=keylist[i];
				var value:*=dataobjs[key];
				
				if(pushheadkey && value is Array){
					value=(value as Array).concat([]);
					
					(value as Array).unshift(key);
				}
				output.push(value);	
			}
			return output;
		}
		
		
		
		/**
		 *得到配置表中某一个field对应的所有数据 
		 * @param datalist
		 * @param keylist
		 * @param fieldlist
		 * @param keyid
		 * @return 
		 * 
		 */		
		public static function getKeyArrayObject(datalist:Object, keylist:Array, fieldlist:Array, keyid:String):Object
		{
			// TODO Auto Generated method stub
			var outresult:Object;
			
			var obj:Array;
			
			obj=ConfigDataHelper.buildKeyObjectArray(datalist,keylist,true);
			
			var keyobj:Array=ConfigDataHelper.buildObjectArray(obj,fieldlist);
			
			for (var i:int = 0; i < keyobj.length; i++) 
			{
				var keylistitem:Object=keyobj[i];
				if(keylistitem[fieldlist[0]]==keyid){
					return keylistitem
				}
			}
			return outresult;
		}
		
		
		/**
		 *从key更新数据组内容 
		 * @param clientdata 对像数组
		 * @param keylabel
		 * @param taskay
		 * @return 
		 * 
		 */		
		public static function replaceDataWithkeyArray(clientdata:Array, keylabel:String, taskay:Array):Array
		{
			// TODO Auto Generated method stub
			for (var i:int = 0; i < clientdata.length; i++) 
			{
				var dataobj:Object=clientdata[i];
				dataobj[keylabel]=taskay[i];
			}
			return clientdata;
		}
	}
}