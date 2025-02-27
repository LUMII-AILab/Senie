package corpus.senie.indexing;

import java.io.*;
import java.nio.charset.StandardCharsets;


/**
 * Logging of exceptions in various steps of the indexing process.
 */
public class Logger {

	private BufferedWriter log;


	/**
	 * Exception event type: removed waste line of text.
	 */
	public static final int DROPPED = 0;
	
	/**
	 * Exception event type: edited line of text, original line.
	 */
	public static final int EDITED_1 = 1;
	
	/**
	 * Exception event type: edited line of text, resulting line.
	 */
	public static final int EDITED_2 = 2;
	
	/**
	 * Exception event type: illegal "operation" in text.
	 */
	public static final int ILLEGAL = 3;
	
	/**
	 * Exception event type: expected tag not found.
	 */
	public static final int NOT_FOUND = 4;
	
	/**
	 * Exception event type: suspicious line of text.
	 */
	public static final int SUSPICIOUS = 5;
	
	/**
	 * Exception event type: line of text didn't match any pattern.
	 */
	public static final int UNDEFINED = 6;


	/**
	 * Constructor.
	 * 
	 * @param name - absolute log file name (usually same as codificator of source text).
	 * @param title - title of section for exception events.
	 * @param append - if true and log file with the same absolute name exists,
	 * this section will be appended at the end of existing log file, otherwise log file will be overwritten.
	 */
	public Logger(String name, String title, boolean append) {
		try {
			log = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(name + "_log.txt", append), StandardCharsets.UTF_8));
			log.write("\r\n" + title + ":\r\n\r\n");
		}
		catch (IOException ioe) {
			log = null;
			System.err.println("Error assigning log file: ");
			ioe.printStackTrace();
		}
	}
	
	
	/**
	 * Appends new record at the end of the list of exception events in the opened section.
	 * 
	 * @param type - event type.
	 * @param lineNumber - number of the line in the source document where the error happened. (2025-02-27)
	 * @param message - string of event content.
	 */
	public void append(int type, int lineNumber, String message) {
		try {
			String lineNumberFormated = "";
			if (lineNumber > -1) lineNumberFormated = " (" + lineNumber + ")";
			switch(type) {
				case DROPPED:
					log.write("IZMESTS" + lineNumberFormated + ": " + message + "\r\n");
					break;
				case EDITED_1:
					log.write("REDIĢĒTS" + lineNumberFormated + ": " + message + " --> ");
					break;
				case EDITED_2:
					log.write(message + "\r\n");
					break;
				case ILLEGAL:
					log.write("NAV ATĻAUTS" + lineNumberFormated + ": " + message + "\r\n");
					break;
				case NOT_FOUND:
					log.write("NAV ATRASTS" + lineNumberFormated + ": " + message + "\r\n");
					break;
				case SUSPICIOUS:
					log.write("AIZDOMĪGI" + lineNumberFormated + ": " + message + "\r\n");
					break;
				case UNDEFINED:
					log.write("NEDEFINĒTS" + lineNumberFormated + ": " + message + "\r\n");
					break;
				default:
					log.write("NEDEFINĒTS REĢISTRA IZSAUKUMA TIPS (" + lineNumber + "): " + type + "\r\n");
					break;
			}
		}
		catch (IOException ioe) {
			log = null;
			System.err.println("Error appending event: " + ioe);
		}
	}
	
	
	/**
	 * Ends logging thread: writes all events in log file and closes it.
	 */
	public void close() {
		try {
			log.flush();
			log.close();
		}
		catch (IOException ioe) {
			log = null;
			System.err.println("Error closing Logger: " + ioe);
		}

	}

}