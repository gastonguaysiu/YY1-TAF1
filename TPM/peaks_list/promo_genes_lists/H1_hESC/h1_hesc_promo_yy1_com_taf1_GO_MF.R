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
revigo.data <- rbind(c("GO:0003712","transcription coregulator activity",0.3252911454641982,2.420894157885666,0.9847536885548155,-0,"transcription coregulator activity"),
c("GO:0003729","mRNA binding",0.29463794571910035,0.9112220005939564,0.7804358738440632,-0,"mRNA binding"),
c("GO:0003723","RNA binding",5.208567618365157,10.804100347590767,0.8159489697077492,0.29293784,"mRNA binding"),
c("GO:0019843","rRNA binding",1.1598689137107523,0.42764010641842004,0.7652195996791072,0.54471954,"mRNA binding"),
c("GO:0003735","structural constituent of ribosome",2.2675249562595297,3.196542884351586,1,0,"structural constituent of ribosome"),
c("GO:0005515","protein binding",5.073796515930947,12.896196279044043,0.9371791805689144,0.05581941,"protein binding"),
c("GO:0008137","NADH dehydrogenase (ubiquinone) activity",0.24089677336115986,1.7267833030019903,0.7812734054992805,0.06121948,"NADH dehydrogenase (ubiquinone) activity"),
c("GO:0043130","ubiquitin binding",0.11891872336233673,0.47230994884514776,0.9544254374132825,0.03914066,"ubiquitin binding"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_h1_hesc_promo_yy1_com_taf1_GO_MF.pdf", width=16, height=9 ) # width and height are in inches

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

