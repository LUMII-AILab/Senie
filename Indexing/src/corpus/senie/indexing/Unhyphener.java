package corpus.senie.indexing;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**
 * Unhyphenates the hyphened running words.
 * Supported text positioning structures: GNP, LR, P.
 * 
 * @version 12.01.2010, 20.11.2014
 * @author Normunds Grûzîtis
 */
public class Unhyphener extends Recognizer {

	private BufferedReader reader;
	private BufferedWriter writer;
	private Logger log;
	
	private Pattern pDefise = Pattern.compile("\\s*\\-+\\s*");
	//private Pattern pMember = Pattern.compile("(\\s+\\=\\s+)|(\\s+\\=\\s*)|(\\s*\\=\\s+)"); // Fuer's case
	
	
	/**
	 * Additional syntax checking of hyphens.
	 * 
	 * @param line - line to check.
	 * @return corrected text line.
	 */
	private String normalizeHyphens(String line) {
		if (getPagePattern().matcher(line).matches()) return line; // Do nothing
		
		// Replace unexpected regular hyphens with ambient white spaces
		return pDefise.matcher(line).replaceAll(" ").trim();
		
		//Fuer's case:
		//Matcher mMember = pMember.matcher(line);
		//line = mMember.replaceAll("=").trim(); // Remove white spaces around member marks
	}
	
		
	/**
	 * Constructor.
	 * 
	 * @param source - codificator of source text, will be used as absolute file name for Unhyphener results.
	 */
	public Unhyphener(String source) throws IOException {
		super();
		
		reader = new BufferedReader(new InputStreamReader(new FileInputStream(source + "_cleaned.txt"), "Cp1257"));
		writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(source + "_unhyphened.txt"), "Cp1257"));
		log = new Logger(source, "VÂRDLIETOJUMU SAVILKÐANA TEKSTÂ", true);
	}
	
	
	/**
	 * Processes a cleaned source text according to the rules of page->row structure.
	 */
	public void unhyphenRow() throws IOException {
		final int PT_REGULAR_LINE  = 0; // Regular text line
		final int PT_SINGLE_HYPHEN = 1; // Normally hyphened word
		final int PT_MULTI_HYPHEN  = 2; // Over several lines
		final int PT_SINGLE_CROSS  = 3; // Over page border
		final int PT_MULTI_CROSS   = 4; // Over page border and several lines
		
		String curr  = "";
		String prev  = "";
		String tight = "";
		String page  = "";
		
		int empty_1 = 0; // Empty line count for current page
		int empty_2 = 0; // Empty line count for next page
		
		int printType = PT_REGULAR_LINE;
		
		boolean concat    = false;
		boolean print     = true;
		boolean crossPage = false;
		boolean oldHypen  = false;
		
		while ((curr = reader.readLine()) != null) {
			if (concat) {
				Matcher mPage = getPagePattern().matcher(curr);
				Matcher mLang = getLangPattern().matcher(curr);
				
				if (!mPage.matches() && !mLang.matches()) {
					// Check for hyphenation over pages
					
					if (curr.indexOf(" ") != -1) {
						// Unhyphen the hyphened part of a word
						
						//Pârbauda vai savelkamajai daïai nav piekabinâts kïûdas labojums;
						//ja ir, òem kopâ ar visâm figûriekavâm (t.sk. ja tajâs ir vairâki vârdi).
						String temp = curr.substring(0, curr.indexOf(" "));
						String sepa = " ";
						Matcher mErrHyp = getHyphenedErrorPattern().matcher(temp);
						if (mErrHyp.matches()) {
							temp = curr.substring(0, curr.indexOf("}") + 1);
							sepa = "}";
						}
						
						tight = prev+temp;
						writer.write(normalizeHyphens(tight)+"\r\n");
						curr = curr.substring(curr.indexOf(sepa) + 1).trim();
						
						if (!crossPage) {
							printType = PT_SINGLE_HYPHEN;
						}
						else {
							oldHypen = false;
							printType = PT_SINGLE_CROSS;
						}
					}
					else {
						curr = prev+curr;			//Word is splitted over several lines.
						
						if (!crossPage) {
							++empty_1;
							printType = PT_MULTI_HYPHEN;
						}
						else {
							++empty_2;
							if (curr.endsWith("-") || curr.endsWith("=")) {
								oldHypen = true;	//Hyphen continues over page border.
							}
							printType = PT_MULTI_CROSS;
						}
					}
				}
				else if (!mLang.matches()) {
					page = curr;
					crossPage = true;
					curr = reader.readLine();
					
					if (curr.indexOf(" ") != -1) {	//Unhyphenates hyphened part of word.
						tight = prev+curr.substring(0, curr.indexOf(" "));
						writer.write(normalizeHyphens(tight) + "\r\n");
						curr = curr.substring(curr.indexOf(" ") + 1).trim();
						
						printType = PT_SINGLE_CROSS;
					}
					else {
						curr = prev+curr;			//Word is splitted over several lines.
						
						++empty_2;
						if (curr.endsWith("-") || curr.endsWith("=")) {
							oldHypen = true;		//Hyphen continues over page border.
						}
						printType = PT_MULTI_CROSS;
					}
				}
				else {								//Seko valodas tags
					tight = prev;
					writer.write(normalizeHyphens(tight) + "\r\n");
					printType = PT_SINGLE_HYPHEN;
				}
				
				concat = false;
			}
			
			if (curr.endsWith("-") && !(curr.endsWith(" -") || curr.endsWith("--"))) {	//Removes regular hyphen.
				prev = curr.substring(0, curr.length() - 1).trim();
				concat = true;
				
				if (crossPage && !oldHypen) {
					print = true;
				}
				else {
					print = false;
				}
			}
			else if (curr.endsWith("=")) {	//Member mark is kept.
				prev = curr;
				concat = true;
				
				if (crossPage && !oldHypen) {
					print = true;
				}
				else {
					print = false;
				}
			}
			else {
				print = true;
			}
			
			if (print) {
				Pattern pIgnore = getIgnorePattern();
				Matcher mIgnore = pIgnore.matcher(curr);
				if ((printType != PT_SINGLE_CROSS) && !mIgnore.matches()) {
					curr = normalizeHyphens(curr);
				}
				else {
					//Hyphen must be kept over page border.
					String tail = "";
					if (curr.endsWith("-")) {
						tail = "-";
					}
					curr = normalizeHyphens(curr);
					curr = curr + tail;
				}
				
				switch (printType) {				//Determines order of lines
					case PT_REGULAR_LINE:			//to be printed in resulting file.
						if (!curr.equals("")) {
							writer.write(curr+"\r\n");
						}
						break;
					case PT_SINGLE_HYPHEN:
						while (empty_1 != 0) {		//Provides proper line count.
							writer.write("@x{}\r\n");
							--empty_1;
						}
						writer.write(curr+"\r\n");	//Writes remaining line.
						break;
					case PT_MULTI_HYPHEN:
						writer.write(curr+"\r\n");	//Writes unhyphened line.
						while (empty_1 != 0) {		//Provides proper line count.
							writer.write("@x{}\r\n");
							--empty_1;
						}
						break;
					case PT_SINGLE_CROSS:
						while (empty_1 != 0) {		//Proper line count in current page.
							writer.write("@x{}\r\n");
							--empty_1;
						}
						writer.write(page+"\r\n");	//Writes page label.
						while (empty_2 != 0) {		//Proper line count in next page.
							writer.write("@x{}\r\n");
							--empty_2;
						}
						
						if (curr.endsWith("-")) {	//Removes regular hyphen.
							prev = curr.substring(0, curr.length() - 1).trim();
							concat = true;
						}
						else if (curr.endsWith("=")) {			
							prev = curr;			//Member mark is kept.
							concat = true;
						}
						else {						//Writes remaining line.
							writer.write(curr+"\r\n");	
						}
						break;
					case PT_MULTI_CROSS:
						writer.write(curr+"\r\n");	//Writes unhyphened line.
						while (empty_1 != 0) {		//Proper line count in current page.
							writer.write("@x{}\r\n");
							--empty_1;
						}
						writer.write(page+"\r\n");	//Writes page label.
						while (empty_2 != 0) {		//Proper line count in next page.
							writer.write("@x{}\r\n");
							--empty_2;
						}
						break;
					default: 
						System.err.println("Print type haven't specified!");
						break;
				}
				
				crossPage = false;
				oldHypen = false;
				printType = PT_REGULAR_LINE;
			}
		}
	}


	/**
	 * Processes a cleaned source text according to the rules of book->chapter->verse or verse structure.
	 * 
	 * @param gnp - true if the GNP structure, false if P.
	 */
	public void unhyphenVerse(boolean gnp) throws IOException {
		String curr = "";
		String prev = "";
		String tight = "";
		
		boolean concat = false;
		
		while ((curr = reader.readLine()) != null) {
			if (concat) {
				Matcher mBook = getBookPattern().matcher(curr);			
				Matcher mChapter = getChapterPattern().matcher(curr);
				Matcher mVerse = (gnp) ? getVerseGNPPattern().matcher(curr) : getVersePPattern().matcher(curr);
				
				if (mBook.matches() || mChapter.matches() || mVerse.matches()) {
					log.append(Logger.ILLEGAL, prev);
				}
				
				if (curr.indexOf(" ") != -1) {
					// Unhyphenate the hyphened part of a word
					tight = prev + curr.substring(0, curr.indexOf(" "));
					writer.write(normalizeHyphens(tight) + "\r\n");
					curr = curr.substring(curr.indexOf(" ") + 1);
				} else {
					// The word is split over several lines
					curr = prev + curr;
				}
				
				concat = false;		
			}
			
			if (curr.endsWith("-")) {
				// Removes a regular hyphen
				prev = curr.substring(0, curr.length() - 1);
				concat = true;
			} else if (curr.endsWith("=")) {
				// The member mark is kept
				prev = curr;						
				concat = true;
			}
			
			if (!concat) writer.write(normalizeHyphens(curr) + "\r\n");
		}
	}
	
	
	/**
	 * Ends the unhyphenation process: closes the source file, writes the resulting text and log.
	 */
	public void close() throws IOException {
		log.close();
		writer.close();
		reader.close();
	}

}
