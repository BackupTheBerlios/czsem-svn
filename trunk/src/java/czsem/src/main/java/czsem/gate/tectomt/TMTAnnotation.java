package czsem.gate.tectomt;

import org.apache.commons.lang.NotImplementedException;

import gate.AnnotationSet;
import gate.FeatureMap;
import gate.util.InvalidOffsetException;

public abstract class TMTAnnotation
{
	public static abstract class SeqAnnotation extends TMTAnnotation
	{
		protected String tmt_id;
		public abstract String getString();
		
		public void annotate(AnnotationSet as, SequenceAnnotator seq_anot) throws InvalidOffsetException
		{
			String str = getString();
			if (str == null)
			{
//				logger.warn("EMPTY annotation detected!");
				return;
			}
			
	    	seq_anot.nextToken(str);
	    	annotate(as, seq_anot.lastStart(), seq_anot.lastEnd());
		}

		@Override
		public void annotate(AnnotationSet as, SentenceInfoManager sentence) throws InvalidOffsetException {
			throw new NotImplementedException();
		}
		
		

	}
	
	protected Integer gate_annotation_id;
	public abstract String getAnnotationType();
	public abstract FeatureMap getFeatures();
	public abstract void annotate(AnnotationSet as, SentenceInfoManager sentence) throws InvalidOffsetException;
	
	protected void annotate(AnnotationSet as, long startOffset, long endOffset) throws InvalidOffsetException
	{
    	gate_annotation_id = as.add(startOffset, endOffset,	getAnnotationType(), getFeatures());			
	}

}
