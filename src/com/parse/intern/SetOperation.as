package com.parse.intern
{
	import com.parse.ParseClient;

	public class SetOperation implements FieldOperation
	{
		private var _value:*;
		private var _isAssociativeArray:Boolean = false;
		
		public function SetOperation(val:*, isAssociativeArray:Boolean = false)
		{
			this._value = val;
			this._isAssociativeArray = isAssociativeArray;
		}
		
		public function get value():*
		{
			return this._value;
		}
		
		public function apply(oldValue:*, object:*, key:String):*
		{
			return this._value;
		}
		
		public function mergeWithPrevious(previous:FieldOperation):FieldOperation
		{
			return this;
		}
		
		public function _encode():*
		{
			if (this._isAssociativeArray) {
				var encodedObject:Object = {};
				
				for( var k:String in this._value ){
					encodedObject[k] = this._value[k];
				}
				return ParseClient.encode( encodedObject, true );
			}
			
			return ParseClient.encode( this._value, true );
		}
	}
}