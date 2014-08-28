package com.parse.intern
{
	import com.parse.ParseClient;
	import com.parse.ParseError;

	public class RemoveOperation implements FieldOperation
	{
		private var objects:Array;
		
		public function RemoveOperation(objs:Array)
		{
			if(! objs is Array ){
				throw new ParseError("RemoveOperation requires an array.");
			}
			this.objects = objs;
		}
		
		public function get value():Array
		{
			return this.objects;
		}
		
		public function apply(oldValue:*, object:*, key:String):*
		{
//			PHP CODE
//			if (empty($oldValue)) {
//				return array();
//			}
//			$newValue = array();
//			foreach ($oldValue as $oldObject) {
//				foreach ($this->objects as $newObject) {
//					if ($oldObject instanceof ParseObject) {
//						if ($newObject instanceof ParseObject
//							&& !$oldObject->isDirty()
//							&& $oldObject->getObjectId() == $newObject->getObjectId()) {
//							// found the object, won't add it.
//						} else {
//							$newValue[] = $oldObject;
//						}
//					} else {
//						if ($oldObject !== $newObject) {
//							$newValue[] = $oldObject;
//						}
//					}
//				}
//			}
//			return $newValue;
			
			return null;
		}
		
		public function mergeWithPrevious(previous:FieldOperation):FieldOperation
		{
//			PHP CODE
//			if (!$previous) {
//				return $this;
//			}
//			if ($previous instanceof DeleteOperation) {
//				return $previous;
//			}
//			if ($previous instanceof SetOperation) {
//				return new SetOperation(
//					$this->_apply($previous->getValue(), $this->objects, null)
//				);
//			}
//			if ($previous instanceof RemoveOperation) {
//				$oldList = $previous->getValue();
//				return new RemoveOperation(
//					array_merge((array)$oldList, (array)$this->objects)
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
			encodedObject["__op"] = "Remove";
			encodedObject["objects"] = ParseClient.encode(this.objects, true);
			return encodedObject;
		}
	}
}