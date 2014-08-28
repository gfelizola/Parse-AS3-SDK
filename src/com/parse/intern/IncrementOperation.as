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
//			PHP CODE
//			if (!$previous) {
//				return $this;
//			}
//			if ($previous instanceof DeleteOperation) {
//				return new SetOperation($this->value);
//			}
//			if ($previous instanceof SetOperation) {
//				return new SetOperation($previous->getValue() + $this->value);
//			}
//			if ($previous instanceof IncrementOperation) {
//				return new IncrementOperation(
//					$previous->getValue() + $this->value
//				);
//			}
//			throw new ParseException(
//				'Operation is invalid after previous operation.'
//			);
			
			return null;
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