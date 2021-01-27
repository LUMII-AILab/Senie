package corpus.senie.indexing;


import java.io.Serializable;
import java.util.Comparator;


/**
 * Implementation of a comparator that provides alphabetical sorting of strings.
 * Intended for the SENIE alphabet.
 */
public class SENIEStringComparator implements Comparator<Object>, Serializable {

	private static final long serialVersionUID = 240566980135937075L;
	
	private String alpha = null;


	/**
	 * Constructor.
	 */
	public SENIEStringComparator() {
		alpha = "AaĀāÆæÄäBbCcČčĆćDdEeĒēFfGgĢģHhIiĪīJjKkĶķLlĻļMmNnŅņOoŌōÖöPpQqRrŖŗSsŠšŚś§ßTtUuŪūÜüVvWwXxYyZzžŹź0123456789";
	}


	/**
	 * Constructor.
	 * @param order sort order - a string representing sorted alphabeth (+ other chars) that will be in use.
	 * Other characters are sorted by their positions in the Unicode table.
	 */
	public SENIEStringComparator(String order) {
		alpha = order;
	}


	/**
	 * Compares this object (String) with the specified object (String) for order.
	 * @param o1 the first object (String) to be compared.
     * @param o2 the second object (String) to be compared.
	 * @return a negative integer, zero, or a positive integer as the first argument is
	 * less than, equal to, or greater than the second.
	 */
	public int compare(Object o1, Object o2) {
		if (!(o1 instanceof String) || !(o2 instanceof String)) {
			throw new ClassCastException("Objects of class String were expected.");
		}

		String str1 = (String)o1;
		String str2 = (String)o2;

		//Case 1: strings are equal.
		if (str1.equals(str2)) return 0;

		//Case 2: strings have to be compared char by char.
		//By default the first string is "less than" the second one.
		int signum = -1;
		int polarity = 1;
		int str1Rank = -1;
		int str2Rank = -1;

		if (str2.length() < str1.length()) {
			//Primary string is the shortest one; polarity changes.
			String temp = str1;
			str1 = str2;
			str2 = temp;
			polarity = -1;
		}

		for (int i = 0; i < str1.length(); i++) {
			str1Rank = alpha.indexOf(str1.charAt(i));
			str2Rank = alpha.indexOf(str2.charAt(i));

			//If char is not present in the specified alphabeth,
			//it's Unicode position is taken; alpha.length() = offset.
			if (str1Rank == -1) {
				str1Rank = str1.charAt(i) + alpha.length();
			}
			if (str2Rank == -1) {
				str2Rank = str2.charAt(i) + alpha.length();
			}

			if (str2Rank < str1Rank) {
				//First string is "greater than" the second one.
				signum = 1;
				break;
			}
			if (str2Rank > str1Rank) {
				//First string is "less than" the second one.
				signum = -1;
				break;
			}

		}

		return signum * polarity;
	}

}