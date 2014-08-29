package com.parse.intern
{
	import com.parse.ParseClient;

	public class ParseRelationOperation implements FieldOperation
	{
		private var _targetClassName:String;
		private var _relationsToAdd:Array = [];
		private var _relationsToRemove:Array = [];
		
		public function ParseRelationOperation(objectsToAdd:Array, objectsToRemove:Array)
		{
		}
		
		public function apply(oldValue:*, object:*, key:String):*
		{
//			PHP CODE
//			if ($oldValue == null) {
//				return new ParseRelation($object, $key, $this->targetClassName);
//			} else if ($oldValue instanceof ParseRelation) {
//				if ($this->targetClassName != null
//					&& $oldValue->getTargetClass() !== $this->targetClassName) {
//					throw new \Exception('Related object object must be of class '
//						. $this->targetClassName . ', but ' . $oldValue->getTargetClass()
//						. ' was passed in.');
//				}
//				return $oldValue;
//			} else {
//				throw new \Exception("Operation is invalid after previous operation.");
//			}
			
			return null;
		}
		
		public function mergeWithPrevious(previous:FieldOperation):FieldOperation
		{
//			PHP CODE
//			if ($previous == null) {
//				return $this;
//			}
//			if ($previous instanceof ParseRelationOperation) {
//				if ($previous->targetClassName != null
//					&& $previous->targetClassName != $this->targetClassName
//				) {
//					throw new \Exception('Related object object must be of class '
//						. $this->targetClassName . ', but ' . $previous->targetClassName
//						. ' was passed in.');
//				}
//				$newRelationToAdd = self::convertToOneDimensionalArray(
//					$this->relationsToAdd);
//				$newRelationToRemove = self::convertToOneDimensionalArray(
//					$this->relationsToRemove);
//				
//				$previous->addObjects($newRelationToAdd,
//					$previous->relationsToAdd);
//				$previous->removeObjects($newRelationToAdd,
//					$previous->relationsToRemove);
//				
//				$previous->removeObjects($newRelationToRemove,
//					$previous->relationsToAdd);
//				$previous->addObjects($newRelationToRemove,
//					$previous->relationsToRemove);
//				
//				$newRelationToAdd = self::convertToOneDimensionalArray(
//					$previous->relationsToAdd);
//				$newRelationToRemove = self::convertToOneDimensionalArray(
//					$previous->relationsToRemove);
//				
//				return new ParseRelationOperation($newRelationToAdd,
//					$newRelationToRemove);
//			}
//			throw new \Exception('Operation is invalid after previous operation.');
			
			return null;
		}
		
		public function _encode():*
		{
			var addRelation:Object = null;
			var removeRelation:Object = null;
			
			if( this._relationsToAdd.length > 0 ){
				addRelation = {};
				addRelation["__op"] = "AddRelation";
				addRelation["objects"] = ParseClient.encode( ParseRelationOperation.convertToOneDimensionalArray( this._relationsToAdd ), true);
			}
			
			if( this._relationsToRemove.length > 0 ){
				addRelation = {};
				addRelation["__op"] = "RemoveRelation";
				addRelation["objects"] = ParseClient.encode( ParseRelationOperation.convertToOneDimensionalArray( this._relationsToRemove ), true);
			}
			
			if( addRelation !== null && removeRelation !== null ){
				var encodedObject:Object = {};
				encodedObject["__op"] = "Batch";
				encodedObject["ops"] = [addRelation, removeRelation];
				return encodedObject;
			}
			
			return addRelation ? addRelation : removeRelation;
		}
		
		private function checkAndAssignClassName(objects:Array):void
		{
			for (var i:int = 0; i < objects.length; i++) 
			{
				var object:* = objects[i];
				if( this._targetClassName === null ){
//					this._targetClassName = 
				}
			}
			
			
//			PHP CODE
//			foreach ($objects as $object) {
//				if ($this->targetClassName === null) {
//					$this->targetClassName = $object->getClassName();
//				}
//				if ($this->targetClassName != $object->getClassName()) {
//					throw new \Exception('All objects in a relation must be of the same class.');
//				}
//			}
		}
		
		private function addObjects(objects:Array, container:Array):void
		{
//			PHP CODE
//			if (!is_array($objects)) {
//				$objects = [$objects];
//			}
//			foreach ($objects as $object) {
//				if ($object->getObjectId() == null) {
//					$container['null'][] = $object;
//				} else {
//					$container[$object->getObjectID()] = $object;
//				}
//			}
		}
		
		private function removeObjects(	objects:Array, container:Array):void
		{
//			PHP CODE
//			if (!is_array($objects)) {
//				$objects = [$objects];
//			}
//			$nullObjects = array();
//			foreach ($objects as $object) {
//				if ($object->getObjectId() == null) {
//					$nullObjects[] = $object;
//				} else {
//					unset($container[$object->getObjectID()]);
//				}
//			}
//			if (!empty($nullObjects)) {
//				self::removeElementsFromArray($nullObjects, $container['null']);
//			}
		}
		
		public function get targetClassName():String 
		{
			return this._targetClassName;
		}
		
		public static function convertToOneDimensionalArray(arr:*):Array
		{
			var newArray:Array = [];
			
			if( arr is Array ){
				for (var i:int = 0; i < arr.length; i++) 
				{
					newArray.concat( convertToOneDimensionalArray( arr[i] ) );
				}
				
			} else {
				newArray.push( arr );
			}
			
			return newArray;
		}
	}
}