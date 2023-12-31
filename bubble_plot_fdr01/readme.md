**GO ANALYSIS OF YY1-TAF1 co-binding**

**Overview**

We analyzed GO terms for YY1 and TAF1 peaks in GM12878 and H1-hESC cells using David's platform, illustrated through a bubble plot with FDR < 0.1, using the bubble_GO.R script to build the bubble plots. Our findings reveal cell-specific GO term impacts due to YY1/TAF1 binding. In GM12878, YY1-TAF1 peaks correlated with more GO terms (5) than YY1 alone (2), mainly involving ribosomal functions and transcription regulation. However, TAF1-exclusive peaks showed the most terms (39). In contrast, H1-hESC cells had different GO term distributions: 19 for YY1 alone, 45 for YY1-TAF1, and 3 for TAF1 alone.

Analysis indicates YY1-TAF1 co-binding expanding GO term variety, suggesting synergistic effects in cellular regulation. Interestingly, YY1-TAF1 co-binding in GM12878 is linked to narrower functions like RNA processing, while in H1-hESC, it correlates with a broader range. TAF1's role varies between cell lines, indicating their influence on cellular needs and differentiation potential. GM12878's mature state leads to TAF1's distinct role in gene regulation, whereas H1-hESC's differentiation potential demands more stringent gene control, highlighting YY1's dual role as a gene expression regulator.


**Contents**

Files:

 - *.tsv: raw data of the GO analysis using David for different conditions and cell lines

Scripts:

 - bubble_GO.R: builds bubble plot figures with colour coding for different GO types.
