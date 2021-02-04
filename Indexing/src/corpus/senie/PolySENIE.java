package corpus.senie;

import corpus.senie.indexing.IndexType;

import java.io.*;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PolySENIE
{
	protected Params p = new Params();
	protected Map<String, IndexType> indexSpec;

	public static void main(String args[]) throws IOException
	{
		//PrintStream out = new PrintStream(System.out, true, "UTF-8");
		PrintStream out = new PrintStream(System.out, true, "Windows-1257");
		if (args == null || args.length < 1)
		{
			out.println("SENIE korpusa masu apstrādes programma.");
			out.println("Sagaidāmie parametri:");
			out.println("    1) apstrādājamo datu mape (struktūra kā Sources mapei);");
			out.println("    1) ignorēt biblisko avotu Prolog* daļas;");
			out.println("    3) indeksēšanas tipu specifikācijas faila adrese, neobligāti, noklusējuma");
			out.println("       vērtība \"../../Sources/indexing.txt\"");
			out.println("NB! Tā kā šis ir ietinamais vecajam skriptam, kas apstrādāja failus pa vienam");
			out.println("  aktīvajā mapē /senie/Indexing/run, tad turiet šo map brīvu no sev svarīgiem");
			out.println("  failiem, kas sākas ar avotu kodiem, jo tie tiks pārraktīti un/vai pārvietoti.");
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

		for (File firstLevelDir : sourceDir.listFiles(File::isDirectory))
		{
			for (File secondLevelPath : firstLevelDir.listFiles(File::isDirectory))
			{
				for (File thirdLevelPath : secondLevelPath.listFiles(File::isFile))
				{
					if (!wrapper.p.ignoreProlog || !thirdLevelPath.getName().startsWith("Prolog"))
						wrapper.processFile(thirdLevelPath, out);
				}
			}
			for (File secondLevelPath : firstLevelDir.listFiles(File::isFile))
			{
				if (!wrapper.p.ignoreProlog || !secondLevelPath.getName().startsWith("Prolog"))
					wrapper.processFile(secondLevelPath, out);
			}
		}

	}

	protected void processFile (File fileName, PrintStream out)
	throws IOException
	{
		out.println();
		out.println("Apstrādā failu " + fileName.getName() + "...");
		String[] fileParams = getParamsFromFile(fileName.getPath());
		out.print("  Avots: " + fileParams[0]);
		if (fileParams[1] != null) out.print(", grāmata: " + fileParams[1]);
		out.println(", autors: " + fileParams[3]);
		Files.copy(fileName.toPath(), FileSystems.getDefault().getPath(".", fileName.getName()), StandardCopyOption.REPLACE_EXISTING);
		if (fileParams[1] != null)
		{
			IndexType iType = indexSpec.get(fileParams[0] + "/" + fileParams[1]);
			out.println("  Indeksa veids: " + iType);
			MonoSENIE.fullNondbProcessing(iType, fileParams[1], fileParams[2], out);
		}
		else
		{
			out.println(fileParams[0]);
			IndexType iType = indexSpec.get(fileParams[0]);
			out.println("  Indeksa veids: " + iType);
			MonoSENIE.fullNondbProcessing(iType, fileParams[0], fileParams[2], out);
		}
		//Path target = fileName.getParentFile().toPath();
		for (File homeDirFile : (new File(".")).listFiles(File::isFile))
		{
			String fileToMoveName = homeDirFile.getName();
			if (fileParams[1] != null && fileToMoveName.startsWith(fileParams[1])
					|| fileToMoveName.startsWith(fileParams[0]))
				Files.move(homeDirFile.toPath(),
						FileSystems.getDefault().getPath(fileName.getParent(), homeDirFile.getName()),
						StandardCopyOption.REPLACE_EXISTING);
		}
	}

	/**
	 * Helper method for getting contents of the @{....} i.e., author mark form
	 * somethere in the file. The whole @{...} must be in a single line.
	 * @param filePath file to check
	 * @return array with @z field, @g field and @a field in that order
	 * @throws IOException
	 */
	public static String[] getParamsFromFile(String filePath)
	throws IOException
	{
		if(filePath == null) return null;
		String authorName = null;
		String sourceCode = null;
		String bookCode = null;
		BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(filePath), "Cp1257"));
		Pattern codePattern = Pattern.compile(".*?@([agz])\\{([^}]+)\\}.*");
		String line = reader.readLine();
		while (line != null && (authorName == null || sourceCode == null || bookCode == null))
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
				}
			}
			line = reader.readLine();
		}
		reader.close();
		return new String[] {sourceCode, bookCode, authorName};
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

	/**
	 * Class for storing pre-configured parameters for this processing wrapper.
	 */
	public static class Params
	{
		/**
		 * Path to the file with information how which file should be indexed.
		 * Format:
		 * GNP/LR/P tab MainSourceCode tab BookCode (if needed)
		 * GNP/LR/P tab MainSourceCode tab BookCode (if needed)
		 * ...
		 */
		public File indexSpecPath = new File("../../Sources/indexing.txt");
		/**
		 * Names for support files to ignore.
		 */
		public HashSet<String> ignoreFiles = new HashSet<String>(){{
			add("indexing.txt");
			add("pub_ord.txt");
		}};
		/**
		 * Whether to ignore sources with codes starting with "Prolog".
		 * This is used to skip Bible prefaces etc.
		 */
		public boolean ignoreProlog = true;
	}
}
