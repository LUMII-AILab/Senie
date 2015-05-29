package corpus.senie.indexing;

import java.util.regex.Pattern;


/**
 * Recognition of text structure elements, and validation of word forms and mark-up syntax.
 * Supported text positioning structures: GNP, LR, P.
 * 
 * @version 12.01.2010, 16.01.2014, 12.09.2014, 20.11.2014
 * @author Normunds Grûzîtis
 */
public class Recognizer extends Object {

	public static Pattern pWForm;
	
	private String wf_ch;
	private String plain;
	
	private Pattern pAuthor;
	private Pattern pBook;
	private Pattern pChapter;
	private Pattern pComment;
	private Pattern pEmpty;
	private Pattern pHeader;
	private Pattern pFooter;
	private Pattern pErrata;
	private Pattern pLang;
	private Pattern pManual;
	private Pattern pMixed;
	private Pattern pNote;
	private Pattern pPage;
	private Pattern pParallel;
	private Pattern pPlain;
	private Pattern pSource;
	private Pattern pVerseExGNP;
	private Pattern pVerseGNP;
	private Pattern pVerseExP;
	private Pattern pVerseP;
	private Pattern pIgnore;
	private Pattern pErrHyp;
	private Pattern pSuspicBraces;
	private Pattern pSuspicPage;
	private Pattern pSuspicVerse;


	/**
	 * Constructor. Initializes patterns for recognition.
	 */
	public Recognizer() {
		String alpha_lv = "ÂâÈèÇçÌìÎîÍíÏïÒòÔôªºÐðÛûÞþ";
		String alpha_other = "¯¿ÄäàÃãæéÙùñÖöóÚú§ßÜüWwYyÊêý";
		String alpha_mark = "~`´'\\^=#&%";
		String punct = "\\!\\?\\.\\,\\:;\\-\\+\\*/\\|\\\\\\(\\)\\[\\]<>\"©®";
		
		wf_ch = "[\\w" + alpha_lv + alpha_other + alpha_mark +"]*";
		plain = "[\\s\\w" + alpha_lv + alpha_other + alpha_mark + punct + "]*";
		
		pAuthor   = Pattern.compile("@a\\{(" + plain + ")\\}");
		pBook     = Pattern.compile("@g\\{(\\w+)\\}");
		pChapter  = Pattern.compile("@n\\{(\\d+)\\}");
		pEmpty    = Pattern.compile("@x\\{\\}");									// Synchronize with pWaste
		pHeader   = Pattern.compile("@[o23]\\{(" + plain + ")\\}");					// Synchronize with pWaste
		pFooter   = Pattern.compile("@[b1]\\{(" + plain + ")\\}");					// Synchronize with pWaste
		pErrata   = Pattern.compile("(" + wf_ch + ")\\{(" + plain + ")\\}");
		pLang     = Pattern.compile("@([cefhijlrsv])\\{(" + plain + ")\\}");		// Synchronize with pWaste
		pManual   = Pattern.compile("@m\\{(" + plain + ")\\}");
		pNote     = Pattern.compile("@p\\{(" + plain + ")\\}");						// Synchronize with pWaste
		pPage     = Pattern.compile("\\[([\\-\\w\\{\\}]+)\\.lpp\\.\\]");
		pParallel = Pattern.compile("@t\\{(" + plain + ")\\}");						// Synchronize with pWaste
		pPlain    = Pattern.compile("(" + plain + ")");
		pSource   = Pattern.compile("@z\\{(\\w+)\\}");
		pComment  = Pattern.compile("@k\\{(" + plain + ")\\}");						// Synchronize with pWaste
		pVerseGNP = Pattern.compile("(\\d+)\\.(" + plain + ")");
		pVerseP   = Pattern.compile("\\s\\s((\\d+\\.)+)(" + plain + ")");
		pIgnore   = Pattern.compile("@[bcefhijkloprstvx123]\\{(" + plain + ")\\}");
		
		String mixed = "(" + plain + "((";
		mixed += pErrata.pattern() + ")|(";
		mixed += pLang.pattern() + ")|(";
		mixed += pManual.pattern() + ")|(";
		mixed += pNote.pattern() + ")|(";
		mixed += pComment.pattern() + "))";
		mixed += plain + ")+";

		pMixed = Pattern.compile("(" + mixed + ")");
		
		pVerseExGNP = Pattern.compile("(\\d+)\\.((" + plain + ")|(" + mixed + "))");
		pVerseExP = Pattern.compile("\\s\\s((\\d+\\.)+)((" + plain + ")|(" + mixed + "))");
		
		pSuspicBraces = Pattern.compile("(?<![\\w" + alpha_lv + alpha_other + alpha_mark + "])\\{");
		pSuspicPage = Pattern.compile("\\[[\\w\\s\\{\\}]+\\.?(lpp)?\\.?\\]");
		pSuspicVerse = Pattern.compile("(\\s*(\\d+\\.)+)((" + plain + ")|(" + mixed + "))");

		pErrHyp = Pattern.compile(wf_ch + "\\{" + plain);
		
		pWForm = Pattern.compile("[\\w" + alpha_lv + alpha_other + "]" + wf_ch + "(\\{" + plain + "\\})?");
	}


	/**
	 * Returns a pattern for author tag recognition.
	 * Groups: 1. - all tag content (author's name).
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getAuthorPattern() {
		return pAuthor;
	}


	/**
	 * Returns a pattern for book tag recognition.
	 * Groups: 1. - all tag content (codificator of book).
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getBookPattern() {
		return pBook;
	}


	/**
	 * Returns a pattern for chapter tag recognition.
	 * Groups: 1. - all tag content (number of chapter).
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getChapterPattern() {
		return pChapter;
	}


	/**
	 * Returns a pattern for empty tag recognition.
	 * Groups: no groups.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getEmptyPattern() {
		return pEmpty;
	}


	/**
	 * Returns a pattern for beginning-of-content-frame tag recognition.
	 * Groups: 1. - all tag content.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getHeaderPattern() {
		return pHeader;
	}


	/**
	 * Returns a pattern for end-of-content-frame (e.g. page or verse) tag recognition.
	 * Groups: 1. - all tag content.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getFooterPattern() {
		return pFooter;
	}


	/**
	 * Returns a pattern for errata tag recognition.
	 * Groups: 1. - correct form; 2. - errata.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getErrataPattern() {
		return pErrata;
	}


	/**
	 * Returns a pattern for recognition of foreign language tags.
	 * Groups: 1. - language code; 2. - all tag content.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getLangPattern() {
		return pLang;
	}


	/**
	 * Returns a pattern for manually-entered-string tag recognition.
	 * Groups: 1. - all tag content.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getManualPattern() {
		return pManual;
	}


	/**
	 * Returns a pattern for mixed tag string recognition.
	 * Groups: 1. - all tag content.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getMixedPattern() {
		return pMixed;
	}


	/**
	 * Returns a pattern for note tag recognition.
	 * Groups: 1. - all tag content.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getNotePattern() {
		return pNote;
	}


	/**
	 * Returns a pattern for page label recognition.
	 * Groups: 1. - page number extracted from page label.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getPagePattern() {
		return pPage;
	}


	/**
	 * Returns a pattern for parallel-text tag recognition.
	 * Groups: 1. - all tag content.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getParallelPattern() {
		return pParallel;
	}


	/**
	 * Returns a set of valid plain (non-markup) characters
	 * for use in recognition patterns.
	 * 
	 * @return string that representing all valid chars.
	 */
	public String getPlainChars() {
		return plain;
	}


	/**
	 * Returns a pattern for plain-text string recognition.
	 * Groups: 1. - all string matched to plain text.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getPlainPattern() {
		return pPlain;
	}


	/**
	 * Returns a pattern for source tag recognition.
	 * Groups: 1. - all tag content (source codificator).
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getSourcePattern() {
		return pSource;
	}


	/**
	 * Returns a pattern for comment tag recognition.
	 * Groups: 1. - all tag content.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getCommentPattern() {
		return pComment;
	}


	/**
	 * Returns a pattern for recognition of extended verse beginning (contains mixed elements) in text of GNP structure.
	 * Groups: 1. - verse number; 2. - first line of verse.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getVerseExGNPPattern() {
		return pVerseExGNP;
	}


	/**
	 * Returns a pattern for recognition of verse beginning in text of GNP structure.
	 * Groups: 1. - verse number; 2. - first line of verse.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getVerseGNPPattern() {
		return pVerseGNP;
	}


	/**
	 * Returns a pattern for recognition of extended verse beginning (contains mixed elements) in text of P structure.
	 * Groups: 1. - verse number; 3. - first line of verse.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getVerseExPPattern() {
		return pVerseExP;
	}


	/**
	 * Returns a pattern for recognition of verse beginning in text of P structure.
	 * Groups: 1. - verse number; 3. - first line of verse.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getVersePPattern() {
		return pVerseP;
	}


	/**
	 * Returns a pattern for recognition of waste text fragments.
	 * Groups: 1. - all tag content.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getIgnorePattern() {
		return pIgnore;
	}


	/**
	 * Returns a pattern for recognition of the hyphened part of a word form 
	 * that has been marked as a multi-word slip of a pen.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getHyphenedErrorPattern() {
		return pErrHyp;
	}
	
	
	/**
	 * 
	 * @return
	 */
	public Pattern getSuspicBracesPattern() {
		return pSuspicBraces;
	}
	
	
	/**
	 * 
	 * @return
	 */
	public Pattern getSuspicPagePattern() {
		return pSuspicPage;
	}
	
	
	/**
	 * Returns a pattern for recognition of suspicious verse beginning in text of P structure.
	 * Groups: 1. - verse number; 3. - first line of verse.
	 * 
	 * @return compiled pattern.
	 */
	public Pattern getSuspicVersePattern() {
		return pSuspicVerse;
	}


	/**
	 * 
	 * @param line
	 * @return
	 */
	public static String encodeNestedBraces(String line) {
		StringBuilder buff = new StringBuilder(line);
		int level = 0;
		
		for (int i = 0; i < buff.length(); i++) {
			if (buff.charAt(i) == '{') {
				level++;
				if (level > 1) buff.replace(i, i + 1, "©");
			}
			else if (buff.charAt(i) == '}') {
				if (level > 1) buff.replace(i, i + 1, "®");
				level--;
			}
		}
		
		return buff.toString();
	}
	
	
	/**
	 * 
	 * @param line
	 * @return
	 */
	public static String decodeNestedBraces(String line) {
		return line.replaceAll("©", "{").replaceAll("®", "}");
	}
	
	
	/**
	 * Additional checking of opening/closing braces.
	 * 
	 * @param line - a line to validate; the length must be at least 1.
	 * @return true if braces are balanced, false otherwise.
	 */
	public static boolean validBraces(String line) {
		int open = 0;
		
		for (int i = 0; i < line.length(); i++) {
			if (line.charAt(i) == '{') {
				open++;
			} else if (line.charAt(i) == '}') {
				open--;
			}
		}
		
		return (open == 0);
	}

}
