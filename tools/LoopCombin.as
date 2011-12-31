package tools
{
	
	/**
	 * CompositorX
	 * 超高效计算组合(个数太长了除外:)
	 * @author CYPL
	 */
	public class LoopCombin
	{
		private var _str : String;
		private var _comList : Array;
		
		/**
		 * @param str : String  需要进行组合的字串
		 */
		public function LoopCombin(str : String) {
			_str = str;
		}
		
		/**
		 * @param n :int 取组合长度
		 * @return Array 返回所有的組合
		 */
		public function getComList(n : int) : Array {
			if(n < 0 || n == 0 || n > _str.length) {
				throw new Error("参数不符合要求");
			}
			if(n == _str.length)return [_str];
			_comList=[];
			return fCom(_str.split(""), n);
		}
		
		private function fCom(items : Array,n : int) : Array {
			var numList : Array = [];
			var tempStr : String = "";
			
			for(var j : uint = 0;j < n;j++) {
				numList[j] = j + 1;
				tempStr += items[j];
			}
			
			var len : int = items.length;
			var p : int;
			var k : int = len - n;
			CYPL:
			while(true) {
				//trace(tempStr);
				_comList.push(tempStr);
				for(p = n - 1;numList[p] > p + k;) {
					p--;
					if(p < 0) {
						break CYPL;
					}
				}
				tempStr = tempStr.substr(0, p - n) + items[++numList[p] - 1];
				while(++p < n) {
					tempStr += items[(numList[p] = numList[p - 1] + 1) - 1];
				}
			}
			return _comList;
		}
	}
}