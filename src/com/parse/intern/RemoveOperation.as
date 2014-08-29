package com.parse.intern
{
	import com.parse.ParseClient;
	import com.parse.ParseError;

	public class RemoveOperation implements FieldOperation
	{
		private var _objects:Array;
		
		public function RemoveOperation(objs:Array)
		{
			if(! objs is Array ){
				throw new ParseError("RemoveOperation requires an array.");
			}
			this._objects = objs;
		}
		
		public function get value():Array
		{
			return this._objects;
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
			if( ! previous ) return this;
			
			if( previous is DeleteOperation ){
				return previous;
			}
			
			if( previous is SetOperation ){
				return new SetOperation( this.apply( SetOperation(previous).value, this._objects, null) );
			}
			
			if( previous is RemoveOperation ){
				return new RemoveOperation( RemoveOperation(previous).value.concat( this._objects ) );
			}
			
			throw new ParseError('Operation is invalid after previous operation.');
			
			return null;
		}
		
		public function _encode():*
		{
			var encodedObject:Object = {};
			encodedObject["__op"] = "Remove";
			encodedObject["objects"] = ParseClient.encode(this._objects, true);
			return encodedObject;
		}
	}
}