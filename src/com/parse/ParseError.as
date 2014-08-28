package com.parse
{
	public class ParseError extends Error
	{
		public function ParseError(message:*="", code:*=0)
		{
			super(message, code);
		}
	}
}