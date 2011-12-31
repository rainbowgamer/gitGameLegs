/***
Vector2D 版本:v1.0 mod by zhouhua

*/
package  utils.trigs{
	import flash.errors.*;
	import flash.geom.Point;

	public class Vector2D{
		private static var tp1:Vector2D=new Vector2D();
		private static var tp2:Vector2D=new Vector2D();
		private static var tp3:Vector2D=new Vector2D();
		private static var tp4:Vector2D=new Vector2D();//减少一些函数要new的Vector2D
		
		//配合MsgBar使用的东西public static var totalVector2D:int=0;
		public static function distance(v1,v2):Number{
			var dx:Number=v1.x-v2.x;
			var dy:Number=v1.y-v2.y;
			return Math.sqrt(dx*dx+dy*dy);//147毫秒
			//return subtract_(v1,v2).length;//553毫秒
		}
		
		public static function polar(len:Number,radian:Number):Vector2D{
			return new Vector2D(len*Math.cos(radian),len*Math.sin(radian));
		}
		
		public var x:Number;
		public var y:Number;
		
		public function Vector2D(vx:Number=0,vy:Number=0){
			x=vx;
			y=vy;
			
			//配合MsgBar使用的东西if(totalVector2D==0){
				//配合MsgBar使用的东西MsgBar.addCheck(Vector2D,"totalVector2D");
			//配合MsgBar使用的东西}
			//配合MsgBar使用的东西totalVector2D++;//统计新建多少个Vector2D
			//trace("totalVector2D="+(++totalVector2D));
		}
		public function get length():Number{
			//求模
			return Math.sqrt(x*x+y*y);
		}
		public function clone():Vector2D{
			//复制
			return new Vector2D(x,y);
		}
		public function copyFrom(v):void{
			//trace("copyFrom不要频繁使用");
			x=v.x;
			y=v.y;
		}
		public function setValues(_x:Number,_y:Number):void{
			//trace("setValues不要频繁使用");
			x=_x;
			y=_y;
		}
		
		//标准化 
		public static function normalize_(v:Vector2D,len:Number):Vector2D{
			v=v.clone();
			v.normalize(len);
			return v;
		}
		public function normalize(len:Number=1):void{
			var len_2:Number=x*x+y*y;
			if(len_2==0){
				return;
			}
			var k:Number=len/Math.sqrt(len_2);
			x*=k;
			y*=k;
		}
		
		//判断相等
		public function equals(toCompare:Object):Boolean{
			//trace("equals不要频繁使用");
			return x==toCompare.x&&y==toCompare.y;
		}
		
		//偏移
		public function offset(dx:Number,dy:Number,dz:Number):void{
			//trace("offset不要频繁使用");
			x+=dx;
			y+=dy;
		}
		
		//相加
		public static function add_(v1,v2):Vector2D{
			return new Vector2D(v1.x+v2.x,v1.y+v2.y);
		}
		public function add(v):void{
			x += v.x;
			y += v.y;
		}
		
		//相减
		public static function subtract_(v1,v2):Vector2D{
			return new Vector2D(v1.x-v2.x,v1.y-v2.y);
		}
		public function subtract(v):void{
			x -= v.x;
			y -= v.y;
		}
		
		//数量积
		public static function mult_(v,s:Number):Vector2D{
			return new Vector2D(v.x * s, v.y * s);
		}
		public function mult(s:Number):void{
			x *= s;
			y *= s;
		}
		
		
		//点积
		public static function dot_(v1,v2):Number{
			return v1.x*v2.x+v1.y*v2.y;
		}
		public function dot(v):Number{
			return x * v.x + y * v.y;
		}
		
		//所谓的叉积
		public static function cross_(v1:Vector2D,v2:Vector2D):Number{
			return v1.x*v2.y-v2.x*v1.y;
		}
		public function cross(v):Number{
			return x * v.y - y * v.x;
		}
		
		//旋转radian弧度
		public function rotate(radian:Number):void {
			var c:Number = Math.cos(radian);
			var s:Number = Math.sin(radian);
			var xx:Number = x;
			var yy:Number = y;
			x = xx * c - yy * s;
			y = xx * s + yy * c;
		}
		
		//v1到v2的角
		public static function toRadian(v1,v2):Number{//v1,v2不定类型,所以可以是z被当成0的Vector3D
			//return Math.atan2(v1.cross(v2),v1.dot(v2));
			return Math.atan2(
				v1.x*v2.y-v2.x*v1.y,
				v1.x*v2.x+v1.y*v2.y
			);
		}
		/*
		public static function toRadianXY(x1:Number,y1:Number,x2:Number,y2:Number):Number{
			return Math.atan2(
				x1*y2-x2*y1,
				x1*x2+y1*y2
			);
		}
		*/
	
		//已知v1到v的角比v1到v2的角为k(k>=0&&k<=1),求v
		public static function getVByK(v1,v2,k:Number,v):void{
			if(k==0){
				v.x=v1.x;
				v.y=v1.y;
				//v.copyFrom(v1);
			}else if(k==1){
				v.x=v2.x;
				v.y=v2.y;
				//v.copyFrom(v2);
			}else if(k>0&&k<1){
				var t:Number=Math.tan(toRadian(v1,v2)*k);
				v.x=v1.x-t*v1.y;
				v.y=t*v1.x+v1.y;
				v.normalize();
			}else{
				throw new Error("k不正常,k="+k);
			}
		}
		
		public function simple(u:Number):void{
			//精确到u
			x=Math.round(x/u)*u;
			y=Math.round(y/u)*u;
		}
		
		//是否在p的右边
		public function isRight(p):Boolean{
			//return cross_(this,p)<0;
			return x*p.y-p.x*y<0;
		}
		
		//pArr为顺时针排列的一圈Vector2D(围成凸多边形),当this都在分别构成的向量的右边则表明this在凸多边形内)
		public function isInside(pArr:Array):Boolean{
			var i:int=0;
			var L:int=pArr.length;
			for each(var p1:* in pArr){
				if(++i>=L){
					L=0;
				}
				var p2:*=pArr[i];
				var x1:Number=x-p1.x;
				var y1:Number=y-p1.y;
				var x2:Number=p2.x-p1.x;
				var y2:Number=p2.y-p1.y;
				
				if(x2*y1-x1*y2<0){
					return false;
				}
				//if(tp2.isRight(tp1)){
					//return false;
				//}
				i++;
			}
			return true;
		}
		
		//得到垂直于this的向量(若this指向y轴正方向则得到x轴正方向)
		public function getMp(len:Number=1):Vector2D{
			var mp:Vector2D=new Vector2D(y,-x);
			mp.normalize(len);
			return mp;
		}
		public function getMpSet(v:Vector2D,len:Number):void{
			v.x=y;
			v.y=-x;
			v.normalize(len);
		}
		
		public static function getK(p,m,n):Number{
			//例:p=k1*m+k2*n,getK(p,m,n)求得的是k1,用getK(p,n,m)可求得k2
			//例:p=k1*m-k2*n,getK(p,n,m)求得的是-k2
			//return cross_(p,n)/cross_(m,n);
			return (p.x*n.y-n.x*p.y)/(m.x*n.y-n.x*m.y);
		}
		//得到p在p0上的投影(p平行p0的分量)
		public static function getHorizontal(p,p0):Vector2D{
			//var k:Number=dot_(p,p0)/(p0.x*p0.x+p0.y*p0.y);
			var k:Number=(p.x*p0.x+p.y*p0.y)/(p0.x*p0.x+p0.y*p0.y);
			return new Vector2D(p0.x*k,p0.y*k);
		}
		//得到p垂直p0的分量
		public static function getVertical(p,p0):Vector2D{
			trace("未优化");
			var rr:Number=(p0.x*p0.x+p0.y*p0.y);
			return new Vector2D(p0.y*cross_(p,p0)/rr, p0.x*cross_(p0,p)/rr);
		}
		
		//顺次连结p1,p3,p2,p4,如果是一个凸四边形则有交点,否则没有
		public static function intersects(p1:Point,p2:Point,p3:Point,p4:Point):Boolean{
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
		
		public function get rotation():Number{
			return Math.atan2(y,x)*(180/Math.PI);
		}
		public function get radian():Number{
			return Math.atan2(y,x);
		}
		
		public function toString():String{
			return "("+x+","+y+")";
			//return "("+Math.round(x*1000)/1000+","+Math.round(y*1000)/1000+")";
		}
	}
}