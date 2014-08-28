package com.parse.intern
{

	public interface FieldOperation extends Encodable
	{
		function apply(oldValue:*, object:*, key:String):*;
		
		function mergeWithPrevious(previous:FieldOperation):FieldOperation;
	}
}