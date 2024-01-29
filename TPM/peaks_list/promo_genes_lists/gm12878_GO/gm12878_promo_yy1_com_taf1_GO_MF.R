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
revigo.data <- rbind(c("GO:0003723","RNA binding",5.208567618365157,3.6903698325741012,0.8776869494545122,0.06352786,"RNA binding"),
c("GO:0003676","nucleic acid binding",20.02236659265439,2.38846526792602,0.8653162378130693,0.24352568,"RNA binding"),
c("GO:0003735","structural constituent of ribosome",2.2675249562595297,4.4723700991286615,1,0,"structural constituent of ribosome"),
c("GO:0005515","protein binding",5.073796515930947,2.600397713696012,0.9146734144129584,0.08282957,"protein binding"),
c("GO:0008137","NADH dehydrogenase (ubiquinone) activity",0.24089677336115986,2.035842090327391,0.9983765941947051,-0,"NADH dehydrogenase (ubiquinone) activity"),
c("GO:0008656","cysteine-type endopeptidase activator activity involved in apoptotic process",0.0014111586800533865,1.1283827882793882,0.9983765941947051,0.00568423,"cysteine-type endopeptidase activator activity involved in apoptotic process"),
c("GO:0042803","protein homodimerization activity",0.1550067909968294,1.0341498921762355,0.9412459168819425,0.0436884,"protein homodimerization activity"),
c("GO:0044877","protein-containing complex binding",0.8357437449165596,2.1704644812912077,0.9305528154208623,-0,"protein-containing complex binding"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_gm12878_promo_yy1_com_taf1_GO_MF.pdf", width=16, height=9 ) # width and height are in inches

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

