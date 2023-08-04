
# set mirror
options("repos"=c(CRAN="https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
options(BioC_mirror="https://mirrors.tuna.tsinghua.edu.cn/bioconductor")

# set compiler options for speed
options(Ncpus=40L)
Sys.setenv(MAKEFLAGS="-j 40")


################################################
# install CRAN packages
################################################
if(!requireNamespace("tidyr",quietly = TRUE)) install.packages("tidyr",update = F,ask = F)
if(!requireNamespace("dplyr",quietly = TRUE)) install.packages("dplyr",update = F,ask = F)
if(!requireNamespace("stringr",quietly = TRUE)) install.packages("stringr",update = F,ask = F)
if(!requireNamespace("stringi",quietly = TRUE)) install.packages("stringi",update = F,ask = F)
if(!requireNamespace("viridisLite",quietly = TRUE)) install.packages("viridisLite",update = F,ask = F)
if(!requireNamespace("ggplot2",quietly = TRUE)) install.packages("ggplot2",update = F,ask = F)
if(!requireNamespace("data.table",quietly = TRUE)) install.packages("data.table",update = F,ask = F)
if(!requireNamespace("ggrepel",quietly = TRUE)) install.packages("ggrepel",update = F,ask = F)
if(!requireNamespace("devtools",quietly = TRUE)) install.packages("devtools",update = F,ask = F)
if(!requireNamespace("pheatmap",quietly = TRUE)) install.packages("pheatmap",update = F,ask = F)
if(!requireNamespace("ggfortify",quietly = TRUE)) install.packages("ggfortify",update = F,ask = F)
if(!requireNamespace("survival",quietly = TRUE)) install.packages("survival",update = F,ask = F)
if(!requireNamespace("survminer",quietly = TRUE)) install.packages("survminer",update = F,ask = F)
if(!requireNamespace("glmnet",quietly = TRUE)) install.packages("glmnet",update = F,ask = F)
if(!requireNamespace("ggpubr",quietly = TRUE)) install.packages("ggpubr",update = F,ask = F)
if(!requireNamespace("ggsignif",quietly = TRUE)) install.packages("ggsignif",update = F,ask = F)
if(!requireNamespace("tibble",quietly = TRUE)) install.packages("tibble",update = F,ask = F)
if(!requireNamespace("cowplot",quietly = TRUE)) install.packages("cowplot",update = F,ask = F)
if(!requireNamespace("xfun",quietly = TRUE)) install.packages("xfun",update = F,ask = F)
if(!requireNamespace("randomForest",quietly = TRUE)) install.packages("randomForest",update = F,ask = F)
if(!requireNamespace("Hmisc",quietly = TRUE)) install.packages("Hmisc",update = F,ask = F)
if(!requireNamespace("jsonlite",quietly = TRUE)) install.packages("jsonlite",update = F,ask = F)
if(!requireNamespace("corrplot",quietly = TRUE)) install.packages("corrplot",update = F,ask = F)
if(!requireNamespace("R.utils",quietly = TRUE)) install.packages("R.utils",update = F,ask = F)
if(!requireNamespace("purrr",quietly = TRUE)) install.packages("purrr",update = F,ask = F)
if(!requireNamespace("future.apply",quietly = TRUE)) install.packages("future.apply",update = F,ask = F)
if(!requireNamespace("rngtools",quietly = TRUE)) install.packages("rngtools",update = F,ask = F)
if(!requireNamespace("bigmemory",quietly = TRUE)) install.packages("bigmemory",update = F,ask = F)
if(!requireNamespace("caret",quietly = TRUE)) install.packages("caret",update = F,ask = F)
if(!requireNamespace("forcats",quietly = TRUE)) install.packages("forcats",update = F,ask = F)
if(!requireNamespace("GOplot",quietly = TRUE)) install.packages("GOplot",update = F,ask = F)
if(!requireNamespace("ggupset",quietly = TRUE)) install.packages("ggupset",update = F,ask = F)
if(!requireNamespace("XML",quietly = TRUE)) install.packages("XML",update=F, ask=F)
if(!requireNamespace("png",quietly = TRUE)) install.packages("png",update = F,ask = F)
if(!requireNamespace("msigdbr",quietly = TRUE)) install.packages("msigdbr",update = F,ask = F)
if(!requireNamespace("table1",quietly = TRUE)) install.packages("table1",update = F,ask = F)
if(!requireNamespace("ggExtra",quietly = TRUE)) install.packages("ggExtra",update = F,ask = F)
if(!requireNamespace("patchwork",quietly = TRUE)) install.packages("patchwork",update = F,ask = F)
if(!requireNamespace("ggstatsplot",quietly = TRUE)) install.packages("ggstatsplot",update = F,ask = F)
if(!requireNamespace("dendextend",quietly = TRUE)) install.packages("dendextend",update = F,ask = F)
if(!requireNamespace("factoextra",quietly = TRUE)) install.packages("factoextra",update = F,ask = F)
if(!requireNamespace("NMF",quietly = TRUE)) install.packages("NMF",update = F,ask = F)


if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager",update=FALSE, ask=FALSE)
}
if (!requireNamespace("assertthat", quietly = TRUE)) {
  install.packages("assertthat",update=FALSE, ask=FALSE)
}

if (!requireNamespace("Seurat", quietly = TRUE)) {
  install.packages("Seurat",update=FALSE, ask=FALSE)
}
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes",update=FALSE, ask=FALSE)
}
if (!requireNamespace("terra", quietly = TRUE)) {
  install.packages("terra",update=FALSE, ask=FALSE)
}
if (!requireNamespace("SCINA", quietly = TRUE)) {
  install.packages('SCINA',update=FALSE, ask=FALSE)
}
if (!requireNamespace("htmlwidgets", quietly = TRUE)) {
  install.packages("htmlwidgets",update=FALSE, ask=FALSE)
}
if (!requireNamespace("ggrastr", quietly = TRUE)) {
  install.packages("ggrastr",update=FALSE, ask=FALSE)
}
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr",update=FALSE, ask=FALSE)
}
if (!requireNamespace("tidyr", quietly = TRUE)) {
  install.packages("tidyr",update=FALSE, ask=FALSE)
}
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2",update=FALSE, ask=FALSE)
}
if (!requireNamespace("scCustomize", quietly = TRUE)) {
  install.packages("scCustomize",update=FALSE, ask=FALSE)
}
if (!requireNamespace("ggalluvial", quietly = TRUE)) {
  install.packages("ggalluvial",update=FALSE, ask=FALSE)
}
if (!requireNamespace("harmony", quietly = TRUE)) {
  install.packages("harmony",update=FALSE, ask=FALSE)
}
if (!requireNamespace("patchwork", quietly = TRUE)) {
  install.packages('patchwork',update=FALSE, ask=FALSE)
}
if (!requireNamespace("cowplot", quietly = TRUE)) {
  install.packages('cowplot',update=FALSE, ask=FALSE)
}
if (!requireNamespace("clustree", quietly = TRUE)) {
  install.packages('clustree',update=FALSE, ask=FALSE)
}
if (!requireNamespace("grr", quietly = TRUE)) {
  install.packages("grr",update=FALSE, ask=FALSE)
}
if (!requireNamespace("leidenbase", quietly = TRUE)) {
  install.packages("leidenbase",update=FALSE, ask=FALSE)
}
if (!requireNamespace("lme4", quietly = TRUE)) {
  install.packages("lme4",update=FALSE, ask=FALSE)
}
if (!requireNamespace("pbmcapply", quietly = TRUE)) {
  install.packages("pbmcapply",update=FALSE, ask=FALSE)
}
if (!requireNamespace("pscl", quietly = TRUE)) {
  install.packages("pscl",update=FALSE, ask=FALSE)
}
if (!requireNamespace("rsample", quietly = TRUE)) {
  install.packages("rsample",update=FALSE, ask=FALSE)
}
if (!requireNamespace("RhpcBLASctl", quietly = TRUE)) {
  install.packages("RhpcBLASctl",update=FALSE, ask=FALSE)
}
if (!requireNamespace("slam", quietly = TRUE)) {
  install.packages("slam",update=FALSE, ask=FALSE)
}
if (!requireNamespace("spdep", quietly = TRUE)) {
  install.packages("spdep",update=FALSE, ask=FALSE)
}
if (!requireNamespace("speedglm", quietly = TRUE)) {
  install.packages("speedglm",update=FALSE, ask=FALSE)
}
if (!requireNamespace("hdf5r", quietly = TRUE)) {
  install.packages("hdf5r",update=FALSE, ask=FALSE)
}


################################################
# install Bioconductor packages
################################################

if(!requireNamespace("limma",quietly = TRUE)) BiocManager::install("limma",update = F,ask = F)
if(!requireNamespace("Biobase",quietly = TRUE)) BiocManager::install("Biobase",update = F,ask = F)
if(!requireNamespace("IRanges",quietly = TRUE)) BiocManager::install("IRanges",update = F,ask = F)
if(!requireNamespace("GenomeInfoDbData",quietly = TRUE)) BiocManager::install("GenomeInfoDbData",update = F,ask = F)
if(!requireNamespace("DO.db",quietly = TRUE)) BiocManager::install("DO.db",update = F,ask = F)
if(!requireNamespace("GO.db",quietly = TRUE)) BiocManager::install("GO.db",update = F,ask = F)
if(!requireNamespace("fgsea",quietly = TRUE)) BiocManager::install("fgsea",update = F,ask = F)
if(!requireNamespace("gridGraphics",quietly = TRUE)) BiocManager::install("gridGraphics",update = F,ask = F)
if(!requireNamespace("clusterProfiler",quietly = TRUE)) BiocManager::install("clusterProfiler",update = F,ask = F)
if(!requireNamespace("GEOquery",quietly = TRUE)) BiocManager::install("GEOquery",update = F,ask = F)
if(!requireNamespace("hugene10sttranscriptcluster.db",quietly = TRUE)) BiocManager::install("hugene10sttranscriptcluster.db",update = F,ask = F)
if(!requireNamespace("DOSE",quietly = TRUE)) BiocManager::install("DOSE",update = F,ask = F)
if(!requireNamespace("GSEABase",quietly = TRUE)) BiocManager::install("GSEABase",update = F,ask = F)
if(!requireNamespace("enrichplot",quietly = TRUE)) BiocManager::install("enrichplot",update = F,ask = F)
if(!requireNamespace("DESeq2",quietly = TRUE)) BiocManager::install("DESeq2",update = F,ask = F)
if(!requireNamespace("edgeR",quietly = TRUE)) BiocManager::install("edgeR",update = F,ask = F)
if(!requireNamespace("pathview",quietly = TRUE)) BiocManager::install("pathview",update = F,ask = F)
if(!requireNamespace("GSVA",quietly = TRUE)) BiocManager::install("GSVA",update = F,ask = F)


if(!requireNamespace("officer",quietly = TRUE)) install.packages("officer",update = F,ask = F)
if(!requireNamespace("rvg",quietly = TRUE)) install.packages("rvg",update = F,ask = F)
if(!requireNamespace("flextable",quietly = TRUE)) install.packages("flextable",update = F,ask = F)
if(!requireNamespace("rgl",quietly = TRUE)) install.packages("rgl",update = F,ask = F)
if(!requireNamespace("stargazer",quietly = TRUE)) install.packages("stargazer",update = F,ask = F)
if(!requireNamespace("export",quietly = TRUE)) install.packages("export", update=F,ask=F)




if (!requireNamespace("BiocGenerics", quietly = TRUE)) {
  BiocManager::install("BiocGenerics",update=FALSE, ask=FALSE)
}
if (!requireNamespace("DelayedArray", quietly = TRUE)){
  BiocManager::install("DelayedArray",update=FALSE, ask=FALSE)
}
if (!requireNamespace("DelayedMatrixStats", quietly = TRUE)) {
  BiocManager::install("DelayedMatrixStats",update=FALSE, ask=FALSE)
}
if (!requireNamespace("limma", quietly = TRUE)) {
  BiocManager::install("limma",update=FALSE, ask=FALSE)
}
if (!requireNamespace("S4Vectors", quietly = TRUE)) {
  BiocManager::install("S4Vectors",update=FALSE, ask=FALSE)
}
if (!requireNamespace("SummarizedExperiment", quietly = TRUE)) {
  BiocManager::install("SummarizedExperiment",update=FALSE, ask=FALSE)
}
if (!requireNamespace("SingleCellExperiment", quietly = TRUE)) {
  BiocManager::install("SingleCellExperiment",update=FALSE, ask=FALSE)
}
if (!requireNamespace("batchelor", quietly = TRUE)) {
  BiocManager::install("batchelor",update=FALSE, ask=FALSE)
}
if (!requireNamespace("HDF5Array", quietly = TRUE)) {
  BiocManager::install("HDF5Array",update=FALSE, ask=FALSE)
}
if (!requireNamespace("multtest", quietly = TRUE)) {
  BiocManager::install("multtest",update=FALSE, ask=FALSE)
}
if (!requireNamespace("ComplexHeatmap", quietly = TRUE)) {
  BiocManager::install("ComplexHeatmap",update=FALSE, ask=FALSE)
}
if (!requireNamespace("dittoSeq", quietly = TRUE)) {
  BiocManager::install("dittoSeq",update=FALSE, ask=FALSE)
}
if (!requireNamespace("DropletUtils", quietly = TRUE)){
  BiocManager::install("DropletUtils",update=FALSE, ask=FALSE)
}
if (!requireNamespace("Nebulosa", quietly = TRUE)) {
  BiocManager::install("Nebulosa",update=FALSE, ask=FALSE)
}
if (!requireNamespace("UCell", quietly = TRUE)) {
  BiocManager::install("UCell",update=FALSE, ask=FALSE)
}

if (!requireNamespace("rtracklayer", quietly = TRUE)) {
  BiocManager::install("rtracklayer",update=FALSE, ask=FALSE)
}
if (!requireNamespace("ashr", quietly = TRUE)) {
  BiocManager::install("ashr",update=FALSE, ask=FALSE)
}