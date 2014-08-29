package com.parse.intern
{
	import com.parse.ParseClient;
	import com.parse.ParseError;
	
	public class AddUniqueOperation implements FieldOperation
	{
		private var _objects:Array;
		
		public function AddUniqueOperation(objs:Array)
		{
			if(! objs is Array ){
				throw new ParseError("AddUniqueOperation requires an array.");
			}
			this._objects = objs;
		}
		
		public function get value():Array
		{
			return this._objects;
		}
		
		public function apply(oldValue:*, object:*, key:String):*
		{
			if (!oldValue) return this._objects;
			
			if (! oldValue is Array) {
				oldValue = new Array(oldValue);
			}
			
			for (var i:int = 0; i < this._objects.length; i++) 
			{
				var obj:* = this._objects[i];
				
			}
			
			
//			PHP CODE
//			foreach ($this->objects as $object) {
//				if ($object instanceof ParseObject && $object->getObjectId()) {
//					if (!$this->isParseObjectInArray($object, $oldValue)) {
//						$oldValue[] = $object;
//					}
//				} else if (is_object($object)) {
//					if (!in_array($object, $oldValue, true)) {
//						$oldValue[] = $object;
//					}
//				} else {
//					if (!in_array($object, $oldValue, true)) {
//						$oldValue[] = $object;
//					}
//				}
//			}
			return oldValue;
		}
		
		public function mergeWithPrevious(previous:FieldOperation):FieldOperation
		{
			if( ! previous ) return this;
			
			if( previous is DeleteOperation ){
				return new SetOperation(this._objects);
			}
			
			if( previous is SetOperation ){
				return new SetOperation( this.apply( SetOperation(previous).value, null, null) );
			}
			
			if( previous is AddUniqueOperation ){
				return new AddUniqueOperation( this.apply( AddOperation(previous).value, null, null) );
			}
			
			throw new ParseError('Operation is invalid after previous operation.');
		}
		
		public function _encode():*
		{
			var encodedObject:Object = {};
			encodedObject["__op"] = "AddUnique";
			encodedObject["objects"] = ParseClient.encode(this._objects, true);
			return encodedObject;
		}
		
		
		
		private function isParseObjectInArray(parseObject, oldValue):Boolean
		{
//			PHP CODE
//			for each ($oldValue as $object) {
//				if ($object instanceof ParseObject && $object->getObjectId() != null) {
//					if ($object->getObjectId() == $parseObject->getObjectId()) {
//						return true;
//					}
//				}
//			}
			return false;
		}
	}
}