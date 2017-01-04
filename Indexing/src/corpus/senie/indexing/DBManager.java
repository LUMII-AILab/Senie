package corpus.senie.indexing;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 * Storage and organization of the index of word forms in a MySQL database according to the SENIE data model.
 * Supported text positioning structures: GNP, LR, P.
 */
public class DBManager extends Object {

	private Connection connection;
	private PreparedStatement getAut;
	private PreparedStatement getBok;
	private PreparedStatement getCat;
	private PreparedStatement getConGNP;
	private PreparedStatement getConLR;
	private PreparedStatement getConP;
	private PreparedStatement getCwf;
	private PreparedStatement getPosGNP;
	private PreparedStatement getPosLR;
	private PreparedStatement getPosP;
	private PreparedStatement getSrc;
	private PreparedStatement getWrd;
	private PreparedStatement insAut;
	private PreparedStatement insBok;
	private PreparedStatement insCat;
	private PreparedStatement insConGNP;
	private PreparedStatement insConLR;
	private PreparedStatement insConP;
	private PreparedStatement insCoo;
	private PreparedStatement insCwf;
	private PreparedStatement insPosGNP;
	private PreparedStatement insPosLR;
	private PreparedStatement insPosP;
	private PreparedStatement insSrc;
	private PreparedStatement insWrd;
	private PreparedStatement updConGNP;
	private PreparedStatement updConLR;
	private PreparedStatement updConP;
	private PreparedStatement updPlainConGNP;
	private PreparedStatement updPlainConLR;
	private PreparedStatement updPlainConP;
	private PreparedStatement updPosGNP;
	private PreparedStatement updPosLR;
	private PreparedStatement updPosP;

	private boolean online;


	/**
	 * Prints an error message in case of parameter length overflow.
	 * @param param mistaken parameter.
	 */
	private void errParam(String param) {
		System.err.println("Parameter length overflow: "+param);
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
	 * Constructor.
	 */
	public DBManager() {
		online = false;
	}


	/**
	 * Connects to the SENIE database and prepares
	 * templates of SQL statements for efficient execution.
	 * @param path path to the database.
	 * @param user user name.
	 * @param passwd user password.
	 */
	public void connect(String path, String user, String passwd) {
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			path = "jdbc:mysql:"+path;
			connection = DriverManager.getConnection(path, user, passwd);

			getAut = connection.prepareStatement(
				"SELECT id FROM authors WHERE name=?;"
			);
			getBok = connection.prepareStatement(
				"SELECT id FROM books WHERE codificator=? AND source=?;"
			);
			getCat = connection.prepareStatement(
				"SELECT id FROM categories WHERE name=?;"
			);

			getConGNP = connection.prepareStatement(
				"SELECT id FROM gnp_contexts "+
				"WHERE source=? AND book=? AND chapter=? AND verse=?;"
			);
			getConLR = connection.prepareStatement(
				"SELECT id FROM lr_contexts "+
				"WHERE source=? AND page=? AND row=?;"
			);
			getConP = connection.prepareStatement(
				"SELECT id FROM p_contexts WHERE source=? AND verse=?;"
			);

			getCwf = connection.prepareStatement(
				"SELECT id FROM crossforms WHERE wordform=? AND source=?;"
			);

			getPosGNP = connection.prepareStatement(
				"SELECT id FROM gnp_positions "+
				"WHERE crossform=? AND book=? AND chapter=? AND verse=?;"
			);
			getPosLR = connection.prepareStatement(
				"SELECT id FROM lr_positions "+
				"WHERE crossform=? AND page=? AND row=?;"
			);
			getPosP = connection.prepareStatement(
				"SELECT id FROM p_positions WHERE crossform=? AND verse=?;"
			);

			getSrc = connection.prepareStatement(
				"SELECT c.source FROM coopers AS c, sources AS s "+
				"WHERE c.author=? AND c.source=s.id AND s.codificator=?;"
			);
			getWrd = connection.prepareStatement(
				"SELECT id, wordform FROM wordforms WHERE wordform=?;"
			);
			insAut = connection.prepareStatement(
				"INSERT INTO authors (name) VALUES (?);"
			);
			insBok = connection.prepareStatement(
				"INSERT INTO books (source,codificator,name) VALUES (?,?,?);"
			);
			insCat = connection.prepareStatement(
				"INSERT INTO categories (name) VALUES (?);"
			);

			insConGNP = connection.prepareStatement(
				"INSERT INTO gnp_contexts "+
				"(source,book,chapter,verse,content) VALUES (?,?,?,?,?);"
			);
			insConLR = connection.prepareStatement(
				"INSERT INTO lr_contexts "+
				"(source,page,row,content) VALUES (?,?,?,?);"
			);
			insConP = connection.prepareStatement(
				"INSERT INTO p_contexts (source,verse,content) VALUES (?,?,?);"
			);

			insCoo = connection.prepareStatement(
				"INSERT INTO coopers (author,source) VALUES (?,?);"
			);
			insCwf = connection.prepareStatement(
				"INSERT INTO crossforms (wordform,source) VALUES (?,?);"
			);

			insPosGNP = connection.prepareStatement(
				"INSERT INTO gnp_positions "+
				"(crossform,book,chapter,verse,count,context) VALUES (?,?,?,?,?,?);"
			);
			insPosLR = connection.prepareStatement(
				"INSERT INTO lr_positions "+
				"(crossform,page,row,count,context) VALUES (?,?,?,?,?);"
			);
			insPosP = connection.prepareStatement(
				"INSERT INTO p_positions "+
				"(crossform,verse,count,context) VALUES (?,?,?,?);"
			);

			insSrc = connection.prepareStatement(
				"INSERT INTO sources "+
				"(codificator,name,category,period) VALUES (?,?,?,?);"
			);
			insWrd = connection.prepareStatement(
				"INSERT INTO wordforms (wordform) VALUES (?);"
			);

			updConGNP = connection.prepareStatement(
				"UPDATE gnp_contexts SET content=? WHERE id=?;"
			);
			updConLR = connection.prepareStatement(
				"UPDATE lr_contexts SET content=? WHERE id=?;"
			);
			updConP = connection.prepareStatement(
				"UPDATE p_contexts SET content=? WHERE id=?;"
			);

			updPlainConGNP = connection.prepareStatement(
				"UPDATE gnp_contexts SET plain=? WHERE id=?;"
			);
			updPlainConLR = connection.prepareStatement(
				"UPDATE lr_contexts SET plain=? WHERE id=?;"
			);
			updPlainConP = connection.prepareStatement(
				"UPDATE p_contexts SET plain=? WHERE id=?;"
			);

			updPosGNP = connection.prepareStatement(
				"UPDATE gnp_positions SET count=?,context=? WHERE id=?;"
			);
			updPosLR = connection.prepareStatement(
				"UPDATE lr_positions SET count=?,context=? WHERE id=?;"
			);
			updPosP = connection.prepareStatement(
				"UPDATE p_positions SET count=?,context=? WHERE id=?;"
			);

			online = true;
		}
		catch (Exception e) {
			System.err.println("Error connecting to SENIE database: "+e);
			disconnect();
		}
	}

	/**
	 * Checks for the database connection state.
	 * @return true if connected, false otherwise.
	 */
	public boolean connected() {
		return online;
	}


	/**
	 * Disconnects from the SENIE database.
	 */
	public void disconnect() {
		online = false;
		try {
			connection.close();
		}
		catch (SQLException sqle) {
			System.err.println("Error disconnecting from SENIE database: "+sqle);
		}
	}


	/**
	 * Retrieves a reference to the given author.
	 * @param name author's name.
	 * @return the matching reference,
	 * or -1 if the author not found or in case of an error.
	 */
	public int getAuthor(String name) {
		int result = -1;
		if (name.length() > 50) {				//Constraint from
			errParam(name);						//data object definition.
			return result;
		}

		try {
			getAut.clearParameters();
			getAut.setBytes(1, name.getBytes("UTF-8"));
			ResultSet id = getAut.executeQuery();
			if (id.next()) {
				result = id.getInt("id");		//Reference to author.
			}
			else {
				result = -1;					//Author not found.
			}
		}
		catch (Exception e) {
			result = -1;						//Error code.
			System.err.println(
				"Error retrieving reference to author {"+
				name+"}: "+e
			);
		}

		return result;
	}


	/**
	 * Retrieves a reference to the given book.
	 * @param code codificator of the book.
	 * @param src source ID.
     * @return the matching reference,
	 * or -1 if the book not found or in case of an error.
	 */
	public int getBook(String code, int src) {
		int result = -1;
		if (code.length() > 15) {				//Constraint from
			errParam(code);						//data object definition.
			return result;
		}

		try {
			getBok.clearParameters();
			getBok.setBytes(1, code.getBytes("UTF-8"));
			getBok.setInt(2, src);
			ResultSet id = getBok.executeQuery();
			if (id.next()) {
				result = id.getInt("id");		//Reference to book.
			}
			else {
				result = -1;					//Book not found.
			}
		}
		catch (Exception e) {
			result = -1;						//Error code.
			System.err.println("Error retrieving reference to book {"+code+"}: "+e);
		}

		return result;
	}


	/**
	 * Retrieves a reference to the given category.
	 * @param name name of the category.
	 * @return the matching reference,
	 * or -1 if the category not found or in case of an error.
	 */
	public int getCategory(String name) {
		int result = -1;
		if (name.length() > 30) {				//Constraint from
			errParam(name);						//data object definition.
			return result;
		}

		try {
			getCat.clearParameters();
			getCat.setBytes(1, name.getBytes("UTF-8"));
			ResultSet id = getCat.executeQuery();
			if (id.next()) {
				result = id.getInt("id");		//Reference to category.
			}
			else {
				result = -1;					//Category not found.
			}
		}
		catch (Exception e) {
			result = -1;						//Error code.
			System.err.println(
				"Error retrieving reference to category {"+name+"}: "+e
			);
		}

		return result;
	}


	/**
	 * Retrieves a reference to context for the given position.
	 * Positioning structure: book->chapter->verse.
	 * @param source reference to source.
	 * @param book reference to book.
	 * @param chapter number of chapter.
	 * @param verse number of verse.
	 * @return the matching reference,
	 * or -1 if context at the given position not found or in case of an SQL error.
	 */
	public int getContext(int source, int book, int chapter, int verse) {
		int result = -1;

		try {
			getConGNP.clearParameters();
			getConGNP.setInt(1, source);
			getConGNP.setInt(2, book);
			getConGNP.setInt(3, chapter);
			getConGNP.setInt(4, verse);
			ResultSet id = getConGNP.executeQuery();
			if (id.next()) {
				result = id.getInt("id");		//Reference to GNP context.
			}
			else {
				result = -1;					//Context not found.
			}
		}
		catch (SQLException sqle) {
			result = -1;						//Error code.
			System.err.println(
				"Error retrieving reference to GNP context {"+
				source+","+book+","+chapter+","+verse+"}: "+sqle
			);
		}

		return result;
	}


	/**
	 * Retrieves a reference to context for the given position.
	 * Positioning structure: page->row.
	 * @param source reference to source.
	 * @param page number of page.
	 * @param row number of row.
	 * @return the matching reference,
	 * or -1 if context at the given position not found or in case of an error.
	 */
	public int getContext(int source, String page, int row) {
		int result = -1;
		if (page.length() > 15) {				//Constraint from
			errParam(page);						//data object definition.
			return result;
		}

		try {
			getConLR.clearParameters();
			getConLR.setInt(1, source);
			getConLR.setBytes(2, page.getBytes("UTF-8"));
			getConLR.setInt(3, row);
			ResultSet id = getConLR.executeQuery();
			if (id.next()) {
				result = id.getInt("id");		//Reference to LR context.
			}
			else {
				result = -1;					//Context not found.
			}
		}
		catch (Exception e) {
			result = -1;						//Error code.
			System.err.println(
				"Error retrieving reference to LR context {"+
				source+","+page+","+row+"}: "+e
			);
		}

		return result;
	}


	/**
	 * Retrieves a reference to context for the given position.
	 * Positioning structure: verse.
	 * @param source reference to source.
	 * @param verse number of verse.
	 * @return the matching reference,
	 * or -1 if context at the given position not found or in case of an error.
	 */
	public int getContext(int source, String verse) {
		int result = -1;
		if (verse.length() > 15) {				//Constraint from
			errParam(verse);					//data object definition.
			return result;
		}

		try {
			getConP.clearParameters();
			getConP.setInt(1, source);
			getConP.setBytes(2, verse.getBytes("UTF-8"));
			ResultSet id = getConP.executeQuery();
			if (id.next()) {
				result = id.getInt("id");		//Reference to P context.
			}
			else {
				result = -1;					//Context not found.
			}
		}
		catch (Exception e) {
			result = -1;						//Error code.
			System.err.println(
				"Error retrieving reference to P context {"+source+","+verse+"}: "+e
			);
		}

		return result;
	}


	/**
	 * Retrieves a reference to the given composition
	 * of word form and source references.
	 * @param form reference to the word form.
	 * @param source reference to the source of the word form.
	 * @return the matching reference,
	 * or -1 if the composition not found or in case of an SQL error.
	 */
	public int getCrossform(int form, int source) {
		int result = -1;

		try {
			getCwf.clearParameters();
			getCwf.setInt(1, form);
			getCwf.setInt(2, source);
			ResultSet id = getCwf.executeQuery();
			if (id.next()) {
				result = id.getInt("id");		//Reference to cross WF.
			}
			else {
				result = -1;					//Composition not found.
			}
		}
		catch (SQLException sqle) {
			result = -1;						//Error code.
			System.err.println(
				"Error retrieving reference to cross WF {"+
				form+","+source+"}: "+sqle
			);
		}

		return result;
	}


	/**
	 * Retrieves a reference to the given position.
	 * Positioning structure: book->chapter->verse.
	 * @param cform reference to cross word form.
	 * @param book reference to book.
	 * @param chapter number of chapter.
	 * @param verse number of verse.
	 * @return the matching reference,
	 * or -1 if the given position not found or in case of an SQL error.
	 */
	public int getPosition(int cform, int book, int chapter, int verse) {
		int result = -1;

		try {
			getPosGNP.clearParameters();
			getPosGNP.setInt(1, cform);
			getPosGNP.setInt(2, book);
			getPosGNP.setInt(3, chapter);
			getPosGNP.setInt(4, verse);
			ResultSet id = getPosGNP.executeQuery();
			if (id.next()) {
				result = id.getInt("id");		//Reference to GNP position.
			}
			else {
				result = -1;					//Position not found.
			}
		}
		catch (SQLException sqle) {
			result = -1;						//Error code.
			System.err.println(
				"Error retrieving reference to GNP position {"+
				cform+","+book+","+chapter+","+verse+"}: "+sqle
			);
		}

		return result;
	}


	/**
	 * Retrieves a reference to the given position.
	 * Positioning structure: page->row.
	 * @param cform reference to cross word form.
	 * @param page number of page.
	 * @param row number of row.
	 * @return the matching reference,
	 * or -1 if the given position not found or in case of an error.
	 */
	public int getPosition(int cform, String page, int row) {
		int result = -1;
		if (page.length() > 15) {				//Constraint from
			errParam(page);						//data object definition.
			return result;
		}

		try {
			getPosLR.clearParameters();
			getPosLR.setInt(1, cform);
			getPosLR.setBytes(2, page.getBytes("UTF-8"));
			getPosLR.setInt(3, row);
			ResultSet id = getPosLR.executeQuery();
			if (id.next()) {
				result = id.getInt("id");		//Reference to LR position.
			}
			else {
				result = -1;					//Position not found.
			}
		}
		catch (Exception e) {
			result = -1;						//Error code.
			System.err.println(
				"Error retrieving reference to LR position {"+
				cform+","+page+","+row+"}: "+e
			);
		}

		return result;
	}


	/**
	 * Retrieves a reference to the given position.
	 * Positioning structure: verse.
	 * @param cform reference to cross word form.
	 * @param verse number of verse.
	 * @return the matching reference,
	 * or -1 if the given position not found or in case of an error.
	 */
	public int getPosition(int cform, String verse) {
		int result = -1;
		if (verse.length() > 15) {				//Constraint from
			errParam(verse);					//data object definition.
			return result;
		}

		try {
			getPosP.clearParameters();
			getPosP.setInt(1, cform);
			getPosP.setBytes(2, verse.getBytes("UTF-8"));
			ResultSet id = getPosP.executeQuery();
			if (id.next()) {
				result = id.getInt("id");		//Reference to P position.
			}
			else {
				result = -1;					//Position not found.
			}
		}
		catch (Exception e) {
			result = -1;						//Error code.
			System.err.println(
				"Error retrieving reference to P position {"+cform+","+verse+"}: "+e
			);
		}

		return result;
	}


	/**
	 * Retrieves a reference to the given source.
	 * @param author reference to author.
	 * @param code codificator of the source.
	 * @return the matching reference,
	 * or -1 if the source not found or in case of an error.
	 */
	public int getSource(int author, String code) {
		int result = -1;
		if (code.length() > 20) {				//Constraint from
			errParam(code);						//data object definition.
			return result;
		}

		try {
			getSrc.clearParameters();
			getSrc.setInt(1, author);
			getSrc.setBytes(2, code.getBytes("UTF-8"));
			ResultSet id = getSrc.executeQuery();
			if (id.next()) {
				result = id.getInt("source");	//Reference to source.
			}
			else {
				result = -1;					//Source not found.
			}
		}
		catch (Exception e) {
			result = -1;						//Error code.
			System.err.println("Error retrieving reference to source {"+
			author+","+code+"}: "+e);
		}

		return result;
	}


	/**
	 * Retrieves a reference to the given word form.
	 * @param form word form to find.
	 * @return the matching reference,
	 * or -1 if the word form not found or in case of an error.
	 */
	public int getWordform(String form) {
		int result = -1;
		if (form.length() > 50) {				//Constraint from
			errParam(form);						//data object definition.
			return result;
		}

		try {
			getWrd.clearParameters();
			getWrd.setBytes(1, form.getBytes("UTF-8"));
			ResultSet id = getWrd.executeQuery();

			if (id.isBeforeFirst()) {
				while (id.next()) {
					if (form.equals(new String(id.getBytes("wordform"), "UTF-8"))) {
						result = id.getInt("id");
						break;
					}
				}
			}
			else {
				result = -1;					//Word form not found.
			}
		}
		catch (Exception e) {
			result = -1;						//Error code.
			System.err.println(
				"Error retrieving reference to word form {"+form+"}: "+e
			);
		}

		return result;
	}


	/**
	 * Inserts a new record for the given author
	 * into table AUTHORS.
	 * @param name author's name.
	 * @return created reference to the given author,
	 * or -1 if an error occurred.
	 */
	public int insAuthor(String name) {
		int result = -1;
		if (name.length() > 50) {				//Constraint from
			errParam(name);						//data object definition.
			return result;
		}

		try {
			insAut.clearParameters();
			insAut.setBytes(1, name.getBytes("UTF-8"));
			insAut.executeUpdate();
			result = getAuthor(name);			//Reference to author.
		}
		catch (Exception e) {
			result = -1;						//Error code.
			System.err.println("Error inserting author {"+name+"}: "+e);
		}

		return result;
	}


	/**
	 * Inserts a new record for the given book
	 * into table BOOKS.
	 * @param code codificator of book.
	 * @param name full name of book.
	 * @return created reference to the given book,
	 * or -1 if an error occurred.
	 */
	public int insBook(int source, String code, String name) {
		int result = -1;
		if ((code.length() > 15) ||				//Constraint from
			(name.length() > 100)) {			//data object definition.
			errParam(code+", "+name);
			return result;
		}

		try {
			insBok.clearParameters();
			insBok.setInt(1, source);
			insBok.setBytes(2, code.getBytes("UTF-8"));
			insBok.setBytes(3, name.getBytes("UTF-8"));
			insBok.executeUpdate();
			result = getBook(code, source);		//Reference to book.
		}
		catch (Exception e) {
			result = -1;						//Error code.
			System.err.println("Error inserting book {"+code+"}: "+e);
		}

		return result;
	}


	/**
	 * Inserts a new record for the given category
	 * into table CATEGORIES.
	 * @param name category name.
	 * @return created reference to the given category,
	 * or -1 if an error occurred.
	 */
	public int insCategory(String name) {
		int result = -1;
		if (name.length() > 30) {				//Constraint from
			errParam(name);						//data object definition.
			return result;
		}

		try {
			insCat.clearParameters();
			insCat.setBytes(1, name.getBytes("UTF-8"));
			insCat.executeUpdate();
			result = getCategory(name);			//Reference to category.
		}
		catch (Exception e) {
			result = -1;						//Error code.
			System.err.println("Error inserting category {"+name+"}: "+e);
		}

		return result;
	}


	/**
	 * Inserts a new record of context
	 * for the given GNP position into table GNP_CONTEXTS.
	 * @param src reference to the context source.
	 * @param bk reference to a book.
	 * @param ch number of chapter.
	 * @param vr number of verse.
	 * @param txt content of context.
	 * @return true if insertion succeed, false otherwise.
	 */
	public boolean insContext(int src, int bk, int ch, int vr, String txt) {
		boolean result = false;

		try {
			insConGNP.clearParameters();
			insConGNP.setInt(1, src);
			insConGNP.setInt(2, bk);
			insConGNP.setInt(3, ch);
			insConGNP.setInt(4, vr);
			insConGNP.setBytes(5, txt.getBytes("UTF-8"));
			insConGNP.executeUpdate();
			result = true;						//Successful insertion.
		}
		catch (Exception e) {
			result = false;						//Error flag.
			System.err.println(
				"Error inserting GNP position {"+src+","+bk+","+ch+","+vr+"}: "+e
			);
		}

		return result;
	}


	/**
	 * Inserts a new record of context
	 * for the given LR position into table LR_CONTEXTS.
	 * @param src reference to the context source.
	 * @param pg number of page.
	 * @param rw number of row.
	 * @param txt content of context.
	 * @return true if insertion succeed, false otherwise.
	 */
	public boolean insContext(int src, String pg, int rw, String txt) {
		boolean result = false;
		if (pg.length() > 15) {					//Constraint from
			errParam(pg);						//data object definition.
			return result;
		}

		try {
			insConLR.clearParameters();
			insConLR.setInt(1, src);
			insConLR.setBytes(2, pg.getBytes("UTF-8"));
			insConLR.setInt(3, rw);
			insConLR.setBytes(4, txt.getBytes("UTF-8"));
			insConLR.executeUpdate();
			result = true;						//Successful insertion.
		}
		catch (Exception e) {
			result = false;						//Error flag.
			System.err.println(
				"Error inserting LR position {"+src+","+pg+","+rw+"}: "+e
			);
		}

		return result;
	}


	/**
	 * Inserts a new record of context
	 * for the given P position into table P_CONTEXTS.
	 * @param src reference to the context source.
	 * @param vr number of verse.
	 * @param txt content of context.
	 * @return true if insertion succeed, false otherwise.
	 */
	public boolean insContext(int src, String vr, String txt) {
		boolean result = false;
		if (vr.length() > 15) {					//Constraint from
			errParam(vr);						//data object definition.
			return result;
		}

		try {
			insConP.clearParameters();
			insConP.setInt(1, src);
			insConP.setBytes(2, vr.getBytes("UTF-8"));
			insConP.setBytes(3, txt.getBytes("UTF-8"));
			insConP.executeUpdate();
			result = true;						//Successful insertion.
		}
		catch (Exception e) {
			result = false;						//Error flag.
			System.err.println(
				"Error inserting P position {"+src+","+vr+"}: "+e
			);
		}

		return result;
	}


	/**
	 * Inserts a new record for the given composition
	 * of author and source references into table COOPERS.
	 * @param author reference to the author.
	 * @param source reference to the source written by the author.
	 * @return true if insertion succeed, false otherwise.
	 */
	public boolean insCooperation(int author, int source) {
		boolean result = false;

		try {
			insCoo.clearParameters();
			insCoo.setInt(1, author);
			insCoo.setInt(2, source);
			insCoo.executeUpdate();
			result = true;						//Successful insertion.
		}
		catch (SQLException sqle) {
			result = false;						//Error code.
			System.err.println(
				"Error inserting crooperation {"+author+","+source+"}: "+sqle
			);
		}

		return result;
	}


	/**
	 * Inserts a new record for the given composition
	 * of word form and source references into table CROSSFORMS.
	 * @param form reference to the word form.
	 * @param source reference to the source of the word form.
	 * @return created reference to the cross word form,
	 * or -1 if an SQL error occurred.
	 */
	public int insCrossform(int form, int source) {
		int result = -1;

		try {
			insCwf.clearParameters();
			insCwf.setInt(1, form);
			insCwf.setInt(2, source);
			insCwf.executeUpdate();
			result = getCrossform(form, source);//Reference to cross WF.
		}
		catch (SQLException sqle) {
			result = -1;						//Error code.
			System.err.println(
				"Error inserting cross WF {"+form+","+source+"}: "+sqle
			);
		}

		return result;
	}


	/**
	 * Inserts a new record of GNP position
	 * for the given cross word form into table GNP_POSITIONS.
	 * @param cf reference to the cross word form.
	 * @param bk reference to a book.
	 * @param ch number of chapter.
	 * @param vr number of verse.
	 * @param cnt occurrencies of the given word form in the verse.
	 * @param txt reference to a word form context.
	 * @return true if insertion succeed, false otherwise.
	 */
	public boolean insPosition(int cf, int bk, int ch, int vr, int cnt, int txt) {
		boolean result = false;

		try {
			insPosGNP.clearParameters();
			insPosGNP.setInt(1, cf);
			insPosGNP.setInt(2, bk);
			insPosGNP.setInt(3, ch);
			insPosGNP.setInt(4, vr);
			insPosGNP.setInt(5, cnt);
			insPosGNP.setInt(6, txt);
			insPosGNP.executeUpdate();
			result = true;						//Successful insertion.
		}
		catch (SQLException sqle) {
			result = false;						//Error flag.
			System.err.println(
				"Error inserting GNP position {"+cf+","+bk+","+ch+","+vr+"}: "+sqle
			);
		}

		return result;
	}


	/**
	 * Inserts a new record of LR position
	 * for the given cross word form into table LR_POSITIONS.
	 * @param cf reference to the cross word form.
	 * @param pg number of page.
	 * @param rw number of row.
	 * @param cnt occurrencies of the given word form in the row.
	 * @param txt reference to a word form context.
	 * @return true if insertion succeed, false otherwise.
	 */
	public boolean insPosition(int cf, String pg, int rw, int cnt, int txt) {
		boolean result = false;
		if (pg.length() > 15) {					//Constraint from
			errParam(pg);						//data object definition.
			return result;
		}

		try {
			insPosLR.clearParameters();
			insPosLR.setInt(1, cf);
			insPosLR.setBytes(2, pg.getBytes("UTF-8"));
			insPosLR.setInt(3, rw);
			insPosLR.setInt(4, cnt);
			insPosLR.setInt(5, txt);
			insPosLR.executeUpdate();
			result = true;						//Successful insertion.
		}
		catch (Exception e) {
			result = false;						//Error flag.
			System.err.println(
				"Error inserting LR position {"+cf+","+pg+","+rw+"}: "+e
			);
		}

		return result;
	}


	/**
	 * Inserts a new record of P position
	 * for the given cross word form into table P_POSITIONS.
	 * @param cf reference to the cross word form.
	 * @param vr number of verse.
	 * @param cnt occurrencies of the given word form in the verse.
	 * @param txt reference to a word form context.
	 * @return true if insertion succeed, false otherwise.
	 */
	public boolean insPosition(int cf, String vr, int cnt, int txt) {
		boolean result = false;
		if (vr.length() > 15) {					//Constraint from
			errParam(vr);						//data object definition.
			return result;
		}

		try {
			insPosP.clearParameters();
			insPosP.setInt(1, cf);
			insPosP.setBytes(2, vr.getBytes("UTF-8"));
			insPosP.setInt(3, cnt);
			insPosP.setInt(4, txt);
			insPosP.executeUpdate();
			result = true;						//Successful insertion.
		}
		catch (Exception e) {
			result = false;						//Error flag.
			System.err.println(
				"Error inserting P position {"+cf+","+vr+"}: "+e
			);
		}

		return result;
	}


	/**
	 * Inserts a new record for the given source
	 * into table SOURCES.
	 * @param auth reference to source author.
	 * @param cod codificator of source.
	 * @param name full source name.
	 * @param cat reference to category of source.
	 * @param per reference to period of source.
	 * @return created reference to the given source,
	 * or -1 if an error occurred.
	 */
	public int insSource(int auth, String cod, String name, int cat, int per) {
		int result = -1;
		if ((cod.length() > 20) ||				//Constraint from
			(name.length() > 100)) {			//data object definition.
			errParam(cod+", "+name);
			return result;
		}

		try {
			insSrc.clearParameters();
			insSrc.setInt(1, auth);
			insSrc.setBytes(2, cod.getBytes("UTF-8"));
			insSrc.setBytes(3, name.getBytes("UTF-8"));
			insSrc.setInt(4, cat);
			insSrc.setInt(5, per);
			insSrc.executeUpdate();
			result = getSource(auth, cod);		//Reference to source.
		}
		catch (Exception e) {
			result = -1;						//Error code.
			System.err.println("Error inserting source {"+auth+","+cod+"}: "+e);
		}

		return result;
	}


	/**
	 * Inserts a new record for the given word form
	 * into table WORDFORMS.
	 * @param form word form to insert.
	 * @return created reference to the given word form,
	 * or -1 if an error occurred.
	 */
	public int insWordform(String form) {
		int result = -1;
		if (form.length() > 50) {				//Constraint from
			errParam(form);						//data object definition.
			return result;
		}

		try {
			insWrd.clearParameters();
			insWrd.setBytes(1, form.getBytes("UTF-8"));
			insWrd.executeUpdate();
			result = getWordform(form);			//Reference to word form.
		}
		catch (Exception e) {
			result = -1;						//Error code.
			System.err.println("Error inserting word form {"+form+"}: "+e);
		}

		return result;
	}


	/**
	 * Updates a record of context for the given position.
	 * @param pos type of positioning structure.
	 * @param id id number of context record.
	 * @param text new content of context.
	 * @return true if update succeed, false otherwise.
	 */
	public boolean updContext(int pos, int id, String text) {
		PreparedStatement pstmt = null;
		String msg = "";
		boolean result = false;

		switch (pos) {
			case POS_GNP:
				pstmt = updConGNP;
				msg = "GNP";
				break;
			case POS_LR:
				pstmt = updConLR;
				msg = "LR";
				break;
			case POS_P:
				pstmt = updConP;
				msg = "P";
				break;
		}

		try {
			pstmt.clearParameters();
			pstmt.setBytes(1, text.getBytes("UTF-8"));
			pstmt.setInt(2, id);
			pstmt.executeUpdate();
			result = true;						//Successful update.
		}
		catch (Exception e) {
			result = false;						//Error flag.
			System.err.println("Error updating "+msg+" context {"+id+"}: "+e);
		}

		return result;
	}


	/**
	 * Updates a record of plain context for the given position.
	 * @param pos type of positioning structure.
	 * @param id id number of context record.
	 * @param text new content of context.
	 * @return true if update succeed, false otherwise.
	 */
	public boolean updPlainContext(int pos, int id, String text) {
		PreparedStatement pstmt = null;
		String msg = "";
		boolean result = false;

		switch (pos) {
			case POS_GNP:
				pstmt = updPlainConGNP;
				msg = "GNP";
				break;
			case POS_LR:
				pstmt = updPlainConLR;
				msg = "LR";
				break;
			case POS_P:
				pstmt = updPlainConP;
				msg = "P";
				break;
		}

		try {
			pstmt.clearParameters();
			pstmt.setBytes(1, text.getBytes("UTF-8"));
			pstmt.setInt(2, id);
			pstmt.executeUpdate();
			result = true;						//Successful update.
		}
		catch (Exception e) {
			result = false;						//Error flag.
			System.err.println("Error updating "+msg+" context {"+id+"}: "+e);
		}

		return result;
	}


	/**
	 * Updates a record for the given position.
	 * @param pos type of positioning structure.
	 * @param id id number of position record.
	 * @param count new count of word form occurrencies in context.
	 * @param text new reference to the word form context.
	 * @return true if update succeed, false otherwise.
	 */
	public boolean updPosition(int pos, int id, int count, int text) {
		PreparedStatement pstmt = null;
		String msg = "";
		boolean result = false;

		switch (pos) {
			case POS_GNP:
				pstmt = updPosGNP;
				msg = "GNP";
				break;
			case POS_LR:
				pstmt = updPosLR;
				msg = "LR";
				break;
			case POS_P:
				pstmt = updPosP;
				msg = "P";
				break;
		}

		try {
			pstmt.clearParameters();
			pstmt.setInt(1, count);
			pstmt.setInt(2, text);
			pstmt.setInt(3, id);
			pstmt.executeUpdate();
			result = true;						//Successful update.
		}
		catch (SQLException sqle) {
			result = false;						//Error flag.
			System.err.println("Error updating "+msg+" position {"+id+"}: "+sqle);
		}

		return result;
	}

}