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
revigo.data <- rbind(c("GO:0000502","proteasome complex",0.4254333957066732,3.9281179926938745,0.5722719238618594,-0,"proteasome complex"),
c("GO:0000151","ubiquitin ligase complex",0.24068950338179262,1.2059627421579548,0.6130208288046207,0.60838668,"proteasome complex"),
c("GO:0019005","SCF ubiquitin ligase complex",0.043566140491568935,1.4744252236460644,0.639873086253554,0.52959938,"proteasome complex"),
c("GO:0030877","beta-catenin destruction complex",0.0018201743864146448,0.3242791881171437,0.7118285141550423,0.42689498,"proteasome complex"),
c("GO:0031466","Cul5-RING ubiquitin ligase complex",0.001698321707826217,0.5504832979050178,0.6931031463357767,0.67673163,"proteasome complex"),
c("GO:0032777","Piccolo NuA4 histone acetyltransferase complex",0.01665573800455577,1.091323237114541,0.49943223446698815,0.49363725,"proteasome complex"),
c("GO:0070776","MOZ/MORF histone acetyltransferase complex",0.0026502957592983113,0.5504832979050178,0.5471830541521652,0.66496179,"proteasome complex"),
c("GO:0005654","nucleoplasm",1.1886804954225278,30.866461091629784,0.5880883366790219,0,"nucleoplasm"),
c("GO:0005634","nucleus",12.339605699963672,14.991399828238082,0.6075701791868261,0.44231542,"nucleoplasm"),
c("GO:0005694","chromosome",1.8755754683141148,0.42730145944720804,0.6167795131408217,0.59262865,"nucleoplasm"),
c("GO:0005737","cytoplasm",25.080076249313628,3.446116973356126,0.7671085540526432,0.19672981,"nucleoplasm"),
c("GO:0005739","mitochondrion",2.7614025547937224,6.844663962534939,0.6577932408272119,0.31329072,"nucleoplasm"),
c("GO:0005743","mitochondrial inner membrane",1.0406713777958525,7.051098239029787,0.5213531491425458,0.27931157,"nucleoplasm"),
c("GO:0005759","mitochondrial matrix",0.33623723497994384,1.7486621824539834,0.5591571496654215,0.69547522,"nucleoplasm"),
c("GO:0005761","mitochondrial ribosome",0.09250522252964638,1.8723095523080993,0.48746763414489014,0.61686706,"nucleoplasm"),
c("GO:0005819","spindle",0.26436319409380066,0.6977936631511334,0.6721623089746043,0.46748776,"nucleoplasm"),
c("GO:0005829","cytosol",1.696303522837096,9.047207556955907,0.7745958903880885,0.12623137,"nucleoplasm"),
c("GO:0005840","ribosome",3.532158825827589,3.7351821769904636,0.5949362305184693,0.2457097,"nucleoplasm"),
c("GO:0005849","mRNA cleavage factor complex",0.04248089007289075,0.81243010914701,0.6201737933734625,0.52870552,"nucleoplasm"),
c("GO:0010008","endosome membrane",0.3759421687187419,0.81243010914701,0.6363257169771026,0.56728768,"nucleoplasm"),
c("GO:0016592","mediator complex",0.17997259837890242,1.7079154715813136,0.5839601101519544,0.46915668,"nucleoplasm"),
c("GO:0016607","nuclear speck",0.12034475169089631,2.5877188555007753,0.6384253243956097,0.67516485,"nucleoplasm"),
c("GO:0022626","cytosolic ribosome",0.16733799876776478,0.43309984242680377,0.6334331173883185,0.56768904,"nucleoplasm"),
c("GO:0022627","cytosolic small ribosomal subunit",0.04412209333762864,0.9119618214454386,0.5492496378728501,0.39187516,"nucleoplasm"),
c("GO:0032040","small-subunit processome",0.1049494273304896,0.7345190953861965,0.7391520417229476,0.41054201,"nucleoplasm"),
c("GO:0042382","paraspeckles",0.0011918715124430625,0.4847948015658288,0.7217054201990234,0.67955911,"nucleoplasm"),
c("GO:0042788","polysomal ribosome",0.005997436524274196,0.30906216004785236,0.6307735770613219,0.33201707,"nucleoplasm"),
c("GO:0043231","intracellular membrane-bounded organelle",20.560529937299183,1.2059627421579548,0.5888744446383591,0.67038262,"nucleoplasm"),
c("GO:0070847","core mediator complex",0.007109342216393603,1.8231705190515213,0.6572743280342217,0.26232671,"nucleoplasm"),
c("GO:0032991","protein-containing complex",14.950577315143775,1.424385015351863,1,-0,"protein-containing complex"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_h1_hesc_promo_yy1_com_taf1_GO_CC.pdf", width=16, height=9 ) # width and height are in inches

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

