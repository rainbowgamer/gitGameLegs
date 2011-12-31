package utils
{

	//import simple2d.primitives.Vector_2D;
	/**
	 通过两个端点定义一个简单的线段
	 */
	public class MathUtils{
		//顺次连结p1,p3,p2,p4,如果是一个凸四边形则有交点,否则没有
		public static function intersects(p1,p2,p3,p4):Boolean{
			//trace("未优化");
			tp1.x=p3.x-p1.x;
			tp1.y=p3.y-p1.y;
			tp2.x=p2.x-p3.x;
			tp2.y=p2.y-p3.y;
			var num1:Number=cross_(tp1,tp2);
			tp3.x=p4.x-p2.x;
			tp3.y=p4.y-p2.y;
			var num2:Number=cross_(tp2,tp3);
			if(num1*num2<0){
				return false;
			}
			tp4.x=p1.x-p4.x;
			tp4.y=p1.y-p4.y;
			var num3:Number=cross_(tp3,tp4);
			if(num2*num3<0){
				return false;
			}
			var num4:Number=cross_(tp4,tp1);
			if(num3*num4<0){
				return false;
			}
			return true;
		}
		
		//p1-p2和p3-p4两直线交点
		public static function intersection(p1,p2,p3,p4):Vector2D{
			//trace("未优化");
			var cp13:Number=cross_(p1,p3);
			var cp24:Number=cross_(p2,p4);
			var cp32:Number=cross_(p3,p2);
			var cp41:Number=cross_(p4,p1);
			var cp34:Number=cross_(p3,p4);
			var k:Number=(cp13+cp34+cp41)/(cp13+cp24+cp32+cp41);
			return new Vector2D(p1.x+(p2.x-p1.x)*k,p1.y+(p2.y-p1.y)*k);
			//return Vector2D.interpolate(p2,p1,k);
		}
	}
}