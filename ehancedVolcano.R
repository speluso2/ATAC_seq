
BiocManager::install('EnhancedVolcano')
library("EnhancedVolcano")
library(airway)
library(magrittr)

data2<-"speluso/genes2.txt"
datas2 <- read.csv(file = data2, sep="\t",na.strings = "\t", row.names=1)


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

