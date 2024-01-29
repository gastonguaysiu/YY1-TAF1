# A treemap R script produced by the Revigo server at http://revigo.irb.hr/
# If you found Revigo useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800

# author: Anton Kratz <anton.kratz@gmail.com>, RIKEN Omics Science Center, Functional Genomics Technology Team, Japan
# created: Fri, Nov 02, 2012  7:25:52 PM
# last change: Fri, Nov 09, 2012  3:20:01 PM

# -----------------------------------------------------------------------------
# If you don't have the treemap package installed, uncomment the following line:
# install.packages( "treemap" );
library(treemap) 								# treemap package by Martijn Tennekes

# Set the working directory if necessary
# setwd("C:/Users/username/workingdir");

# --------------------------------------------------------------------------
# Here is your data from Revigo. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","frequency","value","uniqueness","dispensability","representative");
revigo.data <- rbind(c("GO:0000398","mRNA splicing, via spliceosome",0.5066438464060219,1.0085392631012398,0.9379931656309494,0.08205101,"mRNA splicing, via spliceosome"),
c("GO:0006457","protein folding",1.0590625918025878,1.0803471890556549,0.9963677206814108,0.01107249,"protein folding"),
c("GO:0048026","positive regulation of mRNA splicing, via spliceosome",0.003705365315758327,1.874848021192898,0.8353569517273906,-0,"positive regulation of mRNA splicing, via spliceosome"),
c("GO:0000122","negative regulation of transcription by RNA polymerase II",0.15937394892689427,1.278986091331044,0.7920277310309215,0.39936275,"positive regulation of mRNA splicing, via spliceosome"),
c("GO:0006355","regulation of DNA-templated transcription",9.968929480711344,3.322393047279507,0.7276246674919021,0.66315541,"positive regulation of mRNA splicing, via spliceosome"),
c("GO:0006357","regulation of transcription by RNA polymerase II",1.917576443615649,1.8648744681068508,0.7524769767125516,0.29009552,"positive regulation of mRNA splicing, via spliceosome"),
c("GO:0031647","regulation of protein stability",0.05207135908276177,1.0165399410710931,0.8239044682376047,0.49566301,"positive regulation of mRNA splicing, via spliceosome"),
c("GO:0046605","regulation of centrosome cycle",0.011528542355851311,1.4217962763725864,0.8102013306727305,0.13295906,"positive regulation of mRNA splicing, via spliceosome"),
c("GO:0050821","protein stabilization",0.036474897713290676,1.4237293604423111,0.8268444149941989,0.1246302,"positive regulation of mRNA splicing, via spliceosome"),
c("GO:0051988","regulation of attachment of spindle microtubules to kinetochore",0.007177897981513886,1.2302079211525023,0.813701429303862,0.61829768,"positive regulation of mRNA splicing, via spliceosome"),
c("GO:0051301","cell division",1.3834583445093005,1.1967196083642047,0.9963103552501197,-0,"cell division"),
c("GO:0070936","protein K48-linked ubiquitination",0.010966417815130344,2.277514830499829,0.78982583834378,0,"protein K48-linked ubiquitination"),
c("GO:0031146","SCF-dependent proteasomal ubiquitin-dependent protein catabolic process",0.041168138701203595,2.102712333835707,0.8266003364074772,0.16137431,"protein K48-linked ubiquitination"),
c("GO:0032446","protein modification by small protein conjugation",0.9153483016787367,1.8004467469014087,0.784183741668402,0.63008605,"protein K48-linked ubiquitination"),
c("GO:0071383","cellular response to steroid hormone stimulus",0.05188176678204522,1.0481799074740052,0.9970108014753876,0.00825292,"cellular response to steroid hormone stimulus"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_gm12878_promo_yy1_exclu_taf1_GO_BP.pdf", width=16, height=9 ) # width and height are in inches

# check the tmPlot command documentation for all possible parameters - there are a lot more
treemap(
  stuff,
  index = c("representative","description"),
  vSize = "value",
  type = "categorical",
  vColor = "representative",
  title = "Revigo TreeMap",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  bg.labels = "#CCCCCCAA",   # define background color of group labels
								 # "#CCCCCC00" is fully transparent, "#CCCCCCAA" is semi-transparent grey, NA is opaque
  position.legend = "none"
)

dev.off()

