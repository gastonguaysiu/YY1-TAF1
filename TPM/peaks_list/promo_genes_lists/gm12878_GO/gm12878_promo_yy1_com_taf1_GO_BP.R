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
revigo.data <- rbind(c("GO:0006364","rRNA processing",1.1723523069325057,4.0746879085003505,0.45995388120604086,0,"rRNA processing"),
c("GO:0002181","cytoplasmic translation",0.12046428693071752,2.4939449455609117,0.6617511493362902,0.37715767,"rRNA processing"),
c("GO:0006397","mRNA processing",1.0320905923901242,1.3772625535937828,0.6000595609520388,0.68187522,"rRNA processing"),
c("GO:0006412","translation",5.085673767131161,3.1203307943679466,0.56505977735675,0.57750679,"rRNA processing"),
c("GO:0008380","RNA splicing",0.7198287469292699,2.306576070724086,0.6099654378413254,0.65568149,"rRNA processing"),
c("GO:0032543","mitochondrial translation",0.07416385138731006,1.4121501474417308,0.6722360966538397,0.40597483,"rRNA processing"),
c("GO:0032981","mitochondrial respiratory chain complex I assembly",0.04205622895192844,2.9122712304238854,0.8582221242228456,0.47325138,"rRNA processing"),
c("GO:0006886","intracellular protein transport",1.2951282894596792,1.0183714691055348,0.9837301563855754,0.01111739,"intracellular protein transport"),
c("GO:0009060","aerobic respiration",0.9867813586995857,2.8555717141837005,0.7468044497227346,0.0794012,"aerobic respiration"),
c("GO:0006120","mitochondrial electron transport, NADH to ubiquinone",0.029094102708202944,2.0114609459443793,0.7634660860593301,0.68918887,"aerobic respiration"),
c("GO:0042776","proton motive force-driven mitochondrial ATP synthesis",0.003998069218618948,1.7253916603341888,0.6776556891471176,0.59642557,"aerobic respiration"),
c("GO:0045945","positive regulation of transcription by RNA polymerase III",0.002381545391456878,1.2019125998804017,1,-0,"positive regulation of transcription by RNA polymerase III"),
c("GO:0075522","IRES-dependent viral translational initiation",0.0015566525743042163,1.4553622315611716,1,-0,"IRES-dependent viral translational initiation"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_gm12878_promo_yy1_com_taf1_GO_BP.pdf", width=16, height=9 ) # width and height are in inches

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

