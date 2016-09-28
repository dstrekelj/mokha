package mokha.tools;

/**
	A collection of static extensions for arrays.
**/
class ArrayTools {
	/**
		Checkes whether an array contains a specific element.
		@param	array	Array
		@param	element	Element
		@return	`true` if element is in array
	**/
	public static function has<T>(array : Array<T>, element : T) : Bool {
		return array.indexOf(element) >= 0;
	}
}