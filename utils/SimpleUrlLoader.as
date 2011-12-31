package utils
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	/**
	 *简易加载器 
	 * @author zhouhua
	 * 
	 */	
	public class SimpleUrlLoader extends URLLoader
	{
		
		
		public function SimpleUrlLoader(url:String,backevefun:Function,backerrfun:Function,dataformat:String=null,delay:int=0)
		{
			var request:URLRequest=new URLRequest(url);
			this.addEventListener(Event.COMPLETE,backevefun);
			this.addEventListener(IOErrorEvent.IO_ERROR,backerrfun);
			super();
			dataFormat=dataformat;
			if(dataFormat==null){
				this.dataFormat=URLLoaderDataFormat.BINARY;
			}
			trace("SimpleFileLoader:",url)
			if(delay==0){
				this.load(request);
			}
			else{
				setTimeout(this.load,delay,request);
			}
		}
		
		
		
		
	}
}