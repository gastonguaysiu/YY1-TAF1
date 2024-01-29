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
revigo.data <- rbind(c("GO:0000502","proteasome complex",0.4254333957066732,5.447331783887806,0.659140051589556,-0,"proteasome complex"),
c("GO:0000123","histone acetyltransferase complex",0.16499995049734933,2.908433177193801,0.4876327870465456,0.58902981,"proteasome complex"),
c("GO:0000151","ubiquitin ligase complex",0.24068950338179262,2.303235709672473,0.6922194072682268,0.62976216,"proteasome complex"),
c("GO:0000159","protein phosphatase type 2A complex",0.0531125362797311,1.1082108673160926,0.7538558606882451,0.43578966,"proteasome complex"),
c("GO:0000791","euchromatin",0.010574527763752027,1.043839353676281,0.6347807689176587,0.63136226,"proteasome complex"),
c("GO:0005681","spliceosomal complex",0.39025605055667634,1.8728026046064299,0.5498579508632889,0.55553907,"proteasome complex"),
c("GO:0005697","telomerase holoenzyme complex",0.005609031111273581,1.6679214547799566,0.6037278197432201,0.37154209,"proteasome complex"),
c("GO:0016592","mediator complex",0.17997259837890242,1.5259329509933213,0.6009456976167991,0.62751826,"proteasome complex"),
c("GO:0017053","transcription repressor complex",0.053390512702760955,1.043839353676281,0.8092202118222505,0.62659127,"proteasome complex"),
c("GO:0030014","CCR4-NOT complex",0.0884650446551988,1.205086208258947,0.741203878488203,0.55963345,"proteasome complex"),
c("GO:0030877","beta-catenin destruction complex",0.0018201743864146448,1.318629665323308,0.770894333584815,0.42689498,"proteasome complex"),
c("GO:0070847","core mediator complex",0.007109342216393603,1.4753536290939346,0.6618870092585297,0.42772361,"proteasome complex"),
c("GO:0071013","catalytic step 2 spliceosome",0.03868060965941415,3.6675615400843946,0.5589110636093394,0.42541393,"proteasome complex"),
c("GO:1990904","ribonucleoprotein complex",4.368586074828206,1.3890398164792315,0.7545246290877988,0.37629648,"proteasome complex"),
c("GO:0005622","intracellular anatomical structure",40.53151376821032,2.121430035250827,0.9998697052010858,8.695E-05,"intracellular anatomical structure"),
c("GO:0005654","nucleoplasm",1.1886804954225278,32.28232949699774,0.5716307512954915,0,"nucleoplasm"),
c("GO:0000139","Golgi membrane",0.7837564286807696,2.781470415884146,0.5933031706456618,0.61155785,"nucleoplasm"),
c("GO:0000407","phagophore assembly site",0.07174076451893704,1.1824471358102608,0.8211344097562637,0.18313206,"nucleoplasm"),
c("GO:0005634","nucleus",12.339605699963672,21.138465589140964,0.609270805380286,0.44231542,"nucleoplasm"),
c("GO:0005694","chromosome",1.8755754683141148,2.633791659950755,0.6103517575858302,0.59262865,"nucleoplasm"),
c("GO:0005737","cytoplasm",25.080076249313628,7.638272163982407,0.7723535182545029,0.19672981,"nucleoplasm"),
c("GO:0005739","mitochondrion",2.7614025547937224,10.818156412055227,0.657914812142418,0.31329072,"nucleoplasm"),
c("GO:0005743","mitochondrial inner membrane",1.0406713777958525,9.469800301796917,0.5508158023082708,0.27931157,"nucleoplasm"),
c("GO:0005759","mitochondrial matrix",0.33623723497994384,3.8013429130455774,0.5701622005834696,0.69547522,"nucleoplasm"),
c("GO:0005761","mitochondrial ribosome",0.09250522252964638,3.288192770958809,0.4966826646292555,0.61686706,"nucleoplasm"),
c("GO:0005783","endoplasmic reticulum",2.123313387573007,1.4668021455347722,0.6061604622039438,0.6694422,"nucleoplasm"),
c("GO:0005819","spindle",0.26436319409380066,2.0882438117358193,0.6516565730453109,0.46748776,"nucleoplasm"),
c("GO:0005829","cytosol",1.696303522837096,14.1890957193313,0.7691318205919004,0.12623137,"nucleoplasm"),
c("GO:0005840","ribosome",3.532158825827589,4.412289034981089,0.5882920275556345,0.2457097,"nucleoplasm"),
c("GO:0010494","cytoplasmic stress granule",0.02641918387645357,3.5543957967264026,0.6914274755105242,0.37452242,"nucleoplasm"),
c("GO:0016607","nuclear speck",0.12034475169089631,3.571865205971211,0.6267762372033798,0.67516485,"nucleoplasm"),
c("GO:0022626","cytosolic ribosome",0.16733799876776478,2.986945019554576,0.638753036028127,0.56768904,"nucleoplasm"),
c("GO:0022627","cytosolic small ribosomal subunit",0.04412209333762864,4.425968732272281,0.5686250723524515,0.39187516,"nucleoplasm"),
c("GO:0034774","secretory granule lumen",0.004165838449241886,1.3890445549474715,0.6559423281682086,0.48513692,"nucleoplasm"),
c("GO:0042788","polysomal ribosome",0.005997436524274196,1.246762527800988,0.64240564258012,0.33201707,"nucleoplasm"),
c("GO:0043231","intracellular membrane-bounded organelle",20.560529937299183,4.319664486585437,0.5910461754455936,0.67038262,"nucleoplasm"),
c("GO:0045111","intermediate filament cytoskeleton",0.213622977150338,1.1051566901250234,0.6597390799562619,0.60048816,"nucleoplasm"),
c("GO:0098830","presynaptic endosome",0.0005407212612361498,1.0963789984837302,0.7554924209520876,0.15175885,"nucleoplasm"),
c("GO:1904813","ficolin-1-rich granule lumen",0.00047217912953015893,1.2449864930550636,0.6913036017316457,0.64876814,"nucleoplasm"),
c("GO:0016020","membrane",61.57163680895251,1.0415076169144097,0.9998596077830212,0.00033423,"membrane"),
c("GO:0032991","protein-containing complex",14.950577315143775,1.7101484156265883,1,-0,"protein-containing complex"),
c("GO:0090543","Flemming body",0.004866491351125348,1.094703581775332,0.9999487630704984,3.23E-05,"Flemming body"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_gm12878_promo_taf1_exclu_yy1_GO_CC.pdf", width=16, height=9 ) # width and height are in inches

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

