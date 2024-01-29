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
revigo.data <- rbind(c("GO:0005654","nucleoplasm",1.1886804954225278,6.568636235841013,0.5747270415552772,0,"nucleoplasm"),
c("GO:0005634","nucleus",12.339605699963672,4.910094888560602,0.5741313148799888,0.44231542,"nucleoplasm"),
c("GO:0005681","spliceosomal complex",0.39025605055667634,2.2067041290734792,0.6202903356161172,0.36762581,"nucleoplasm"),
c("GO:0005739","mitochondrion",2.7614025547937224,1.0443285127869757,0.6091848618707654,0.31329072,"nucleoplasm"),
c("GO:0005819","spindle",0.26436319409380066,2.0802931355927377,0.4888364230063268,0.18427378,"nucleoplasm"),
c("GO:0005829","cytosol",1.696303522837096,1.0837549373093858,0.7864546657195756,0.12623137,"nucleoplasm"),
c("GO:0015630","microtubule cytoskeleton",1.1896629326436472,1.0498319730862908,0.47357034245176055,0.69995336,"nucleoplasm"),
c("GO:0016607","nuclear speck",0.12034475169089631,1.4975637820798808,0.6337549028883519,0.67516485,"nucleoplasm"),
c("GO:0019005","SCF ubiquitin ligase complex",0.043566140491568935,1.3157853067072733,0.9562473767904067,-0,"SCF ubiquitin ligase complex"),
c("GO:0030496","midbody",0.058599714712416255,1.096260537493618,0.9999299627602171,3.907E-05,"midbody"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_gm12878_promo_yy1_exclu_taf1_GO_CC.pdf", width=16, height=9 ) # width and height are in inches

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

