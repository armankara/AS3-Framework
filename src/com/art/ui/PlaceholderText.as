package com.art.ui 
{
	import flash.events.FocusEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Arman Kara
	 */
	public class PlaceholderText 
	{
		private var placeHolder:String;
		private var tf:TextField;
		public function PlaceholderText(_tf:TextField, _placeholder:String) 
		{
			if (!_tf.hasEventListener(FocusEvent.FOCUS_IN) && !_tf.hasEventListener(FocusEvent.FOCUS_OUT))
			{
				tf = _tf;
				placeHolder = _placeholder;
				tf.addEventListener(FocusEvent.FOCUS_IN, onFucusIn);
				tf.addEventListener(FocusEvent.FOCUS_OUT, onFucusOut);
			}
		}		
		
		public function onFucusIn(e:FocusEvent = null):void 
		{
			if (tf.text == placeHolder)
				tf.text = "";
		}
		
		public function onFucusOut(e:FocusEvent = null):void 
		{
			if (tf.text == "")
				tf.text = placeHolder;
		}
	}
}