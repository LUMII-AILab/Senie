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

		<script type="text/javascript" language="JavaScript">
			function appSearchSymb(symbol) {
				with (document.search_form.wordform) {
					value = value + symbol;
					focus();
				}
			}
		</script>
	</head>
	<body background="./images/bg.jpg">

		<center>
		<table border="0" cellpadding="0" cellspacing="0" width="80%" height="100%">
		<tr height="75px">
			<td colspan="2">
				<img src="./images/senie.jpg" width="600px" height="75px" border="0">
			</td>
		</tr>

		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr>
					<td><p class="title">Statistika</p></td>
					<td><p class="navig">
						<a href="./toc.jsp" class="button">&nbsp;SĀKUMLAPA&nbsp;</a>
					</p></td>
				</tr>
				</table>
			</td>
		</tr>

		<%
			Properties db_access = new Properties();
			String conf = config.getServletContext().getRealPath("/") + File.separator + "WEB-INF" + File.separator + "db.conf";
			db_access.load(new InputStreamReader(new FileInputStream(conf), "UTF-8"));

			Properties params = new Properties();
			params.put("user", db_access.getProperty("user"));
			params.put("password", db_access.getProperty("password"));
			params.put("charSet", "utf8");

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(db_access.getProperty("url"), params);

			PreparedStatement selAllSrc = con.prepareStatement(
				"SELECT codificator FROM sources WHERE active = '1' " +
				"UNION SELECT codificator FROM books " +
				"ORDER BY codificator;"
			);
			PreparedStatement selSrc = con.prepareStatement(
				"SELECT codificator FROM sources WHERE active = '1' ORDER BY codificator;"
			);

			ResultSet sources = null;
		%>

		<tr>
			<td width="10%">&nbsp;</td>
			<td bgcolor="#CCFF99">
				<p class="subchap">Biežuma vārdnīcas:</p>
				<center>
				<form name="freq_form" method="GET" action="./frequencies.jsp">
					<table border="0" cellpadding="4px" cellspacing="0">
					<tr>
						<td style="border-right: 1px #669933 solid;">
							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td><p class="hint">Avots:</p></td>
								<td>
									<select name="source" size="1" class="menu">
										<option value="SENIE" selected>SENIE</option>
										<%
											sources = selAllSrc.executeQuery();
											while (sources.next()) {
												String codif = new String(sources.getBytes("codificator"), "UTF-8");
												out.println("<option value=\""+codif+"\">"+codif+"</option>");
											}
										%>
									</select>
									<p class="seperator">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td><p class="hint">Limits:</p></td>
								<td>
									<input type="text" name="limit" value="1000" maxlength="4" class="field" style="width: 50px;">
									<p class="seperator">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td><p class="hint">Reģistrjūtība:&nbsp;</p></td>
								<td>
									<select name="lower" size="1" class="menu" style="width: 50px;">
										<option value="no" selected>jā</option>
										<option value="yes">nē</option>
									</select>
								</td>
							</tr>
							</table>
						</td>
						<td valign="middle">
							<input type="submit" value="Atlasīt!" class="subutt">
						</td>
					</tr>
					</table>
				</form>
				</center>
				<hr class="hrSeparator">

				<p class="subchap">Inversās vārdnīcas:</p>
				<center>
				<form name="freq_form" method="GET" action="./inverse.jsp">
					<table border="0" cellpadding="4px" cellspacing="0">
					<tr>
						<td style="border-right: 1px #669933 solid;">
							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td><p class="hint">Avots:&nbsp;</p></td>
								<td>
									<select name="source" size="1" class="menu">
										<%
											sources = selSrc.executeQuery();
											while (sources.next()) {
												String codif = new String(sources.getBytes("codificator"), "UTF-8");
												out.println("<option value=\""+codif+"\">"+codif+"</option>");
											}

											con.close();
										%>
									</select>
								</td>
							</tr>
							</table>
						</td>
						<td valign="bottom">
							<input type="submit" value="Atlasīt!" class="subutt">
						</td>
					</tr>
					</table>
				</form>
				</center>
				<hr class="hrSeparator">

				<p class="subchap">Vārdformu saraksti:</p>
				<center>
				<form name="search_form" method="GET" action="./wordlist.jsp">
					<table border="0" cellpadding="4px" cellspacing="0">
					<tr>
						<td style="border-right: 1px #669933 solid;">
							<p class="hint">Vārdformu šablons:&nbsp;</p>
							<input type="text" name="wordform" maxlength="50" class="field" style="width: 196px;">
						</td>
						<td valign="bottom" align="right">

							<span class="hint">Rezultāti atvērumā:&nbsp;</span>
							<select name="limit" size="1" class="menu" style="width: 50px;">
								<option value="25">25</option>
								<option value="50" selected>50</option>
								<option value="75">75</option>
								<option value="100">100</option>
							</select>
						</td>
					</tr>
					<tr>
						<td valign="top" style="border-top: 1px #669933 solid; border-right: 1px #669933 solid;">
							<input type="button" value="Æ" onClick="appSearchSymb('Æ')" class="symbutt">
							<input type="button" value="Ä" onClick="appSearchSymb('Ä')" class="symbutt">
							<input type="button" value="Ć" onClick="appSearchSymb('Ć')" class="symbutt">
							<input type="button" value="Ö" onClick="appSearchSymb('Ö')" class="symbutt">
							<input type="button" value="Ś" onClick="appSearchSymb('Ś')" class="symbutt">
							<input type="button" value="§" onClick="appSearchSymb('§')" class="symbutt">
							<input type="button" value="Ü" onClick="appSearchSymb('Ü')" class="symbutt">
							<input type="button" value="Ź" onClick="appSearchSymb('Ź')" class="symbutt">
							<p class="seperator">&nbsp;</p>
							<input type="button" value="æ" onClick="appSearchSymb('æ')" class="symbutt">
							<input type="button" value="ä" onClick="appSearchSymb('ä')" class="symbutt">
							<input type="button" value="ć" onClick="appSearchSymb('ć')" class="symbutt">
							<input type="button" value="ö" onClick="appSearchSymb('ö')" class="symbutt">
							<input type="button" value="ś" onClick="appSearchSymb('ś')" class="symbutt">
							<input type="button" value="ß" onClick="appSearchSymb('ß')" class="symbutt">
							<input type="button" value="ü" onClick="appSearchSymb('ü')" class="symbutt">
							<input type="button" value="ź" onClick="appSearchSymb('ź')" class="symbutt">
						</td>
						<td valign="top" align="right" style="border-top: 1px #669933 solid;">
							<input type="submit" value="Atlasīt!" class="subutt">
						</td>
					</tr>
					</table>
				</form>
				</center>
			</td>
		</tr>

		<tr>
			<td width="10%">&nbsp;</td>
			<td bgcolor="#CCFF99">
				<p class="legend">
					% - nenoteiktu burtu, patvaļīga garuma (arī tukša) virkne<br>
					_ - jebkurš viens burts
				</p>
				<p class="legend">Piemēri: Śwee§ts, d§imdin%, Alg%, Semm_.</p>
			</td>
		</tr>

		<tr>
			<td colspan="2" height="100%">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<p class="copy">
					&copy; LU MII Mākslīgā intelekta laboratorija<br>
					&copy; LU Filoloģijas fakultātes Baltu valodu katedra<br>2002-2015
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