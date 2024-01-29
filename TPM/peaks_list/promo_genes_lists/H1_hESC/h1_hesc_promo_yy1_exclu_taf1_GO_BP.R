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
revigo.data <- rbind(c("GO:0002181","cytoplasmic translation",0.12046428693071752,1.3345010987811698,0.7727197183281099,0.00866484,"cytoplasmic translation"),
c("GO:0006261","DNA-templated DNA replication",0.5186580111461646,0.35649960744901615,0.885963885162504,0.13955971,"cytoplasmic translation"),
c("GO:0006412","translation",5.085673767131161,0.9951869322252052,0.7530126724708317,0.57750679,"cytoplasmic translation"),
c("GO:0006325","chromatin organization",1.0463199934860077,1.3345010987811698,0.9894995602778478,-0,"chromatin organization"),
c("GO:0045893","positive regulation of DNA-templated transcription",0.723806859063603,2.0384042836822642,0.6323443138759441,0,"positive regulation of DNA-templated transcription"),
c("GO:0006355","regulation of DNA-templated transcription",9.968929480711344,1.3228895533748397,0.7186871934929706,0.57384123,"positive regulation of DNA-templated transcription"),
c("GO:0051973","positive regulation of telomerase activity",0.006412876417219078,0.42569580576807536,0.6959487283484089,0.65495397,"positive regulation of DNA-templated transcription"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_treemap.pdf", width=16, height=9 ) # width and height are in inches

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

