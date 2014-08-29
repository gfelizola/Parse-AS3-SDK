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
		
		private function performOperation(key:String, operation:FieldOperation):void
		{
			var oldValue:* = null;
			if( this._estimatedData[key] ){
				oldValue = this._estimatedData[key]; 
			}
			
			var newValue:* = operation.apply( oldValue, this, key );
			if( newValue !== null ){
				this._estimatedData[key] = newValue;
			} else if( this._estimatedData[key] !== null ){
				delete this._estimatedData[key];
			}
			
			if( this._operationSet[key] !== null ){
				var oldOperation:FieldOperation = this._operationSet[key]; 
				this._operationSet[key] = operation.mergeWithPrevious( oldOperation ); 
			} else {
				this._operationSet[key] = operation;
			}
		}
		
		public function get className():String { return this._className; }
		public function get objectId():String { return this._objectId; }
		public function get createdAt():Date { return this._createdAt; }
		public function get updatedAt():Date { return this._updatedAt; }
		
		public function get isDataAvailable():Boolean { return this._hasBeenFetched; }
		
		private function _isDataAvailable(key:String):Boolean { 
			return this.isDataAvailable() || this._dataAvailability[key] !== null; 
		}
		
		public static function create(className:String, objectId:String = null, isPointer:Boolean = false):ParseObject
		{
			return new ParseObject(className, objectId, isPointer);
		}
		
		public function fetch():void
		{
			//PHP CODE
//			$sessionToken = null;
//			if (ParseUser::getCurrentUser()) {
//				$sessionToken = ParseUser::getCurrentUser()->getSessionToken();
//			}
//			$response = ParseClient::_request(
//				'GET',
//				'/1/classes/' . $this->className . '/' . $this->objectId,
//				$sessionToken
//			);
//			$this->_mergeAfterFetch($response);
		}
		
		public function mergeAfterFetch(result:Object, completeData:Boolean = true):void
		{
			//PHP CODE
			// This loop will clear operations for keys provided by the server
			// It will not clear operations for new keys the server doesn't have.
//			foreach ($result as $key => $value) {
//				if (isset($this->operationSet[$key])) {
//					unset($this->operationSet[$key]);
//				}
//			}
//			$this->serverData = array();
//			$this->dataAvailability = array();
//			$this->mergeFromServer($result, $completeData);
//			$this->rebuildEstimatedData();
			
			
		}
		
		public function mergeAfterFetchWithSelectedKeys(result:Object, selectedKeys:Array):void
		{
			//PHP CODE
//			$this->_mergeAfterFetch($result, $selectedKeys ? empty($selectedKeys) : true);
//			foreach ($selectedKeys as $key) {
//				$this->dataAvailability[$key] = true;
//			}
		}
		
		private function mergeFromServer(data:Object, completeData:Boolean = true):void
		{
			//PHP CODE
//			$this->hasBeenFetched = ($this->hasBeenFetched || $completeData) ? true : false;
//			$this->mergeMagicFields($data);
//			foreach ($data as $key => $value) {
//				if ($key === '__type' && $value === 'className') {
//					continue;
//				}
//				
//				$decodedValue = ParseClient::_decode($value);
//				
//				if (is_array($decodedValue)) {
//					if (isset($decodedValue['__type'])) {
//						if ($decodedValue['__type'] === 'Relation') {
//							$className = $decodedValue['className'];
//							$decodedValue = new ParseRelation($this, $key, $className);
//						}
//					}
//					if ($key == 'ACL') {
//						$decodedValue = ParseACL::_createACLFromJSON($decodedValue);
//					}
//				}
//				$this->serverData[$key] = $decodedValue;
//				$this->dataAvailability[$key] = true;
//				
//			}
//			if (!$this->updatedAt && $this->createdAt) {
//				$this->updatedAt = $this->createdAt;
//			}
		}
		
		private function mergeMagicFields(data:Object):void
		{
			//PHP CODE
//			if (isset($data['objectId'])) {
//				$this->objectId = $data['objectId'];
//				unset($data['objectId']);
//			}
//			if (isset($data['createdAt'])) {
//				$this->createdAt = new \DateTime($data['createdAt']);
//				unset($data['createdAt']);
//			}
//			if (isset($data['updatedAt'])) {
//				$this->updatedAt = new \DateTime($data['updatedAt']);
//				unset($data['updatedAt']);
//			}
//			if (isset($data['ACL'])) {
//				$acl = ParseACL::_createACLFromJSON($data['ACL']);
//				$this->serverData['ACL'] = $acl;
//				unset($data['ACL']);
//			}
		}
		
		protected function rebuildEstimatedData():VOID
		{
//			PHP CODE
//			$this->estimatedData = array();
//			foreach ($this->serverData as $key => $value) {
//				$this->estimatedData[$key] = $value;
//			}
//			$this->applyOperations($this->operationSet, $this->estimatedData);
		}
		
		private function applyOperations(operations:Array, target:Object):void
		{
//			PHP CODE
//			foreach ($operations as $key => $operation) {
//				$oldValue = (isset($target[$key]) ? $target[$key] : null);
//				$newValue = $operation->_apply($oldValue, $this, $key);
//				if (empty($newValue) && !is_array($newValue)
//					&& $newValue !== null && !is_scalar($newValue)
//				) {
//					unset($target[$key]);
//					unset($this->dataAvailability[$key]);
//				} else {
//					$target[$key] = $newValue;
//					$this->dataAvailability[$key] = true;
//				}
//			}
		}
		
		public function destroy($useMasterKey = false):void
		{
//			PHP CODE
//			if (!$this->objectId) {
//				return;
//			}
//			$sessionToken = null;
//			if (ParseUser::getCurrentUser()) {
//				$sessionToken = ParseUser::getCurrentUser()->getSessionToken();
//			}
//			ParseClient::_request(
//				'DELETE', '/1/classes/' . $this->className .
//				'/' . $this->objectId, $sessionToken, null, $useMasterKey
//			);
		}
		
		public static function destroyAll(objects:Array, useMasterKey:Boolean = false):void
		{
//			PHP CODE
//			$errors = [];
//			$count = count($objects);
//			if ($count) {
//				$batchSize = 40;
//				$processed = 0;
//				$currentBatch = [];
//				$currentcount = 0;
//				while ($processed < $count) {
//					$currentcount++;
//					$currentBatch[] = $objects[$processed++];
//					if ($currentcount == $batchSize || $processed == $count) {
//						$results = static::destroyBatch($currentBatch);
//						$errors = array_merge($errors, $results);
//						$currentBatch = [];
//						$currentcount = 0;
//					}
//				}
//				if (count($errors)) {
//					throw new ParseAggregateException(
//						"Errors during batch destroy.", $errors
//					);
//				}
//			}
//			return null;
		}
		
		private static function destroyBatch(objects:Array, useMasterKey:Array = false):void
		{
//			PHP CODE
//			$data = [];
//			$errors = [];
//			foreach ($objects as $object) {
//				$data[] = array(
//					"method" => "DELETE",
//					"path" => "/1/classes/" . $object->getClassName() .
//					"/" . $object->getObjectId()
//				);
//			}
//			$sessionToken = null;
//			if (ParseUser::getCurrentUser()) {
//				$sessionToken = ParseUser::getCurrentUser()->getSessionToken();
//			}
//			$result = ParseClient::_request(
//				"POST", "/1/batch", $sessionToken,
//				json_encode(array("requests" => $data)),
//				$useMasterKey
//			);
//			foreach ($objects as $key => $object) {
//				if (isset($result[$key]['error'])) {
//					$error = $result[$key]['error']['error'];
//					$code = isset($result[$key]['error']['code']) ?
//						$result[$key]['error']['code'] : -1;
//					$errors[] = array(
//						'error' => $error,
//						'code' => $code
//					);
//				}
//			}
//			return $errors;
		}
		
		
	}
}