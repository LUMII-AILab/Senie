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
			var expand = new Image();
			var collapse = new Image();

			function preload() {
				expand.src = './images/expand.jpg';
				collapse.src = './images/collapse.jpg';
			}

			function menusaur(id, ico) {
				if (document.all){
					var menu = document.all[id].style;
					if (menu.display == 'none') {
						menu.display = '';
						document.all[ico].src = collapse.src;
					}
					else {
						menu.display = 'none';
						document.all[ico].src = expand.src;
					}
				}
				else if (document.getElementById){
					var menu = document.getElementById(id).style;
					if(menu.display == 'none'){
						menu.display = 'block';
						document.getElementById(ico).src = collapse.src;
				    } else {
						menu.display = 'none';
						document.getElementById(ico).src = expand.src;
				    }
				}
				window.focus();
				return false;
			}

			function printPosCount(count) {
				if (document.all){
					document.all['total'].innerText = count;
				}
				else if (document.getElementById){
					document.getElementById('total').innerHTML = count;
				}
			}
		</script>

	</head>
	<body background="./images/bg.jpg" onLoad="preload()">

	<center>
		<table border="0" cellpadding="0" cellspacing="0" width="80%" height="100%">
		<tr height="75px">
			<td colspan="2">
				<img src="./images/senie.jpg" width="600px" height="75px" border="0">
			</td>
		</tr>

		<%
			int current_page = 1; // Tekošās lpp (atvēruma) numurs
			int cursor = 0; // Tekošais DB ieraksts
			int limit = 50; // Līdz kuram DB ierakstam lasīt (drukāt uz ekrāna)

			String param_wf = new String(request.getParameter("wordform").getBytes("8859_1"), "UTF-8");
			String param_limit = request.getParameter("limit");
			String param_page = request.getParameter("page");
			String param_src[] = request.getParameterValues("source");   //klāt
			String param_sort = request.getParameter("sort");            //pieliktie parametri
			String param_kolon = request.getParameter("cols");     //kolonnu skaits

			if("desc".equals(param_sort)){
				param_sort = "Z-A";
			}
			else {
				param_sort = "A-Z";
			}

			if (param_limit != null) {
				limit = Integer.parseInt(param_limit);
			}

            if( param_page != null ){
				current_page = Integer.parseInt(param_page);
			}

			int offset = current_page * limit - limit + 1; // No kura DB ieraksta lasīt (drukāt uz ekrāna)

			// Pieslēgšanās DB un vaicājumu inicializācija ----------------------------------------
			Properties db_access = new Properties();
			String conf = config.getServletContext().getRealPath("/") + File.separator + "WEB-INF" + File.separator + "db.conf";
			db_access.load(new InputStreamReader(new FileInputStream(conf), "UTF-8"));

			Properties params = new Properties();
			params.put("user", db_access.getProperty("user"));
			params.put("password", db_access.getProperty("password"));
			params.put("charSet", "utf8");

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(db_access.getProperty("url"), params);

			PreparedStatement selLowerCase = con.prepareStatement(
				"SELECT DISTINCT LOWER(wordform) AS wordform FROM wordforms " +
				"WHERE LOWER(wordform) LIKE ? ORDER BY wordform;"
			);

			PreparedStatement sumGNP = con.prepareStatement(
				"SELECT SUM(count) AS summ FROM gnp_positions WHERE crossform = ?;"
			);
			PreparedStatement sumLR = con.prepareStatement(
				"SELECT SUM(count) AS summ FROM lr_positions WHERE crossform = ?;"
			);
			PreparedStatement sumP = con.prepareStatement(
				"SELECT SUM(count) AS summ FROM p_positions WHERE crossform = ?;"
			);
			PreparedStatement selGNP = con.prepareStatement(
				"SELECT p.count AS count, b.codificator AS book, p.chapter AS chapter, p.verse AS verse, p.context AS context "+
				"FROM gnp_positions p "+
				"LEFT JOIN books b ON p.book = b.id "+
				"WHERE p.crossform = ? ORDER BY b.codificator, p.chapter, p.verse;"
			);
			PreparedStatement selLR = con.prepareStatement(
				"SELECT count, page, row, context FROM lr_positions WHERE crossform = ? ORDER BY CAST(page AS UNSIGNED INTEGER), row;"
			);
			PreparedStatement selP = con.prepareStatement(
				"SELECT count, verse, context FROM p_positions WHERE crossform = ? ORDER BY verse;"
			);
			ResultSet list = null;
			// ------------------------------------------------------------------------------------

				selLowerCase.clearParameters();
				selLowerCase.setBytes(1, param_wf.getBytes("UTF-8"));
				list = selLowerCase.executeQuery();

			// Saskaita cik ir kopā ierakstu
			int count_ = 0;
			while (list.next())	{
				count_++;
			}
			list.beforeFirst();

			// Aprēķina nepieciešamo atvērumu skaitu
			int page_count = (count_ / limit) + 1;

			int src_count=0;
		%>

		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr>
					<td><p class="title">Meklēšanas rezultāts</p></td>
					<td>
						<p class="navig">
							<a href="./search.jsp" class="button">&nbsp;MEKLĒŠANA&nbsp;</a>
							<a href="./toc.jsp" class="button">&nbsp;SĀKUMLAPA&nbsp;</a>
						</p>
					</td>
				</tr>
				</table>
			</td>
		</tr>

		<tr>
			<td width="10%">&nbsp;</td>
			<td bgcolor="#CCFF99">
				<p class="text">

				<p class="text">

		<%
		String query = "";
		PreparedStatement selDistinctAll = null;
		PreparedStatement selAll = null;
		PreparedStatement selSrc = null;
		PreparedStatement selDistinctSrc = null;

			ResultSet words = null;
			ResultSet pos = null;
			ResultSet count = null;

			int wf_count = 0;


			if("SENIE".equals(param_src[0])){
				query = "SELECT id FROM wordforms ";
					query = query + "WHERE LOWER(wordform) LIKE ?;";
					param_wf = param_wf.toLowerCase();



				selDistinctAll = con.prepareStatement(query);
				selDistinctAll.clearParameters();
			    selDistinctAll.setBytes(1, param_wf.getBytes("UTF-8"));
				words = selDistinctAll.executeQuery();
				words.last();
				wf_count = words.getRow();

				query = "SELECT DISTINCT s.codificator FROM wordforms w LEFT JOIN crossforms c ON w.id = c.wordform LEFT JOIN sources s ON c.source = s.id ";

					query = query + "WHERE LOWER(w.wordform) LIKE ?;";
					param_wf = param_wf.toLowerCase();



				selDistinctSrc = con.prepareStatement(query);
				selDistinctSrc.clearParameters();
			    selDistinctSrc.setBytes(1, param_wf.getBytes("UTF-8"));
				words = selDistinctSrc.executeQuery();
				words.last();
				src_count = words.getRow();

				query = "SELECT w.wordform AS wf, s.codificator AS src, c.id AS cf FROM wordforms w LEFT JOIN crossforms c ON w.id = c.wordform LEFT JOIN sources s ON c.source = s.id ";
				if (param_limit.equals("nē")) {
					query = query + "WHERE LOWER(w.wordform) LIKE ? ";
					param_wf = param_wf.toLowerCase();
				}
				else {
					query = query + "WHERE w.wordform LIKE ? ";
				}
				query = query + "ORDER BY w.wordform";
				if (param_sort.equals("Z-A")) {
					query = query + " DESC";
				}
				query = query + ";";

				selAll = con.prepareStatement(query);
				selAll.clearParameters();
			    selAll.setBytes(1, param_wf.getBytes("UTF-8"));
				words = selAll.executeQuery();
			}
			else {
				query = "SELECT w.wordform AS wf, s.codificator AS src, c.id AS cf FROM wordforms w LEFT JOIN crossforms c ON w.id = c.wordform LEFT JOIN sources s ON c.source = s.id ";
				if (param_limit.equals("nē")) {
					query = query + "WHERE (LOWER(w.wordform) LIKE ?) AND (";
					param_wf = param_wf.toLowerCase();
				}
				else {
					query = query + "WHERE (w.wordform LIKE ?) AND (";
				}

				for (int i = 0; i < param_src.length; i++) {
					query = query + "(s.codificator = '" + param_src[i] + "')";
					if (i + 1 != param_src.length) {
						query = query + " OR ";
					}
				}
				query = query + ") ORDER BY w.wordform";
				if (param_sort.equals("Z-A")) {
					query = query + " DESC";
				}
				query = query + ";";

				selSrc = con.prepareStatement(query);
				selSrc.clearParameters();
				selSrc.setBytes(1, param_wf.getBytes("UTF-8"));
				words = selSrc.executeQuery();

				words.last();
				wf_count = words.getRow();
				src_count = 1;
				words.beforeFirst();
			}


			// Aiziet līdz tekošās lpp OFFSETam
			for (cursor = 0; list.next() && cursor < (offset - 2); cursor++) {
				// Neko pa ceļam nedara
			}


			%>
					Vārdformu šablons: <b><%= param_wf %></b><br>
					Kārtošana: <%= param_sort %><br>
					Statistika: vārdformas - <span class="count"><%= wf_count %></span>,
					vārdlietojumi - <span id="total" class="count"></span>,
					avoti - <span class="count"><%= src_count %></span>

				</p>
			<%
			//expandi


			int summ = 0;
			int total = 0;
			int cf = 0;
			String wf;
			String src;

			while (words.next()) {
				cf = words.getInt("cf");
				wf = new String(words.getBytes("wf"), "UTF-8");
				src = new String(words.getBytes("src"), "UTF-8");
				sumGNP.clearParameters();
				sumGNP.setInt(1, cf);
				count = sumGNP.executeQuery();
				count.first();
				summ = count.getInt("summ");

				sumLR.clearParameters();
				sumLR.setInt(1, cf);
				count = sumLR.executeQuery();
				count.first();
				summ = summ + count.getInt("summ");

				sumP.clearParameters();
				sumP.setInt(1, cf);
				count = sumP.executeQuery();
				count.first();
				summ = summ + count.getInt("summ");

				total = total + summ;
			}
			int total2 = total;



			words.first();
			words.previous();
			for (int j=0;words.next() && j<(offset-2);j++)
			{
				//out.println(j);
			}
			words.previous();

		int count5=0;
		int k=0;

			while (words.next() && count5 < limit) {
				cf = words.getInt("cf");
				wf = new String(words.getBytes("wf"), "UTF-8");
				src = new String(words.getBytes("src"), "UTF-8");

				sumGNP.clearParameters();
				sumGNP.setInt(1, cf);
				count = sumGNP.executeQuery();
				count.first();
				summ = count.getInt("summ");

				sumLR.clearParameters();
				sumLR.setInt(1, cf);
				count = sumLR.executeQuery();
				count.first();
				summ = summ + count.getInt("summ");

				sumP.clearParameters();
				sumP.setInt(1, cf);
				count = sumP.executeQuery();
				count.first();
				summ = summ + count.getInt("summ");

				total = total + summ;





		%>
				<div id="top_<%= cf %>" class="wf">
					<a href="javascript:void(0);" onClick="menusaur('sub_<%= cf %>','ico_<%= cf %>'); return false">
					<img id="ico_<%= cf %>" src="./images/expand.jpg" border="0"/></a>
					&nbsp;<b><%= wf %></b> (<span class="count"><%= summ %></span> - <%= src %>)
					<div id="sub_<%= cf %>" class="pos" style="display: none;">

		<%
				selGNP.clearParameters();
			    selGNP.setInt(1, cf);
				pos = selGNP.executeQuery(); //count,book,chapter,verse,context

				 int kolonnas;
		         kolonnas=(param_kolon != null) ? Integer.parseInt(param_kolon) : 3;
		%>

			<table border="0">
					<tr>
				<%
				k=0;
				while (pos.next()) {
					if (k==kolonnas)
					{
						out.println ("</tr><tr>");
						k=0;
					}
		%>
						<td width="150">
							<span class="count" style="font-size: 13px;"><%= pos.getString("count") %></span>
							<a style="font-size: 13px;" href="context.jsp?structure=GNP&source=<%= src %>&book=<%= new String(pos.getBytes("book"), "UTF-8") %>&chapter=<%= pos.getString("chapter") %>&verse=<%= pos.getString("verse") %>&wordform=<%= wf %>"><%= new String(pos.getBytes("book"), "UTF-8") %> <%= pos.getString("chapter") %>:<%= pos.getString("verse") %></a>

						</td>
		<%
					k++;
					}
		%>
					</tr>
					</table>
		<%
				selLR.clearParameters();
			    selLR.setInt(1, cf);
				pos = selLR.executeQuery(); //count, page, row, context

							/*--------------------CAUTION, THIS IS XTREME----------------------*/


	//out.println("<br>");

	String[][] mas = new String[summ][];
	String[][] mas2 = new String[summ][];
	int kopskaits=summ;
	//uztaisu kur ielasīt
    for(int i=0;i<mas.length;i++){              //count,book,chapter,verse,context
		mas[i]=new String[4];
		mas2[i]=new String[4];
	}

	for(int i=0;pos.next(); i++) // ...
	{
	  mas[i][0]=pos.getString("count");
	  mas[i][1]=pos.getString("page");
	  mas[i][2]=pos.getString("row");
	  //mas[i][3]=pos.getString("context");
	}


    int atlikums=kopskaits % kolonnas; // cik kolonnas buus "garaas"

    int iisaa_kolonna = kopskaits / kolonnas;
    int garaa_kolonna = iisaa_kolonna + 1;

    pos.beforeFirst();
    int i = 0;
    for (int c=0; pos.next(); ++c) {      // mas2[c]=mas[i]
		mas2[c][0] = mas[i][0];
		mas2[c][1] = mas[i][1];
		mas2[c][2] = mas[i][2];
		//mas2[c][3] = mas[i][3];
		/*
	 pos.updateString("count", mas[i][0]);
	 pos.updateString("page", mas[i][1]);
	 pos.updateString("row", mas[i][2]);
	 pos.updateString("context", mas[i][3]);
	*/

        i += (c % kolonnas < atlikums) ? garaa_kolonna : iisaa_kolonna;
        if (c % kolonnas == kolonnas-1) {
            i = (c / kolonnas) + 1;
        }
    }

/*---------------------------------------XTREME END-----------------------------------------*/
	pos.beforeFirst();
		%>
				<table border="0">
				<tr>
		<%

		int f=0;
				k=0;
				while (pos.next()) {
					if (k==kolonnas)
					{
						out.println ("</tr><tr>");
						k=0;
					}
		%>

					<td width="150">
						<span class="count" style="font-size: 13px;"><%= mas2[f][0] %></span>
						<a style="font-size: 13px;" href="context.jsp?structure=LR&source=<%= src %>&page=<%= mas2[f][1] %>&row=<%= mas2[f][2] %>&wordform=<%= wf %>"><%= mas2[f][1] %>. lpp., <%= mas2[f][2] %>. rinda</a>
					</td>
		<%
				k++;
				f++;
				}
		%>
				</tr>
				</table>
		<%
				selP.clearParameters();
			    selP.setInt(1, cf);
				pos = selP.executeQuery(); //count, verse, context

		%>
				<table border="0">
				<tr>
		<%
				k=0;
				while (pos.next()) {
					if (k==kolonnas)
					{
						out.println ("</tr><tr>");
						k=0;
					}
		%>

						<td width="150">
							<span class="count" style="font-size: 13px;"><%= pos.getString("count") %></span>
							<a style="font-size: 13px;" href="./context.jsp?structure=P&source=<%= src %>&verse=<%= new String(pos.getBytes("verse"), "UTF-8") %>&wordform=<%= wf %>"><%= new String(pos.getBytes("verse"), "UTF-8") %> pants</a>
						</td>


		<%
					k++;
					}
				%>
				</tr>
				</table>

					</div>
				</div>
		<%
			count5++;
			}




			con.close();
		%>
				<script type="text/javascript" language="JavaScript">
					printPosCount(<%=total2%>);
				</script>
				<p>&nbsp;</p>
			</td>
		</tr>

		<tr>
			<td>&nbsp;</td>
			<!-- Atvērumi START ------------------------------------------------------------------>
			<td bgcolor="#E8E8E8" valign="middle" align="center">
				<p class="seperator">&nbsp;</p>
				<table border="0">
				<tr><td>
				<%

					String encoded_wf = param_wf.replaceAll("%", "%25");

					// Ja kreisā konteksta logs nesniedzas līdz pirmajam atvērumam,
					// jāpiedāvā "back" podziņa
					if (current_page - 5 > 1) {
						int back_page = current_page - 5 - 1;

						out.print("<a href=\"index.jsp");

				out.print("?wordform=" + encoded_wf);
				out.print("&sort=" + param_sort);
				out.print("&limit=" + limit);
				out.print("&page=" + back_page);
				out.print("&cols=" + param_kolon);

				for (int s = 0; s < param_src.length; s++) {
					out.print("&source=" + param_src[s]);
				}


				out.println("\" class=\"colc\">&lt;&lt;</a>");

						%>



				<%
					}

					// Aprēķina kreisā konteksta logu (līdz piecām lpp)
					int left_page = current_page - 5;
					if (left_page < 1) {
						left_page = 1;
					}

					// Izdrukā kreiso kontekstlogu
					while (left_page < current_page) {
				%>

						<%
						out.print("<a href=\"index.jsp");

						out.print("?wordform=" + encoded_wf);
						out.print("&sort=" + param_sort);
						out.print("&limit=" + limit);
						out.print("&page=" + left_page);
						out.print("&cols=" + param_kolon);

						for (int s = 0; s < param_src.length; s++) {
							out.print("&source=" + param_src[s]);
						}

				out.println("\" class=\"colc\">");
				out.println(left_page);
				out.println("</a>");

						%>

				<%
						left_page++;
					}
				%>

				</td>
				<!-- Tekošais atvērums -->
				<td><span class="colcx"><%= current_page %></span></td>

				<%
					int right_page = current_page + 1; // Nākošais potenciālais atvērums

					// Ja vēl ir kāds neizdrukāts DB ieraksts...
					if (right_page <= page_count)
					{
				%>

				<td align="left" style="valign: middle;">

				<%
						// Izdrukā labo kontekstlogu (līdz piecām lpp)
						while (right_page <= page_count && right_page - current_page <= 5)
						{
				%>

						<%
							out.print("<a href=\"index.jsp");

							out.print("?wordform=" + encoded_wf);
							out.print("&sort=" + param_sort);
							out.print("&limit=" + limit);
							out.print("&page=" + right_page);
							out.print("&cols=" + param_kolon);

							for (int s = 0; s < param_src.length; s++) {
								out.print("&source=" + param_src[s]);
							}

										out.println("\" class=\"colc\">");
								out.println(right_page);
								out.println("</a>");

						%>

				<%
							right_page++;
						}

						// Ja labā konteksta logs nesniedzas līdz pēdējam atvērumam,
						// jāpiedāvā "forward" podziņa
						if (right_page <= page_count)
						{
							int forward_page = current_page + 5 + 1;
				%>

						<%
							out.print("<a href=\"index.jsp");

							out.print("?wordform=" + encoded_wf);
							out.print("&sort=" + param_sort);
							out.print("&limit=" + limit);
							out.print("&page=" + forward_page);
							out.print("&cols=" + param_kolon);

							for (int s = 0; s < param_src.length; s++) {
								out.print("&source=" + param_src[s]);
							}

							out.println("\" class=\"colc\">&gt;&gt;</a>");

						%>

				<%
						}
					}
				%>

				</td></tr>
				</table>
				<p class="seperator">&nbsp;</p>
			</td>
			<!-- Atvērumi END -------------------------------------------------------------------->
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