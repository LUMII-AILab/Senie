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
		<link rel="stylesheet" type="text/css" href="./senie.css">
		<title>Latviešu valodas seno tekstu korpuss</title>
	</head>
	<body background="./images/bg.jpg">

		<center>
		<table border="0" cellpadding="0" cellspacing="0" width="80%" height="100%">
		<tr height="75px">
			<td colspan="2">
				<img src="./images/senie.jpg" width="600px" height="75px" border="0">
			</td>
		</tr>

		<!-- PIESLĒGŠANĀS DB UN PARAMETRU INICIALIZĀCIJA ------------------------------->
		<%
			String param_codif = request.getParameter("codificator");

			Properties db_access = new Properties();
			String conf = config.getServletContext().getRealPath("/") + File.separator + "WEB-INF" + File.separator + "db.conf";
			db_access.load(new InputStreamReader(new FileInputStream(conf), "UTF-8"));

			Properties params = new Properties();
			params.put("user", db_access.getProperty("user"));
			params.put("password", db_access.getProperty("password"));
			params.put("charSet", "utf8");

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(db_access.getProperty("url"), params);

			PreparedStatement selSource = con.prepareStatement(
				"SELECT name, facsimile FROM sources WHERE codificator = ?;"
			);
			PreparedStatement selBooks = con.prepareStatement(
				"SELECT b.codificator, b.name FROM books AS b, sources AS s WHERE b.source = s.id AND s.codificator = ? ORDER BY b.id;"
			);

			selSource.clearParameters();
			selSource.setBytes(1, param_codif.getBytes("UTF-8"));
			ResultSet source = selSource.executeQuery();

			String param_name = "";
			String param_biblio = "";
			String param_fax = "";

			if (source.next()) {
				param_name = new String(source.getBytes("name"), "UTF-8");
				param_fax = new String(source.getBytes("facsimile"), "UTF-8");
			}
			else {
				param_codif = "";
			}

			String demopath = getServletContext().getRealPath("/") + File.separator + "static" + File.separator;
			File demofile = null;
		%>
		<!------------------------------------------------------------------------------>

		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr>
					<td>
						<p class="title"><i><%= param_name %></i> (<%= param_codif %>)</p>
					</td>
					<td>
						<p class="navig"><a href="./toc.jsp" class="button">&nbsp;SĀKUMLAPA&nbsp;</a></p>
					</td>
				</tr>
				</table>
			</td>
		</tr>

		<tr>
			<td width="10%">&nbsp;</td>
			<td bgcolor="#CCFF99">
				<ul class="liste">
					<li>
						<span class="code"><a href="./biblio.jsp?source=<%= param_codif %>">bibliogrāfija</a></span>
					</li>

					<%
						demofile = new File(demopath + param_codif + ".html");
						if (demofile.exists()) {
					%>
					<li>
						<span class="code"><a href="./static/<%= param_codif %>.html">statisks indekss un teksts</a></span>
					</li>
					<% } %>

					<li>
						<span class="code">vārdformu biežuma saraksts (CS): </span>&nbsp;
						<a href="./frequencies.jsp?source=<%= param_codif %>&limit=1000&lower=no"><img src="./images/txt.gif" width="13px" height="16px" border="0"></a>&nbsp;<span class="hint">(top 1000)</span>&nbsp;&nbsp;
						<a href="./downloads/<%= param_codif %>_frequencies.zip"><img src="./images/zip.gif" width="15px" height="16px" border="0"></a>&nbsp;<span class="hint">(pilns)</span>
					</li>
					<li>
						<span class="code">vārdformu biežuma saraksts (LC): </span>&nbsp;
						<a href="./frequencies.jsp?source=<%= param_codif %>&limit=1000&lower=yes"><img src="./images/txt.gif" width="13px" height="16px" border="0"></a>&nbsp;<span class="hint">(top 1000)</span>&nbsp;&nbsp;
						<a href="./downloads/<%= param_codif %>_frequencies_lower.zip"><img src="./images/zip.gif" width="15px" height="16px" border="0"></a>&nbsp;<span class="hint">(pilns)</span>
					</li>
					<li>
						<span class="code">vārdformu indekss (CS): </span>&nbsp;
						<a href="./downloads/<%= param_codif %>_indexed.zip"><img src="./images/zip.gif" width="15px" height="16px" border="0"></a>&nbsp;<span class="hint">(pilns)</span>
					</li>
					<li>
						<span class="code">vārdformu indekss (LC): </span>&nbsp;
						<a href="./downloads/<%= param_codif %>_indexed_lower.zip"><img src="./images/zip.gif" width="15px" height="16px" border="0"></a>&nbsp;<span class="hint">(pilns)</span>
					</li>

					<% if (!param_fax.equals("")) { %>
					<!-- FIXME: add #<book_codif>
					<li>
						<span class="code"><a href="<%= param_fax %>" target="_new">oriģināla faksimils</a></span>
					</li>
					-->
					<% } %>

				</ul>

				<%
					if (param_codif.matches("JT1685|VD1689_94")) {
						selBooks.clearParameters();
						selBooks.setBytes(1, param_codif.getBytes("UTF-8"));
						ResultSet books = selBooks.executeQuery();
						out.println("<hr class=\"hrSeparator\">");

						while (books.next()) {
							String book_codif = new String(books.getBytes("codificator"), "UTF-8");
				%>
				<p class="chapter"><%= new String(books.getBytes("name"), "UTF-8") %> (<%= book_codif %>)</p>
				<ul class="liste">

					<%
						demofile = new File(demopath + book_codif + ".html");
						if (demofile.exists()) {
					%>
					<li>
						<span class="code"><a href="./static/<%= book_codif %>.html">statisks indekss un teksts</a></span>
					</li>
					<% } %>

					<li>
						<span class="code">vārdformu biežuma saraksts (CS): </span>&nbsp;
						<a href="./frequencies.jsp?source=<%= book_codif %>&limit=1000&lower=no"><img src="./images/txt.gif" width="13px" height="16px" border="0"></a>&nbsp;<span class="hint">(top 1000)</span>&nbsp;&nbsp;
						<a href="./downloads/<%= book_codif %>_frequencies.zip"><img src="./images/zip.gif" width="15px" height="16px" border="0"></a>&nbsp;<span class="hint">(pilns)</span>
					</li>
					<li>
						<span class="code">vārdformu biežuma saraksts (LC): </span>&nbsp;
						<a href="./frequencies.jsp?source=<%= book_codif %>&limit=1000&lower=yes"><img src="./images/txt.gif" width="13px" height="16px" border="0"></a>&nbsp;<span class="hint">(top 1000)</span>&nbsp;&nbsp;
						<a href="./downloads/<%= book_codif %>_frequencies_lower.zip"><img src="./images/zip.gif" width="15px" height="16px" border="0"></a>&nbsp;<span class="hint">(pilns)</span>
					</li>
					<li>
						<span class="code">vārdformu indekss (CS): </span>&nbsp;
						<a href="./downloads/<%= book_codif %>_indexed.zip"><img src="./images/zip.gif" width="15px" height="16px" border="0"></a>&nbsp;<span class="hint">(pilns)</span>
					</li>
					<li>
						<span class="code">vārdformu indekss (LC): </span>&nbsp;
						<a href="./downloads/<%= book_codif %>_indexed_lower.zip"><img src="./images/zip.gif" width="15px" height="16px" border="0"></a>&nbsp;<span class="hint">(pilns)</span>
					</li>
				</ul>
				<%
						}
					}
					con.close();
				%>

				<p class="legend">CS - reģistrjūtība (<I>case sensitive</I>)<br>LC - reģistrnejūtība (<I>lower case</I>)</p>
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
