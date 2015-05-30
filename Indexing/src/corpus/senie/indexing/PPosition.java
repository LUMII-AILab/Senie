package corpus.senie.indexing;


/**
 * Data structure for P positions.
 */
public class PPosition extends PosStructure {

	private String source;
	private String verse;
	private int count;


	/**
	 * Creates a new position instance with default "weight" 1.
	 * 
	 * @param source - source name.
	 * @param verse - verse number.
	 */
	public PPosition(String source, String verse) {
		this.source = source;
		this.verse = verse;
		count = 1;
	}
	
	
	/**
	 * Creates a new position instance with given "weight".
	 * 
	 * @param source - source name.
	 * @param verse - verse number.
	 * @param count - "weight" - occurrences of according running word.
	 */
	public PPosition(String source, String verse, int count) {
		this.source = source;
		this.verse = verse;
		this.count = count;
	}
	
	
	/**
	 * Creates and returns a copy of this object.
	 * 
	 * @return a clone of this instance.
	 */
	public Object clone() {
		return new PPosition(source, verse, count);
	}
	
	
	/**
	 * Indicates whether some other position address is equal to this one.
	 * 
	 * @param pos - the reference object with which to compare.
	 * @return true if this position address is the same as the argument; false otherwise.
	 */
	public boolean equals(Object pos) {
		boolean result = false;
		
		if (pos instanceof PPosition) {
			PPosition p = (PPosition)pos;

			if (p.getSource().equals(source) && p.getVerse().equals(verse)) {
				result = true;					
			}
		}
		
		return result;
	}
	
	
	/**
	 * Extracts the current "weight" of this position address.
	 * 
	 * @return count of occurrences of according running word.
	 */
	public int getCount() {
		return count;
	}
	
	
	/**
	 * Extracts the source part of this position address.
	 * 
	 * @return source name as string.
	 */
	public String getSource() {
		return source;
	}
	
	
	/**
	 * Extracts the verse part of this position address.
	 * 
	 * @return verse number as string.
	 */
	public String getVerse() {
		return verse;
	}
	
	
	/**
	 * Increments the "weight" (occurrences of according running word) of this position address.
	 */
	public void incCount() {
		count++;
	}
	
	
	/**
	 * Returns a string representation (address) of the position object.
	 * 
	 * @return position address as a string.
	 */
	public String toString() {
		return source + " " + verse + "p.";
	}
	
}