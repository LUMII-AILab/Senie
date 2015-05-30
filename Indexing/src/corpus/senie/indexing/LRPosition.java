package corpus.senie.indexing;


/**
 * Data structure for LR positions.
 */
public class LRPosition extends PosStructure {

	private String source;
	private String page;
	private int row;
	private int count;


	/**
	 * Creates a new position instance with default "weight" 1.
	 * 
	 * @param source - source name.
	 * @param page - page number.
	 * @param row - row number.
	 */
	public LRPosition(String source, String page, int row) {
		this.source = source;
		this.page = page;
		this.row = row;
		count = 1;
	}
	
	
	/**
	 * Creates a new position instance with given "weight".
	 * 
	 * @param source - source name.
	 * @param page - page number.
	 * @param row - row number.
	 * @param count - "weight" - occurrences of according running word.
	 */
	public LRPosition(String source, String page, int row, int count) {
		this.source = source;
		this.page = page;
		this.row = row;
		this.count = count;
	}
	
	
	/**
	 * Creates and returns a copy of this object.
	 * 
	 * @return a clone of this instance.
	 */
	public Object clone() {
		return new LRPosition(source, page, row, count);
	}
	
	
	/**
	 * Indicates whether some other position address is equal to this one.
	 * 
	 * @param pos - the reference object with which to compare.
	 * @return true if this position address is the same as the argument; false otherwise.
	 */
	public boolean equals(Object pos) {
		boolean result = false;
		
		if (pos instanceof LRPosition) {
			LRPosition lr = (LRPosition)pos;
			
			if (lr.getSource().equals(source) && 
				lr.getPage().equals(page) &&
				lr.getRow() == row) {
				
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
	 * Extracts the page part of this position address.
	 * 
	 * @return page number as string.
	 */
	public String getPage() {
		return page;
	}
	
	
	/**
	 * Extracts the row part of this position address.
	 * 
	 * @return row number as integer.
	 */
	public int getRow() {
		return row;
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
		return source + " " + page + ".lpp. " + row + ".r.";
	}
	
}