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
revigo.data <- rbind(c("GO:0005654","nucleoplasm",1.1886804954225278,5.860120913598763,0.6286374037185007,0,"nucleoplasm"),
c("GO:0005739","mitochondrion",2.7614025547937224,1.520504603778916,0.5913056058163179,0.31329072,"nucleoplasm"),
c("GO:0005747","mitochondrial respiratory chain complex I",0.051657919929081746,2.004587473559383,0.4879450218101576,0.22590489,"nucleoplasm"),
c("GO:0005829","cytosol",1.696303522837096,1.7596622660624799,0.693116962249155,0.19157292,"nucleoplasm"),
c("GO:0005840","ribosome",3.532158825827589,2.678395137608346,0.5842621798054405,0.43014036,"nucleoplasm"),
c("GO:0022625","cytosolic large ribosomal subunit",0.11811713241045162,3.0665127121512947,0.512797213582405,0.1709871,"nucleoplasm"),
c("GO:0022626","cytosolic ribosome",0.16733799876776478,1.4971503463313736,0.594610243325178,0.61025077,"nucleoplasm"),
c("GO:0032040","small-subunit processome",0.1049494273304896,1.6702383662291793,0.8351587674100839,0.44026603,"nucleoplasm"),
c("GO:0070847","core mediator complex",0.007109342216393603,1.1237176057297074,0.6816236001387828,0.26232671,"nucleoplasm"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_gm12878_promo_yy1_com_taf1_GO_CC.pdf", width=16, height=9 ) # width and height are in inches

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

