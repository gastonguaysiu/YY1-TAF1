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
revigo.data <- rbind(c("GO:0001701","in utero embryonic development",0.04501985596839224,0.3583078133651504,1,-0,"in utero embryonic development"),
c("GO:0006369","termination of RNA polymerase II transcription",0.01180128917442598,0.5899803839598696,0.8649079746520584,0.07958746,"termination of RNA polymerase II transcription"),
c("GO:0006886","intracellular protein transport",1.2951282894596792,2.0985858157732626,0.9298696612232588,0.00806503,"intracellular protein transport"),
c("GO:0006890","retrograde vesicle-mediated transport, Golgi to endoplasmic reticulum",0.08378316601313868,0.36597007489561084,0.9684906081120197,0.24133066,"intracellular protein transport"),
c("GO:0016192","vesicle-mediated transport",1.624410201635736,0.37605476125496795,0.960789405044848,0.32583524,"intracellular protein transport"),
c("GO:0007049","cell cycle",1.795399173617054,0.6693672683939471,0.988843398680461,0.01177661,"cell cycle"),
c("GO:0007059","chromosome segregation",0.3991184024540295,0.6693672683939471,0.9618685432825772,0.00990373,"chromosome segregation"),
c("GO:0000281","mitotic cytokinesis",0.03798165757688001,0.4117182024795607,0.9635171461953739,0.68434361,"chromosome segregation"),
c("GO:0009060","aerobic respiration",0.9867813586995857,2.2750283521511148,0.8680224540330497,0.02827325,"aerobic respiration"),
c("GO:0006120","mitochondrial electron transport, NADH to ubiquinone",0.029094102708202944,2.0985858157732626,0.8882772605896533,0.68918887,"aerobic respiration"),
c("GO:0042776","proton motive force-driven mitochondrial ATP synthesis",0.003998069218618948,1.3792076168745535,0.8210247108799377,0.59642557,"aerobic respiration"),
c("GO:0032968","positive regulation of transcription elongation by RNA polymerase II",0.02436759991314677,1.883351053273827,0.8182171148623684,-0,"positive regulation of transcription elongation by RNA polymerase II"),
c("GO:0006355","regulation of DNA-templated transcription",9.968929480711344,0.8325811924462906,0.84862856589148,0.39068986,"positive regulation of transcription elongation by RNA polymerase II"),
c("GO:0006974","DNA damage response",2.609069457039582,1.1278676183041196,0.9747918398793827,0.33152442,"positive regulation of transcription elongation by RNA polymerase II"),
c("GO:0051973","positive regulation of telomerase activity",0.006412876417219078,0.3583078133651504,0.8003726588094721,0.67671698,"positive regulation of transcription elongation by RNA polymerase II"),
c("GO:0060261","positive regulation of transcription initiation by RNA polymerase II",0.016920281293772536,0.6526118034348886,0.8215037408017646,0.65639382,"positive regulation of transcription elongation by RNA polymerase II"),
c("GO:0070131","positive regulation of mitochondrial translation",0.002730794366461029,0.3583078133651504,0.8422841771539191,0.50728722,"positive regulation of transcription elongation by RNA polymerase II"),
c("GO:0090261","positive regulation of inclusion body assembly",0.0001995708428595149,0.6526118034348886,0.8737344194953813,0.37787332,"positive regulation of transcription elongation by RNA polymerase II"),
c("GO:0097190","apoptotic signaling pathway",0.050029084124166054,1.1658471437924192,0.9044398581459272,0.15892347,"positive regulation of transcription elongation by RNA polymerase II"),
c("GO:1903706","regulation of hemopoiesis",0.04796352590057008,0.7327009462206036,0.925325685208994,0.1659839,"positive regulation of transcription elongation by RNA polymerase II"),
c("GO:2000779","regulation of double-strand break repair",0.025308909055300814,0.5666022166311145,0.86203944129146,0.24468504,"positive regulation of transcription elongation by RNA polymerase II"),
c("GO:0032981","mitochondrial respiratory chain complex I assembly",0.04205622895192844,3.175223537524454,0.8778087587524612,-0,"mitochondrial respiratory chain complex I assembly"),
c("GO:0006325","chromatin organization",1.0463199934860077,1.37600506557016,0.8527386480621064,0.57239293,"mitochondrial respiratory chain complex I assembly"),
c("GO:0006364","rRNA processing",1.1723523069325057,1.3792076168745535,0.7005072868772849,0.47325138,"mitochondrial respiratory chain complex I assembly"),
c("GO:0006397","mRNA processing",1.0320905923901242,0.6693672683939471,0.8046449273002863,0.68187522,"mitochondrial respiratory chain complex I assembly"),
c("GO:0008380","RNA splicing",0.7198287469292699,0.9418519621053295,0.8100988077492436,0.65568149,"mitochondrial respiratory chain complex I assembly"),
c("GO:0044085","cellular component biogenesis",4.796572117984153,0.37605476125496795,0.8766809607749757,0.57122417,"mitochondrial respiratory chain complex I assembly"),
c("GO:0051123","RNA polymerase II preinitiation complex assembly",0.013773714338020854,0.6059885274459371,0.7647107745692878,0.65771754,"mitochondrial respiratory chain complex I assembly"),
c("GO:0043161","proteasome-mediated ubiquitin-dependent protein catabolic process",0.3014484319585829,3.8013429130455774,0.8027310803541614,0,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0000209","protein polyubiquitination",0.10886589477986537,0.7284370450113977,0.8541062449815158,0.68690111,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0002181","cytoplasmic translation",0.12046428693071752,0.37605476125496795,0.7993705174419451,0.47198297,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0006412","translation",5.085673767131161,1.8401116250497624,0.7321215432595531,0.6800612,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0006413","translational initiation",0.5201814019133255,0.7198294595200041,0.7766479483807784,0.4536163,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0006550","isoleucine catabolic process",0.0008115880942953606,0.6526118034348886,0.895820794090295,0.40936375,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0016573","histone acetylation",0.0861713637660242,1.2648461813087424,0.8454403609157203,0.21222286,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0016579","protein deubiquitination",0.2889985375448635,1.1658471437924192,0.8173497117949042,0.4757202,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0032543","mitochondrial translation",0.07416385138731006,1.9685318000648768,0.8059781952862681,0.20977521,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0048511","rhythmic process",0.1080110663362838,0.6149796417809037,1,-0,"rhythmic process"),
c("GO:0051301","cell division",1.3834583445093005,0.7284370450113977,0.9891325264116817,0.01133076,"cell division"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_h1_hesc_promo_yy1_com_taf1_GO_BP.pdf", width=16, height=9 ) # width and height are in inches

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

