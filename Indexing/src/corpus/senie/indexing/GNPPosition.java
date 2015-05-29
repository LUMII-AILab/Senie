package corpus.senie.indexing;


/**
 * Data structure for GNP positions.
 * 
 * @version 01.04.2003
 * @author Normunds Grûzîtis
 */
public class GNPPosition extends PosStructure {

	private String source;
	private String book;
	private int chapter;
	private int verse;
	private int count;

	
	/**
	 * Creates a new position instance with default "weight" 1.
	 * 
	 * @param source - source name.
	 * @param book - book name.
	 * @param chapter - chapter number.
	 * @param verse - verse number.
	 */
	public GNPPosition(String source, String book, int chapter, int verse) {
		this.source = source;
		this.book = book;
		this.chapter = chapter;
		this.verse = verse;
		count = 1;
	}
	
	
	/**
	 * Creates a new position instance with given "weight".
	 * 
	 * @param source - source name.
	 * @param book - book name.
	 * @param chapter - chapter number.
	 * @param verse - verse number.
	 * @param count - "weight" - occurrences of according running word.
	 */
	public GNPPosition(String source, String book, int chapter, int verse, int count) {
		this.source = source;
		this.book = book;
		this.chapter = chapter;
		this.verse = verse;
		this.count = count;
	}
	
	
	/**
	 * Creates and returns a copy of this object.
	 * 
	 * @return a clone of this instance.
	 */
	public Object clone() {
		return new GNPPosition(source, book, chapter, verse, count);
	}
	
	
	/**
	 * Indicates whether some other position address is equal to this one.
	 * 
	 * @param pos - the reference object with which to compare.
	 * @return true if this position address is the same as the argument; false otherwise.
	 */
	public boolean equals(Object pos) {
		boolean result = false;
		
		if (pos instanceof GNPPosition) {
			GNPPosition gnp = (GNPPosition)pos;
			
			if (gnp.getSource().equals(source) && 
				gnp.getBook().equals(book) &&
				gnp.getChapter() == chapter &&
				gnp.getVerse() == verse) {
				
				result = true;					
			}
		}
		
		return result;
	}
	
	
	/**
	 * Extracts the book part of this position address.
	 * 
	 * @return book name as string.
	 */
	public String getBook() {
		return book;
	}
	
	
	/**
	 * Extracts the chapter part of this position address.
	 * 
	 * @return chapter number as integer.
	 */
	public int getChapter() {
		return chapter;
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
	 * @return verse number as integer.
	 */
	public int getVerse() {
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
		return source + " " + book + " " + chapter + ":" + verse;
	}
	
}