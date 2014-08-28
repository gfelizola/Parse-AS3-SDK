package com.parse.intern
{
	import com.parse.ParseClient;
	import com.parse.ParseError;
	
	public class AddOperation implements FieldOperation
	{
		private var objects:Array;
		
		public function AddOperation(objs:Array)
		{
			if(! objs is Array ){
				throw new ParseError("AddOperation requires an array.");
			}
			this.objects = objs;
		}
		
		public function get value():Array
		{
			return this.objects;
		}
		
		public function apply(oldValue:*, object:*, key:String):*
		{
			if( ! oldValue ) return this.objects;
			
			return (oldValue as Array).concat( this.objects );
		}
		
		public function mergeWithPrevious(previous:FieldOperation):FieldOperation
		{
			if( ! previous ) return null;
			
			
			return null;
		}
		
		public function _encode():*
		{
			var encodedObject:Object = {};
			encodedObject["__op"] = "Add";
			encodedObject["objects"] = ParseClient.encode(this.objects, true);
			return encodedObject;
		}
	}
}