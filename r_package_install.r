
#tested 8/8/24 and works
# sets up environment values and runs installation. 
#run using the following:
# $(spack location -i r)/bin/R
# source("r_package_install.r")

#snafu: to get terra to compile, I needed to do spack load on all the modules.
# spack load sqlite@3.43.2
# spack load proj@6.3.2
# spack load gdal@3.8.5
# spack load geos@3.12.1
# spack load r@4.4.0


install.packages(c("codetools", "stringr", "Rcpp"))

#read snafu above or you will have trouble. 
install.packages("terra",
                 repos = "https://rspatial.r-universe.dev",
                 configure.args = c(
                   paste0("--with-gdal-config=", Sys.getenv("GDAL_CONFIG")),
                   paste0("--with-proj-include=", Sys.getenv("PROJ_INCLUDE")),
                   paste0("--with-proj-lib=", Sys.getenv("PROJ_ROOT"), "/lib64"),
                   paste0("--with-proj-share=", Sys.getenv("PROJ_ROOT"), "/share"),
                   paste0("--with-sqlite3-lib=", Sys.getenv("SQLITE_ROOT"), "/lib"),
                   paste0("--with-sqlite3-include=", Sys.getenv("SQLITE_ROOT"), "/include")
                 ))
#read snafu above or you will have trouble.


install.packages("sf", repos="http://cran.us.r-project.org", configure.args = c(
                 paste0("--with-gdal-config=", Sys.getenv("GDAL_CONFIG")),
                 paste0("--with-proj-include=", Sys.getenv("PROJ_INCLUDE")),
                 paste0("--with-proj-lib=", Sys.getenv("PROJ_ROOT"), "/lib64"),
                 paste0("--with-proj-share=", Sys.getenv("PROJ_ROOT"), "/share"),
                 paste0("--with-sqlite3-lib=", Sys.getenv("SQLITE_ROOT"), "/lib"),
                 paste0("--with-sqlite3-include=", Sys.getenv("SQLITE_ROOT"), "/include")
), INSTALL_opts='--no-test-load')
install.packages("MASS", repos="http://cran.us.r-project.org")
install.packages(c("class", "e1071", "classInt"), repos="http://cran.us.r-project.org")
install.packages(c('raster', 'prism', 'data.table', 'dplyr', 'lubridate', 'tidyr', 'ggplot2', 'purrr', 'tibble', 'forcats', 'readr','readxl'))
