package gamelegs.utils
{
	import flash.utils.getQualifiedClassName;

	public class ClassUtils
	{
		public function ClassUtils()
		{
		}
		
		/**
		 *得到类或对像的类全名 
		 * @param classobj
		 * @return 
		 * 
		 */		
		public static function getObjectClassFullName(classobj:Object):String{
		
			var classname:String=getQualifiedClassName(classobj);
			
			return classname;
		}
		
		/**
		 *得到一个类的短名 
		 * @param classobj
		 * @return 
		 * 
		 */		
		public static function getShortClassName(classobj:Object):String{
		
			var fullclassname:String=getObjectClassFullName(classobj);
			
			var shortname:String=fullclassname.split("::")[1];
			
			return shortname;
		}
		
	}
	
}