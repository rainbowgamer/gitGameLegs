package utils
{
	public class ArrayUtils
	{
		public function ArrayUtils()
		{
		}
		
		
		/**
		 *合并两个数组 
		 * @param outay
		 * @param stateay
		 * @return 
		 * 
		 */		
		public static function recombdaystateay(outay:Array,stateay:Array):Array
		{
			// TODO Auto Generated method stub
			for (var i:int = 0; i < stateay.length; i++) 
			{
				
				var dayay:Array=stateay[i];
				
				var outday:Array=outay[i];
				
				if(outday==null){
					outday=dayay
					outay.push(outday);
				}
				else{
					outday=outday.concat(dayay);
				}
				outay[i]=outday;
			}
			return outay;
		}
		
		public static function convertTimeRand(stateid:String, timernd:Array):Array
		{
			// TODO Auto Generated method stub
			for (var i:int = 0; i < timernd.length; i++) 
			{
				var dayay:Array=timernd[i]
				var nday:Array=[];
				for (var j:int = 0; j < dayay.length; j++) 
				{
					var dayitem:int=dayay[j]
					
					if(dayitem==1){
						
						nday.push(stateid);
					}
					
				}
				
				timernd[i]=nday;
			}
			
			return timernd;
		}
		
		public static function gettimernd(timetime:int, timelen:int, maxday:int):Array
		{
			// TODO Auto Generated method stub
			
			var typeay:Array=[];
			
			while(typeay.length<maxday){
				var tempay:Array=getTempAy(timetime,timelen);
				typeay=typeay.concat(tempay);
			}
			return typeay;
		}
		
		public static function getTempAy(timetime:int, timelen:int):Array
		{
			// TODO Auto Generated method stub
			
			var outay:Array=[];
			var dayay:Array=[];
			if(timelen==1){
				for (var j:int = 0; j < timetime; j++) 
				{
					dayay.push(1);
				}
				outay.push(dayay);
			}
			else{
				
				var count:int=timetime;
				
				while(outay.length<timelen){
					
					
					if(count>0){
						
						dayay=[1];
					}
					else{
						dayay=[0];
					}
					outay.push(dayay);
					count--;
					
				}
				
				
				
			}
			
			
			
			outay=ArrayUtils.randArray(outay);
			
			
			return outay;
		}
		
		
		
		/**
		 *打乱数组 
		 * @param myArr
		 * @return 
		 * 
		 */		
		public static function randArray(myArr:Array):Array{
			var rnd:int;
			var tmp:*;
			var len:int = myArr.length;
			for(var i:uint = 0;i<len;i++){
				tmp = myArr[i];
				rnd = Math.random()*len;
				myArr[i] = myArr[rnd];
				myArr[rnd] = tmp;
			}
			return myArr;
		}
		
		
		
		/**
		 *在数组里随机找一个 
		 * @param array
		 * @return 
		 * 
		 */		
		public static function getRandItem(array:Array):*{
		
			var len:int=array.length;
			var ran:int=int(Math.random()*len);
			
			var item:*=array[ran];
		
			return item;
		}
		
		/**
		 *得到字串数组 
		 * @param str
		 * @param split
		 * @return 
		 * 
		 */		
		public static function getStringAy(str:String,split:String=","):Array{
		
			return str.split(split);
		}
		
		/**
		 *得到字串数组中的索引 
		 * @param str
		 * @param index
		 * @param split
		 * @return 
		 * 
		 */		
		public static function getStingAyIndex(str:String,index:int,split:String=","):*{
		
			var ay:Array=getStringAy(str,split);
			
			return ay[index];
			
		}
		
		/**
		 *从字串中数组取 
		 * @param str
		 * @param split
		 * @return 
		 * 
		 */		
		public static function getStingAyRandom(str:String,split:String=","):*{
			
			var ay:Array=getStringAy(str,split);
			
			var randitem:*=getRandItem(ay);
			
			return randitem;
			
		}
		
		
		/**
		 *以某个字段索引 字段值 搜索相关条目  单条返回
		 * @param fieldindex
		 * @param fieldvalue
		 * @return 
		 * 
		 */		
		public static function searchfieldItem(array:Array,fieldindex:int,fieldvalue:String):*{
			
			var outay:Array=[];
			
			var dataaylen:int=array.length;
			
			
			for (var i:int = 0; i < dataaylen; i++) 
			{
				var dataobj:*=array[i];
				
				var datavalue:*=dataobj[fieldindex];
				
				if(datavalue==fieldvalue){
					
					return dataobj
				}
				
			}
			
			
			
			
			return null;
		}
		
		
		/**
		 *得到数组里某个索引位对应的所有元件 合成数组 
		 * @param param0
		 * @param param1
		 * @return 
		 * 
		 */		
		public static function getArrayFieldIndexAy(dataay:Array, fieldindex:int):Array
		{
			// TODO Auto Generated method stub
			var outay:Array=[];
			for (var i:int = 0; i < dataay.length; i++) 
			{
				var item:*=dataay[i];
				var itemvalue:*=item[fieldindex];
				
				outay.push(itemvalue);
			}
			
			return outay;
		}
	}
}