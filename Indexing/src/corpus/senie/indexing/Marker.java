package corpus.senie.indexing;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.IOException;
import java.util.regex.Matcher;


/**
 * HTML mark-up and static bookmarking of source text to provide automatic context positioning.
 * Supported text positioning structures: GNP, LR, P.
 */
public class Marker extends Recognizer {

	private BufferedReader text;
	private BufferedWriter html;
	private Logger log;


	/**
	 * Highlights author's name.
	 * 
	 * @param author - name for mark-up.
	 * @return marked line.
	 */
	private String markupAuthor(String author) {
		return "<p class=\"auth\">" + author + "</p>";
	}


	/**
	 * Highlights the codificator of a book.
	 * 
	 * @param book - codificator for mark-up.
	 * @return marked line.
	 */
	private String markupBook(String book) {
		return "<p class=\"book\">" + book + "</p>";
	}


	/**
	 * Highlights number of chapter.
	 * 
	 * @param chapter - number for mark-up.
	 * @return marked line.
	 */
	private String markupChapter(String chapter) {
		return "<p class=\"chap\">" + chapter + ". nodaļa</p>";
	}


	/**
	 * Highlights and bookmarks page number.
	 * 
	 * @param page - number for mark-up.
	 * @return marked line.
	 */
	private String markupPage(String page) {
		return "<p class=\"page\"><a name=\"" + page + "\">" + page + ". lpp.</a></p>";
	}


	/**
	 * Highlights source codificator.
	 * 
	 * @param source - codificator for mark-up.
	 * @return marked line.
	 */
	private String markupSource(String source) {
		return "<p class=\"src\">" + source + "</p>";
	}


	/**
	 * Highlights and bookmarks verse number. Positioning structure: GNP.
	 * 
	 * @param book - codificator of book.
	 * @param chap - number of chapter.
	 * @param verse - number for mark-up.
	 * @return marked line.
	 */
	private String markupVerse(String book, String chap, String verse) {
		return "<p class=\"verse\"><a name=\"" + book + "_" + chap + "_" + verse + "\">" + verse + ". pants</a></p>";
	}


	/**
	 * Highlights and bookmarks verse number. Positioning structure: P.
	 * 
	 * @param verse - number for mark-up.
	 * @return marked line.
	 */
	private String markupVerse(String verse) {
		return "<p class=\"verse\"><a name=\"" + verse + "\">" + verse + " pants</a></p>";
	}


	/**
	 * Constructor.
	 * 
	 * @param source		codificator of source text, will be used as
	 *                      absolute file name for Marker results.
	 * @param collection	codificator of text collection, or null, will be
	 *                      used to indicate path to css files in the html.
	 */
	public Marker(String source, String collection) throws IOException {
		super();

		text = new BufferedReader(new InputStreamReader(new FileInputStream(source + ".txt"), "Cp1257"));
		html = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(source + "_marked.htm"), "Cp1257"));

		html.write("<html>\n<head>\n");
		html.write("<meta http-equiv=\"content-type\" content=\"text/html; charset=windows-1257\">\n");
		if (collection == null || collection.trim().isEmpty())
			html.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"../source.css\">\n");
		else
			html.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"../../source.css\">\n");
		html.write("</head>\n<body>\n");
		html.write("<table align=\"center\" border=\"0\" width=\"80%\"><tr><td>\n");

		log = new Logger(source, "TEKSTA MARĶĒŠANA UN GRĀMATZĪMJU SALIKŠANA", true);
	}


	/**
	 * Highlights the beginning of a content frame.
	 * 
	 * @param line - line to search for the opus tag.
	 * @return marked line.
	 */
	public String markupHeader(String line) {
		Matcher mHead = getHeaderPattern().matcher(line);
		return mHead.replaceAll("<p class=\"opus\">$1</p>");
	}


	/**
	 * Highlights the end of a content frame.
	 * 
	 * @param line - line to search for the end tag.
	 * @return marked line.
	 */
	public String markupFooter(String line) {
		Matcher mFoot = getFooterPattern().matcher(line);
		return mFoot.replaceAll("<p class=\"end\">$1</p>");
	}


	/**
	 * Highlights comments.
	 * 
	 * @param line - line to search for comments.
	 * @return marked line.
	 */
	public String markupComment(String line) {
		Matcher mComment = getCommentPattern().matcher(line);
		return mComment.replaceAll("<span class=\"comment\">$1</span>");
	}


	/**
	 * Highlights erratas.
	 * 
	 * @param line - line to search for erratas.
	 * @return marked line.
	 */
	public String markupErrata(String line) {
		Matcher mErrata = getErrataPattern().matcher(line);
		return mErrata.replaceAll("$1<span class=\"errata\">{$2}</span>");
	}


	/**
	 * Highlights foreign language fragments.
	 * 
	 * @param line - line to search for fragments.
	 * @return marked line.
	 */
	public String markupLang(String line) {
		Matcher mLang = getLangPattern().matcher(line);
		return mLang.replaceAll("<span class=\"lang\">$2</span>");
	}


	/**
	 * Highlights manually entered text fragments.
	 * 
	 * @param line - line to search for fragments.
	 * @return marked line.
	 */
	public String markupManual(String line) {
		Matcher mManual = getManualPattern().matcher(line);
		return mManual.replaceAll("<span class=\"manual\">$1</span>");
	}


	/**
	 * Highlights notes.
	 * 
	 * @param line - line to search for notes.
	 * @return marked line.
	 */
	public String markupNote(String line) {
		Matcher mNote = getNotePattern().matcher(line);
		return mNote.replaceAll("<span class=\"note\">$1</span>");
	}


	/**
	 * Highlights parallel text references.
	 * 
	 * @param line - line to search for references.
	 * @return marked line.
	 */
	public String markupParallel(String line) {
		Matcher mParallel = getParallelPattern().matcher(line);
		return mParallel.replaceAll("<p class=\"para\">$1</p>");
	}

	/**
	 * Wrapper for invoking any of markupX methods by given indexation type.
	 * @param type source indexing type
	 * @return true, if any method was called
	 */
	public boolean markup (IndexType type
	) throws IOException
	{
		switch (type)
		{
			case GNP: markupGNP(); return true;
			case LR: markupLR(); return true;
			case GLR: markupGLR(); return true;
			case P: markupP(); return true;
			default: return false;
		}
	}

	/**
	 * Processes a well-formed source text according to the book->chapter->verse structure.
	 */
	public void markupGNP() throws IOException {
		String book  = "";
		String chap  = "";
		String verse = "";
		String line  = "";

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
			
			if (mBook.matches()) {
				html.write("</div>\n");									// Closes previous verse
				book = mBook.group(1);
				html.write(markupBook(book) + "\n");					// Marked book codificator
			}
			else if (mChapter.matches()) {
				html.write("</div>\n");									// Closes previous verse
				chap = mChapter.group(1);
				html.write(markupChapter(chap) + "\n");					// Marked number of chapter
			}
			else if (mVerse.matches()) {
				html.write("</div>\n");									// Closes previous verse
				html.write("<div class=\"verse\">\n");					// Opens new verse
				verse = markupVerse(book, chap, mVerse.group(1));
				html.write(verse + "\n");								// Marked verse number

				line = mVerse.group(2).trim();							// Extracts first line of verse
				if (!line.isEmpty()) {
					line = markupComment(line);
					line = markupLang(line);
					line = markupNote(line);
					line = markupManual(line);
					line = markupErrata(line);
					
					html.write(decodeNestedBraces(line) + "<br>\n");	// Marked first line of verse
				}
			}
			else if (!line.isEmpty() && mPlain.matches()) {
				line = markupErrata(line);
				html.write(decodeNestedBraces(line) + "<br>\n");		// Marked regular line
			}
			else if (mParallel.matches()) {
				line = markupParallel(line);
				html.write(decodeNestedBraces(line) + "\n");			// Marked parallel text reference
			}
			else if (mFoot.matches()) {
				line = markupFooter(line);
				html.write(decodeNestedBraces(line) + "\n");			// Marked end of verse
			}
			else if (mMixed.matches()) {
				line = markupComment(line);
				line = markupLang(line);
				line = markupNote(line);
				line = markupManual(line);
				line = markupErrata(line);
				
				html.write(decodeNestedBraces(line) + "<br>\n");		// Marked mixed line
			}
			else if (mAuthor.matches()) {
				line = markupAuthor(mAuthor.group(1));
				html.write(decodeNestedBraces(line) + "\n");			// Marked author's name
			}
			else if (mSource.matches()) {
				line = markupSource(mSource.group(1));
				html.write(decodeNestedBraces(line) + "\n");			// Marked source codificator
			}
			else if (!line.isEmpty()) {
				log.append(Logger.DROPPED, decodeNestedBraces(line));
			}
		}
	}


	/**
	 * Processes a well-formed source text according to the page->row structure.
	 */
	public void markupLR() throws IOException {
		String line = "";
		int row = 0;

		while ((line = text.readLine()) != null) {
			line = encodeNestedBraces(line.trim());

			Matcher mAuthor   = getAuthorPattern().matcher(line);
			Matcher mHead     = getHeaderPattern().matcher(line);
			Matcher mFoot     = getFooterPattern().matcher(line);
			Matcher mMixed    = getMixedPattern().matcher(line);
			Matcher mPage     = getPagePattern().matcher(line);
			Matcher mParallel = getParallelPattern().matcher(line);
			Matcher mPlain    = getPlainPattern().matcher(line);
			Matcher mSource   = getSourcePattern().matcher(line);

			if (mPage.matches()) {
				html.write("</div>\n");											// Closes previous page
				html.write("<div class=\"page\">\n");							// Opens new page
				
				line = markupPage(mPage.group(1));
				html.write(decodeNestedBraces(line) + "\n");					// Marked page number
				row = 0;
			}
			else if (!line.isEmpty() && mPlain.matches()) {
				line = markupErrata(line);
				html.write(++row + ": " + decodeNestedBraces(line) + "<br>\n");	// Marked regular line
			}
			else if (mMixed.matches()) {
				line = markupComment(line);
				line = markupLang(line);
				line = markupNote(line);
				line = markupManual(line);
				line = markupErrata(line);
				
				html.write(++row + ": " + decodeNestedBraces(line) + "<br>\n");	// Marked mixed line
			}
			else if (mParallel.matches()) {
				line = markupParallel(line);
				html.write(decodeNestedBraces(line) + "\n");					// Marked parallel text reference
			}
			else if (mFoot.matches()) {
				line = markupFooter(line);
				html.write(decodeNestedBraces(line) + "\n");					// Marked end of page
			}
			else if (mHead.matches()) {
				line = markupHeader(line);
				html.write(decodeNestedBraces(line) + "\n");					// Marked beginning of page
			}
			else if (mAuthor.matches()) {
				line = markupAuthor(mAuthor.group(1));
				html.write(decodeNestedBraces(line) + "\n");					// Marked author's name
			}
			else if (mSource.matches()) {
				line = markupSource(mSource.group(1));
				html.write(decodeNestedBraces(line) + "\n");					// Marked source codificator
			}
			else if (!line.isEmpty()) {
				log.append(Logger.DROPPED, decodeNestedBraces(line));
			}
		}
	}

	/**
	 * Processes a well-formed source text according to the page->row structure.
	 * Note: this is added >10 years latter without clear understanding.
	 */
	public void markupGLR() throws IOException {
		String book  = "";
		String line = "";
		int row = 0;

		while ((line = text.readLine()) != null) {
			line = encodeNestedBraces(line.trim());

			Matcher mAuthor   = getAuthorPattern().matcher(line);
			Matcher mBook     = getBookPattern().matcher(line);
			Matcher mHead     = getHeaderPattern().matcher(line);
			Matcher mFoot     = getFooterPattern().matcher(line);
			Matcher mMixed    = getMixedPattern().matcher(line);
			Matcher mPage     = getPagePattern().matcher(line);
			Matcher mParallel = getParallelPattern().matcher(line);
			Matcher mPlain    = getPlainPattern().matcher(line);
			Matcher mSource   = getSourcePattern().matcher(line);

			if (mBook.matches()) {
				html.write("</div>\n");									// Closes previous verse
				book = mBook.group(1);
				html.write(markupBook(book) + "\n");					// Marked book codificator
			}
			else if (mPage.matches()) {
				html.write("</div>\n");											// Closes previous page
				html.write("<div class=\"page\">\n");							// Opens new page

				line = markupPage(mPage.group(1));
				html.write(decodeNestedBraces(line) + "\n");					// Marked page number
				row = 0;
			}
			else if (!line.isEmpty() && mPlain.matches()) {
				line = markupErrata(line);
				html.write(++row + ": " + decodeNestedBraces(line) + "<br>\n");	// Marked regular line
			}
			else if (mMixed.matches()) {
				line = markupComment(line);
				line = markupLang(line);
				line = markupNote(line);
				line = markupManual(line);
				line = markupErrata(line);

				html.write(++row + ": " + decodeNestedBraces(line) + "<br>\n");	// Marked mixed line
			}
			else if (mParallel.matches()) {
				line = markupParallel(line);
				html.write(decodeNestedBraces(line) + "\n");					// Marked parallel text reference
			}
			else if (mFoot.matches()) {
				line = markupFooter(line);
				html.write(decodeNestedBraces(line) + "\n");					// Marked end of page
			}
			else if (mHead.matches()) {
				line = markupHeader(line);
				html.write(decodeNestedBraces(line) + "\n");					// Marked beginning of page
			}
			else if (mAuthor.matches()) {
				line = markupAuthor(mAuthor.group(1));
				html.write(decodeNestedBraces(line) + "\n");					// Marked author's name
			}
			else if (mSource.matches()) {
				line = markupSource(mSource.group(1));
				html.write(decodeNestedBraces(line) + "\n");					// Marked source codificator
			}
			else if (!line.isEmpty()) {
				log.append(Logger.DROPPED, decodeNestedBraces(line));
			}
		}
	}

	/**
	 * Processes a well-formed source text according to the verse structure.
	 */
	public void markupP() throws IOException {
		String line = "";

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

			if (mVerse.matches()) {
				html.write("</div>\n");									// Closes previous verse
				html.write("<div class=\"verse\">\n");					// Opens new verse
				
				line = markupVerse(mVerse.group(1));
				html.write(decodeNestedBraces(line) + "\n");			// Marked verse number

				line = mVerse.group(3).trim();							// Extracts first line of verse
				if (!line.equals("")) {
					line = markupComment(line);
					line = markupLang(line);
					line = markupNote(line);
					line = markupManual(line);
					line = markupErrata(line);
					
					html.write(decodeNestedBraces(line) + "<br>\n");	// Marked first line of verse
				}
			}
			else if (!line.isEmpty() && mPlain.matches()) {
				line = markupErrata(line);
				html.write(decodeNestedBraces(line) + "<br>\n");		// Marked regular line
			}
			else if (mParallel.matches()) {
				line = markupParallel(line);
				html.write(decodeNestedBraces(line) + "\n");			// Marked parallel text reference
			}
			else if (mFoot.matches()) {
				line = markupFooter(line);
				html.write(decodeNestedBraces(line) + "\n");			// Marked end of verse
			}
			else if (mMixed.matches()) {
				line = markupComment(line);
				line = markupLang(line);
				line = markupNote(line);
				line = markupManual(line);
				line = markupErrata(line);
				
				html.write(decodeNestedBraces(line) + "<br>\n");		// Marked mixed line
			}
			else if (mAuthor.matches()) {
				line = markupAuthor(mAuthor.group(1));
				html.write(decodeNestedBraces(line) + "\n");			// Marked author's name
			}
			else if (mSource.matches()) {
				line = markupSource(mSource.group(1));
				html.write(decodeNestedBraces(line) + "\n");			// Marked source codificator
			}
			else if (!line.isEmpty()) {
				log.append(Logger.DROPPED, decodeNestedBraces(line));
			}
		}
	}


	/**
	 * Ends the mark-up process: closes the source file, and writes the resulting HTML and log.
	 */
	public void close() throws IOException {
		html.write("</td></tr></table>\n</body>\n</html>");
		html.close();
		text.close();
		log.close();
	}

}