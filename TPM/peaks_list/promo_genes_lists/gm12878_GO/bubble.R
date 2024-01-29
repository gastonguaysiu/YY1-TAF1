# Load ggplot2 package
library(ggplot2)

df <- read.csv("start.csv")
colnames(df) <- c("Category", "Term", "Count", "percent", "p_val", "Benjamini", "convergence")

# Subset the data frame for each of the three GO enrichment type, and one for KEGG pathways
df_BP <- subset(df, Category == "GOTERM_BP_DIRECT")
df_CC <- subset(df, Category == "GOTERM_CC_DIRECT")
df_MF <- subset(df, Category == "GOTERM_MF_DIRECT")
df_KEGG <- subset(df, Category == "KEGG_PATHWAY")

# Create bubble plot
ggplot(data = df_BP, aes(x = convergence, y = Term, size = percent, fill = p_val )) +
  geom_point(shape = 21) +
  scale_fill_gradient(low = "blue", high = "red") +
  labs(x = "convergence set", y = "GO biological processes term", size = "percent", fill = "p value",
       caption = "percent = number of associated genes on list found in David / all genes listed found in David") +
  theme(legend.position = "right", axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(data = df_CC, aes(x = convergence, y = Term, size = percent, fill = p_val )) +
  geom_point(shape = 21) +
  scale_fill_gradient(low = "blue", high = "red") +
  labs(x = "convergence set", y = "GO cellular components term", size = "percent", fill = "p value",
       caption = "percent = number of associated genes on list found in David / all genes listed found in David") +
  theme(legend.position = "right", axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(data = df_MF, aes(x = convergence, y = Term, size = percent, fill = p_val )) +
  geom_point(shape = 21) +
  scale_fill_gradient(low = "blue", high = "red") +
  labs(x = "convergence set", y = "GO molecular functions term", size = "percent", fill = "p value",
       caption = "percent = number of associated genes on list found in David / all genes listed found in David") +
  theme(legend.position = "right", axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(data = df_KEGG, aes(x = convergence, y = Term, size = percent, fill = p_val )) +
  geom_point(shape = 21) +
  scale_fill_gradient(low = "blue", high = "red") +
  labs(x = "convergence set", y = "KEGG pathways term", size = "percent", fill = "p value",
       caption = "percent = number of associated genes on list found in David / all genes listed found in David") +
  theme(legend.position = "right", axis.text.x = element_text(angle = 90, hjust = 1))
