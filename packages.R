## CRAN packages needed
pkgs = c(
  "drat",  "devtools", "ggplot2", # Generic
  "downloader", "grid", "rbenchmark", # Generic
  "pryr", ## Memory chapter
  "dplyr", "readxl",
  "readr", "gdata", "openxlsx",
  "tidyr",
  "Rcpp",## Rcpp chapter
  "png",
  "ff", "ffbase", "biglm", ## FF chapter
  "xtable",
  "tabplot" ##Graphics chapter
)
## Github Drat packages
github_pkgs = c("r4bd")

## Packages not in a proper repo
if(!"bigvis" %in% installed.packages()){
  devtools::install_github("hadley/bigvis")
}

## create the data frames
pkgs = data.frame(pkg = pkgs,
                  repo = "http://cran.rstudio.com/",
                  installed = pkgs %in% installed.packages(),
                  stringsAsFactors = FALSE)

if(!require(drat)){
  install.packages("drat")
}
repo = drat::addRepo("rcourses")["rcourses"]

github_pkgs = data.frame(pkg = github_pkgs,
                         repo = repo,
                         installed = github_pkgs %in% installed.packages(),
                         stringsAsFactors = FALSE, row.names=NULL)

## Combine all data frames of package info
pkgs = rbind(pkgs, github_pkgs)

## Update packages
update.packages(checkBuilt = TRUE, ask = FALSE,
                repos = unique(pkgs$repo),
                oldPkgs = pkgs$pkg)

## Install missing packages
to_install = pkgs[!pkgs$installed,]
if(nrow(to_install))
  install.packages(to_install$pkg, repos = to_install$repo)
