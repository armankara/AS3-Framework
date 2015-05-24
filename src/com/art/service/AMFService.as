package com.art.service 
{
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.external.ExternalInterface;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	/**
	 * ...
	 * @author Arman Kara
	 */
	public class AMFService extends EventDispatcher 
	{
		private var connection:NetConnection;
		private var Gateway:String;
		private var RemoteClass:String;
		
		public function AMFService(Gateway:String, RemoteClass:String)
		{
			if(Gateway == null)
				throw new Error("The gateway parameter is required in the ServiceProxy class.");
			
			this.Gateway = Gateway;
			this.RemoteClass = RemoteClass;
			
			connection = new NetConnection();
			connection.client = this;
			connection.addEventListener(NetStatusEvent.NET_STATUS, onConnectionStatus);
			connection.addEventListener(IOErrorEvent.IO_ERROR, onConnectionError);
			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR , onConnectionError);
			connection.objectEncoding = ObjectEncoding.AMF3;
			connection.connect(Gateway);
		}
		
		protected function onConnectionStatus(e:NetStatusEvent):void
		{
			if (e.info.code == "NetConnection.Connect.Failed")
				onError();
			else
				onConnected();
		}
		
		private function onConnectionError(e:ErrorEvent):void
		{
			onError();
		}
		
		protected function onConnected():void { }
		protected function onError():void { }
		
		protected function call(RemoteMethod:String, responder:Responder, ...rest):void
		{
			connection.call.apply(null, [RemoteClass + "." + RemoteMethod, responder].concat(rest));
		}
		
		public function Trace(...rest):void
		{
			trace(rest);
			if (ExternalInterface.available)
				ExternalInterface.call("console.log", rest);
		}
	}
}