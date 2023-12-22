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
	</head>
	<body background="./images/bg.jpg">

		<center>
		<table border="0" cellpadding="0" cellspacing="0" width="80%" height="100%">
		<tr height="75px">
			<td colspan="2">
				<img src="./images/senie.jpg" width="600px" height="75px" border="0"/>
			</td>
		</tr>

		<!-- PIESLĒGŠANĀS DB UN VAICĀJUMU INICIALIZĀCIJA ------------------------------->
		<%
			Properties db_access = new Properties();
			String conf = config.getServletContext().getRealPath("/") + "WEB-INF/db.conf";
			db_access.load(new InputStreamReader(new FileInputStream(conf), "UTF-8"));

			Properties params = new Properties();
			params.put("user", db_access.getProperty("user"));
			params.put("password", db_access.getProperty("password"));
			params.put("charSet", "utf8");

			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(db_access.getProperty("url"), params);

			PreparedStatement selPeriods = con.prepareStatement(
				"SELECT id, name FROM periods ORDER BY name;"
			);
			PreparedStatement selSources = con.prepareStatement(
				"SELECT codificator, name, active FROM sources WHERE period = ? ORDER BY codificator;"
			);

			PreparedStatement selWordCount = con.prepareStatement(
				"SELECT COUNT(rnd) AS total FROM words;"
			);
			PreparedStatement selWord = con.prepareStatement(
				"SELECT word, sense, context FROM words WHERE rnd = ?;"
			);
			PreparedStatement selQuoteCount = con.prepareStatement(
				"SELECT COUNT(rnd) AS total FROM quotes;"
			);
			PreparedStatement selQuote = con.prepareStatement(
				"SELECT text, context FROM quotes WHERE rnd = ?;"
			);
			PreparedStatement selTipCount = con.prepareStatement(
				"SELECT COUNT(rnd) AS total FROM tips;"
			);
			PreparedStatement selTip = con.prepareStatement(
				"SELECT text, link FROM tips WHERE rnd = ?;"
			);

			ResultSet periods = null;
			ResultSet sources = null;
			ResultSet tiptop = null;

			int npk = 0;
			int rnd = 0;
			String codificator = "";
			String active = "";
		%>
		<!------------------------------------------------------------------------------>

		<!-- SENIE --------------------------------------------------------------------->
		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<p class="title">SENIE</p>
			</td>
		</tr>
		<tr>
			<td width="7.5%">&nbsp;</td>
			<td bgcolor="#CCFF99">

				<!-- INTRO ------------------------------------------------------------->
				<p class="text">
					<b>Laipni lūdzam!</b> 2003. gadā tika atklāta latviešu valodas seno tekstu korpusa mājas lapa. Tagad te atradīsiet gan 16. gs., gan 17. gs., gan arī dažus 18. gs. sākuma latviešu rakstu pieminekļus un to indeksus.
				</p>
				<p class="text">
					Senie teksti elektroniskā veidā ir pieejami un brīvi izmantojami pētnieciskiem mērķiem, pateicoties 90. gadu vidū saņemtajam Sorosa fonda - Latvija atbalstam, 2002. gadā piešķirtajam Kultūrkapitāla fonda un LU finansējumam, kā arī Izglītības un zinātnes ministrijas finansējumam 2003. gadā. 2004. gadā, izmantojot  VKKF piešķirto radošo stipendiju, seno tekstu korpuss tika papildināts ar vēl diviem avotiem.
				</p>
				<p class="text">
					Latviešu valodas seno tekstu uzkrāšanu un apstrādi nodrošina LU Filoloģijas fakultātes Baltu valodu katedra un LU Matemātikas un informātikas institūta Mākslīgā intelekta laboratorija.
				</p>
				<!---------------------------------------------------------------------->

				<!-- IZVĒLNE ----------------------------------------------------------->
				<ul class="liste">
					<li>
						<span class="code"><a href="./about.htm">Par seno tekstu korpusu</a></span>
					</li>
					<!--
					<li>
						<span class="code"><a href="./summary.htm">kopējā statistika</a></span>
					</li>
					<li>
						<span class="code"><a href="./abbrevs.jsp">lietotie saīsinājumi</a></span>
					</li>
					-->
					<li>
						<span class="code"><a href="./notations.htm">Sākotnējie apzīmējumi</a></span>
					</li>
					<li>
						<span class="code"><a href="./unicode.htm">Unicode simboli</a> (<a href="./unicode_full.htm">ar avotiem</a>)</span>
					</li>
					<li>
						<span class="code">Saziņa: </span><a href="mailto:senie@korpuss.lv" class="hint">senie@korpuss.lv</a>
					</li>
				</ul>
				<!---------------------------------------------------------------------->


			</td>
		</tr>
		<!------------------------------------------------------------------------------>

		<!-- RĪKI ---------------------------------------------------------------------->
		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<p class="title">Korpusa rīki</p>
			</td>
		</tr>
		<tr>
			<td width="7.5%">&nbsp;</td>
			<td bgcolor="#CCFF99">
				<ul class="liste">
					<li>
						<span class="code"><a href="./navigation.jsp?dimension=sources">Korpusa pārlūkošana</a></span>
					</li>
					<li>
						<span class="code"><a target="_new" href="https://nosketch.korpuss.lv/#dashboard?corpname=senie_unicode">Meklēšana korpusā</a></span>
					</li>
				</ul>
			</td>
		</tr>
		<!------------------------------------------------------------------------------>

		<!-- GADSIMTS ------------------------------------------------------------------>
		<%
			periods = selPeriods.executeQuery();
			while (periods.next()) {
		%>
		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<p class="title"><%= new String(periods.getBytes("name"), "UTF-8") %></p>
			</td>
		</tr>

			<!-- AVOTI --------------------------------------------------------------------->
			<%
				selSources.clearParameters();
				selSources.setInt(1, periods.getInt("id"));
				sources = selSources.executeQuery();
				npk = 0;
			%>
			<tr>
				<td width="7.5%">&nbsp;</td>
				<td bgcolor="#CCFF99">
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td colspan="4">&nbsp;</td>
					</tr>

					<%
						while (sources.next()) {
							codificator = new String(sources.getBytes("codificator"), "UTF-8");
							active = new String(sources.getBytes("active"), "UTF-8");
							if (active.equals("1")) {
								npk++;
					%>
					<tr>
						<td width="50px">
							<p class="num"><%= npk %>.</p>
						</td>
						<td width="100px">
							<p class="code">
								<a href="source.jsp?codificator=<%= codificator %>"><%= codificator %></a>
							</p>
						</td>
						<td width="50px" align="center">-</td>
						<td>
							<p class="name"><%= new String(sources.getBytes("name"), "UTF-8") %></p>
						</td>
					</tr>
					<%
							}
						}
					%>

					<tr>
						<td colspan="4">&nbsp;</td>
					</tr>
					</table>
				</td>
			</tr>
			<!------------------------------------------------------------------------------>

		<%
			}
			con.close();
		%>
		<!------------------------------------------------------------------------------>

		<tr>
			<td colspan="2">&nbsp;</td>
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