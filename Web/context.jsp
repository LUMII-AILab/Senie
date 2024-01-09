<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%@ page pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%!
	private String highlight(String wf, String line) {
		while (line.indexOf(wf) != -1) {
    		line = line.substring(0, line.indexOf(wf)) + "DEAD_LOCK" + line.substring(line.indexOf(wf) + wf.length(), line.length());
    	}
		while (line.indexOf("DEAD_LOCK") != -1) {
    		line = line.substring(0, line.indexOf("DEAD_LOCK")) + "<b>"+wf+"</b>" + line.substring(line.indexOf("DEAD_LOCK") + "DEAD_LOCK".length(), line.length());
    	}

		return line;
	}
%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="stylesheet" type="text/css" href="./css/senie.css">
		<title>Senie</title>
	</head>
	<body background="./images/bg.jpg">

		<center>
		<table border="0" cellpadding="0" cellspacing="0" width="80%" height="100%">
		<tr height="75px">
			<td colspan="2">
				<img src="./images/senie.jpg" width="600px" height="75px" border="0"/>
			</td>
		</tr>

		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr>
					<td><p class="title">Vārdlietojuma konteksts</p></td>
					<td><p class="navig">
						<a href="javascript:history.back();" class="button">&nbsp;ATPAKAĻ&nbsp;</a>&nbsp;
						<a href="." class="button">&nbsp;SĀKUMLAPA&nbsp;</a>
					</p></td>
				</tr>
				</table>
			</td>
		</tr>

		<!-- PIESLĒGŠANĀS DB UN VAICĀJUMU INICIALIZĀCIJA  ------------------------------>
		<%
			String param_pos = request.getParameter("structure");
			String param_src = request.getParameter("source");
			String param_book = request.getParameter("book");
			String param_chap = request.getParameter("chapter");
			String param_vr = request.getParameter("verse");
			String param_pg = request.getParameter("page");
			String param_row = request.getParameter("row");
			String param_wf = request.getParameter("wordform");

			//if (param_wf != null) {
			//	param_wf = new String(request.getParameter("wordform").getBytes("8859_1"), "UTF-8");
			//}

			Properties db_access = new Properties();
			String conf = config.getServletContext().getRealPath("/") + "WEB-INF/db.conf";
			db_access.load(new InputStreamReader(new FileInputStream(conf), "UTF-8"));

			Properties params = new Properties();
			params.put("user", db_access.getProperty("user"));
			params.put("password", db_access.getProperty("password"));
			params.put("charSet", "utf8");

			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(db_access.getProperty("url"), params);

			PreparedStatement selGNP = con.prepareStatement(
				"SELECT s.codificator AS src, b.codificator AS book, c.chapter, c.verse, c.content "+
				"FROM gnp_contexts c "+
				"LEFT JOIN sources s ON c.source = s.codificator "+
				"LEFT JOIN books b ON c.book = b.codificator "+
				"WHERE (s.codificator = ?) AND (b.codificator = ?) AND (c.chapter = ?) AND (c.verse = ?);"
			);
			PreparedStatement selLR = con.prepareStatement(
				"SELECT c.row, c.content "+
				"FROM lr_contexts c "+
				"LEFT JOIN sources s ON c.source = s.codificator "+
				"WHERE (s.codificator = ?) AND (c.page = ?) "+
				"ORDER BY c.row;"
			);
			PreparedStatement selP = con.prepareStatement(
				"SELECT s.codificator AS src, c.verse, c.content "+
				"FROM p_contexts c "+
				"LEFT JOIN sources s ON c.source = s.codificator "+
				"WHERE (s.codificator = ?) AND (c.verse = ?);"
			);

			ResultSet text = null;
			String content = "";
		%>


		<tr>
			<td width="10%">&nbsp;</td>
			<td bgcolor="#CCFF99"><br>

			<p>&nbsp;<em style="color:red;">Šī rīka saturs šobrīd ir novecojies un var neatbilst korpusa jaunākajai versijai!</em></p>

		<%
			if (param_pos.equals("GNP")) {
				selGNP.clearParameters();
				selGNP.setBytes(1, param_src.getBytes("UTF-8"));
				selGNP.setBytes(2, param_book.getBytes("UTF-8"));
				selGNP.setInt(3, Integer.parseInt(param_chap));
				selGNP.setInt(4, Integer.parseInt(param_vr));

				text = selGNP.executeQuery();
				if (text.next()) {
		%>
				<p class="text">
					<%=param_src%>, <%=param_book%>, <%=param_chap%>:<%=param_vr%>
		<%
				if (param_wf != null) {
		%>
					<br>Pozicionētais vārdlietojums: <b><%=param_wf%></b>
		<%
				}
		%>
				</p>
		<%
					content = new String(text.getBytes("content"), "UTF-8");
					if (param_wf != null) {
						content = highlight(param_wf, content);
					}
		%>
				<div class="context">
					<%=content%>
				</div>
		<%
				}
			}
			else if (param_pos.equals("LR")) {
				selLR.clearParameters();
				selLR.setBytes(1, param_src.getBytes("UTF-8"));
				selLR.setBytes(2, param_pg.getBytes("UTF-8"));
				text = selLR.executeQuery();
		%>
				<p class="text">
					<%=param_src%>, <%=param_pg%>. lpp.<% if (param_row != null) { %>, <%=param_row%>. rindiņa <% } %>
		<%
				if (param_wf != null) {
		%>
					<br>Pozicionētais vārdlietojums: <b><%=param_wf%></b>
		<%
				}
		%>
				</p>
				<div class="context">
		<%
				while (text.next()) {
					content = new String(text.getBytes("content"), "UTF-8");
					if (param_wf != null) {
						content = highlight(param_wf, content);
					}

					if (param_row != null && text.getInt("row") == Integer.parseInt(param_row)) {
		%>
					<span class="therow">
						<span class="count"><%= text.getString("row") %>:</span> <%=content%>
					</span><br>
		<%
					}
					else {
		%>
					<span class="count"><%= text.getString("row") %>:</span> <%=content%><br>
		<%
					}
				}
		%>
				</div>
		<%
			}
			else {
				selP.clearParameters();
				selP.setBytes(1, param_src.getBytes("UTF-8"));
				selP.setBytes(2, param_vr.getBytes("UTF-8"));

				text = selP.executeQuery();
				if (text.next()) {
		%>
				<p class="text">
					<%=param_src%>, <%=param_vr%> pants
		<%
				if (param_wf != null) {
		%>
					<br>Pozicionētais vārdlietojums: <b><%=param_wf%></b>
		<%
				}
		%>
				</p>
		<%
					content = new String(text.getBytes("content"), "UTF-8");
					if (param_wf != null) {
						content = highlight(param_wf, content);
					}
		%>
				<div class="context">
					<%=content%>
				</div>
		<%
				}
			}
			con.close();
		%>

				<br><br>
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