package com.parse
{
	import com.parse.intern.Encodable;
	
	import flash.globalization.DateTimeFormatter;
	import flash.net.URLRequestHeader;

	public final class ParseClient
	{
		private static const HOST_NAME:String = "https://api.parse.com";
		private const VERSION_STRING:String = 'as3-1.0.0';
		
		private static var _applicationId:String;
		private static var _restKey:String;
		private static var _masterKey:String;
		
		
		//-------------------------------------------
		// ESTATICOS
		//-------------------------------------------
		
		public static function initialize( appId:String, restKey:String, masterKey:String ):void
		{
			_applicationId = appId;
			_restKey = restKey;
			_masterKey = masterKey;
		}
		
		public static function encode(value:*, allowParseObject:Boolean = true):*
		{
			if( value is Date ){
				return { "__type": "Date", "iso": "" }
			}
			
//			if( value is ParseObject ){
//				if( ! allowParseObject ){
					throw new ParseError("ParseObjects not allowed here.");
//				} else {
//					return ParseObject(value).toPointer();
					
//				}
//			}
			
			if( value is Encodable ){
				return Encodable(value)._encode();
			}
			
			if( value is Array ){
				// return encodeArray(value, allowParseObject);
			}
			
			if( value !== null ){
				// verifica se é primitivo
				var isPrimitive:Boolean = true;
				if( ! isPrimitive ){
					throw new ParseError("Invalid type encountered.");
				}
			}
			
			return value;
		}
		
		public static function decode(data:*):*
		{
			if( data === null ) return null;
			
			var typeString:String = data.__type ? data.__type : null;
			
			
			return data;
		}
		
		public static function encodeArray(value:Array, allowParseObjects:Boolean = true):Object
		{
			var output:Object = {};
			for (var k:String in value) {
				output[k] = encode( value[k], allowParseObjects);
			}
			return output;
		}
		
		public static function request(method:String, relativeUrl:String, sessionToken:String = null, data:* = null, useMasterKey:Boolean = false):void
		{
			//TODO - metodo de request
		}
		
		public static function getRequestHeaders(sessionToken:String, useMasterKey:Boolean):URLRequestHeader
		{
			//TODO
			return new URLRequestHeader();
		}
		
		public static function getProperDateFormat(value:Date):String
		{
			//TODO
			return value.toUTCString();
		}
		
		public function ParseClient(k:SingletonBlocker)
		{
			if( k == null ){
				throw new ParseError("Error: Instantiation failed: Use ParseClient.<method>() instead of new.")
			}
		}
	}
}

internal class SingletonBlocker {}