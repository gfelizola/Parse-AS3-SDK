package com.parse.intern
{
	import com.parse.ParseClient;
	import com.parse.ParseError;

	public class IncrementOperation implements FieldOperation
	{
		private var _value:Number;
		
		public function IncrementOperation(val:Number = 1)
		{
			this._value = val;
		}
		
		public function get value():Number
		{
			return this._value;
		}
		
		public function apply(oldValue:*, object:*, key:String):*
		{
			if ( isNaN(oldValue)) {
				throw new ParseError('Cannot increment a non-number type.');
			}
			return oldValue + this._value;
		}
		
		public function mergeWithPrevious(previous:FieldOperation):FieldOperation
		{
			if( ! previous ) return this;
			
			if( previous is DeleteOperation ){
				return new SetOperation(this._value);
			}
			
			var oldList:Array;
			
			if( previous is SetOperation ){
				return new SetOperation( SetOperation(previous).value + this._value );
			}
			
			if( previous is IncrementOperation ){
				return new IncrementOperation( IncrementOperation(previous).value + this._value );
			}
			
			throw new ParseError('Operation is invalid after previous operation.');
		}
		
		public function _encode():*
		{
			var encodedObject:Object = {};
			encodedObject["__op"] = "Increment";
			encodedObject["amount"] = this._value
			return encodedObject;
		}
	}
}