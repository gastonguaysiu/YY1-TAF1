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
revigo.data <- rbind(c("GO:0003682","chromatin binding",0.16732037639034544,1.2810390194229597,0.9298774233577733,0.04023438,"chromatin binding"),
c("GO:0003712","transcription coregulator activity",0.3252911454641982,4.534617148551582,0.9710941461167302,0,"transcription coregulator activity"),
c("GO:0003713","transcription coactivator activity",0.09842423156688958,1.7955329367256347,0.9662084634891366,0.45369605,"transcription coregulator activity"),
c("GO:0003729","mRNA binding",0.29463794571910035,3.5346171485515816,0.8777513630086524,-0,"mRNA binding"),
c("GO:0000049","tRNA binding",0.6659470302247306,1.9473660835771627,0.8695513759460556,0.51683489,"mRNA binding"),
c("GO:0003676","nucleic acid binding",20.02236659265439,1.3743674636657726,0.9110193465760058,0.14945237,"mRNA binding"),
c("GO:0003677","DNA binding",11.827531128307996,1.845556293669315,0.8716514159701411,0.50546017,"mRNA binding"),
c("GO:0003723","RNA binding",5.208567618365157,15.067526235322847,0.8823164303588459,0.29293784,"mRNA binding"),
c("GO:0019843","rRNA binding",1.1598689137107523,1.3626763800629254,0.8634631624014341,0.59163245,"mRNA binding"),
c("GO:0070034","telomerase RNA binding",0.0034189269178899616,1.5583006847808745,0.9097276318351765,0.34771249,"mRNA binding"),
c("GO:0003735","structural constituent of ribosome",2.2675249562595297,4.136677139879544,1,-0,"structural constituent of ribosome"),
c("GO:0003954","NADH dehydrogenase activity",0.32917591820117914,1.3069250570849735,0.9275144709231216,0.03785151,"NADH dehydrogenase activity"),
c("GO:0009055","electron transfer activity",1.0711593382308713,1.2393045887849272,0.9241923530961443,0.36915601,"NADH dehydrogenase activity"),
c("GO:0005515","protein binding",5.073796515930947,19.18775530319963,0.9483482941058516,0.0653582,"protein binding"),
c("GO:0016887","ATP hydrolysis activity",3.291701972876113,2.6581600637685003,0.9539505851984266,0.02335563,"ATP hydrolysis activity"),
c("GO:0004553","hydrolase activity, hydrolyzing O-glycosyl compounds",1.5818244287586074,1.2500130436661525,0.9561389875900752,0.3213983,"ATP hydrolysis activity"),
c("GO:0004843","cysteine-type deubiquitinase activity",0.2535127499004016,1.1887340614290811,0.8809766701781183,0.2587386,"ATP hydrolysis activity"),
c("GO:0019888","protein phosphatase regulator activity",0.11426026517142691,3.1079053973095196,0.9455881182821937,-0,"protein phosphatase regulator activity"),
c("GO:0008073","ornithine decarboxylase inhibitor activity",0.005135200988225161,1.0553524132903835,0.9525322700080946,0.49254431,"protein phosphatase regulator activity"),
c("GO:0030234","enzyme regulator activity",1.5523481026617394,1.6440267210399946,0.9434240548285003,0.69367291,"protein phosphatase regulator activity"),
c("GO:0036408","histone H3K14 acetyltransferase activity",0.0011387342244446245,2.6950667469367113,0.7879145207818383,0.00571275,"histone H3K14 acetyltransferase activity"),
c("GO:0004842","ubiquitin-protein transferase activity",0.5662887158739333,1.380423339201015,0.8168311587304014,0.39366484,"histone H3K14 acetyltransferase activity"),
c("GO:0008545","JUN kinase kinase activity",0.00023973352093571045,1.224870123310817,0.9056939351494642,0.16188508,"histone H3K14 acetyltransferase activity"),
c("GO:0016301","kinase activity",6.264659159956308,1.1964295441067287,0.8977170998342332,0.28869277,"histone H3K14 acetyltransferase activity"),
c("GO:0016407","acetyltransferase activity",0.444149935446301,1.0814997953734706,0.8209794260230179,0.61543738,"histone H3K14 acetyltransferase activity"),
c("GO:0043996","histone H4K8 acetyltransferase activity",0.001285843430473356,2.421493962555371,0.7712568259455502,0.64161103,"histone H3K14 acetyltransferase activity"),
c("GO:0043130","ubiquitin binding",0.11891872336233673,2.511156942075064,0.8422841643731647,0.03914066,"ubiquitin binding"),
c("GO:0000993","RNA polymerase II complex binding",0.01807536262964135,1.2137537936498615,0.8582872108565074,0.36863838,"ubiquitin binding"),
c("GO:0017025","TBP-class protein binding",0.03720228365793252,1.2879224189884289,0.8121500604847078,0.3868251,"ubiquitin binding"),
c("GO:0035064","methylated histone binding",0.01422055658277737,1.0772361879759549,0.8367955530034492,0.36296765,"ubiquitin binding"),
c("GO:0042393","histone binding",0.08839356311137497,1.5454328026773643,0.8450061546036869,0.41114437,"ubiquitin binding"),
c("GO:0045296","cadherin binding",0.0192522362778712,1.7404093500022786,0.8577985838025238,0.37015918,"ubiquitin binding"),
c("GO:0051539","4 iron, 4 sulfur cluster binding",1.0655855338691158,1.3029211139685102,0.9561504260066908,0.04741829,"4 iron, 4 sulfur cluster binding"),
c("GO:0060090","molecular adaptor activity",0.20342206524761858,1.6253249058826162,1,-0,"molecular adaptor activity"),
c("GO:1904047","S-adenosyl-L-methionine binding",0.04468033496439303,1.6696355964949257,0.9664244594931947,0.03631102,"S-adenosyl-L-methionine binding"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_gm12878_promo_taf1_exclu_yy1_GO_MF.pdf", width=16, height=9 ) # width and height are in inches

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

