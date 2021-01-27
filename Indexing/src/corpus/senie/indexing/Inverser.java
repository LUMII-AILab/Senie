package corpus.senie.indexing;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.IOException;
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

		index = new TreeSet<String>();
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
	 * Indexes all running words from the given unhyphened source text.
	 * Positioning structure: book->chapter->verse.
	 */
	public void indexGNP() throws IOException {
		BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(source + "_unhyphened.txt"), "Cp1257"));
		String line = "";

		Matcher mAuthor = getAuthorPattern().matcher(reader.readLine());
		if (!mAuthor.matches()) {
			log.append(Logger.NOT_FOUND, "autoram jābūt 1. rindiņā");
		}

		Matcher mSource = getSourcePattern().matcher(reader.readLine());
		if (!mSource.matches()) {
			log.append(Logger.NOT_FOUND, "avota kodam jābūt 2. rindiņā");
		}

		while ((line = reader.readLine()) != null) {
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
				
				addWordForm(Indexer.tokenize(line, true, log));
			}
		}

		reader.close();
	}


	/**
	 * Indexes all running words from the given unhyphened source text.
	 * Positioning structure: page->row.
	 */
	public void indexLR() throws IOException {
		BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(source + "_unhyphened.txt"), "Cp1257"));
		String line = "";

		Matcher mAuthor = getAuthorPattern().matcher(reader.readLine());
		if (!mAuthor.matches()) {
			log.append(Logger.NOT_FOUND, "autoram jābūt 1. rindiņā");
		}

		Matcher mSource = getSourcePattern().matcher(reader.readLine());
		if (!mSource.matches()) {
			log.append(Logger.NOT_FOUND, "avota kodam jābūt 2. rindiņā");
		}

		while ((line = reader.readLine()) != null) {
			line = encodeNestedBraces(line);
			
			Matcher mPage = getPagePattern().matcher(line);
			Matcher mWaste = getIgnorePattern().matcher(line);
			mAuthor = getAuthorPattern().matcher(line);

			if (mPage.matches() || mAuthor.matches() || mWaste.matches()) {
				// Skip
			} else {
				addWordForm(Indexer.tokenize(decodeNestedBraces(line), true, log));
			}
		}

		reader.close();
	}


	/**
	 * Indexes all running words from the given unhyphened source text.
	 * Positioning structure: verse.
	 */
	public void indexP() throws IOException {
		BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(source + "_unhyphened.txt"), "Cp1257"));
		String line = "";

		Matcher mAuthor = getAuthorPattern().matcher(reader.readLine());
		if (!mAuthor.matches()) {
			log.append(Logger.NOT_FOUND, "autoram jābūt 1. rindiņā");
		}

		Matcher mSource = getSourcePattern().matcher(reader.readLine());
		if (!mSource.matches()) {
			log.append(Logger.NOT_FOUND, "avota kodam jābūt 2. rindiņā");
		}

		while ((line = reader.readLine()) != null) {
			Matcher mVerse = getVersePPattern().matcher(line);
			mAuthor = getAuthorPattern().matcher(line);

			if (!mAuthor.matches()) {
				if (mVerse.matches()) {
					line = mVerse.group(3);
				}
				addWordForm(Indexer.tokenize(line, true, log));
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
			writer.write(word.reverse().toString() + "\r\n");
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