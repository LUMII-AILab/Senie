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

		<!-- PIESLĒGŠANĀS DB UN VAICĀJUMU INICIALIZĀCIJA ------------------------------->
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
			<td width="10%">&nbsp;</td>
			<td bgcolor="#CCFF99">

				<!-- INTRO ------------------------------------------------------------->
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td valign="top">
						<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://active.macromedia.com/flash2/cabs/swflash.cab#version=4,0,0,0" id="senie" width="150px" height="200px" style="margin: 20px 0px 0px 20px;">
							<param name="movie" value="./images/senie.swf">
							<param name="menu" value="false">
							<param name="quality" value="high">
							<param name="bgcolor" value="#EEFFBB">
							<embed src="./images/senie.swf" menu="false" quality="high" bgcolor="#EEFFBB" width="150px" height="200px" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">
							</embed>
						</object>
					</td>
					<td valign="bottom" width="100%">

						<!-- DIENAS ODZIŅAS -------------------------------------------->
						<table border="0" cellpadding="0" cellspacing="0">
						<%
							tiptop = selWordCount.executeQuery();
							if (tiptop.next()) {
								rnd = tiptop.getInt("total");
							}
							rnd = (int)(Math.random() * rnd + 1);

							selWord.clearParameters();
							selWord.setInt(1, rnd);
							tiptop = selWord.executeQuery();
							if (tiptop.next()) {
						%>
						<tr>
							<td width="130px"><p class="text"><b><span class="count">Viens vārds:</span></b></p></td>
							<td>
								<p class="text" style="margin-left: 0px;"><b><%= new String(tiptop.getBytes("word"), "UTF-8") %></b> - <%= new String(tiptop.getBytes("sense"), "UTF-8") %> [<a href="<%= new String(tiptop.getBytes("context"), "UTF-8") %>">konteksts</a>]</p>
							</td>
						</tr>
						<%
							}
							tiptop = selQuoteCount.executeQuery();
							if (tiptop.next()) {
								rnd = tiptop.getInt("total");
							}
							rnd = (int)(Math.random() * rnd + 1);

							selQuote.clearParameters();
							selQuote.setInt(1, rnd);
							tiptop = selQuote.executeQuery();
							if (tiptop.next()) {
						%>
						<tr>
							<td><p class="text" style="margin-top: 0px;"><b><span class="count">Viens citāts:</span></b></p></td>
							<td>
								<p class="text" style="margin-top: 0px; margin-left: 0px;"><i>"<%= new String(tiptop.getBytes("text"), "UTF-8") %>"</i> [<a href="<%= new String(tiptop.getBytes("context"), "UTF-8") %>">konteksts</a>]</p>
							</td>
						</tr>
						<%
							}
							tiptop = selTipCount.executeQuery();
							if (tiptop.next()) {
								rnd = tiptop.getInt("total");
							}
							rnd = (int)(Math.random() * rnd + 1);

							selTip.clearParameters();
							selTip.setInt(1, rnd);
							tiptop = selTip.executeQuery();
							if (tiptop.next()) {
						%>
						</table>

						<p class="text"><b><span class="count">Vai jūs zināt...</span></b><br>
						<%= new String(tiptop.getBytes("text"), "UTF-8") %>
						<%
								String link = new String(tiptop.getBytes("link"), "UTF-8");
								if (!link.equals("")) {
						%>
						[<a href="<%= link %>" target="_new">vairāk</a>]
						<%
								}
							}
						%>
						</p>
						<!-------------------------------------------------------------->

					</td>
				</tr>
				</table>

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
						<span class="code"><a href="./about.htm">par seno tekstu korpusu</a></span>
					</li>
					<li>
						<span class="code"><a href="./summary.htm">kopējā statistika</a></span>
					</li>
					<li>
						<span class="code"><a href="./abbrevs.jsp">lietotie saīsinājumi</a></span>
					</li>
					<li>
						<span class="code"><a href="./notations.htm">lietotie apzīmējumi</a></span>
					</li>
					<li>
						<span class="code">kopējais vārdformu biežuma saraksts (CS): </span>&nbsp;
						<a href="./frequencies.jsp?source=SENIE&limit=1000&lower=no"><img src="./images/txt.gif" width="13px" height="16px" border="0"></a>&nbsp;<span class="hint">(top 1000)</span>&nbsp;&nbsp;
						<a href="./downloads/SENIE_frequencies.zip"><img src="./images/zip.gif" width="15px" height="16px" border="0"></a>&nbsp;<span class="hint">(pilns)</span>
					</li>
					<li>
						<span class="code">kopējais vārdformu biežuma saraksts (LC): </span>&nbsp;
						<a href="./frequencies.jsp?source=SENIE&limit=1000&lower=yes"><img src="./images/txt.gif" width="13px" height="16px" border="0"></a>&nbsp;<span class="hint">(top 1000)</span>&nbsp;&nbsp;
						<a href="./downloads/SENIE_frequencies_lower.zip"><img src="./images/zip.gif" width="15px" height="16px" border="0"></a>&nbsp;<span class="hint">(pilns)</span>
					</li>
					<li>
						<span class="code">kopējais vārdformu indekss (CS): </span>&nbsp;
						<a href="./downloads/SENIE_indexed.zip"><img src="./images/zip.gif" width="15px" height="16px" border="0"></a>&nbsp;<span class="hint">(pilns)</span>
					</li>
					<li>
						<span class="code">kopējais vārdformu indekss (LC): </span>&nbsp;
						<a href="./downloads/SENIE_indexed_lower.zip"><img src="./images/zip.gif" width="15px" height="16px" border="0"></a>&nbsp;<span class="hint">(pilns)</span>
					</li>
					<li>
						<span class="code">saziņa: </span>&nbsp;
						<a href="mailto:senie no ailab punkts lv"><img src="./images/mail.jpg" width="14px" height="11px" border="0"></a>&nbsp;<span class="hint">senie no ailab punkts lv</span>
					</li>
				</ul>
				<!---------------------------------------------------------------------->


			</td>
		</tr>
		<!------------------------------------------------------------------------------>

		<!-- RĪKI ---------------------------------------------------------------------->
		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<p class="title">Lietojumrīki</p>
			</td>
		</tr>
		<tr>
			<td width="10%">&nbsp;</td>
			<td bgcolor="#CCFF99">
				<ul class="liste">
					<li>
						<span class="code"><a href="./navigation.jsp?dimension=sources">navigācija korpusa saturā</a></span>
					</li>
					<li>
						<span class="code"><a href="./search.jsp">meklēšana vārdformu indeksā</a></span>
					</li>
					<li>
						<span class="code"><a href="./concordance.jsp">konkordance</a></span>
					</li>
					<li>
						<span class="code"><a href="./statistic.jsp">statistika un citi dati</a></span>
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
				<td width="10%">&nbsp;</td>
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