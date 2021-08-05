
install.packages('VennDiagram')
library('VennDiagram')
grid.newpage()
draw.pairwise.venn(7841+23450,7841+13574,7841, category = c("dist CUT", "dist ATAC"), fill = c("pink", "grey"), lty = rep("blank", 2), alpha = rep(0.5, 2), cat.pos = c(0, 0), cat.dist = rep(0.025, 2), scaled = TRUE)

BiocManager::install('EnhancedVolcano')
library("EnhancedVolcano")
library(airway)
library(magrittr)
EnhancedVolcano(datas2,
                lab = rownames(datas2),
                x = 'log2FoldChange',
                y = 'pvalue',
                xlim = c(-5, 8))
EnhancedVolcano(datas2,
                lab = rownames(datas2),
                x = 'log2FoldChange',
                y = 'padj',
                selectLab = c("Shh", "Hand2", "Twist1", "Isl1", "Fgf4"),
                xlim = c(-8,3), #ylim = c(0, 100),
                ylim = c(0,-log10(10e-40)),
                title = 'CPC wt versus CPC isl1 KO',
                subtitle = "Differential expression",
                caption = "FC cutoff, 1.4; padj (adj. p-value) cutoff, 5e-40",
                captionLabSize = 10,
                titleLabSize = 14,
                drawConnectors = TRUE,
                widthConnectors = 2.0,
                lengthConnectors = unit(2, 'npc'),
                colConnectors = 'black',
                pCutoff = 0.0005,
                FCcutoff = 1.4,
                col=c('grey', 'yellow', 'green', 'orange'),
                colAlpha = 1,
                legendPosition = 'right',
                legendLabSize = 10)

rownames(datas2) = 1:SYMBOL(datas2)

dat<-rownames(datas2) <- t(datas2[2])

read.table(data2, row.names=2)


celltype1 <- datas2[SYMBOL$""]

data<-"/Users/speluso2/Downloads/fromNAtureIsl1pioneer/genes.txt"
datas <- read.csv(file = data, sep="\t",na.strings = "\t",)

data2[!duplicated(data2[, c("SYMBOL")]), ]

data2<-"/Users/speluso2/Downloads/fromNAtureIsl1pioneer/genes2.txt"
datas2 <- read.csv(file = data2, sep="\t",na.strings = "\t", row.names=1)
 
top_genes<-datas[which(datas$pvalue < 0.05 ),]

top <-datas2[datas2$extra]

top_genes2 <-datas2[which(datas2$padj < 0.05 ),]

ggplot(data=top_genes2, aes(x=padj, y=log2FoldChange ,)) +geom_point(aes(colour=pvalue))+geom_text_repel(aes(label=ifelse(pvalue<=1.5, as.character(extra),'')),colour="red", size=4,  hjust=0.25)

ggplot(data=top_genes, aes(x=pvalue, y=log2FoldChange))+geom_point()+geom_text(aes(label=ifelse(log2FoldChange>=1.5,as.character(SYMBOL),'')))


+geom_point(aes(colour=pvalue))
data2 <- datas[symbol,  pvalue]
scale_color_jco()

row.names=1

ggplot(data=datas, aes(x=SYMBOL, y=log2FoldChange))+
  geom_point()

library('DESeq2')