package corpus.senie.indexing;

import corpus.senie.util.IndexType;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.regex.Matcher;


/**
 * Splitting, HTML mark-up and storage of context fragments into the SENIE database to provide automatic context positioning.
 * Supported text positioning structures: GNP, LR, P.
 */
public class Contexter extends Recognizer {

	private BufferedReader text;
	private Marker marker;
	private Logger log;
	private DBManager db;


	/**
	 * Inserts the given context of GNP position into SENIE database.
	 *
	 * @param src - reference to the context source.
	 * @param book - reference to a book.
	 * @param chap - number of chapter.
	 * @param verse - number of verse.
	 * @param text - content of context.
	 * @return true if insertion succeed, false otherwise.
	 */
	private boolean insContext(int src, int book, int chap, int verse, String text) {
		boolean result = false;
		int contxtID   = -1;

		if (text.length() > 0) {
			contxtID = db.getContext(src, book, chap, verse);
			if (contxtID == -1)	{
				result = db.insContext(src, book, chap, verse, text);
			}
			else {
				result = db.updContext(DBManager.POS_GNP, contxtID, text);
			}
		}
		return result;
	}


	/**
	 * Inserts the given context of LR position into SENIE database.
	 *
	 * @param src - reference to the context source.
	 * @param page - number of page.
	 * @param row - number of row.
	 * @param text - content of context.
	 * @return true if insertion succeed, false otherwise.
	 */
	private boolean insContext(int src, String page, int row, String text) {
		boolean result = false;
		int contxtID   = -1;

		contxtID = db.getContext(src, page, row);
		if (contxtID == -1)	{
			db.insContext(src, page, row, text);
		}
		else {
			result = db.updContext(DBManager.POS_LR, contxtID, text);
		}
		return result;
	}


	/**
	 * Inserts the given context of P position into SENIE database.
	 *
	 * @param src - reference to the context source.
	 * @param verse - number of verse.
	 * @param text - content of context.
	 * @return true if insertion succeed, false otherwise.
	 */
	private boolean insContext(int src, String verse, String text) {
		boolean result = false;
		int contxtID   = -1;

		if (text.length() > 0) {
			contxtID = db.getContext(src, verse);
			if (contxtID == -1)	{
				db.insContext(src, verse, text);
			}
			else {
				result = db.updContext(DBManager.POS_P, contxtID, text);
			}
		}
		return result;
	}


	/**
	 * Constructor.
	 *
	 * @param source		codificator of source text, will be used as
	 *                      absolute file name for Contexter results.
	 * @param collection	codificator of text collection, or null, will be
	 *                      used for Marker.
	 **/
	public Contexter(String source, String collection) throws IOException {
		super();

		text = new BufferedReader(new InputStreamReader(new FileInputStream(source + ".txt"), "Cp1257"));
		marker = new Marker(source, collection);
		log = new Logger(source, "KONTEKSTU ATDALĪŠANA, MARĶĒŠANA UN IEVIETOŠANA DATUBĀZĒ", true);
		db = new DBManager();
	}


	/**
	 * Connects to the SENIE database.
	 *
	 * @param path - path to the database.
	 * @param user - user name.
	 * @param passwd - user password.
	 */
	public void dbConnect(String path, String user, String passwd) {
		db.connect(path, user, passwd);
	}


	/**
	 * Checks for the database connection state.
	 *
	 * @return true if connected, false otherwise.
	 */
	public boolean dbConnected() {
		return db.connected();
	}


	/**
	 * Disconnects from the SENIE database.
	 */
	public void dbDisconnect() {
		db.disconnect();
	}

	/**
	 * Wrapper for invoking any of splitX methods by given indexation type.
	 * @param type source indexing type
	 * @return true, if any method was called
	 */
	public boolean split (IndexType type
	) throws IOException
	{
		switch (type)
		{
			case GNP: splitGNP(); return true;
			case LR: splitLR(); return true;
			case P: splitP(); return true;
			default: return false;
		}
	}

	/**
	 * Processes a well-formed source text according to the book->chapter->verse structure.
	 */
	public void splitGNP() throws IOException {
		StringBuffer content = new StringBuffer();

		int chapter = -1;
		int verse   = -1;

		int authorID = -1;
		int bookID   = -1;
		int sourceID = -1;

		String author = "";
		String source = "";
		String line   = "";

		while ((line = text.readLine()) != null) {
			Matcher mVerse = getVerseExGNPPattern().matcher(line);

			if (!mVerse.matches()) {
				// It's important to keep first two white spaces of line that represents beginning of verse
				// to recognize it in further processing.
				line = encodeNestedBraces(line.trim());
			}

			Matcher mAuthor   = getAuthorPattern().matcher(line);
			Matcher mBook     = getBookPattern().matcher(line);
			Matcher mChapter  = getChapterPattern().matcher(line);
			Matcher mFoot     = getFooterPattern().matcher(line);
			Matcher mMixed    = getMixedPattern().matcher(line);
			Matcher mPlain    = getPlainPattern().matcher(line);
			Matcher mParallel = getParallelPattern().matcher(line);
			Matcher mSource   = getSourcePattern().matcher(line);

			if (mAuthor.matches()) {
				author = mAuthor.group(1);
				authorID = db.getAuthor(author);

				if (authorID == -1) {
					System.err.println("Author not found: {" + author + "}!");
				}

				if (sourceID != -1) {
					sourceID = db.getSource(authorID, source);
				}
			}
			else if (mSource.matches()) {
				source = mSource.group(1);
				sourceID = db.getSource(authorID, source);

				if (sourceID == -1) {
					System.err.println("Source not found: {" + author + "," + source + "}!");
				}
			}
			else if (mBook.matches()) {
				if (verse != -1) {
					// Inserts content of previous verse
					insContext(sourceID, bookID, chapter, verse, content.toString());
				}

				// Deletes previous context
				content.setLength(0);
				verse = -1;

				bookID = db.getBook(mBook.group(1), sourceID);
				if (bookID == -1) {
					System.err.println("Book not found: {" + mBook.group(1) + "}!");
				}
			}
			else if (mChapter.matches()) {
				if (verse != -1) {
					// Inserts content of previous verse
					insContext(sourceID, bookID, chapter, verse, content.toString());
				}

				// Deletes previous context
				content.setLength(0);
				verse = -1;

				chapter = Integer.parseInt(mChapter.group(1));
			}
			else if (mVerse.matches()) {
				insContext(sourceID, bookID, chapter, verse, content.toString());
				content.setLength(0);												// Deletes previous context

				verse = Integer.parseInt(mVerse.group(1));
				line = mVerse.group(2).trim();										// Extracts first line of verse

				if (!line.isEmpty()) {
					line = marker.markupComment(line);
					line = marker.markupLang(line);
					line = marker.markupStrikethrough(line);
					line = marker.markupNote(line);
					line = marker.markupManual(line);
					line = marker.markupErrata(line);

					content.append(decodeNestedBraces(line) + "<br>");				// Adds first line to context
				}
			}
			else if (!line.isEmpty() && mPlain.matches() && verse != -1) {
				line = marker.markupErrata(line);
				content.append(decodeNestedBraces(line) + "<br>");					// Adds regular line
			}
			else if (mParallel.matches() && verse != -1) {
				line = marker.markupParallel(line);
				content.append(decodeNestedBraces(line));							// Adds parallel text reference
			}
			else if (mFoot.matches() && verse != -1) {
				line = marker.markupFooter(line);
				content.append(decodeNestedBraces(line));							// Adds end of verse
			}
			else if (mMixed.matches() && verse != -1) {
				line = marker.markupComment(line);
				line = marker.markupLang(line);
				line = marker.markupStrikethrough(line);
				line = marker.markupNote(line);
				line = marker.markupManual(line);
				line = marker.markupErrata(line);

				content.append(decodeNestedBraces(line) + "<br>");					// Adds mixed line
			}
			else if (!line.isEmpty()) {
				log.append(Logger.DROPPED, decodeNestedBraces(line));
			}
		}

		// Inserts last verse
		insContext(sourceID, bookID, chapter, verse, content.toString());
	}


	/**
	 * Processes a well-formed source text according to the page->row structure.
	 */
	public void splitLR() throws IOException {
		int authorID = -1;
		int sourceID = -1;

		String author = "";
		String source = "";
		String page   = "";
		String line   = "";

		int row = 0;

		while ((line = text.readLine()) != null) {
			line = encodeNestedBraces(line.trim());

			Matcher mAuthor = getAuthorPattern().matcher(line);
			Matcher mMixed  = getMixedPattern().matcher(line);
			Matcher mPage   = getPagePattern().matcher(line);
			Matcher mPlain  = getPlainPattern().matcher(line);
			Matcher mSource = getSourcePattern().matcher(line);

			if (mAuthor.matches()) {
				author = mAuthor.group(1);
				authorID = db.getAuthor(author);

				if (authorID == -1) System.err.println("Author not found: {" + author + "}!");

				if (sourceID != -1) sourceID = db.getSource(authorID, source); // Written by several authors
			}
			else if (mSource.matches()) {
				source = mSource.group(1);
				sourceID = db.getSource(authorID, source);

				if (sourceID == -1) System.err.println("Source not found: {" + author + "," + source + "}!");
			}
			else if (mPage.matches()) {
				page = mPage.group(1);
				row = 0;
			}
			else if (!line.isEmpty() && mPlain.matches()) {
				line = marker.markupErrata(line);
				insContext(sourceID, page, ++row, decodeNestedBraces(line));
			}
			else if (mMixed.matches()) {
				line = marker.markupComment(line);
				line = marker.markupLang(line);
				line = marker.markupStrikethrough(line);
				line = marker.markupNote(line);
				line = marker.markupManual(line);
				line = marker.markupErrata(line);

				insContext(sourceID, page, ++row, decodeNestedBraces(line));
			}
			else if (!line.isEmpty()) {
				log.append(Logger.DROPPED, decodeNestedBraces(line));
			}
		}
	}


	/**
	 * Processes a well-formed source text according to the verse structure.
	 */
	public void splitP() throws IOException {
		StringBuffer content = new StringBuffer();

		int authorID = -1;
		int sourceID = -1;

		String author = "";
		String source = "";
		String verse  = "";
		String line   = "";

		while ((line = text.readLine()) != null) {
			Matcher mVerse = getVerseExPPattern().matcher(line);

			if (!mVerse.matches()) {
				// It's important to keep first two white spaces of line that represents beginning of verse
				// to recognize it in further processing.
				line = encodeNestedBraces(line.trim());
			}

			Matcher mAuthor   = getAuthorPattern().matcher(line);
			Matcher mFoot     = getFooterPattern().matcher(line);
			Matcher mMixed    = getMixedPattern().matcher(line);
			Matcher mPlain    = getPlainPattern().matcher(line);
			Matcher mParallel = getParallelPattern().matcher(line);
			Matcher mSource   = getSourcePattern().matcher(line);

			if (mAuthor.matches()) {
				author = mAuthor.group(1);
				authorID = db.getAuthor(author);

				if (authorID == -1) System.err.println("Author not found: {" + author + "}!");

				if (sourceID != -1) sourceID = db.getSource(authorID, source); // Written by several authors
			}
			else if (mSource.matches()) {
				source = mSource.group(1);
				sourceID = db.getSource(authorID, source);

				if (sourceID == -1) System.err.println("Source not found: {" + author + "," + source + "}!");
			}
			else if (mVerse.matches()) {
				insContext(sourceID, verse, content.toString());
				content.setLength(0);									// Deletes previous context

				verse = mVerse.group(1);								// Extracts number and
				line = mVerse.group(3).trim();							// and first line of verse

				if (!line.isEmpty()) {
					line = marker.markupComment(line);
					line = marker.markupLang(line);
					line = marker.markupStrikethrough(line);
					line = marker.markupNote(line);
					line = marker.markupManual(line);
					line = marker.markupErrata(line);

					content.append(decodeNestedBraces(line) + "<br>");	// Adds first line to context
				}
			}
			else if (!line.isEmpty() && mPlain.matches()) {
				line = marker.markupErrata(line);
				content.append(decodeNestedBraces(line) + "<br>");		// Adds regular line
			}
			else if (mParallel.matches()) {
				line = marker.markupParallel(line);
				content.append(decodeNestedBraces(line));				// Adds parallel text reference
			}
			else if (mFoot.matches()) {
				line = marker.markupFooter(line);
				content.append(decodeNestedBraces(line));				// Adds end of verse
			}
			else if (mMixed.matches()) {
				line = marker.markupComment(line);
				line = marker.markupLang(line);
				line = marker.markupStrikethrough(line);
				line = marker.markupNote(line);
				line = marker.markupManual(line);
				line = marker.markupErrata(line);

				content.append(decodeNestedBraces(line) + "<br>");		// Adds mixed line
			}
			else if (!line.isEmpty()) {
				log.append(Logger.DROPPED, decodeNestedBraces(line));
			}
		}

		// Inserts last verse
		insContext(sourceID, verse, content.toString());
	}


	/**
	 * Ends the context splitting process: closes the source file and writes log.
	 */
	public void close() throws IOException {
		text.close();
		log.close();
	}

}
