package com.parse.intern
{
	import com.parse.ParseClient;
	import com.parse.ParseError;
	
	public class AddOperation implements FieldOperation
	{
		private var _objects:Array;
		
		public function AddOperation(objs:Array)
		{
			if(! objs is Array ){
				throw new ParseError("AddOperation requires an array.");
			}
			this._objects = objs;
		}
		
		public function get value():Array
		{
			return this._objects;
		}
		
		public function apply(oldValue:*, object:*, key:String):*
		{
			if( ! oldValue ) return this._objects;
			
			return (oldValue as Array).concat( this._objects );
		}
		
		public function mergeWithPrevious(previous:FieldOperation):FieldOperation
		{
			if( ! previous ) return null;
			
			if( previous is DeleteOperation ){
				return new SetOperation(this._objects);
			}
			
			var oldList:Array;
			
			if( previous is SetOperation ){
				oldList = SetOperation(previous).value;
				return new SetOperation( this._objects.concat( oldList ) );
			}
			
			if( previous is AddOperation ){
				oldList = AddOperation(previous).value;
				return new SetOperation( this._objects.concat( oldList ) );
			}
			
			throw new ParseError('Operation is invalid after previous operation.');
		}
		
		public function _encode():*
		{
			var encodedObject:Object = {};
			encodedObject["__op"] = "Add";
			encodedObject["objects"] = ParseClient.encode(this._objects, true);
			return encodedObject;
		}
	}
}