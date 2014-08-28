package com.parse.intern
{
	import com.parse.ParseClient;
	import com.parse.ParseError;
	
	public class AddUniqueOperation implements FieldOperation
	{
		private var objects:Array;
		
		public function AddUniqueOperation(objs:Array)
		{
			if(! objs is Array ){
				throw new ParseError("AddUniqueOperation requires an array.");
			}
			this.objects = objs;
		}
		
		public function get value():Array
		{
			return this.objects;
		}
		
		public function apply(oldValue:*, object:*, key:String):*
		{
			if (!oldValue) return this.objects;
			
			if (! oldValue is Array) {
				oldValue = new Array(oldValue);
			}
			
			for (var i:int = 0; i < this.objects.length; i++) 
			{
				var obj:* = this.objects[i];
				
				
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
//			PHP CODE
//			if (!$previous) {
//				return $this;
//			}
//			if ($previous instanceof DeleteOperation) {
//				return new SetOperation($this->objects);
//			}
//			if ($previous instanceof SetOperation) {
//				$oldValue = $previous->getValue();
//				$result = $this->_apply($oldValue, null, null);
//				return new SetOperation($result);
//			}
//			if ($previous instanceof AddUniqueOperation) {
//				$oldList = $previous->getValue();
//				$result = $this->_apply($oldList, null, null);
//				return new AddUniqueOperation($result);
//			}
//			throw new ParseException(
//				'Operation is invalid after previous operation.'
//			);
			
			return null;
		}
		
		public function _encode():*
		{
			var encodedObject:Object = {};
			encodedObject["__op"] = "AddUnique";
			encodedObject["objects"] = ParseClient.encode(this.objects, true);
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