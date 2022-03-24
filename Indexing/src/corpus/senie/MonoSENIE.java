package corpus.senie;

import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintStream;

import corpus.senie.indexing.*;


public class MonoSENIE {

	public static void main(String args[]) throws IOException {
		//PrintStream out = new PrintStream(System.out, true, "UTF-8");
		PrintStream out = new PrintStream(System.out, true, "Windows-1257");
		//BufferedReader input = new BufferedReader(new InputStreamReader(System.in, "UTF-8"));
		BufferedReader input = new BufferedReader(new InputStreamReader(System.in, "Windows-1257"));

		out.print("Ievadiet avota kodu: ");
		String source = input.readLine().trim();
		out.println("");

		out.println("Ievadiet adresācijas struktūru: ");
		out.println("(1) grāmata->nodaļa->pants");
		out.println("(2) lappuse->rinda");
		out.println("(3) pants");
		out.println("(4) grāmata->lapuse->rinda");
		out.print("Izvēle: ");
		int pos = Integer.parseInt(input.readLine().trim());
		IndexType indexType = IndexType.getByLegacyCode(pos);
		out.println("");

		String confirm = "";
		boolean loop = true;

		do {
			String collection = "";
			String name = "";
			String title = "";

			out.println("Ievadiet veicamo uzdevumu: ");
			out.println("(1) tīrīšana & pārbaude");
			out.println("(2) savilkšana");
			out.println("(3) indeksēšana");
			out.println("(4) inversā vārdnīca");
			out.println("(5) fragmentēšana (DB)");
			out.println("(6) marķēšana");
			out.println("(7) \"ietinamie\" HTML faili");
			out.println("(8) viss, ko var izdarīt bez DB");
			out.println("(0) beigt");
			out.print("Izvēle: ");
			int task = Integer.parseInt(input.readLine().trim());
			out.println("");

			switch (task) {
				case 1:
					out.println("+---------------------------------------------------+");
					out.println("| Teksta attīrīšana un marķējuma sintakses pārbaude |");
					out.println("+---------------------------------------------------+");
					out.println("");

					Cleaner cleaner = new Cleaner(source);
					if (indexType == null)
						out.println("[E] Adresācijas struktūra nav definēta!");
					else cleaner.clean(indexType);
					cleaner.close();
					break;

				case 2:
					out.println("+---------------------------+");
					out.println("| Pārnesto vārdu savilkšana |");
					out.println("+---------------------------+");
					out.println("");

					Unhyphener unhyphener = new Unhyphener(source);
					if (indexType == null)
						out.println("[E] Adresācijas struktūra nav definēta!");
					else unhyphener.unhyphen(indexType);
					unhyphener.close();
					break;

				case 3:
					out.println("+-------------------------------------+");
					out.println("| Vārdformu indeksēšana un statistika |");
					out.println("+-------------------------------------+");
					out.println("");

					boolean lower = false;
					out.print("Ņemt vērā lielos/mazos burtus? [j/n]: ");
					confirm = input.readLine().trim();
					if (confirm.toLowerCase().equals("n")) {
						lower = true;
					}
					out.println("");

					name = "";
					out.print("Ievadiet avota autoru: ");
					name = input.readLine().trim();
					out.println("");

					Indexer indexer = new Indexer(source);

					boolean db = false;
					if (!lower && !name.isEmpty()) {
						out.print("Saglabāt SENIE datubāzē? [j/n]: ");
						confirm = input.readLine().trim();
						out.println("");
						if (confirm.toLowerCase().equals("j")) db = true;

						if (db) {
							indexer.dbConnect("//localhost:3306/senie", "senie", "corpsbase03");
							
							if (!indexer.setAuthor(name)){
								out.println("[E] DB kļūda: nav atrasts autors '" + name + "'");
							}
							
							collection = source;
							if (pos == 1 || pos == 4) {
								out.print("Ievadiet virsavota kodu: ");
								collection = input.readLine().trim();
								out.println();
							}
							
							if (!indexer.setSource(collection)) {
								out.println("[E] DB kļūda: nav atrasts avots '" + collection + "'");
							}
						}
					}

					if (indexType == null)
						out.println("[E] Adresācijas struktūra nav definēta!");
					else indexer.index(indexType, source, name, lower, db);

					out.print("Indekss tiek rakstīts teksta failā... ");
					indexer.storePlaintext(lower);
					out.println("Darīts.");
					out.println("");
					out.print("Indekss tiek rakstīts HTML failā... ");
					indexer.storeHTML(lower, pos == 1 || pos == 4);
					out.println("Darīts.");
					out.println("");

					/*
					if (pos == 2) {
						out.print("Indekss tiek rakstīts teksta failā kompaktā formātā... ");
						indexer.storeCompact(lower);
						out.println("Darīts.");
						out.println("");
					}
					*/

					out.print("Tiek veidots vārdformu biežuma rādītājs... ");
					indexer.storeFrequencies(lower);
					out.println("Darīts.");
					out.println("");

					if (!lower && db) {
						out.print("Indekss tiek saglabāts datubāzē... ");
						indexer.storeDatabase(pos);
						out.println("Darīts.");
						out.println("");
					}

					indexer.close();
					break;

				case 4:
					out.println("+------------------------------+");
					out.println("| Inversās vārdnīcas veidošana |");
					out.println("+------------------------------+");
					out.println("");

					Inverser inverser = new Inverser(source);
					if (indexType == null)
						out.println("[E] Adresācijas struktūra nav definēta!");
					else inverser.index(indexType);

					out.print("Vārdnīca tiek rakstīta teksta failā... ");
					inverser.storeDictionary();
					out.println("Darīts.");
					out.println("");

					inverser.close();
					break;

				case 5:
					out.println("+-----------------------------------+");
					out.println("| Kontekstu atdalīšana un marķēšana |");
					out.println("+-----------------------------------+");
					out.println("");

					if (pos == 1 || pos == 4) {
						out.print("Ievadiet virsavota kodu: ");
						collection = input.readLine().trim();
						out.println();
					}

					Contexter contexter = new Contexter(source, collection);
					contexter.dbConnect("//localhost:3306/senie", "senie", "corpsbase03");
					if (contexter.dbConnected()) {
						if (indexType == null)
							out.println("[E] Adresācijas struktūra nav definēta!");
						else contexter.split(indexType);
						contexter.dbDisconnect();
					}
					else {
						out.println("[E] Neizdevās pieslēgties SENIE datubāzei!");
					}
					contexter.close();
					break;

				case 6:
					out.println("+-------------------------------------------+");
					out.println("| Teksta marķēšana un grāmatzīmju salikšana |");
					out.println("+-------------------------------------------+");
					out.println("");

					//String source_prim = null;
					if (pos == 1 || pos == 4) {
						out.print("Ievadiet virsavota kodu: ");
						collection = input.readLine().trim();
						out.println();
					}

					Marker marker = new Marker(source, collection);
					if (indexType == null)
						out.println("[E] Adresācijas struktūra nav definēta!");
					else marker.markup(indexType);
					marker.close();
					break;

				case 7:
					// TODO
					out.println("+-----------------------------------+");
					out.println("| \"Ietinamo\" HTML failu izveidošana |");
					out.println("+-----------------------------------+");
					out.println("");

					name = "";
					out.print("Ievadiet avota autoru: ");
					name = input.readLine().trim();
					out.print("Ievadiet avota nosaukumu: ");
					title = input.readLine().trim();
					out.print("Ievadiet virsavota kodu: ");
					collection = input.readLine().trim();
					out.print("Ievadiet vārdformu skaitu (reģistrinejūtīgo): ");
					String wordforms = input.readLine().trim();
					out.print("Ievadiet vārdu skaitu (reģistrinejūtīgo): ");
					String words = input.readLine().trim();
					HtmlWrapperPrinter printer = new HtmlWrapperPrinter(source, collection);
					printer.writeHtml();
					printer.writeTitleHtm(name, title, wordforms, words);
					break;
				case 8:
					name = "";
					out.print("Ievadiet avota autoru: ");
					name = input.readLine().trim();
					out.print("Ievadiet avota nosaukumu: ");
					title = input.readLine().trim();
					out.print("Ievadiet avotu ietverošo kolekciju): ");
					collection = input.readLine().trim();
					out.println("");
					boolean result = fullNondbProcessing(indexType, source, collection, name, title, out);
					if (!result) System.out.println("Kāds no soļiem neizdevās!");
					System.out.println();
					break;
					
				case 0:
					loop = false;
					break;

				default:
					out.println("[E] Veicamais uzdevums nav definēts!");
					break;
			}
		} while (loop);
	}

	public static boolean fullNondbProcessing(
			IndexType indexType, String source, String collection, String author, String title, PrintStream out)
	throws IOException
	{
		if (indexType == null) throw new IllegalArgumentException();
		boolean fullSuccess = true;
		boolean stepSuccess;
		out.println("Teksta attīrīšana un marķējuma sintakses pārbaude.");
		Cleaner cleaner = new Cleaner(source);
		stepSuccess = cleaner.clean(indexType);
		cleaner.close();
		if (!stepSuccess)
		{
			fullSuccess = false;
			System.out.println("\tNeizdevās!");
		}

		out.println("Pārnesto vārdu savilkšana.");
		Unhyphener unhyphener = new Unhyphener(source);
		stepSuccess = unhyphener.unhyphen(indexType);
		unhyphener.close();
		if (!stepSuccess)
		{
			fullSuccess = false;
			System.out.println("\tNeizdevās!");
		}

		out.println("Vārdformu indeksēšana un statistika, reģistrjūtīga, visiem autoriem.");
		Indexer indexer = new Indexer(source);
		// Priekš neDB apstrādes vajag, lai indeksē visus autorus, tapēc te
		// nedrīkst norādīt konkrētu autoru.
		stepSuccess = indexer.index(indexType, source, "", false, false);
		indexer.storePlaintext(false);
		indexer.storeHTML(false, collection == null || collection.trim().isEmpty());
		indexer.storeFrequencies(false);
		indexer.close();
		if (!stepSuccess)
		{
			fullSuccess = false;
			System.out.println("\tNeizdevās!");
		}

		out.println("Vārdformu indeksēšana un statistika, reģistrnejūtīga, visiem autoriem.");
		indexer = new Indexer(source);
		// Priekš neDB apstrādes vajag, lai indeksē visus autorus, tapēc te
		// nedrīkst norādīt konkrētu autoru.
		stepSuccess = indexer.index(indexType, source, "", true, false);
		int wordformsLC = indexer.countWF();
		int wordsLC = indexer.countRW();
		indexer.storePlaintext(true);
		indexer.storeHTML(true, collection == null || collection.trim().isEmpty());
		indexer.storeFrequencies(true);
		indexer.close();
		if (!stepSuccess)
		{
			fullSuccess = false;
			System.out.println("\tNeizdevās!");
		}

		out.println("Inversās vārdnīcas veidošana.");
		Inverser inverser = new Inverser(source);
		stepSuccess = inverser.index(indexType);
		inverser.storeDictionary();
		inverser.close();
		if (!stepSuccess)
		{
			fullSuccess = false;
			System.out.println("\tNeizdevās!");
		}

		out.println("Teksta marķēšana un grāmatzīmju salikšana.");
		Marker marker = new Marker(source, collection);
		stepSuccess = marker.markup(indexType);
		marker.close();
		if (!stepSuccess)
		{
			fullSuccess = false;
			System.out.println("\tNeizdevās!");
		}

		out.println("\"Ietinamo\" HTML failu izveidošana.");
		HtmlWrapperPrinter printer = new HtmlWrapperPrinter(source, collection);
		printer.writeHtml();
		printer.writeTitleHtm(author, title, Integer.toString(wordformsLC), Integer.toString(wordsLC));

		return fullSuccess;
	}

}
