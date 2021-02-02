package corpus.senie.indexing;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.stream.Collectors;


/**
 * Indexing and statistics of word forms. Provides storage in different formats.
 * Supported text positioning structures: GNP, LR, P.
 */
public class Indexer extends Recognizer {

	private Map<String, List<PosStructure>> index;

	private DBManager db;
	private Logger log;

	private int running;

	private String authname;
	private String srccode;
	private String abssrc;


	/**
	 * Updates the index of word forms from the given list of running words.
	 *
	 * @param words - the list of running words.
	 * @param pos - position - object of class inherited from PosStructure.
	 */
	private void addPosition(List<String> words, PosStructure pos) {
		for (String word : words) {
			List<PosStructure> list = index.get(word);

			if (list == null) {
				// Word form doesn't exist in index yet
				list = new LinkedList<PosStructure>();
				list.add((PosStructure) pos.clone());
				index.put(word, list);
			}
			else {
				boolean exists = false;

				for (PosStructure curr : list) {
					if (curr.equals(pos)) {
						// Word form already indexed in this position; increase count
						curr.incCount();
						exists = true;
						break;
					}
				}

				if (!exists) list.add((PosStructure) pos.clone()); // Add new position
			}
		}
	}


	/**
	 * Inserts the given GNP positions into a table GNP_POSITIONS.
	 *
	 * @param list - list of positions.
	 * @param srcID - reference to source text.
	 * @param crossID - reference to cross word form.
	 */
	private void insPositionsGNP(List<PosStructure> list, int srcID, int crossID) {
		int bookID = -1;
		String prevbook = "";

		for (PosStructure pos : list) {
			String book = ((GNPPosition) pos).getBook();
			int chapter = ((GNPPosition) pos).getChapter();
			int verse = ((GNPPosition) pos).getVerse();
			int count = pos.getCount(); // Word form occurrences in this position

			if (!book.equals(prevbook)) { // Communicate with DB only if necessary
				prevbook = book;
				bookID = db.getBook(book, srcID); // Book reference must be prepared in advance

				if (bookID == -1) System.err.println("Book not found: {" + book + "}!");
			}

			int contID = db.getContext(srcID, bookID, chapter, verse); // Context reference must be prepared in advance
			if (contID == -1) {
				System.err.println("Context of GNP structure not found: {" + srcID + "," + bookID + "," + chapter + "," + verse + "}!");
			}

			int posID = db.getPosition(crossID, bookID, chapter, verse);
			if (posID == -1) {
				db.insPosition(crossID, bookID, chapter, verse, count, contID);
			} else {
				db.updPosition(DBManager.POS_GNP, posID, count, contID);
			}
		}
	}


	/**
	 * Inserts the given LR positions into a table LR_POSITIONS.
	 *
	 * @param list - list of positions.
	 * @param srcID - reference to source text.
	 * @param crossID - reference to cross word form.
	 */
	private void insPositionsLR(List<PosStructure> list, int srcID, int crossID) {
		for (PosStructure pos : list) {
			String page = ((LRPosition) pos).getPage();
			int row = ((LRPosition) pos).getRow();
			int count = pos.getCount(); // Word form occurrences in this position

			int contID = db.getContext(srcID, page, row); // Context reference must be prepared in advance
			if (contID == -1) {
				System.err.println("Context of LR structure not found: {" + srcID + "," + page + "," + row + "}!");
			}

			int posID = db.getPosition(crossID, page, row);
			if (posID == -1) {
				db.insPosition(crossID, page, row, count, contID);
			} else {
				db.updPosition(DBManager.POS_LR, posID, count, contID);
			}
		}
	}


	/**
	 * Inserts the given P positions into a table P_POSITIONS.
	 *
	 * @param list - list of positions.
	 * @param srcID - reference to source text.
	 * @param crossID - reference to cross word form.
	 */
	private void insPositionsP(List<PosStructure> list, int srcID, int crossID) {
		for (PosStructure pos : list) {
			String verse = ((PPosition) pos).getVerse();
			int count = pos.getCount(); // Word form occurrences in this position

			int contID = db.getContext(srcID, verse); // Context reference must be prepared
			if (contID == -1) {
				System.err.println("Context of P structure not found: {" + srcID + "," + verse + "}!");
			}

			int posID = db.getPosition(crossID, verse);
			if (posID == -1) {
				db.insPosition(crossID, verse, count, contID);
			} else {
				db.updPosition(DBManager.POS_P, posID, count, contID);
			}
		}
	}


	/**
	 * Inserts the given normalized plain GNP context into a table GNP_CONTEXTS.
	 *
	 * @param text - normalized context.
	 * @param book - book name.
	 * @param chap - chapter number.
	 * @param verse - verse number.
	 */
	private void insPlainGNP(String text, String book, int chap, int verse) {
		if (!dbPrepared()) {
			System.err.println("SENIE database not prepared!");
			return;
		}

		int srcID = db.getSource(db.getAuthor(authname), srccode);
		int bookID = db.getBook(book, srcID);
		int contID = db.getContext(srcID, bookID, chap, verse);

		db.updPlainContext(DBManager.POS_GNP, contID, text);
	}


	/**
	 * Inserts the given normalized plain LR context into a table LR_CONTEXTS.
	 *
	 * @param text - normalized context.
	 * @param page - page number.
	 * @param row - row number.
	 */
	private void insPlainLR(String text, String page, int row) {
		if (!dbPrepared()) {
			System.err.println("SENIE database not prepared!");
			return;
		}

		int srcID = db.getSource(db.getAuthor(authname), srccode);
		int contID = db.getContext(srcID, page, row);

		db.updPlainContext(DBManager.POS_LR, contID, text);
	}


	/**
	 * Inserts the given normalized plain P context into a table P_CONTEXTS.
	 *
	 * @param text - normalized context.
	 * @param verse - verse number.
	 */
	private void insPlainP(String text, String verse) {
		if (!dbPrepared()) {
			System.err.println("SENIE database not prepared!");
			return;
		}

		int srcID = db.getSource(db.getAuthor(authname), srccode);
		int contID = db.getContext(srcID, verse);

		db.updPlainContext(DBManager.POS_P, contID, text);
	}


	/**
	 * Creates a string from given token list.
	 *
	 * @param tokens - token list.
	 * @return created string.
	 */
	private String tokensToString(List<String> tokens) {
		StringBuilder buffer = new StringBuilder();

		for (String word : tokens) buffer.append(word + " ");

		return buffer.toString();
	}


	/**
	 * GNP positioning structure.
	 */
	public static final int POS_GNP = 1;

	/**
	 * LR positioning structure.
	 */
	public static final int POS_LR = 2;

	/**
	 * P positioning structure.
	 */
	public static final int POS_P = 3;


	/**
	 * Converts the given word form into lower case.
	 *
	 * @param wform - the word form to convert.
	 * @return conversion result - word form in lower case.
	 */
	public static String toLowerCase(String wform) {
		if (wform.matches("[IVXLCDM]+")) {
			// Romiešu cipari
			return wform.toLowerCase();
		}

		StringBuilder lower = new StringBuilder();

		for (int indx = 0; indx < wform.length() - 1; indx++) {
			if (wform.charAt(indx) == 'V') {
				lower.append('u'); // Upper 'V' => lower 'u'
			} else if (wform.charAt(indx) == 'J') {
				// Upper 'J' => lower 'j' if next char is vowel; lower 'i' otherwise
				switch (wform.charAt(indx + 1)) {
					case 'a': case 'A':
					case 'ā': case 'Ā':
					case 'ä': case 'Ä':
					case 'æ': case 'Æ':
					case 'e': case 'E':
					case 'ē': case 'Ē':
					case 'i': case 'I':
					case 'ī': case 'Ī':
					case 'o': case 'O':
					case 'ō': case 'Ō':
					case 'ö': case 'Ö':
					case 'u': case 'U':
					case 'ū': case 'Ū':
					case 'ü': case 'Ü':
						lower.append('j');
						break;
					default:
						lower.append('i');
						break;
				}
			} else {
				lower.append(wform.charAt(indx)); // Other chars are converted regularly
			}
		}

		lower.append(wform.charAt(wform.length() - 1));	// Append the last character

		return lower.toString().toLowerCase();
	}


	/**
	 * Tokenizes running words out of the given text line.
	 *
	 * @param line - text line to tokenize.
	 * @param lower - if true, converts all tokens to lower case.
	 * @return list of all tokens.
	 */
	public static List<String> tokenize(String line, boolean lower, Logger log) {
		String prev  = "";
		String next  = "";

		String marks = "!?.,:;-+*†/|\\()[]<>\" \t\n\f\r";

		StringTokenizer tokenizer = new StringTokenizer(line, marks, true);
		List<String> tokens = new LinkedList<String>();

		boolean concat = false;
		boolean skip   = false;

		while (tokenizer.hasMoreTokens()) {
			skip = false;
			next = tokenizer.nextToken();

			if ((next.indexOf("{") != -1) && (next.indexOf("}") == -1)) {
				// All symbols are kept in errata fragments
				prev = next;
				concat = true;
				skip = true;
			} else if ((next.indexOf("{") == -1) && (next.indexOf("}") != -1)){
				prev = prev + next;

				if (lower) prev = toLowerCase(prev);
				if (!prev.equals("=")) tokens.add(prev);

				concat = false;
				skip = true;
			}

			if (!concat && !skip && (marks.indexOf(next) == -1)) {
				if (lower) next = toLowerCase(next);
				if (!next.equals("=")) tokens.add(next);
			} else if (!skip) {
				prev = prev + next;
			}
		}

		for (String t : tokens) {
			Matcher mAlpha = pWForm.matcher(t);
			if (!validBraces(t) || !mAlpha.matches()) log.append(Logger.ILLEGAL, t);
		}

		return tokens;
	}


	/**
	 * Constructor.
	 *
	 * @param source - codificator of the source that will be indexed.
	 */
	public Indexer(String source) {
		super();

		index = new TreeMap<String, List<PosStructure>>();
		db = new DBManager();
		log = new Logger(source, "TEKSTA INDEKSĒŠANA UN STATISTIKA", true);

		running = 0;
		authname = "";
		srccode = "";
		abssrc = source;
	}


	/**
	 * Clears entire index deleting all inserted word forms and position lists.
	 * Running word and word form count sets to 0.
	 */
	public void clear() {
		index.clear();
		running = 0;
		authname = "";
		srccode = "";
	}


	/**
	 * Retrieves total count of running words for processed text(s).
	 *
	 * @return count greater or equal to 0.
	 */
	public int countRW() {
		return running;
	}


	/**
	 * Retrieves total count of word forms for created index.
	 *
	 * @return count greater or equal to 0.
	 */
	public int countWF() {
		return index.size();
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
	 * Disconnects from the SENIE database.
	 */
	public void dbDisconnect() {
		db.disconnect();
	}


	/**
	 * Checks whether the DB is prepared for storing the created index.
	 *
	 * @return true if database is ready, false otherwise.
	 */
	public boolean dbPrepared() {
		if (!db.connected()) return false;

		if (authname.isEmpty() || srccode.isEmpty()) return false;

		return true;
	}

	/**
	 * Wrapper for invoking any of indexX methods by given indexation type.
	 * @param type	source indexing type
	 * @param src	source codificator
	 * @param auth	author's name
	 * @param lower	if true, converts all running words to lower case before updating the index
	 * @return true, if any method was called
	 */
	public boolean index (IndexType type, String src, String auth, boolean lower, boolean db)
	throws IOException
	{
		switch (type)
		{
			case GNP: indexGNP(src, auth, lower, db); return true;
			case LR: indexLR(src, auth, lower, db); return true;
			case P: indexP(src, auth, lower, db); return true;
			default: return false;
		}
	}



	/**
	 * Indexes all running words from the given unhyphened source text.
	 * Positioning structure: book->chapter->verse.
	 *
	 * @param src - source codificator.
	 * @param auth - author's name.
	 * @param lower - if true, converts all running words to lower case before updating the index.
	 */
	public void indexGNP(String src, String auth, boolean lower, boolean db) throws IOException {
		BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(src + "_unhyphened.txt"), "Cp1257"));

		StringBuilder plain = new StringBuilder(" ");

		String line = "";
		String source = "";
		String book = "";

		int chapter = 0;
		int verse = 0;

		boolean process = false;

		// Author's name must be on first line
		Matcher mAuthor = getAuthorPattern().matcher(reader.readLine());
		if (mAuthor.matches()) {
			if (mAuthor.group(1).equals(auth)) process = true;
		} else {
			log.append(Logger.NOT_FOUND, "autoram jābūt 1. rindiņā");
		}

		// Source codificator must be on second line
		Matcher mSource = getSourcePattern().matcher(reader.readLine());
		if (mSource.matches()) {
			source = mSource.group(1);
		} else {
			log.append(Logger.NOT_FOUND, "avota kodam jābūt 2. rindiņā");
		}

		while ((line = reader.readLine()) != null) {
			Matcher mBook = getBookPattern().matcher(line);
			Matcher mChapter = getChapterPattern().matcher(line);
			Matcher mVerse = getVerseGNPPattern().matcher(line);
			Matcher mNote = getNotePattern().matcher(line);
			mAuthor = getAuthorPattern().matcher(line);

			if (mBook.matches()) {
				if (plain.length() > 1) {
					if (!lower && db) insPlainGNP(plain.toString(), book, chapter, verse);

					plain.setLength(0);
					plain.append(" ");
				}

				book = mBook.group(1);
			}
			else if (mChapter.matches()) {
				if (plain.length() > 1) {
					if (!lower && db) insPlainGNP(plain.toString(), book, chapter, verse);

					plain.setLength(0);
					plain.append(" ");
				}

				chapter = Integer.parseInt(mChapter.group(1));
			}
			else if (mAuthor.matches()) {
				if (mAuthor.group(1).equals(auth)) {
					// Indexes only fragments written by the given author
					process = true;
				} else {
					process = false;
					log.append(Logger.SUSPICIOUS, "līdzautora '" + mAuthor.group(1) + "' teksts tika ignorēts");
				}
			}
			else if (process) {
				if (mVerse.matches()) {
					if (plain.length() > 1) {
						if (!lower && db) insPlainGNP(plain.toString(), book, chapter, verse);

						plain.setLength(0);
						plain.append(" ");
					}

					verse = Integer.parseInt(mVerse.group(1));
					line = mVerse.group(2);
				}
				else if (mNote.matches()) {
					line = mNote.group(1);
				}

				List<String> tokens = tokenize(line, lower, log);

				running += tokens.size();
				plain.append(tokensToString(tokens));
				addPosition(tokens, new GNPPosition(source, book, chapter, verse));
			}
		}

		if (plain.length() > 1 && !lower && db) insPlainGNP(plain.toString(), book, chapter, verse);

		reader.close();
	}


	/**
	 * Indexes all running words from the given unhyphened source text fragments written by the given author.
	 * Positioning structure: page->row.
	 *
	 * @param src - source codificator.
	 * @param auth - author's name; if empty, author is ignored.
	 * @param lower - if true, converts all running words to lower case before updating the index.
	 */
	public void indexLR(String src, String auth, boolean lower, boolean db) throws IOException {
		BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(src + "_unhyphened.txt"), "Cp1257"));

		StringBuilder plain = new StringBuilder(" ");

		String line = "";
		String source = "";
		String page = "";
		int row = 0;

		boolean process = false;

		// Author's name must be on first line
		Matcher mAuthor = getAuthorPattern().matcher(reader.readLine());
		if (mAuthor.matches()) {
			if (mAuthor.group(1).equals(auth) || auth.equals("")) process = true;
		} else {
			log.append(Logger.NOT_FOUND, "autoram jābūt 1. rindiņā");
		}

		// Source codificator must be on second line
		Matcher mSource = getSourcePattern().matcher(reader.readLine());
		if (mSource.matches()) {
			source = mSource.group(1);
		} else {
			log.append(Logger.NOT_FOUND, "avota kodam jābūt 2. rindiņā");
		}

		while ((line = reader.readLine()) != null) {
			line = encodeNestedBraces(line);

			Matcher mPage = getPagePattern().matcher(line);
			Matcher mWaste = getIgnorePattern().matcher(line);
			mAuthor = getAuthorPattern().matcher(line);

			if (mPage.matches()) {
				page = mPage.group(1);
				row = 0;
			}
			else if (mAuthor.matches()) {
				if (mAuthor.group(1).equals(auth) || auth.equals("")) {
					// Indexes only fragments written by the given author
					process = true;
				} else {
					process = false;
					log.append(Logger.SUSPICIOUS, "līdzautora '" + mAuthor.group(1) + "' teksts tika ignorēts");
				}
			}
			else if (mWaste.matches()) {
				if (line.startsWith("@2") || line.startsWith("@3")) System.err.println(decodeNestedBraces(line));
				row++;
			}
			else {
				row++;

				if (process) {
					List<String> tokens = tokenize(decodeNestedBraces(line), lower, log);

					running += tokens.size();

					plain.setLength(0);
					plain.append(" " + tokensToString(tokens));

					if (!lower && db) insPlainLR(plain.toString(), page, row);

					addPosition(tokens, new LRPosition(source, page, row));
				}
			}
		}

		reader.close();
	}


	/**
	 * Indexes all running words from the given unhyphened source text.
	 * Positioning structure: verse.
	 *
	 * @param src - source codificator.
	 * @param auth - author's name.
	 * @param lower - if true, converts all running words to lower case before updating the index.
	 */
	public void indexP(String src, String auth, boolean lower, boolean db) throws IOException {
		BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(src + "_unhyphened.txt"), "Cp1257"));

		StringBuilder plain = new StringBuilder(" ");

		String line = "";
		String source = "";
		String verse = "";

		boolean process = false;

		// Author's name must be on first line
		Matcher mAuthor = getAuthorPattern().matcher(reader.readLine());
		if (mAuthor.matches()) {
			if (mAuthor.group(1).equals(auth)) process = true;
		} else {
			log.append(Logger.NOT_FOUND, "autoram jābūt 1. rindiņā");
		}

		// Source codificator must be on second line
		Matcher mSource = getSourcePattern().matcher(reader.readLine());
		if (mSource.matches()) {
			source = mSource.group(1);
		} else {
			log.append(Logger.NOT_FOUND, "avota kodam jābūt 2. rindiņā");
		}

		while ((line = reader.readLine()) != null) {
			Matcher mVerse = getVersePPattern().matcher(line);
			mAuthor = getAuthorPattern().matcher(line);

			if (mAuthor.matches()) {
				if (mAuthor.group(1).equals(auth)) {
					// Indexes only fragments written by the given author
					process = true;
				} else {
					process = false;
					log.append(Logger.SUSPICIOUS, "līdzautora '" + mAuthor.group(1) + "' teksts tika ignorēts");
				}
			}
			else if (process) {
				if (mVerse.matches()) {
					if (plain.length() > 1) {
						if (!lower && db) insPlainP(plain.toString(), verse);

						plain.setLength(0);
						plain.append(" ");
					}

					verse = mVerse.group(1);
					line = mVerse.group(3);
				}

				List<String> tokens = tokenize(line, lower, log);

				running += tokens.size();
				plain.append(tokensToString(tokens));
				addPosition(tokens, new PPosition(source, verse));
			}
		}

		if (plain.length() > 1 && !lower && db) insPlainP(plain.toString(), verse);

		reader.close();
	}


	/**
	 * Sets author of source for index storage in database.
	 *
	 * @param author - author's name.
	 * @return true if author is set, false otherwise.
	 */
	public boolean setAuthor(String author) {
		boolean result = false;
		authname = "";

		if (db.getAuthor(author) != -1) {
			authname = author;
			result = true;
		}

		return result;
	}


	/**
	 * Sets default source codificator for index storage in database.
	 * Author of source must be set first.
	 *
	 * @return true if source is set, false otherwise.
	 */
	public boolean setSource() {
		boolean result = false;
		srccode = "";

		if (db.getSource(db.getAuthor(authname), abssrc) != -1) {
			srccode = abssrc;
			result = true;
		}

		return result;
	}


	/**
	 * Sets source codificator for index storage in database.
	 * Author of source must be set first.
	 *
	 * @param source - codificator of source.
	 * @return true if source is set, false otherwise.
	 */
	public boolean setSource(String source) {
		boolean result = false;
		srccode = "";

		if (db.getSource(db.getAuthor(authname), source) != -1) {
			srccode = source;
			result = true;
		}

		return result;
	}


	/**
	 * Stores the created index into the SENIE database.
	 * Must be used only for a single source index.
	 *
	 * @param pos - type of positioning structure.
	 */
	public void storeDatabase(int pos) {
		if (!dbPrepared()) {
			System.err.println("SENIE database not prepared!");
			return;
		}

		int srcID = db.getSource(db.getAuthor(authname), srccode);

		for (String wform : index.keySet()) {
			int wformID = db.getWordform(wform);	// Retrieve a reference to the word form
			int crossID = -1;

			if (wformID == -1) {					// Insert if doesn't exist yet
				wformID = db.insWordform(wform);
				crossID = db.insCrossform(wformID, srcID);
			} else {
				crossID = db.getCrossform(wformID, srcID);
				if (crossID == -1) crossID = db.insCrossform(wformID, srcID);
			}

			List<PosStructure> list = index.get(wform); // List of all positions

			switch (pos) {
				case POS_GNP:
					insPositionsGNP(list, srcID, crossID);
					break;
				case POS_LR:
					insPositionsLR(list, srcID, crossID);
					break;
				case POS_P:
					insPositionsP(list, srcID, crossID);
					break;
			}
		}
	}


	/**
	 * Creates a frequency list from the index and stores it into a text file.
	 *
	 * @param lower - true if index is in lower case, false otherwise.
	 */
	public void storeFrequencies(boolean lower) throws IOException {
		String fname = (lower) ? abssrc + "_frequencies_lower.txt" : abssrc + "_frequencies.txt";
		BufferedWriter writer  = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fname), "Cp1257"));

		writer.write("Vārdformu skaits:\t" + countWF() + "\r\n");
		writer.write("Vārdlietojumu skaits:\t" + countRW() + "\r\n\r\n\r\n");

		TreeMap<String, Integer> cumulInd = new TreeMap<>();
		for (String word : index.keySet()) {
			int count = 0;
			for (PosStructure pos : index.get(word)) count += pos.getCount();
			cumulInd.put(word, count);
			//writer.write(count + "\t" + word + "\r\n");
		}
		List<String> sortedKeys = cumulInd.keySet().stream()
				.sorted((s1, s2) ->
						cumulInd.getOrDefault(s2,0).compareTo(cumulInd.getOrDefault(s1, 0)))
				.collect(Collectors.toList());
		for (String word : sortedKeys)
		{
			writer.write(cumulInd.get(word) + "\t" + word + "\r\n");
		}
		writer.flush();
		writer.close();
	}


	/**
	 * Stores the created index into a HTML file.
	 * Developed for demo version, must be used only for single source index.
	 *
	 * @param lower - true if index is in lower case, false otherwise.
	 */
	public void storeHTML(boolean lower) throws IOException {
		String fname = (lower) ? abssrc + "_indexed_lower.htm" : abssrc + "_indexed.htm";
		String target = abssrc + "_marked.htm";

		BufferedWriter writer  = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fname), "Cp1257"));

		writer.write("<html>\n<head>\n");
		writer.write("<meta http-equiv=\"content-type\" content=\"text/html; charset=windows-1257\">\n");
		writer.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"./index.css\">\n");
		writer.write("</head>\n<body>\n<pre>\n");

		writer.write("Vārdformu skaits: <b>"+countWF()+"</b>\n");
		writer.write("Vārdlietojumu skaits: <b>"+countRW()+"</b>\n\n\n");

		for (String word : sortNumbersAfterWords(index.keySet())) {
			writer.write("<b>" + word + "</b>\n");

			int count = 0;

			for (PosStructure pos : index.get(word)) {
				count += pos.getCount();
				writer.write("\t" + pos.getCount() + " ");

				String href = ""; // Link to the context
				if (pos instanceof GNPPosition) {
					GNPPosition gnp = (GNPPosition) pos;
					href = "<a href=\"" + target + "#";
					href += gnp.getBook() + "_" + gnp.getChapter() + "_" + gnp.getVerse();
					href += "\" target=\"text\">";
				}
				else if (pos instanceof LRPosition) {
					LRPosition lr = (LRPosition) pos;
					href = "<a href=\"" + target + "#" + lr.getPage() + "\" target=\"text\">";
				}
				else if (pos instanceof PPosition) {
					PPosition p = (PPosition) pos;
					href = "<a href=\"" + target + "#" + p.getVerse() + "\" target=\"text\">";
				}

				writer.write(href + pos.getCount() + " " + pos.toString() + "</a>\n");
			}

			writer.write("\t<b>" + count + "</b>\n\n");
		}

		writer.write("</pre>\n</body>\n<html>\n");
		writer.close();
	}


	/**
	 * Stores the created index into a text file.
	 *
	 * @param lower - true if index is in lower case, false otherwise.
	 */
	public void storePlaintext(boolean lower) throws IOException {
		String fname = (lower) ? abssrc + "_indexed_lower.txt" : abssrc + "_indexed.txt";
		BufferedWriter writer  = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fname), "Cp1257"));

		writer.write("Vārdformu skaits:\t" + countWF() + "\r\n");
		writer.write("Vārdlietojumu skaits:\t" + countRW() + "\r\n\r\n\r\n");

		for (String word : sortNumbersAfterWords(index.keySet())) {
			writer.write(word + "\r\n\r\n");

			int count = 0;

			for (PosStructure pos : index.get(word)) {
				count += pos.getCount();
				writer.write("\t" + pos.getCount() + " " + pos.toString() + "\r\n");
			}

			writer.write("\t-----\r\n\t" + count + "\r\n\r\n\r\n");
		}

		writer.flush();
		writer.close();
	}


	/**
	 * Stores the created index into a HTML file in a compact format.
	 * Use for single source LR structure only.
	 *
	 * @param lower - true if index is in lower case, false otherwise.
	 */
	public void storeCompact(boolean lower) throws IOException {
		String fname = (lower) ? abssrc + "_indexed_comp_lower.htm" : abssrc + "_indexed_comp.htm";
		BufferedWriter writer  = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fname), "Cp1257"));

		writer.write("<html>\n<head>\n");
		writer.write("<meta http-equiv=\"content-type\" content=\"text/html; charset=windows-1257\">\n");
		writer.write("</head>\n<body>\n");

		for (String word : sortNumbersAfterWords(index.keySet())) {
			writer.write("<b>" + word + "</b> - ");

			for (PosStructure pos : index.get(word)) {
				if (pos instanceof LRPosition) {
					LRPosition lrpos = (LRPosition) pos;

					writer.write("[" + lrpos.getPage() + "," + lrpos.getRow() + "]");
					//if (iterator.hasNext()) { // FIXME
						writer.write(", ");
					//}
				}
			}

			writer.write("<br><br>\n\n");
		}

		writer.write("</body>\n</html>\n");
		writer.flush();
		writer.close();
	}


	/**
	 *
	 * @param corpus_old
	 * @param corpus_new
	 * @param output
	 */
	public void listNewWordforms(List<String> corpus_old, List<String> corpus_new, String output) throws IOException {
		Set<String> old_forms = new TreeSet<String>();
		Set<String> new_forms = new TreeSet<String>(new SENIEStringComparator()); //new TreeSet(Collator.getInstance(new Locale("lv", "LV")))

		BufferedReader reader = null;
		BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(output), "Cp1257"));

		for (String corp : corpus_old) {
			reader = new BufferedReader(new InputStreamReader(new FileInputStream(corp), "Cp1257"));

			String line = null;
			while ((line = reader.readLine()) != null) {
				line = encodeNestedBraces(line);

				Matcher mWaste = getIgnorePattern().matcher(line);

				if (!mWaste.matches() && !line.startsWith("@a") && !line.startsWith("@z")) {
					List<String> tokens = tokenize(decodeNestedBraces(line), true, log);
					for (String form : tokens) old_forms.add(form);
				}
			}

			reader.close();
		}

		for (String corp : corpus_new) {
			reader = new BufferedReader(new InputStreamReader(new FileInputStream(corp), "Cp1257"));

			String line = null;
			while ((line = reader.readLine()) != null) {
				Matcher mWaste = getIgnorePattern().matcher(line);

				if (!mWaste.matches() && !line.startsWith("@a") && !line.startsWith("@z")) {
					List<String> tokens = tokenize(line, true, log);

					for (String form : tokens) {
						if (!old_forms.contains(form)) new_forms.add(form);
					}
				}
			}

			reader.close();
		}

		for (String form : new_forms) writer.write(form + "\n");

		writer.close();
	}


	/**
	 *
	 * @param corpus_old
	 * @param corpus_new
	 * @param out_all
	 * @param out_new
	 */
	public void listNewFormsInContext(List<String> corpus_old, List<String> corpus_new, String out_all, String out_new) throws IOException {
		Set<String> old_forms = new TreeSet<String>(new SENIEStringComparator());
		Set<String> new_forms = new TreeSet<String>(new SENIEStringComparator());
		Set<String> all_forms = new TreeSet<String>(new SENIEStringComparator());

		BufferedReader reader = null;
		BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(out_all), "Cp1257"));
		BufferedWriter writer_new = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(out_new), "Cp1257"));

		writer.write("<html><head><meta content=\"text/html; charset=windows-1257\" http-equiv=\"content-type\"/>");
		writer.write("</head><body leftmargin=\"10\" topmargin=\"10\" bottommargin=\"10\" rightmargin=\"10\">");

		writer_new.write("<html><head><meta content=\"text/html; charset=windows-1257\" http-equiv=\"content-type\"/>");
		writer_new.write("</head><body leftmargin=\"10\" topmargin=\"10\" bottommargin=\"10\" rightmargin=\"10\">");

		for (String corp : corpus_old) {
			reader = new BufferedReader(new InputStreamReader(new FileInputStream(corp), "Cp1257"));

			String line = null;
			while ((line = reader.readLine()) != null) {
				line = encodeNestedBraces(line);

				Matcher mWaste = getIgnorePattern().matcher(line);
				Matcher mPage = getPagePattern().matcher(line);

				if (line.startsWith("@a") || line.startsWith("@g") || line.startsWith("@n") || line.startsWith("@z")) continue;

				if (!mWaste.matches() && !mPage.matches()) {
					List<String> tokens = tokenize(decodeNestedBraces(line), true, log);
					for (String form : tokens) old_forms.add(form);
				}
			}

			reader.close();
		}

		for (String corp : corpus_new) {
			reader = new BufferedReader(new InputStreamReader(new FileInputStream(corp), "Cp1257"));

			String line = null;
			while ((line = reader.readLine()) != null) {
				Matcher mWaste = getIgnorePattern().matcher(line);
				Matcher mPage = getPagePattern().matcher(line);

				if (line.startsWith("@a") || line.startsWith("@g") || line.startsWith("@n") || line.startsWith("@z")) continue;

				if (!mWaste.matches() && !mPage.matches()) {
					List<String> tokens = tokenize(line, true, log);

					for (String form : tokens) {
						if (!old_forms.contains(form)) new_forms.add(form);
					}
				}
			}

			reader.close();
		}

		all_forms.addAll(old_forms);
		all_forms.addAll(new_forms);

		for (String form : all_forms) {
			if (new_forms.contains(form)) {
				writer.write("<a name=\"" + form + "\"><span style=\"background-color:#FFCC33\">" + form + "</span></a><br/>");
			} else {
				writer.write(form + "<br/>");
			}
		}

		for (String form : new_forms) {
			writer_new.write("<a href=\"wf_SENIE_all.htm#" + form + "\" target=\"context\">" + form + "</a><br/>");
		}

		writer.write("</body></html>");
		writer_new.write("</body></html>");

		writer.close();
		writer_new.close();
	}

	/**
	 * Takes keyset and moves words starting with number to the end.
	 * @param indexKeySet	set to sort
	 * @return	almost naturaly sorted set, but words starting with numbers moved
	 * 			to the end of the list.
	 */
	protected List<String> sortNumbersAfterWords(Collection<String> indexKeySet) {
		return indexKeySet.stream()
				.sorted((s1, s2) -> {
					for (int i = 0; i < Math.min(s1.length(), s2.length()); i++) {
						if (s1.charAt(i) ==  s2.charAt(i)) continue;
						if (!s1.substring(i).matches("^\\d.*") && s2.substring(i).matches("^\\d.*"))
							return -1;
						if (s1.substring(i).matches("^\\d.*") && !s2.substring(i).matches("^\\d.*"))
							return 1;
						return s1.compareTo(s2);
					}
					return s1.compareTo(s2);
				})
				.collect(Collectors.toList());

		/*return indexKeySet.stream()
				.sorted((s1, s2) -> {
					if (s1.matches("^\\d.*") && !s2.matches("^\\d.*")) return 1;
					else if (!s1.matches("^\\d.*") && s2.matches("^\\d.*")) return -1;
					else return s1.compareTo(s2);})
				.collect(Collectors.toList()); //*/
	}

	/**
	 * Ends indexing process: closes connection with SENIE database,
	 * and writes resulting process log.
	 */
	public void close() throws IOException {
		if (db.connected()) {
			dbDisconnect();
		}
		log.close();
	}

}