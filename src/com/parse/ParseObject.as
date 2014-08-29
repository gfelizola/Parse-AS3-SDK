package com.parse
{
	import com.parse.intern.Encodable;
	import com.parse.intern.FieldOperation;
	import com.parse.intern.RemoveOperation;
	import com.parse.intern.SetOperation;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class ParseObject implements Encodable
	{
		protected var _serverData:Dictionary;
		protected var _operationSet:Dictionary;
		
		private var _estimatedData:Dictionary;
		private var _dataAvailability:Dictionary;
		private var _className:String;
		private var _objectId:String;
		private var _createdAt:Date;
		private var _updatedAt:Date;
		private var _hasBeenFetched:Boolean;
		
		protected static const CLASS:Object = ParseObject;
		
		private static var registeredSubclasses:Array = [];
		
		
		public function ParseObject( className:String = null, objectId:String = null, isPointer:Boolean = false )
		{
			
			
			this._className = className;
			this._serverData = new Dictionary();
			this._operationSet = new Dictionary();
			this._estimatedData = new Dictionary();
			this._estimatedData = new Dictionary();
			
			if( objectId !== null || isPointer ){
				this._objectId = objectId;
				this._hasBeenFetched = false;
			} else {
				this._hasBeenFetched = true;
			}
		}
		
		private static function getSubclass():String
		{
			var indx:uint = registeredSubclasses.indexOf( getQualifiedClassName( CLASS ) );
			return indx >= 0 ? registeredSubclasses[indx] : null;
		}
		
		public function _encode():*
		{
			//TODO: implement function
			return null;
		}
		
		public function set(key:String, value:*):void
		{
			if( ! key ){
				throw new Error('key may not be null.');
			}
			
			if( value is Array ){
				throw new Error('Must use setArray() or setAssociativeArray() for this value.');
			}
			
			this.performOperation(key, new SetOperation(value));
		}
		
		public function setAssociativeArray(key:String, value:*):void
		{
			if (key) {
				throw new Error('key may not be null.');
			}
			if (! value is Array ) {
				throw new Error('Must use set() for non-array values.');
			}
			this.performOperation(key, new SetOperation(value, true));
		}
		
		public function remove(key:String, value:*):void
		{
			if (!key) {
				throw new Error('key may not be null.');
			}
			if (! value is Array ) {
				value = [value];
			}
			this.performOperation(key, new RemoveOperation(value));
		}
		
		public function revert():void
		{
			this._operationSet = new Dictionary();
			this.rebuildEstimatedData();
		}
		
		private function rebuildEstimatedData():void
		{
			
		}
		
		private function performOperation(key:String, open:FieldOperation):void
		{
			var oldValue:* = null;
			if( this._estimatedData[key] ){
				oldValue = this._estimatedData[key]; 
			}
			
//			PHP CODE
//			$oldValue = null;
//			if (isset($this->estimatedData[$key])) {
//				$oldValue = $this->estimatedData[$key];
//			}
//			$newValue = $operation->_apply($oldValue, $this, $key);
//			if ($newValue !== null) {
//				$this->estimatedData[$key] = $newValue;
//			} else if (isset($this->estimatedData[$key])) {
//				unset($this->estimatedData[$key]);
//			}
//			
//			if (isset($this->operationSet[$key])) {
//				$oldOperations = $this->operationSet[$key];
//				$newOperations = $operation->_mergeWithPrevious($oldOperations);
//				$this->operationSet[$key] = $newOperations;
//			} else {
//				$this->operationSet[$key] = $operation;
//			}
//			$this->dataAvailability[$key] = true;
		}
	}
}