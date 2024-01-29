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
revigo.data <- rbind(c("GO:0000281","mitotic cytokinesis",0.03798165757688001,1.337708249413569,0.97808026626314,0.00624624,"mitotic cytokinesis"),
c("GO:0006417","regulation of translation",1.455224019601582,2.912260702382041,0.7687159778049125,-0,"regulation of translation"),
c("GO:0000122","negative regulation of transcription by RNA polymerase II",0.15937394892689427,1.745657350403486,0.7597997192280842,0.64407053,"regulation of translation"),
c("GO:0006355","regulation of DNA-templated transcription",9.968929480711344,4.287350298372789,0.7551291217697346,0.66315541,"regulation of translation"),
c("GO:0006357","regulation of transcription by RNA polymerase II",1.917576443615649,1.6276130762243428,0.7863248506944192,0.47130783,"regulation of translation"),
c("GO:0030308","negative regulation of cell growth",0.02028637617666969,1.143621912174376,0.8340869804461113,0.46939566,"regulation of translation"),
c("GO:0032434","regulation of proteasomal ubiquitin-dependent protein catabolic process",0.031864811243235876,1.0297001816134541,0.8194418982386198,0.61491618,"regulation of translation"),
c("GO:0032465","regulation of cytokinesis",0.027381119640325444,1.4941131269366583,0.8668230066310934,0.20349422,"regulation of translation"),
c("GO:0033235","positive regulation of protein sumoylation",0.0034359446778979815,1.281735261040475,0.7883860697916998,0.5515547,"regulation of translation"),
c("GO:0042752","regulation of circadian rhythm",0.03276953239753235,1.4089112234137102,0.8909735385479695,0.19045467,"regulation of translation"),
c("GO:0045944","positive regulation of transcription by RNA polymerase II",0.36927923526581774,2.6462249215945186,0.712202519924492,0.39233943,"regulation of translation"),
c("GO:0046604","positive regulation of mitotic centrosome separation",0.0004989271071487873,1.0764128372167951,0.8203921102680777,0.56373359,"regulation of translation"),
c("GO:0048025","negative regulation of mRNA splicing, via spliceosome",0.0026742492943174997,1.56289093775834,0.8060251683713593,0.41824073,"regulation of translation"),
c("GO:0048147","negative regulation of fibroblast proliferation",0.0038616958093316135,1.0472771694440752,0.854683182643681,0.42667266,"regulation of translation"),
c("GO:0050793","regulation of developmental process",1.1712047745860634,1.1689290142824906,0.8603167266500216,0.26895062,"regulation of translation"),
c("GO:0051726","regulation of cell cycle",0.5059719579017281,2.6881344319265983,0.8598289083317413,0.26586165,"regulation of translation"),
c("GO:0060261","positive regulation of transcription initiation by RNA polymerase II",0.016920281293772536,1.0473056473626572,0.7588675040748184,0.68497864,"regulation of translation"),
c("GO:0070131","positive regulation of mitochondrial translation",0.002730794366461029,1.0297001816134541,0.7752113141907089,0.5928852,"regulation of translation"),
c("GO:1902268","negative regulation of polyamine transmembrane transport",0.0003958155050047046,1.0764128372167951,0.8613936660583962,0.41273748,"regulation of translation"),
c("GO:1903706","regulation of hemopoiesis",0.04796352590057008,2.4827947785071953,0.8719494872695038,0.21310267,"regulation of translation"),
c("GO:1903955","positive regulation of protein targeting to mitochondrion",0.0009280044192967442,1.0750585651051636,0.8165787630326942,0.55290978,"regulation of translation"),
c("GO:1904780","negative regulation of protein localization to centrosome",0.0003392704328611753,1.2462520320406578,0.8601738521329966,0.37643981,"regulation of translation"),
c("GO:1905168","positive regulation of double-strand break repair via homologous recombination",0.00515890628791846,1.5989121697168114,0.7129486940399942,0.65588704,"regulation of translation"),
c("GO:1990117","B cell receptor apoptotic signaling pathway",0.00027939918000332084,1.2462520320406578,0.7991142694623921,0.56865293,"regulation of translation"),
c("GO:2000001","regulation of DNA damage checkpoint",0.002867167775748364,1.1689290142824906,0.8276238587117015,0.61655324,"regulation of translation"),
c("GO:2000278","regulation of DNA biosynthetic process",0.017798393002354404,2.611768701617751,0.7846369926999193,0.29985158,"regulation of translation"),
c("GO:2001234","negative regulation of apoptotic signaling pathway",0.0314723219189455,1.7991912664243022,0.7975333272596887,0.20579924,"regulation of translation"),
c("GO:0006974","DNA damage response",2.609069457039582,1.2959654260830755,0.9748548535542044,0.01354138,"DNA damage response"),
c("GO:0006301","postreplication repair",0.03848723704545745,1.222943272451278,0.901963234887208,0.58229376,"DNA damage response"),
c("GO:0007049","cell cycle",1.795399173617054,2.944736981230697,0.9914231717433147,0.01287476,"cell cycle"),
c("GO:0015031","protein transport",2.808294377104807,3.987162775294828,0.9261569453118027,0.00861517,"protein transport"),
c("GO:0006890","retrograde vesicle-mediated transport, Golgi to endoplasmic reticulum",0.08378316601313868,1.2316877111771911,0.9481304839367354,0.63464813,"protein transport"),
c("GO:0006897","endocytosis",0.33861850144116756,1.502436819420629,0.9437871306870457,0.54750023,"protein transport"),
c("GO:0006904","vesicle docking involved in exocytosis",0.010969743995844668,1.756220920386354,0.9487199919436986,0.21738613,"protein transport"),
c("GO:0016197","endosomal transport",0.1617255586919222,1.130157076970078,0.9154310906313777,0.6691001,"protein transport"),
c("GO:0051457","maintenance of protein location in nucleus",0.0036721035086150744,1.222943272451278,0.9517942803292374,0.49116876,"protein transport"),
c("GO:0019827","stem cell population maintenance",0.021094638090250726,1.068339871451036,1,-0,"stem cell population maintenance"),
c("GO:0032981","mitochondrial respiratory chain complex I assembly",0.04205622895192844,4.015472686656207,0.8946555605091244,-0,"mitochondrial respiratory chain complex I assembly"),
c("GO:0000028","ribosomal small subunit assembly",0.016075431392333923,1.119049489834079,0.8877942979190356,0.61502811,"mitochondrial respiratory chain complex I assembly"),
c("GO:0000045","autophagosome assembly",0.04711202363770282,1.7868124856488414,0.8365432486331215,0.46206278,"mitochondrial respiratory chain complex I assembly"),
c("GO:0006325","chromatin organization",1.0463199934860077,3.7399286120149253,0.8803915648899395,0.57239293,"mitochondrial respiratory chain complex I assembly"),
c("GO:0036258","multivesicular body assembly",0.0027540776314613053,1.2310850667182038,0.9115806337318879,0.55528009,"mitochondrial respiratory chain complex I assembly"),
c("GO:0042274","ribosomal small subunit biogenesis",0.2330189161227696,1.7060281572606504,0.9091397727184362,0.41798809,"mitochondrial respiratory chain complex I assembly"),
c("GO:0051123","RNA polymerase II preinitiation complex assembly",0.013773714338020854,1.0067603812539392,0.8066996871197775,0.65771754,"mitochondrial respiratory chain complex I assembly"),
c("GO:0061025","membrane fusion",0.11522887848636958,1.0750585651051636,0.9215636470330831,0.32386461,"mitochondrial respiratory chain complex I assembly"),
c("GO:0043161","proteasome-mediated ubiquitin-dependent protein catabolic process",0.3014484319585829,5.623423042943488,0.8632052369925163,0,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0000209","protein polyubiquitination",0.10886589477986537,2.5775678224661975,0.8650487782820949,0.32662257,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0000398","mRNA splicing, via spliceosome",0.5066438464060219,3.638272163982407,0.8516096609774836,0.1065696,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0002181","cytoplasmic translation",0.12046428693071752,3.54515513999149,0.8513773440309708,0.35080404,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0006121","mitochondrial electron transport, succinate to ubiquinone",0.006343026622218249,2.107839048260512,0.8724370042659007,0.60076075,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0006261","DNA-templated DNA replication",0.5186580111461646,1.7147933354451648,0.9000212052608727,0.2542359,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0006369","termination of RNA polymerase II transcription",0.01180128917442598,1.222943272451278,0.8994766490245317,0.24139386,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0006412","translation",5.085673767131161,4.610833915635467,0.7991007977059039,0.6800612,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0006413","translational initiation",0.5201814019133255,1.684318996797658,0.8341538743568773,0.47198297,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0006744","ubiquinone biosynthetic process",0.17058317793417038,2.0794413928310567,0.943282976113405,0.19403994,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0008033","tRNA processing",1.448545048727217,1.5628347982914805,0.8409624011282476,0.67081018,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0008380","RNA splicing",0.7198287469292699,2.063772717900451,0.8521027329845267,0.60185152,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0016573","histone acetylation",0.0861713637660242,3.1567672219019904,0.822159011397225,0.21222286,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0016579","protein deubiquitination",0.2889985375448635,2.358365341631879,0.8440160668011241,0.68690111,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0032543","mitochondrial translation",0.07416385138731006,2.1890846096571215,0.8563477746070093,0.40597483,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0042776","proton motive force-driven mitochondrial ATP synthesis",0.003998069218618948,2.5873048182610283,0.8295826010532534,0.14292941,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0045333","cellular respiration",1.1686502677974617,2.1644769405463893,0.8500735331501653,0.58173842,"proteasome-mediated ubiquitin-dependent protein catabolic process"),
c("GO:0048511","rhythmic process",0.1080110663362838,2.6767702821189863,1,-0,"rhythmic process"),
c("GO:0051301","cell division",1.3834583445093005,2.342316035005088,0.991634884765069,0.01244746,"cell division"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_gm12878_promo_taf1_exclu_yy1_GO_BP.pdf", width=16, height=9 ) # width and height are in inches

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

