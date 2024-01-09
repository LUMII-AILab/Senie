<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%@ page pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="stylesheet" type="text/css" href="./css/senie.css">
		<title>Senie</title>

		<script type="text/javascript" language="JavaScript">
			function setDim() {
				var dim = new String(window.location);

				if (dim.indexOf("&") > 0) {
					dim = dim.substring(dim.indexOf("dimension=") + 10, dim.indexOf("&"));
				}
				else {
					dim = dim.substring(dim.indexOf("dimension=") + 10, dim.length);
				}

				if (dim == 'authors') {
					document.navig_form.dimension.selectedIndex = 1;
				}
				else if (dim == 'categories') {
					document.navig_form.dimension.selectedIndex = 2;
				}
				else {
					document.navig_form.dimension.selectedIndex = 0;
				}
			}
		</script>
	</head>
	<body background="./images/bg.jpg" onLoad="setDim();">

		<center>
		<table border="0" cellpadding="0" cellspacing="0" width="80%" height="100%">
		<tr height="75px">
			<td colspan="2">
				<img src="./images/senie.jpg" width="600px" height="75px" border="0"/>
			</td>
		</tr>

		<!-- PIESLĒGŠANĀS DB UN VAICĀJUMU INICIALIZĀCIJA ------------------------------->
		<%
			String param_dim = request.getParameter("dimension");
			String param_auth = request.getParameter("author");
			String param_cat = request.getParameter("category");
			String param_pos = request.getParameter("structure");
			String param_src = request.getParameter("source");
			String param_book = request.getParameter("book");
			String param_chap = request.getParameter("chapter");

			//if (param_auth != null) {
			//	param_auth = new String(request.getParameter("author").getBytes("8859_1"), "UTF-8");
			//}
			//if (param_cat != null) {
			//	param_cat = new String(request.getParameter("category").getBytes("8859_1"), "UTF-8");
			//}

			Properties db_access = new Properties();
			String conf = config.getServletContext().getRealPath("/") + File.separator + "WEB-INF" + File.separator + "db.conf";
			db_access.load(new InputStreamReader(new FileInputStream(conf), "UTF-8"));

			Properties params = new Properties();
			params.put("user", db_access.getProperty("user"));
			params.put("password", db_access.getProperty("password"));
			params.put("charSet", "utf8");

			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(db_access.getProperty("url"), params);

			PreparedStatement selSources = con.prepareStatement(
				"SELECT codificator, name, structure FROM sources WHERE active = '1' ORDER BY codificator;"
			);
			PreparedStatement selAuthSrc = con.prepareStatement(
				"SELECT s.codificator, s.name, s.structure FROM sources s "+
				"LEFT JOIN coopers c ON s.codificator = c.source "+
				"LEFT JOIN authors a ON c.author = a.id "+
				"WHERE a.name = ? AND s.active = '1' ORDER BY s.codificator;"
			);
			PreparedStatement selCatSrc = con.prepareStatement(
				"SELECT s.codificator, s.name, s.structure FROM sources s "+
				"LEFT JOIN categories c ON s.category = c.id "+
				"WHERE c.name = ? AND s.active = '1' ORDER BY s.codificator;"
			);
			PreparedStatement selBooks = con.prepareStatement(
				"SELECT b.codificator, b.name FROM books b "+
				"LEFT JOIN sources s ON b.source = s.codificator "+
				"WHERE s.codificator = ?;"
			);
			PreparedStatement selChaps = con.prepareStatement(
				"SELECT DISTINCT c.chapter FROM gnp_contexts c "+
				"LEFT JOIN sources s ON c.source = s.codificator "+
				"LEFT JOIN books b ON c.book = b.codificator "+
				"WHERE s.codificator = ? AND b.codificator = ? ORDER BY c.chapter;"
			);
			PreparedStatement selVersesGNP = con.prepareStatement(
				"SELECT DISTINCT c.verse FROM gnp_contexts c "+
				"LEFT JOIN sources s ON c.source = s.codificator "+
				"LEFT JOIN books b ON c.book = b.codificator "+
				"WHERE s.codificator = ? AND b.codificator = ? AND c.chapter = ? ORDER BY c.verse;"
			);
			PreparedStatement selVersesP = con.prepareStatement(
				"SELECT DISTINCT c.verse FROM p_contexts c "+
				"LEFT JOIN sources s ON c.source = s.codificator "+
				"WHERE s.codificator = ?;"
			);
			PreparedStatement selPages = con.prepareStatement(
				"SELECT DISTINCT c.page FROM lr_contexts c "+
				"LEFT JOIN sources s ON c.source = s.codificator "+
				"WHERE s.codificator = ?;"
			);
			PreparedStatement selAuthors = con.prepareStatement(
				"SELECT name FROM authors ORDER BY name;"
			);
			PreparedStatement selCats = con.prepareStatement(
				"SELECT name FROM categories ORDER BY name;"
			);

			ResultSet sources = null;
			ResultSet books = null;
			ResultSet chaps = null;
			ResultSet verses = null;
			ResultSet pages = null;
			ResultSet authors = null;
			ResultSet cats = null;
		%>
		<!------------------------------------------------------------------------------>

		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr>
					<td><p class="title">Navigācija korpusa saturā</p></td>
					<td>
						<p class="navig">
							<% if (param_src != null || param_auth != null || param_cat != null) { %>
							<a href="javascript:history.back();" class="button">&nbsp;ATPAKAĻ&nbsp;</a>&nbsp;
							<% } %>
							<a href="." class="button">&nbsp;SĀKUMLAPA&nbsp;</a>
						</p>
					</td>
				</tr>
				</table>
			</td>
		</tr>

		<tr>
			<td width="10%">&nbsp;</td>
			<td bgcolor="#CCFF99">
				<p class="separator">&nbsp;</p>
				<center>
				<form name="navig_form" method="GET" action="./navigation.jsp">
					<table border="0" cellpadding="4px" cellspacing="0">
					<tr>
						<td style="border-right: 1px #669933 solid;">
							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td><p class="hint">Šķērsgriezums:&nbsp;</p></td>
								<td>
									<select name="dimension" size="1" class="menu">
										<option value="sources">avoti</option>
										<option value="authors">autori</option>
										<option value="categories">kategorijas</option>
									</select>
								</td>
							</tr>
							</table>
						</td>
						<td valign="bottom">
							<input type="submit" value="Kārtot!" class="subutt">
						</td>
					</tr>
					</table>
				</form>
				</center>
				<hr class="hrSeparator">

		<!-- PAŠREIZĒJĀS ATRAŠANĀS VIETAS RĀDĪTĀJS ------------------------------------->
		<%
			if (param_src != null || param_auth != null || param_cat != null) {
				out.print("<p class=\"indic\">");
				if (param_cat != null) {
					out.print(param_cat + " :: ");
				}
				if (param_auth != null) {
					out.print(param_auth + " :: ");
				}
				if (param_src != null) {
					out.print(param_src + " :: ");
				}
				if (param_book != null) {
					out.print(param_book + " :: ");
				}
				if (param_chap != null) {
					out.print(param_chap + ". nodaļa :: ");
				}
				out.print("</p><hr class=\"hrSeparator\">");
			}
		%>
		<!------------------------------------------------------------------------------>


		<%
		String a[] = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
		String src2[]=new String[1000];
		int len[] = new int[1000];
		%>
		<p class="navicont">

		<!-- DIMENSIJAS LĪMEŅA DATI ---------------------------------------------------->
		<%
			String pos = "";
			String auth = "";
			String cat = "";
			String src = "";
			String book = "";
			String chap = "";
			String vr = "";
			String pg = "";

			if (param_dim.equals("authors") && param_auth == null) {
				authors = selAuthors.executeQuery();
				while (authors.next()) {
					auth = new String(authors.getBytes("name"), "UTF-8");
		%>
					<a href="./navigation.jsp?dimension=authors&author=<%= auth %>"><b><%= auth %></b></a><br>
		<%
				}
			}
			else if (param_dim.equals("categories") && param_cat == null) {
				cats = selCats.executeQuery();
				while (cats.next()) {
					cat = new String(cats.getBytes("name"), "UTF-8");
		%>
					<a href="./navigation.jsp?dimension=categories&category=<%= cat %>"><b><%= cat %></b></a><br>
		<%
				}
			}
			else if (param_auth != null && param_src == null) {
				selAuthSrc.clearParameters();
				selAuthSrc.setBytes(1, param_auth.getBytes("UTF-8"));
				sources = selAuthSrc.executeQuery();

				while (sources.next()) {
					src = new String(sources.getBytes("codificator"), "UTF-8");
					pos = sources.getString("structure");
		%>
					<a href="./navigation.jsp?dimension=authors&author=<%= param_auth %>&structure=<%= pos %>&source=<%= src %>"><b><%= src %></b></a>
					(<%= new String(sources.getBytes("name"), "UTF-8") %>)<br>
		<%
				}
			}
			else if (param_cat != null && param_src == null) {
				selCatSrc.clearParameters();
				selCatSrc.setBytes(1, param_cat.getBytes("UTF-8"));
				sources = selCatSrc.executeQuery();

				while (sources.next()) {
					src = new String(sources.getBytes("codificator"), "UTF-8");
					pos = sources.getString("structure");
		%>
					<a href="./navigation.jsp?dimension=categories&category=<%= param_cat %>&structure=<%= pos %>&source=<%= src %>"><b><%= src %></b></a>
					(<%= new String(sources.getBytes("name"), "UTF-8") %>)<br>
		<%
				}
			}
			else if (param_dim.equals("sources") && param_src == null) {
				sources = selSources.executeQuery();
				while (sources.next()) {
					src = new String(sources.getBytes("codificator"), "UTF-8");
					pos = sources.getString("structure");
		%>
					<a href="./navigation.jsp?dimension=sources&structure=<%= pos %>&source=<%= src %>"><b><%= src %></b></a>
					(<%= new String(sources.getBytes("name"), "UTF-8") %>)<br>
		<%
				}
			}
			else {
		%>
		<!------------------------------------------------------------------------------>

		<!-- DZIĻĀKU LĪMEŅU DATI ------------------------------------------------------->
		<%
				if (param_pos.equals("GNP") && param_book == null) {
					//GNP grāmatas
					selBooks.clearParameters();
					selBooks.setBytes(1, param_src.getBytes("UTF-8"));
					books = selBooks.executeQuery();

					while (books.next()) {
						book = new String(books.getBytes("codificator"), "UTF-8");

						if (param_auth != null) {
		%>
					<a href="./navigation.jsp?dimension=authors&author=<%= param_auth %>&structure=<%= param_pos %>&source=<%= param_src %>&book=<%= book %>"><b><%= book %></b></a>
					(<%= new String(books.getBytes("name"), "UTF-8") %>)<br>
		<%
						}
						else if (param_cat != null) {
		%>
					<a href="./navigation.jsp?dimension=categories&category=<%= param_cat %>&structure=<%= param_pos %>&source=<%= param_src %>&book=<%= book %>"><b><%= book %></b></a>
					(<%= new String(books.getBytes("name"), "UTF-8") %>)<br>
		<%
						}
						else {
		%>
					<a href="./navigation.jsp?dimension=sources&structure=<%= param_pos %>&source=<%= param_src %>&book=<%= book %>"><b><%= book %></b></a>
					(<%= new String(books.getBytes("name"), "UTF-8") %>)<br>
		<%
						}
					}
				}
				else if (param_book != null && param_chap == null) {
					//GNP nodaļas
					selChaps.clearParameters();
					selChaps.setBytes(1, param_src.getBytes("UTF-8"));
					selChaps.setBytes(2, param_book.getBytes("UTF-8"));
					chaps = selChaps.executeQuery();

					while (chaps.next()) {
						chap = chaps.getString("chapter");

						if (param_auth != null) {
		%>
					<a href="./navigation.jsp?dimension=authors&author=<%= param_auth %>&structure=<%= param_pos %>&source=<%= param_src %>&book=<%= param_book %>&chapter=<%= chap %>"><b><%= chap %></b></a>. nodaļa<br>
		<%
						}
						else if (param_cat != null) {
		%>
					<a href="./navigation.jsp?dimension=categories&category=<%= param_cat %>&structure=<%= param_pos %>&source=<%= param_src %>&book=<%= param_book %>&chapter=<%= chap %>"><b><%= chap %></b></a>. nodaļa<br>
		<%
						}
						else {
		%>
					<a href="./navigation.jsp?dimension=sources&structure=<%= param_pos %>&source=<%= param_src %>&book=<%= param_book %>&chapter=<%= chap %>"><b><%= chap %></b></a>. nodaļa<br>
		<%
						}
					}
				}
				else if (param_chap != null) {
					//GNP panti
					selVersesGNP.clearParameters();
					selVersesGNP.setBytes(1, param_src.getBytes("UTF-8"));
					selVersesGNP.setBytes(2, param_book.getBytes("UTF-8"));
					selVersesGNP.setInt(3, Integer.parseInt(param_chap));
					verses = selVersesGNP.executeQuery();

					int length;
					int max = 0;
					for (int k=0; verses.next(); k++) {
						vr = verses.getString("verse");

								length=1;
								src2[k] = vr;

								int n=0;
								int c=2;
								int q=0;
								int m;
								int p;
								for (m = 0, p=1; n!=1 && c!=0; m++, p++, length++)
								{

									try{

									String ads = src2[k].substring (m,p);
										//out.println ("<b>" + ads + "</b>");
										if (ads.equals("0") && m==0)
										{
											length--;
											continue;
										}

										c=0;
									for (q=0; a[q]!=null && c!=1; q++)
									{
										c=0;
										if (ads.equals(a[q]))
										{
											c=1;
											break;
										}
									}

									}catch(Exception e){n=1;}
									if (m==0 && c==0) {length=21; break;}
								}

								if (length>1){length--;}
								if (max<length){max=length;}

								len[k] = length;
							}


							for (int s=1; s<=max; s++){
							for (int t=0; src2[t]!=null; t++)
							{

								if (len[t] == s)
								{
		%>
					<a href="context.jsp?structure=GNP&source=<%= param_src %>&book=<%= param_book %>&chapter=<%= param_chap %>&verse=<%= src2[t] %>"><b><%= src2[t] %></b></a>. pants<br>
		<%
								}}
					}
				}
				else if (param_pos.equals("LR")) {
					//LR lappuses
					selPages.clearParameters();
					selPages.setBytes(1, param_src.getBytes("UTF-8"));
					pages = selPages.executeQuery();

				int length=1;
				int max = 0;
					for (int k=0; pages.next(); k++) {
						pg = new String(pages.getBytes("page"), "UTF-8");

						length=1;
						src2[k] = pg;

						int n=0;
						int c=2;
						int q=0;
						int m;
						int p;
						for (m = 0, p=1; n!=1 && c!=0; m++, p++, length++)
						{

							try{

							String ads = src2[k].substring (m,p);
								if (ads.equals("0") && m==0)
								{
									length--;
									continue;
								}

								c=0;
							for (q=0; a[q]!=null && c!=1; q++)
							{
								c=0;
								if (ads.equals(a[q]))
								{
									c=1;
									break;
								}
							}

							}catch(Exception e){n=1;}
							if (m==0 && c==0) {length=21; break;}
						}

						if (length>1){length--;}
						if (max<length){max=length;}

						len[k] = length;
					}


					for (int s=1; s<=max; s++){
					for (int t=0; src2[t]!=null; t++)
					{

						if (len[t] == s)
						{

		%>
					<a href="context.jsp?structure=LR&source=<%= param_src %>&page=<%= src2[t] %>"><b><%= src2[t] %></b></a>. lpp.<br>

		<%
						}
					}}

				}
				else if (param_pos.equals("P")) {
					//P panti
					selVersesP.clearParameters();
					selVersesP.setBytes(1, param_src.getBytes("UTF-8"));
					verses = selVersesP.executeQuery();

					int length=1;
					int max = 0;
					for (int k=0; verses.next(); k++) {
						vr = new String(verses.getBytes("verse"), "UTF-8");

								length=1;
								src2[k] = vr;

								int n=0;
								int c=2;
								int q=0;
								int m;
								int p;
								for (m = 0, p=1; n!=1 && c!=0; m++, p++, length++)
								{

									try{

									String ads = src2[k].substring (m,p);
										if (ads.equals("0") && m==0)
										{
											length--;
											continue;
										}

										c=0;
									for (q=0; a[q]!=null && c!=1; q++)
									{
										c=0;
										if (ads.equals(a[q]))
										{
											c=1;
											break;
										}
									}

									}catch(Exception e){n=1;}
									if (m==0 && c==0) {length=21; break;}
								}

								if (length>1){length--;}
								if (max<length){max=length;}

								len[k] = length;
							}


							for (int s=1; s<=max; s++){
							for (int t=0; src2[t]!=null; t++)
							{

								if (len[t] == s)
								{
		%>
					<a href="context.jsp?structure=P&source=<%= param_src %>&verse=<%= src2[t] %>"><b><%= src2[t] %></b></a> pants<br>
		<%
								}
							}
					}
				}
			}
		%>
		<!------------------------------------------------------------------------------>

				</p>
			</td>
		</tr>

		<tr>
			<td colspan="2" height="100%">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<p class="copy">
					&copy; LU Matemātikas un informātikas institūta Mākslīgā intelekta laboratorija<br>
					&copy; LU Humanitāro zinātņu fakultātes Baltu valodu katedra<br>
					&copy; LU Latviešu valodas institūts<br>
					2002-2015
				</p>
			</td>
		</tr>
		</table>
		</center>

<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-2563945-3");
pageTracker._trackPageview();
} catch(err) {}</script>

	</body>
</html>
