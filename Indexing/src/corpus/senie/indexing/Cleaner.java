package corpus.senie.indexing;

import corpus.senie.util.IndexType;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.IOException;
import java.util.regex.Matcher;


/**
 * Removes irrelevant text fragments and checks the mark-up syntax.
 * Supported text positioning structures: GNP, LR, P.
 */
public class Cleaner extends Recognizer {

	private BufferedReader reader;
	private BufferedWriter writer;
	private Logger log;
	
	
	/**
	 * Keeps manually entered text substrings, removing tags.
	 * 
	 * @param line - string to search for substrings.
	 * @return cleaned string.
	 */
	private String cleanupManual(String line) {
		Matcher mManual = getManualPattern().matcher(line);
		return mManual.replaceAll("$1").trim();
	}


	/**
	 * Removes waste text substrings.
	 * 
	 * @param line - string to search for waste substrings.
	 * @return cleaned string.
	 */
	private String cleanupWaste(String line) {
		Matcher mWaste = getIgnorePattern().matcher(line);
		return mWaste.replaceAll("/").trim();
	}
	
	
	/**
	 * Additional checking of opening/closing braces.
	 * 
	 * @param line - a line to validate; the length must be at least 1.
	 * @return true if braces are balanced, false otherwise.
	 */
	private boolean validBracesInContext(String line) {
		Matcher mSuspicious = getSuspicBracesPattern().matcher(line);
		if (mSuspicious.find()) log.append(Logger.SUSPICIOUS, decodeNestedBraces(line));
		
		return validBraces(line);
	}
	
	
	/**
	 * Constructor.
	 * 
	 * @param source - codificator of source text, will be used as absolute file name for Cleaner results.
	 */
	public Cleaner(String source) throws IOException {
		super();

		reader = new BufferedReader(new InputStreamReader(new FileInputStream(source + ".txt"), "Cp1257"));
		writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(source + "_cleaned.txt"), "Cp1257"));
		log = new Logger(source, "TEKSTA ATTĪRĪŠANA UN PĀRBAUDE", false);
	}

	/**
	 * Wrapper for invoking any of cleanX methods by given indexation type.
	 * @param type source indexing type
	 * @return true, if any method was called
	 */
	public boolean clean (IndexType type
	) throws IOException
	{
		switch (type)
		{
			case GNP: cleanGNP(); return true;
			case LR: cleanLR(); return true;
			case GLR: cleanGLR(); return true;
			case P: cleanP(); return true;
			default: return false;
		}
	}

	/**
	 * Processes source text according to rules of book->chapter->verse structure.
	 */
	public void cleanGNP() throws IOException {
		String line = "";

		while ((line = reader.readLine()) != null) {
			Matcher mVerse = getVerseExGNPPattern().matcher(line);
			Matcher mSuspic = getSuspicVersePattern().matcher(line);
			
			if (!mVerse.matches()) {
				// It's important to keep first two white spaces of line that represents beginning of verse
				// to recognize it in further processing.
				if (mSuspic.matches()) log.append(Logger.SUSPICIOUS, line);
				line = encodeNestedBraces(line.trim());
			}

			Matcher mAuthor = getAuthorPattern().matcher(line);
			Matcher mBook = getBookPattern().matcher(line);
			Matcher mChapter = getChapterPattern().matcher(line);
			Matcher mMixed = getMixedPattern().matcher(line);
			Matcher mPlain = getPlainPattern().matcher(line);
			Matcher mSource = getSourcePattern().matcher(line);
			Matcher mNote = getNotePattern().matcher(line);
			Matcher mWaste = getIgnorePattern().matcher(line);

			if (mNote.matches()) {
				writer.write(decodeNestedBraces(line) + "\r\n");	// Do not change that type of line
			}
			else if (mWaste.matches()) {
				//log.append(Logger.DROPPED, line);
			}
			else if (mVerse.matches() && validBracesInContext(line)) {
				String num = mVerse.group(1);

				String txt = mVerse.group(2).trim();
				txt = cleanupWaste(cleanupManual(txt));

				writer.write("@@" + num + ". " + decodeNestedBraces(txt) + "\r\n");
			}
			else if (mChapter.matches() || mBook.matches() || mAuthor.matches() || mSource.matches()
					|| (!line.isEmpty() && mPlain.matches() && validBracesInContext(line))) {
				writer.write(decodeNestedBraces(line) + "\r\n");	// Do not change that type of line
			}
			else if (mMixed.matches() && validBracesInContext(line)) {
				line = cleanupWaste(cleanupManual(line));			// Clean up the mixed line
				if (!line.isEmpty()) writer.write(decodeNestedBraces(line) + "\r\n");
			}
			else if (!line.isEmpty()) {
				if (!validBracesInContext(line)) {
					log.append(Logger.ILLEGAL, decodeNestedBraces(line));	// Braces are not well-formed
				} else {
					log.append(Logger.UNDEFINED, decodeNestedBraces(line));	// Line did not match any pattern
				}
			}
		}
	}


	/**
	 * Processes source text according to rules of page->row structure.
	 */
	public void cleanLR() throws IOException {
		String line = "";

		while ((line = reader.readLine()) != null) {
			line = line.trim();
			
			Matcher mPage = getPagePattern().matcher(line);
			Matcher mSuspicPage = getSuspicPagePattern().matcher(line);
			
			if (!mPage.matches() && mSuspicPage.matches()) log.append(Logger.SUSPICIOUS, line); 
			
			line = encodeNestedBraces(line);
			
			Matcher mAuthor = getAuthorPattern().matcher(line);
			Matcher mHead = getHeaderPattern().matcher(line);
			Matcher mFoot = getFooterPattern().matcher(line);
			Matcher mMixed = getMixedPattern().matcher(line);
			Matcher mParallel = getParallelPattern().matcher(line);
			Matcher mPlain = getPlainPattern().matcher(line);
			Matcher mSource = getSourcePattern().matcher(line);
			Matcher mWaste = getIgnorePattern().matcher(line);

			if (mHead.matches() || mFoot.matches() || mParallel.matches()) {
				//log.append(Logger.DROPPED, line);
			}
			else if (mWaste.matches() || mPage.matches() ||	mAuthor.matches() || mSource.matches()
					|| (!line.isEmpty() && mPlain.matches() && validBracesInContext(line))) {
				writer.write(decodeNestedBraces(line) + "\r\n");	// Do not change that type of line
			}
			else if (mMixed.matches() && validBracesInContext(line)) {
				line = cleanupWaste(cleanupManual(line));			// Clean up the mixed line
				if (!line.isEmpty()) writer.write(decodeNestedBraces(line) + "\r\n");
			}
			else if (!line.isEmpty()) {
				if (!validBracesInContext(line)) {
					log.append(Logger.ILLEGAL, decodeNestedBraces(line));	// Braces are not well-formed
				} else {
					log.append(Logger.UNDEFINED, decodeNestedBraces(line));	// Line did not match any pattern
				}
			}
		}
	}

	/**
	 * Processes source text according to rules of book->page->row structure.
	 *
	 * Note: this is added >10 years latter without clear understanding.
	 */
	public void cleanGLR() throws IOException {
		String line = "";

		while ((line = reader.readLine()) != null) {
			line = line.trim();

			Matcher mPage = getPagePattern().matcher(line);
			Matcher mSuspicPage = getSuspicPagePattern().matcher(line);

			if (!mPage.matches() && mSuspicPage.matches()) log.append(Logger.SUSPICIOUS, line);

			line = encodeNestedBraces(line);

			Matcher mAuthor = getAuthorPattern().matcher(line);
			Matcher mBook = getBookPattern().matcher(line);
			Matcher mHead = getHeaderPattern().matcher(line);
			Matcher mFoot = getFooterPattern().matcher(line);
			Matcher mMixed = getMixedPattern().matcher(line);
			Matcher mParallel = getParallelPattern().matcher(line);
			Matcher mPlain = getPlainPattern().matcher(line);
			Matcher mSource = getSourcePattern().matcher(line);
			Matcher mWaste = getIgnorePattern().matcher(line);


			if (mHead.matches() || mFoot.matches() || mParallel.matches()) {
				//log.append(Logger.DROPPED, line);
			}
			else if (mWaste.matches() || mPage.matches() ||	mBook.matches() || mAuthor.matches() || mSource.matches()
					|| (!line.isEmpty() && mPlain.matches() && validBracesInContext(line))) {
				writer.write(decodeNestedBraces(line) + "\r\n");	// Do not change that type of line
			}
			else if (mMixed.matches() && validBracesInContext(line)) {
				line = cleanupWaste(cleanupManual(line));			// Clean up the mixed line
				if (!line.isEmpty()) writer.write(decodeNestedBraces(line) + "\r\n");
			}
			else if (!line.isEmpty()) {
				if (!validBracesInContext(line)) {
					log.append(Logger.ILLEGAL, decodeNestedBraces(line));	// Braces are not well-formed
				} else {
					log.append(Logger.UNDEFINED, decodeNestedBraces(line));	// Line did not match any pattern
				}
			}
		}
	}

	/**
	 * Processes source text according to rules of verse structure.
	 */
	public void cleanP() throws IOException {
		String line = "";

		while ((line = reader.readLine()) != null) {
			Matcher mVerse = getVerseExPPattern().matcher(line);
			Matcher mSuspic = getSuspicVersePattern().matcher(line);

			if (!mVerse.matches()) {						
				// It's important to keep first two white spaces of line that represents beginning of verse
				// to recognize it in further processing.
				if (mSuspic.matches()) log.append(Logger.SUSPICIOUS, line); 
				line = encodeNestedBraces(line.trim()); 
			}

			Matcher mAuthor = getAuthorPattern().matcher(line);
			Matcher mMixed = getMixedPattern().matcher(line);
			Matcher mPlain = getPlainPattern().matcher(line);
			Matcher mSource = getSourcePattern().matcher(line);
			Matcher mWaste = getIgnorePattern().matcher(line);

			if (mWaste.matches()) {
				//log.append(Logger.DROPPED, line);
			}
			else if (mVerse.matches() && validBracesInContext(line)) {
				String num = mVerse.group(1);

				String txt = mVerse.group(3).trim();
				txt = cleanupWaste(cleanupManual(txt));

				writer.write("@@" + num + " " + decodeNestedBraces(txt) + "\r\n");
			}
			else if ((!line.isEmpty() && mPlain.matches() && validBracesInContext(line)) ||	mAuthor.matches() || mSource.matches()) {
				writer.write(decodeNestedBraces(line) + "\r\n");	// Do not change that type of line
			}
			else if (mMixed.matches() && validBracesInContext(line)) {
				line = cleanupWaste(cleanupManual(line));			// Clean up the mixed line
				if (!line.isEmpty()) writer.write(decodeNestedBraces(line) + "\r\n");
			}
			else if (!line.isEmpty()) {
				if (!validBracesInContext(line)) {
					log.append(Logger.ILLEGAL, decodeNestedBraces(line));	// Braces are not well-formed
				} else {
					log.append(Logger.UNDEFINED, decodeNestedBraces(line));	// Line did not match any pattern
				}
			}
		}
	}


	/**
	 * Ends cleaning process: closes source file and writes resulting text and process log.
	 */
	public void close() throws IOException {
		log.close();
		writer.flush();
		writer.close();
		reader.close();
	}

}