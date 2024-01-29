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
revigo.data <- rbind(c("GO:0000151","ubiquitin ligase complex",0.24068950338179262,1.0673463566412034,0.9034752049210732,-0,"ubiquitin ligase complex"),
c("GO:0031463","Cul3-RING ubiquitin ligase complex",0.010860119979193655,0.6254905706385999,0.9151668383699766,0.51671478,"ubiquitin ligase complex"),
c("GO:0097550","transcription preinitiation complex",0.004135375279594779,0.41365105659853163,0.9377467655349734,0.20049867,"ubiquitin ligase complex"),
c("GO:0005829","cytosol",1.696303522837096,16.323306390375134,0.773353375286068,0,"cytosol"),
c("GO:0000421","autophagosome membrane",0.017451588311586438,0.6254905706385999,0.7442941719515261,0.43553775,"cytosol"),
c("GO:0000932","P-body",0.07256707799561482,1.442075779486034,0.6178412739039637,0.31845323,"cytosol"),
c("GO:0005634","nucleus",12.339605699963672,14.924453038607469,0.6274567979316116,0.44231542,"cytosol"),
c("GO:0005654","nucleoplasm",1.1886804954225278,13.400116927926312,0.6138509968233407,0.12623137,"cytosol"),
c("GO:0005681","spliceosomal complex",0.39025605055667634,0.43998857635223226,0.6399053957577561,0.36762581,"cytosol"),
c("GO:0005694","chromosome",1.8755754683141148,1.1965859588668362,0.585221124869721,0.59262865,"cytosol"),
c("GO:0005737","cytoplasm",25.080076249313628,9.712198270069774,0.7734863107316025,0.19672981,"cytosol"),
c("GO:0005739","mitochondrion",2.7614025547937224,0.8174847766234796,0.6686276899774243,0.31329072,"cytosol"),
c("GO:0005743","mitochondrial inner membrane",1.0406713777958525,0.6320129249509026,0.6344982013873651,0.27931157,"cytosol"),
c("GO:0005815","microtubule organizing center",0.3898371819740286,0.8402265724221151,0.5738079413879651,0.48791131,"cytosol"),
c("GO:0005840","ribosome",3.532158825827589,1.1965859588668362,0.5620514141063774,0.44552985,"cytosol"),
c("GO:0016607","nuclear speck",0.12034475169089631,0.6323476142531599,0.6666573550419189,0.67516485,"cytosol"),
c("GO:0022626","cytosolic ribosome",0.16733799876776478,2.225450531816406,0.619312521157604,0.19794681,"cytosol"),
c("GO:0022627","cytosolic small ribosomal subunit",0.04412209333762864,0.7581217958942857,0.5856730945829696,0.56768904,"cytosol"),
c("GO:0042645","mitochondrial nucleoid",0.026099320595158945,0.3592981358654149,0.5713086043038466,0.55532522,"cytosol"),
c("GO:1904813","ficolin-1-rich granule lumen",0.00047217912953015893,0.3482828814118999,0.7626470585806502,0.4218692,"cytosol"),
c("GO:0005925","focal adhesion",0.05808184082841544,0.6203128607267697,0.9999361583505499,4.024E-05,"focal adhesion"),
c("GO:0030496","midbody",0.058599714712416255,0.3482828814118999,0.9999361148268767,4.028E-05,"midbody"),
c("GO:0042995","cell projection",1.3174825845867024,1.9243919499780942,0.9999159196679653,5.519E-05,"cell projection"),
c("GO:0043194","axon initial segment",0.001698321707826217,0.6861002027190221,0.9999497302637343,3.081E-05,"axon initial segment"));

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

