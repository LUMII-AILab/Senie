package corpus.senie;

import corpus.senie.indexing.IndexType;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;

public class PolySENIE
{
	protected Params p = new Params();
	protected Map<String, IndexType> indexSpec;

	public static void main(String[] args) throws IOException
	{
		//PrintStream out = new PrintStream(System.out, true, "UTF-8");
		PrintStream out = new PrintStream(System.out, true, "Windows-1257");
		if (args == null || args.length < 1 || args.length > 3)
		{
			// If not enough arguments, print general info
			out.println("SENIE korpusa masu apstrādes programma.");
			out.println("Sagaidāmie parametri:");
			out.println("    1) apstrādājamo datu mape (struktūra kā Sources mapei);");
			out.println("    2) ignorēt biblisko avotu Prolog* daļas;");
			out.println("    3) indeksēšanas tipu specifikācijas faila adrese, neobligāti, noklusējuma");
			out.println("       vērtība \"../../Sources/indexing.txt\"");
			out.println("NB! Tā kā šis ir ietinamais vecajam skriptam, kas apstrādāja failus pa vienam");
			out.println("  aktīvajā mapē /senie/Indexing/run, tad turiet šo map brīvu no sev svarīgiem");
			out.println("  failiem, kas sākas ar avotu kodiem, jo tie tiks pārraktīti un/vai pārvietoti.");
			out.println("P.S. Mapē Unicoding ir izsaukumpiemērs runFileCollector-sample.bat, kurā");
			out.println("  parādīts, kā dabūt tieši tādu mapīti ar datiem, kā vajadzīgs 1. punktā.");
			out.println("AILab, LUMII, ...-2021");
			return;
		}

		File sourceDir = new File(args[0]);
		if (!sourceDir.isDirectory())
		{
			out.println("Neatradās datu mape!");
			return;
		}

		PolySENIE wrapper = new PolySENIE();

		if (args.length > 1) wrapper.p.ignoreProlog = Boolean.parseBoolean(args[2]);
		if (args.length > 2)
		{
			File newIndexSpec = new File(args[2]);
			if (newIndexSpec.isFile()) wrapper.p.indexSpecPath = newIndexSpec;
			else
			{
				out.println("Neatradās indeksēšanas specifikācijas fails!");
				return;
			}
		}

		wrapper.loadIndexSpec(out);

		File resTxtDir = new File("result-txt");
		File resHtmlDir = new File("result-html");
		File trashDir = new File("result-trash");
		trashDir.mkdirs();

		for (File firstLevelDir : sourceDir.listFiles(File::isDirectory))
		{
			File firstLevelTxtDir = new File(resTxtDir.getPath() + File.separator + firstLevelDir.getName());
			firstLevelTxtDir.mkdirs();
			File firstLevelHtmlDir = new File(resHtmlDir.getPath() + File.separator + firstLevelDir.getName());
			firstLevelHtmlDir.mkdirs();
			for (File secondLevelPath : firstLevelDir.listFiles(File::isDirectory))
			{
				File secondLevelTxtDir = new File(firstLevelTxtDir.getPath() + File.separator + secondLevelPath.getName());
				secondLevelTxtDir.mkdirs();
				File secondLevelHtmlDir = new File(firstLevelHtmlDir.getPath() + File.separator + secondLevelPath.getName());
				secondLevelHtmlDir.mkdirs();
				for (File thirdLevelPath : secondLevelPath.listFiles(File::isFile))
					if (!wrapper.p.ignoreProlog || !thirdLevelPath.getName().startsWith("Prolog"))
						wrapper.processFile(thirdLevelPath, secondLevelTxtDir, secondLevelHtmlDir, trashDir, out);
			}
			for (File secondLevelPath : firstLevelDir.listFiles(File::isFile))
				if (!wrapper.p.ignoreProlog || !secondLevelPath.getName().startsWith("Prolog"))
					wrapper.processFile(secondLevelPath, firstLevelTxtDir, firstLevelHtmlDir, trashDir, out);
		}

		String[] trash = trashDir.list();
		for(String s : trash) {
			File currentFile = new File(trashDir.getPath(), s);
			currentFile.delete();
		}
		//java.nio.file.Files.delete(trashDir.toPath());
		trashDir.delete();

		out.println();
		out.println("~~~");
		out.println("Apstrāde pabeigta.");
		out.println("Neaizmirstiet pirms TXT failu pārkopēšanas uz Sources mapi tajā iztīrīt vecos");
		out.println("_log.txt failus.");


	}

	/**
	 * Process a single file.
	 * @param fileName		path to the file to be indexed
	 * @param txtResultDir	folder for all .txt results
	 * @param htmlResultDir	folder for all .htm results
	 * @param trashDir		folder for all unneeded results - workaround for
	 *                      windows occasionally blocking names of recently
	 *                      deleted files
	 * @param out			status message output
	 * @throws IOException
	 */
	protected void processFile (File fileName, File txtResultDir, File htmlResultDir, File trashDir, PrintStream out)
	throws IOException
	{
		out.println();
		out.println("Apstrādā failu " + fileName.getName() + "...");
		String[] fileParams = getParamsFromFile(fileName.getPath());
		out.print("  Avots: " + fileParams[0]);
		if (fileParams[1] != null) out.print(", grāmata: " + fileParams[1]);
		out.print(", autors: " + fileParams[2]);
		if (fileParams[3] != null) out.print(", virsraksts: " + fileParams[3]);
		out.println();
		Files.copy(fileName.toPath(), FileSystems.getDefault().getPath(".", fileName.getName()), StandardCopyOption.REPLACE_EXISTING);
		if (fileParams[1] != null)
		{
			IndexType iType = indexSpec.get(fileParams[0] + "/" + fileParams[1]);
			out.println("  Indeksa veids: " + iType);
			MonoSENIE.fullNondbProcessing(iType, fileParams[1], fileParams[0], fileParams[2], fileParams[3], out);
		}
		else
		{
			IndexType iType = indexSpec.get(fileParams[0]);
			out.println("  Indeksa veids: " + iType);
			MonoSENIE.fullNondbProcessing(iType, fileParams[0], null, fileParams[2], fileParams[3], out);
		}

		for (File resultFile : (new File(".")).listFiles(File::isFile))
		{
			String resultFileName = resultFile.getName();
			String fileCodeStub = fileParams[1] == null ? fileParams[0] : fileParams[1];
			if (resultFileName.startsWith(fileCodeStub))
			{
				if (resultFileName.equals(fileCodeStub + "_log.txt") && isLogFileEmpty(resultFile) ||
						resultFileName.equals(fileCodeStub + "_indexed.htm"))
				{
					System.out.println ("Deleting " + resultFileName);
					Path target = FileSystems.getDefault().getPath(trashDir.getPath(), resultFile.getName());
					//while (!Files.isWritable(target));
					//Files.delete(resultFile.toPath());
					Files.move(resultFile.toPath(), target,
							StandardCopyOption.REPLACE_EXISTING);
				}
				else if (resultFileName.endsWith(".htm") || resultFileName.endsWith(".html"))
					Files.move(resultFile.toPath(),
							FileSystems.getDefault().getPath(htmlResultDir.getPath(), resultFile.getName()),
							StandardCopyOption.REPLACE_EXISTING);
				else if (resultFileName.equals(fileCodeStub + ".txt"))
					//Files.delete(resultFile.toPath());
					Files.move(resultFile.toPath(),
							FileSystems.getDefault().getPath(trashDir.getPath(), resultFile.getName()),
							StandardCopyOption.REPLACE_EXISTING);
				else if (resultFileName.endsWith(".txt"))
					Files.move(resultFile.toPath(),
							FileSystems.getDefault().getPath(txtResultDir.getPath(), resultFile.getName()),
							StandardCopyOption.REPLACE_EXISTING);
				else continue; // not a valid result file.
			}
		}
	}

	/**
	 * Helper method for getting contents of the @{....} i.e., author mark form
	 * somethere in the file. The whole @{...} must be in a single line.
	 * @param filePath file to check
	 * @return array with @z field, @g field, @a field and @k field in that order
	 * @throws IOException
	 */
	public static String[] getParamsFromFile(String filePath)
	throws IOException
	{
		if(filePath == null) return null;
		String authorName = null;
		String sourceCode = null;
		String bookCode = null;
		String firstComment = null;
		BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(filePath), "Cp1257"));
		Pattern codePattern = Pattern.compile(".*?@([agzk])\\{([^}]+)\\}.*");
		String line = reader.readLine();
		int linecount = 0;
		while (line != null && (authorName == null || sourceCode == null || bookCode == null || firstComment == null) && linecount < 20)
		{
			Matcher codeMatcher = codePattern.matcher(line);
			if (codeMatcher.matches())
			{
				String code = codeMatcher.group(1);
				String value = codeMatcher.group(2);
				switch (code)
				{
					case "a" : authorName = value; break;
					case "g" : bookCode = value; break;
					case "z" : sourceCode = value; break;
					case "k" : if (firstComment == null || firstComment.isEmpty()) firstComment = value; break;
				}
			}
			line = reader.readLine();
			linecount++;
		}
		reader.close();
		return new String[] {sourceCode, bookCode, authorName, firstComment};
	}

	/**
	 * Load into memory information about how which file should be processed.
	 * @param out	output stream for non-fatal complaints
	 * @throws IOException
	 */
	public void loadIndexSpec(PrintStream out)
	throws IOException
	{
		indexSpec = new HashMap<>();
		BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(p.indexSpecPath)));
		String line = reader.readLine();
		while (line != null)
		{
			if (!line.isEmpty())
			{
				String[] parts = line.split("\t", 2);
				if (parts.length < 2)
					out.println("Indeksācijas failā ir nesaprotama rinda: " + line);
				else indexSpec.put(
						parts[1].replace("\t", "/").trim(),
						IndexType.getByStringCode(parts[0]));
			}
			line = reader.readLine();
		}
	}

	public static boolean isLogFileEmpty (File logFilePath)
	throws IOException
	{
		Stream<String> contentStream = Files.lines(logFilePath.toPath(), StandardCharsets.UTF_8);
		StringBuilder contentBuilder = new StringBuilder();
		contentStream.forEach(s -> contentBuilder.append(s).append("\n"));
		Pattern emptyFilePattern = Pattern.compile("\\s*" +
				"TEKSTA ATTĪRĪŠANA UN PĀRBAUDE:\\s*" +
				"VĀRDLIETOJUMU SAVILKŠANA TEKSTĀ:\\s*" +
				"TEKSTA INDEKSĒŠANA UN STATISTIKA:\\s*" +
				"TEKSTA INDEKSĒŠANA UN STATISTIKA:\\s*" +
				"INVERSĀ VĀRDNĪCA:\\s*" +
				"TEKSTA MARĶĒŠANA UN GRĀMATZĪMJU SALIKŠANA:\\s*");
		Matcher m = emptyFilePattern.matcher(contentBuilder.toString());
		return m.matches();
	}
	/**
	 * Class for storing pre-configured parameters for this processing wrapper.
	 */
	public static class Params
	{
		/**
		 * Path to the file with information how which file should be indexed.
		 * Format:
		 * GNP/LR/P/GLR tab MainSourceCode tab BookCode (if needed)
		 * GNP/LR/P/GLR tab MainSourceCode tab BookCode (if needed)
		 * ...
		 */
		public File indexSpecPath = new File("../../Sources/indexing.txt");
		/**
		 * Names for support files to ignore.
		 */
		public HashSet<String> ignoreFiles = new HashSet<String>() {{
			add("indexing.txt");
			add("pub_ord.txt");
		}};
		/**
		 * Whether to ignore sources with codes starting with "Prolog".
		 * This is used to skip Bible prefaces etc.
		 */
		public boolean ignoreProlog = false;
	}
}
