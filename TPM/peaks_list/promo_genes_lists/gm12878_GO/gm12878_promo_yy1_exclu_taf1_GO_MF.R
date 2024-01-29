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
revigo.data <- rbind(c("GO:0000978","RNA polymerase II cis-regulatory region sequence-specific DNA binding",0.19448654310365118,1.8269690552174505,0.7520684700250931,-0,"RNA polymerase II cis-regulatory region sequence-specific DNA binding"),
c("GO:0003723","RNA binding",5.208567618365157,1.8575655999471465,0.8536221679809267,0.27970786,"RNA polymerase II cis-regulatory region sequence-specific DNA binding"),
c("GO:0003700","DNA-binding transcription factor activity",4.532603540907692,1.7153902605473919,0.6691742299310045,-0,"DNA-binding transcription factor activity"),
c("GO:0001227","DNA-binding transcription repressor activity, RNA polymerase II-specific",0.033530001996326414,1.435707113394653,0.6815670371386842,0.5173883,"DNA-binding transcription factor activity"),
c("GO:0001228","DNA-binding transcription activator activity, RNA polymerase II-specific",0.08421457196233656,1.319885111900332,0.6660181029150016,0.61536398,"DNA-binding transcription factor activity"),
c("GO:0005515","protein binding",5.073796515930947,1.9980283653124367,0.9409905215629462,0.05807013,"protein binding"),
c("GO:0019787","ubiquitin-like protein transferase activity",0.6016875496357359,1.8855098100266336,1,0,"ubiquitin-like protein transferase activity"),
c("GO:0051082","unfolded protein binding",0.4145292243879603,1.453711217205206,0.8722045514012737,0.04192168,"unfolded protein binding"),
c("GO:0019904","protein domain specific binding",0.10786646319828927,1.3039489397662967,0.8768513998531771,0.45946902,"unfolded protein binding"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_gm12878_promo_yy1_exclu_taf1_GO_MF.pdf", width=16, height=9 ) # width and height are in inches

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

