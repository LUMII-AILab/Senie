package corpus.senie.indexing;

import corpus.senie.util.IndexType;

import java.io.*;
import java.util.regex.Matcher;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;


/**
 * Creation of inverse word form dictionaries.
 * Supported text positioning structures: GNP, LR, P.
 */
public class Inverser extends Recognizer {

	private Set<String> index;
	private Logger log;
	private String source;


	/**
	 * Updates the index of word forms from the given list of running words.
	 * 
	 * @param words - the list of running words.
	 */
	private void addWordForm(List<String> words) {
		for (String w : words) {
			StringBuilder word = new StringBuilder(w);
			word.reverse();
			w = word.toString();
			
			if (!index.contains(w)) index.add(w);
		}
	}


	/**
	 * Constructor.
	 * 
	 * @param source - codificator of source which will be indexed.
	 */
	public Inverser(String source) {
		super();

		index = new TreeSet<>();
		log = new Logger(source, "INVERSĀ VĀRDNĪCA", true);
		this.source = source;
	}


	/**
	 * Clears the entire index.
	 */
	public void clear() {
		index.clear();
	}

	/**
	 * Wrapper for invoking any of indexX methods by given indexation type.
	 * @param type source indexing type
	 * @return true, if any method was called
	 */
	public boolean index (IndexType type
	) throws IOException
	{
		switch (type)
		{
			case GNP: indexGNP(); return true;
			case LR: indexLR(); return true;
			case GLR: indexGLR(); return true;
			case P: indexP(); return true;
			default: return false;
		}
	}

	/**
	 * Indexes all running words from the given unhyphened source text.
	 * Positioning structure: book->chapter->verse.
	 */
	public void indexGNP() throws IOException {
		LineNumberReader reader = new LineNumberReader(new InputStreamReader(new FileInputStream(source + "_unhyphened.txt"), "Cp1257"));
		String line = "";

		Matcher mAuthor = getAuthorPattern().matcher(reader.readLine());
		if (!mAuthor.matches()) {
			log.append(Logger.NOT_FOUND, reader.getLineNumber(), "autoram jābūt 1. rindiņā");
		}

		Matcher mSource = getSourcePattern().matcher(reader.readLine());
		if (!mSource.matches()) {
			log.append(Logger.NOT_FOUND, reader.getLineNumber(), "avota kodam jābūt 2. rindiņā");
		}

		while ((line = reader.readLine()) != null) {
			int lineNumber = reader.getLineNumber();
			Matcher mBook = getBookPattern().matcher(line);
			Matcher mChapter = getChapterPattern().matcher(line);
			Matcher mVerse = getVerseGNPPattern().matcher(line);
			Matcher mNote = getNotePattern().matcher(line);
			mAuthor = getAuthorPattern().matcher(line);

			if (mBook.matches() || mChapter.matches() || mAuthor.matches()) {
				// Skip
			} else {
				if (mVerse.matches()) {
					line = mVerse.group(2);
				}
				else if (mNote.matches()) {
					line = mNote.group(1);
				}
				
				addWordForm(Indexer.tokenize(line, lineNumber, true, log));
			}
		}

		reader.close();
	}


	/**
	 * Indexes all running words from the given unhyphened source text.
	 * Positioning structure: page->row.
	 */
	public void indexLR() throws IOException {
		LineNumberReader reader = new LineNumberReader(new InputStreamReader(new FileInputStream(source + "_unhyphened.txt"), "Cp1257"));
		String line = "";

		Matcher mAuthor = getAuthorPattern().matcher(reader.readLine());
		if (!mAuthor.matches()) {
			log.append(Logger.NOT_FOUND, reader.getLineNumber(), "autoram jābūt 1. rindiņā");
		}

		Matcher mSource = getSourcePattern().matcher(reader.readLine());
		if (!mSource.matches()) {
			log.append(Logger.NOT_FOUND, reader.getLineNumber(), "avota kodam jābūt 2. rindiņā");
		}

		while ((line = reader.readLine()) != null) {
			int lineNumber = reader.getLineNumber();
			line = encodeNestedBraces(line);
			
			Matcher mPage = getPagePattern().matcher(line);
			Matcher mWaste = getIgnorePattern().matcher(line);
			mAuthor = getAuthorPattern().matcher(line);

			if (mPage.matches() || mAuthor.matches() || mWaste.matches()) {
				// Skip
			} else {
				addWordForm(Indexer.tokenize(decodeNestedBraces(line), lineNumber, true, log));
			}
		}

		reader.close();
	}

	/**
	 * Indexes all running words from the given unhyphened source text.
	 * Positioning structure: book->page->row.
	 * Note: this is added >10 years later without clear understanding.
	 */
	public void indexGLR() throws IOException {
		LineNumberReader reader = new LineNumberReader(new InputStreamReader(new FileInputStream(source + "_unhyphened.txt"), "Cp1257"));
		String line = "";

		Matcher mAuthor = getAuthorPattern().matcher(reader.readLine());
		if (!mAuthor.matches()) {
			log.append(Logger.NOT_FOUND, reader.getLineNumber(), "autoram jābūt 1. rindiņā");
		}

		Matcher mSource = getSourcePattern().matcher(reader.readLine());
		if (!mSource.matches()) {
			log.append(Logger.NOT_FOUND, reader.getLineNumber(), "avota kodam jābūt 2. rindiņā");
		}

		while ((line = reader.readLine()) != null) {
			int lineNumber = reader.getLineNumber();
			line = encodeNestedBraces(line);

			Matcher mPage = getPagePattern().matcher(line);
			Matcher mWaste = getIgnorePattern().matcher(line);
			Matcher mBook = getBookPattern().matcher(line);
			mAuthor = getAuthorPattern().matcher(line);

			if (mPage.matches() || mBook.matches() || mAuthor.matches() || mWaste.matches()) {
				// Skip
			} else {
				addWordForm(Indexer.tokenize(decodeNestedBraces(line), lineNumber, true, log));
			}
		}

		reader.close();
	}

	/**
	 * Indexes all running words from the given unhyphened source text.
	 * Positioning structure: verse.
	 */
	public void indexP() throws IOException {
		LineNumberReader reader = new LineNumberReader(new InputStreamReader(new FileInputStream(source + "_unhyphened.txt"), "Cp1257"));
		String line = "";

		Matcher mAuthor = getAuthorPattern().matcher(reader.readLine());
		if (!mAuthor.matches()) {
			log.append(Logger.NOT_FOUND, reader.getLineNumber(), "autoram jābūt 1. rindiņā");
		}

		Matcher mSource = getSourcePattern().matcher(reader.readLine());
		if (!mSource.matches()) {
			log.append(Logger.NOT_FOUND, reader.getLineNumber(), "avota kodam jābūt 2. rindiņā");
		}

		while ((line = reader.readLine()) != null) {
			int lineNumber = reader.getLineNumber();
			Matcher mVerse = getVersePPattern().matcher(line);
			mAuthor = getAuthorPattern().matcher(line);

			if (!mAuthor.matches()) {
				if (mVerse.matches()) {
					line = mVerse.group(3);
				}
				addWordForm(Indexer.tokenize(line, lineNumber, true, log));
			}
		}

		reader.close();
	}



	/**
	 * Creates an inverse dictionary from the index and stores it into a text file.
	 */
	public void storeDictionary() throws IOException {
		BufferedWriter writer  = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(source + "_inverse.txt"), "Cp1257"));

		Iterator<String> itIndx = index.iterator();
		
		while (itIndx.hasNext()) {
			StringBuilder word = new StringBuilder(itIndx.next());
			if (!word.toString().matches("^(\\}\\d*\\{)?\\d+$"))
				writer.write(word.reverse() + "\r\n");
		}

		writer.flush();
		writer.close();
	}


	/**
	 * Ends indexing process: writes resulting process log.
	 */
	public void close() throws IOException {
		log.close();
	}

}