package corpus.senie.indexing;

import java.text.Collator;
import java.text.ParseException;
import java.text.RuleBasedCollator;
import java.util.Locale;

/**
 * Singleton for providing Latvian-based comparator for all SENIE needs:
 * accented characters are after non-accented, numbers are after letters and
 * '=', '-' are ignored characters.
 * Considers only caracters included in "Windows-1257" code sheet; for full
 * unicode glory of Senie another comparator must be written.
 */
public class WordComparator
{
	protected static RuleBasedCollator OLD_LV_COLLATOR = null;
	protected static void init()
	{
		try
		{
			OLD_LV_COLLATOR = (RuleBasedCollator) Collator.getInstance(new Locale("lv"));
			String extRules = "'=' '-' ' '"
					+ "<a,A<b,B<c,C<d,D<e,E<f,F<g,G<h,H<i,I<j,J<k,K<l,L<m,M<n,N"
					+ "<o,O<p,P<q,Q<r,R<s,S<t,T<u,U<v,V<w,W<x,X<y,Y<z,Z"
					+ "<0<1<2<3<4<5<6<7<8<9"
					+ "&A;Ā;Ä<Æ &C;Č;Ć &E;Ē &G;Ģ &I;Ī &K;Ķ &L;Ļ;Ł &N;Ņ &O;Ō;Ö &R;Ŗ &S;Š;Ś &U;Ū;Ü &Z;Ž;Ź"
					+ "&a;ā;ä;ą<æ &c;č;ć &e;ē;ę;é &g;ģ &i;ī &k;ķ &l;ļ;ł &n;ņ;ń"
					+ "&o;ō;ö;ó &r;ŗ &s;š;ś;§;ß &u;ū;ü &z;ž;ź;ż";
			OLD_LV_COLLATOR = new RuleBasedCollator(
					OLD_LV_COLLATOR.getRules() + extRules);
			OLD_LV_COLLATOR.setStrength(Collator.TERTIARY);
		} catch (ParseException e)
		{
			e.printStackTrace();
		}
	}
	public static RuleBasedCollator getCollator()
	{
		if (OLD_LV_COLLATOR == null) init();
		return OLD_LV_COLLATOR;
	}
}
