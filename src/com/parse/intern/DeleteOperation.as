package com.parse.intern
{
	import com.parse.ParseClient;

	public class DeleteOperation implements FieldOperation
	{
		public function DeleteOperation()
		{
		}
		
		public function apply(oldValue:*, object:*, key:String):*
		{
			return null;
		}
		
		public function mergeWithPrevious(previous:FieldOperation):FieldOperation
		{
			return this;
		}
		
		public function _encode():*
		{
			var encodedObject:Object = {};
			encodedObject["__op"] = "Delete";
			return encodedObject;
		}
	}
}