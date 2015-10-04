package corpus.senie;

import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintStream;
import corpus.senie.indexing.Cleaner;
import corpus.senie.indexing.Unhyphener;
import corpus.senie.indexing.Indexer;
import corpus.senie.indexing.Inverser;
import corpus.senie.indexing.Contexter;
import corpus.senie.indexing.Marker;


public class MonoSENIE {

	public static void main(String args[]) throws IOException {
		PrintStream out = new PrintStream(System.out, true, "UTF-8");
		BufferedReader input = new BufferedReader(new InputStreamReader(System.in, "UTF-8"));

		out.print("Ievadiet avota kodu: ");
		String source = input.readLine();
		out.println("");

		out.println("Ievadiet adresācijas struktūru: ");
		out.println("(1) grāmata->nodaļa->pants");
		out.println("(2) lappuse->rinda");
		out.println("(3) pants");
		out.print("Izvēle: ");
		int pos = Integer.parseInt(input.readLine());
		out.println("");

		String confirm = "";
		boolean loop = true;

		do {
			out.println("Ievadiet veicamo uzdevumu: ");
			out.println("(1) tīrīšana & pārbaude");
			out.println("(2) savilkšana");
			out.println("(3) indeksēšana");
			out.println("(4) inversā vārdnīca");
			out.println("(5) fragmentēšana (DB)");
			out.println("(6) marķēšana");
			out.println("(0) beigt");
			out.print("Izvēle: ");
			int task = Integer.parseInt(input.readLine());
			out.println("");

			switch (task) {
				case 1:
					out.println("+---------------------------------------------------+");
					out.println("| Teksta attīrīšana un marķējuma sintakses pārbaude |");
					out.println("+---------------------------------------------------+");
					out.println("");

					Cleaner cleaner = new Cleaner(source);
					switch (pos) {
						case 1:
							cleaner.cleanGNP();
							break;
						case 2:
							cleaner.cleanLR();
							break;
						case 3:
							cleaner.cleanP();
							break;
						default:
							out.println("Adresācijas struktūra nav definēta!");
							break;
					}
					cleaner.close();
					break;

				case 2:
					out.println("+---------------------------+");
					out.println("| Pārnesto vārdu savilkšana |");
					out.println("+---------------------------+");
					out.println("");

					Unhyphener unhyphener = new Unhyphener(source);
					switch (pos) {
						case 1:
							unhyphener.unhyphenVerse(true);
							break;
						case 2:
							unhyphener.unhyphenRow();
							break;
						case 3:
							unhyphener.unhyphenVerse(false);
							break;
						default:
							out.println("Adresācijas struktūra nav definēta!");
							break;
					}
					unhyphener.close();
					break;

				case 3:
					out.println("+-------------------------------------+");
					out.println("| Vārdformu indeksēšana un statistika |");
					out.println("+-------------------------------------+");
					out.println("");

					boolean lower = false;
					out.print("Ņemt vērā lielos/mazos burtus? [j/n]: ");
					confirm = input.readLine();
					if (confirm.toLowerCase().trim().equals("n")) {
						lower = true;
					}
					out.println("");

					String name = "";
					out.print("Ievadiet avota autoru: ");
					name = input.readLine();
					out.println("");

					Indexer indexer = new Indexer(source);

					boolean db = false;
					if (!lower && !name.isEmpty()) {
						out.print("Saglabāt SENIE datubāzē? [j/n]: ");
						confirm = input.readLine();
						out.println("");
						if (confirm.toLowerCase().trim().equals("j")) db = true;

						if (db) {
							indexer.dbConnect("//localhost:3306/senie", "senie", "corpsbase03");
							indexer.setAuthor(name);
							indexer.setSource(source);
						}
					}

					switch (pos) {
						case 1:
							indexer.indexGNP(source, name, lower, db);
							break;
						case 2:
							indexer.indexLR(source, name, lower, db);
							break;
						case 3:
							indexer.indexP(source, name, lower, db);
							break;
						default:
							out.println("Adresācijas struktūra nav definēta!");
							break;
					}

					out.print("Indekss tiek rakstīts teksta failā... ");
					indexer.storePlaintext(lower);
					out.println("Darīts.");
					out.println("");
					out.print("Indekss tiek rakstīts HTML failā... ");
					indexer.storeHTML(lower);
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
					switch (pos) {
						case 1:
							inverser.indexGNP();
							break;
						case 2:
							inverser.indexLR();
							break;
						case 3:
							inverser.indexP();
							break;
						default:
							out.println("Adresācijas struktūra nav definēta!");
							break;
					}

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

					Contexter contexter = new Contexter(source);
					contexter.dbConnect("//localhost:3306/senie", "senie", "corpsbase03");
					if (contexter.dbConnected()) {
						switch (pos) {
							case 1:
								contexter.splitGNP();
								break;
							case 2:
								contexter.splitLR();
								break;
							case 3:
								contexter.splitP();
								break;
							default:
								out.println("Adresācijas struktūra nav definēta!");
								break;
						}
						contexter.dbDisconnect();
					}
					else {
						out.println("Neizdevās pieslēgties SENIE datubāzei!");
					}
					contexter.close();
					break;

				case 6:
					out.println("+-------------------------------------------+");
					out.println("| Teksta marķēšana un grāmatzīmju salikšana |");
					out.println("+-------------------------------------------+");
					out.println("");

					Marker marker = new Marker(source);
					switch (pos) {
						case 1:
							marker.markupGNP();
							break;
						case 2:
							marker.markupLR();
							break;
						case 3:
							marker.markupP();
							break;
						default:
							out.println("Adresācijas struktūra nav definēta!");
							break;
					}
					marker.close();
					break;
					
				case 0:
					loop = false;
					break;

				default:
					out.println("Veicamais uzdevums nav definēts!");
					break;
			}
		} while (loop);
	}

}
