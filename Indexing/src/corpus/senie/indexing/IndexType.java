package corpus.senie.indexing;

public enum IndexType
{
	GNP, LR, P;
	public static IndexType getByLegacyCode(int i)
	{
		switch (i)
		{
			case 1:
				return GNP;
			case 2:
				return LR;
			case 3:
				return P;
			default:
				return null;
		}
	}
}
