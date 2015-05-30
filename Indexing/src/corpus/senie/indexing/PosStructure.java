package corpus.senie.indexing;


/**
 * Abstract position data structure.
 */
public abstract class PosStructure extends Object {

	/**
	 * Creates and returns a copy of this object.
	 * 
	 * @return a clone of this instance.
	 */
	public abstract Object clone();
	
	
	/**
	 * Indicates whether some other position address is equal to this one.
	 * 
	 * @param pos - the reference object with which to compare.
	 * @return true if this position address is the same as the argument; false otherwise.
	 */
	public abstract boolean equals(Object pos);
	
	
	/**
	 * Extracts the source part of this position address.
	 * 
	 * @return source name as string.
	 */
	public abstract String getSource();
	
	
	/**
	 * Extracts the current "weight" of this position address.
	 * 
	 * @return count of occurrences of according running word.
	 */
	public abstract int getCount();
	
	
	/**
	 * Increments the "weight" (occurrences of according running word) of this position address.
	 */
	public abstract void incCount();
	
	
	/**
	 * Returns a string representation (address) of the position object.
	 * 
	 * @return position address as a string.
	 */		
	public abstract String toString();
		
}