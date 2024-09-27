
# R INSTALLTION NOTES 

- This document shows how to create a R environment in Spack. 
Snafu: proj versions > 6.x don't come with proj_api.h this is required by terra and some other R modules. 
       - CFLAGS and LDFLAGS and a bunch of environment variables need to be defined in spack for it find all the libraries.

# REF flags 
```
  --with-gdal-config=GDAL_CONFIG
                          the location of gdal-config
  --with-data-copy=yes/no local copy of data directories in package, default
                          no
  --with-proj-data=DIR    location of PROJ data directory
  --with-proj-include=DIR location of proj header files
  --with-proj-api=yes/no  use the deprecated proj_api.h even when PROJ 6 is
                          available; default no
  --with-proj-lib=LIB_PATH
                          the location of proj libraries
  --with-proj-share=SHARE_PATH
                          the location of proj metadata files
  --with-geos-config=GEOS_CONFIG
                          the location of geos-config

```

# Source your environment variables to load the spack environment

```
source /modeling/spack/share/spack/setup-env.sh
```

# Install the packages using Spack proper:

```
spack install proj@6.3.2 
spack install gdal@3.8.5
spack install r@4.4.0
```

# Create a Spack environment :

```
spack env create r-env
==> Created environment r-env in: /modeling/spack/var/spack/environments/r-env
==> Activate with: spack env activate r-env
```

# Activate r environment

```
spack env activate r-env
```

# Add R and the dependencies to the environment:

```
spack add r@4.4.0
spack add proj@6.3.2
spack add geos@3.12.1
spack add gdal@3.8.5
spack add sqlite@3.43.2
```

# Install the packages in the environment ( tell spack to re-use the installed packages. ):

```
spack install --reuse
```

# turn off depeciated PROJ API we are using a depeciated version. 

```
export CPPFLAGS="-DACCEPT_USE_OF_DEPRECATED_PROJ_API_H=1"
```


# To make R aware of these libraries, you need load the spack environments for each of the programs.

```
spack load gdal
spack load proj
spack load sqlite
spack load geos
spack load r
```

# grab the environment values  

```
wget https://raw.githubusercontent.com/zeekus/bash/master/loop_out_paths_for_r.sh
bash loop_out_paths_for_r.sh > r_environment_script.R
```



# run R to load the spack version or R 
```
 $(spack location -i r)/bin/R
```

# load the environment settings from a script *This is much better than a copy/paste*
```
source("r_environment_script.R")
```

# copy and paste the ouptput for the environment values. 

# Now when you run R, it should be able to find and use these libraries. You may need to install the R packages that interface with these libraries (like rgdal, rgeos, etc.) from within R:

# depricated libaries "rgdal", "rgeos" 
*note* 

The R packages rgdal and rgeos have been significant in the R-spatial ecosystem, providing interfaces to external geospatial libraries. However, both packages are being retired by the end of 2023 due to the retirement of their maintainer, Roger Bivand, and the challenges associated with maintaining these packages. 

Replacements: Terra and sf. 


```
install.packages(c("codetools", "stringr", "Rcpp")))
```

# install Terra referencing environment values above.  

```
install.packages("terra", 
                 repos = "https://rspatial.r-universe.dev", 
                 configure.args = c(
                   paste0("--with-gdal-config=", Sys.getenv("GDAL_CONFIG")),
                   paste0("--with-proj-include=", Sys.getenv("PROJ_INCLUDE")),
                   paste0("--with-proj-lib=", Sys.getenv("PROJ_ROOT"), "/lib64"),
                   paste0("--with-proj-share=", Sys.getenv("PROJ_ROOT"), "/share"),
                   paste0("--with-sqlite3-lib=", Sys.getenv("SQLITE_ROOT"), "/lib")
                 ))
```

*note if the above fails try and add this* remember the "," after the currentl "lib" line.
   paste0("--with-sqlite3-include=", Sys.getenv("SQLITE_ROOT"), "/include")



# install SF

```
install.packages("sf", repos="http://cran.us.r-project.org", configure.args = c(
                 paste0("--with-gdal-config=", Sys.getenv("GDAL_CONFIG")),
                 paste0("--with-proj-include=", Sys.getenv("PROJ_INCLUDE")),
                 paste0("--with-proj-lib=", Sys.getenv("PROJ_ROOT"), "/lib64"),
                 paste0("--with-proj-share=", Sys.getenv("PROJ_ROOT"), "/share"),
                 paste0("--with-sqlite3-lib=", Sys.getenv("SQLITE_ROOT"), "/lib"),
                 paste0("--with-sqlite3-include=", Sys.getenv("SQLITE_ROOT"), "/include")
), INSTALL_opts='--no-test-load')	
```

# if install of SF fails due to dependancies add these. Otherwise skip this. 
- MASS
- class 
- e1071 
- classInt


```
install.packages("MASS", repos="http://cran.us.r-project.org")
install.packages(c("class", "e1071", "classInt"), repos="http://cran.us.r-project.org")
```

# install remaining libraries that tidyverse provides. 

```
install.packages(c("raster","prism","data.table","dplyr","lubridate","tidyr","ggplot2","purrr","tibble","forcats","readr"))
```
/or/

```
install.packages('raster')
install.packages('prism')
install.packages('data.table')
install.packages('dplyr')
install.packages('lubridate')
install.packages('tidyr')
install.packages('ggplot2')
install.packages('purrr')
install.packages('tibble')
install.packages('forcats')
install.packages('readr')
```
-ref https://www.tidyverse.org/


# Ref list commands:

```
installed.packages() 
```

# Ref items: Script to generate the environment values:

```
#!/bin/bash
#filename: loop_out_paths_for_r.sh
#description: Generates the path information in R. 
#             This is needed to install terrra and some other packages.


source /modeling/spack/share/spack/setup-env.sh

mypackages='sqlite proj gdal geos'

echo "# Setup Environment values in R from Spack values"
echo ""

for package in $mypackages; do
    location=$(spack location -i $package 2>/dev/null)
    if [ -n "$location" ]; then
        echo "# Package $package found at: $location"

        # Find lib or lib64 directory
        libdir=$(find "$location" -type d -name 'lib64' 2>/dev/null)
        if [ -z "$libdir" ]; then
            libdir=$(find "$location" -type d -name 'lib' 2>/dev/null)
        fi
        
        # Find bin directory
        bindir=$(find "$location" -type d -name 'bin' 2>/dev/null)
        
        # Find include directory
        includedir=$(find "$location" -type d -name 'include' 2>/dev/null)
        
        case $package in
            gdal)
                echo "Sys.setenv(GDAL_CONFIG=\"$bindir/gdal-config\")"
                echo "Sys.setenv(GDAL_LIB=\"$libdir\")"
                echo "Sys.setenv(GDAL_BIN=\"$bindir\")"
		echo "Sys.setenv(GDAL_ROOT=\"$location\")"
                ;;
            proj)
		echo "Sys.setenv(PROJ_ROOT=\"$location\")"
                echo "Sys.setenv(PROJ_BIN=\"$bindir\")"
                echo "Sys.setenv(PROJ_INCLUDE=\"$includedir\")"
		echo "Sys.setenv(CFLAGS = paste0(\"-I${includedir}\", Sys.getenv(\"CFLAGS\")))"
		echo "Sys.setenv(LDFLAGS = paste0(\"-L${location}/lib64\", Sys.getenv(\"LDFLAGS\")))"
                ;;
            sqlite)
                sqlite3_lib=$(find "$libdir" -name "libsqlite3.so*" | head -n 1)
                sqlite3_pkgconfig=$(find "$libdir" -name "sqlite3.pc" | head -n 1)
                if [ -n "$sqlite3_lib" ] && [ -n "$sqlite3_pkgconfig" ]; then
		    echo "Sys.setenv(SQLITE_ROOT=\"$location\")"
                    echo "sqlite3_lib=\"$sqlite3_lib\""
                    echo "sqlite3_pkgconfig=\"$sqlite3_pkgconfig\""
                    echo "Sys.setenv(PKG_CONFIG_PATH = paste0(dirname(sqlite3_pkgconfig), \":\", Sys.getenv(\"PKG_CONFIG_PATH\")))"
                    echo "Sys.setenv(LIBS = paste0(\"-L\", dirname(sqlite3_lib), \" -lsqlite3\"))"
                fi
                ;;
        esac
        echo ""
    else
        echo "# Package $package not found"
        echo ""
    fi
done

# Add LD_LIBRARY_PATH setting
echo "Sys.setenv(LD_LIBRARY_PATH = paste("
for package in gdal proj sqlite; do
    location=$(spack location -i $package 2>/dev/null)
    if [ -n "$location" ]; then
        libdir=$(find "$location" -type d -name 'lib64' 2>/dev/null)
        if [ -z "$libdir" ]; then
            libdir=$(find "$location" -type d -name 'lib' 2>/dev/null)
        fi
        if [ -n "$libdir" ]; then
            echo "  \"$libdir\","
        fi
    fi
done
echo "  Sys.getenv(\"LD_LIBRARY_PATH\"),"
echo "  sep = \":\""
echo "))"

```

# Sample output of r_environment_script.R

```
# Setup Environment values in R from Spack values

# Package sqlite found at: /modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/sqlite-3.43.2-pfuqkkv2x4tjoiuq6c43nsxrtaqxidrh
Sys.setenv(SQLITE_ROOT="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/sqlite-3.43.2-pfuqkkv2x4tjoiuq6c43nsxrtaqxidrh")
sqlite3_lib="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/sqlite-3.43.2-pfuqkkv2x4tjoiuq6c43nsxrtaqxidrh/lib/libsqlite3.so"
sqlite3_pkgconfig="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/sqlite-3.43.2-pfuqkkv2x4tjoiuq6c43nsxrtaqxidrh/lib/pkgconfig/sqlite3.pc"
Sys.setenv(PKG_CONFIG_PATH = paste0(dirname(sqlite3_pkgconfig), ":", Sys.getenv("PKG_CONFIG_PATH")))
Sys.setenv(LIBS = paste0("-L", dirname(sqlite3_lib), " -lsqlite3"))

# Package proj found at: /modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/proj-6.3.2-rh7bjpql5dq4sr2z7gqlx3hhnnxtnsw3
Sys.setenv(PROJ_ROOT="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/proj-6.3.2-rh7bjpql5dq4sr2z7gqlx3hhnnxtnsw3")
Sys.setenv(PROJ_BIN="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/proj-6.3.2-rh7bjpql5dq4sr2z7gqlx3hhnnxtnsw3/bin")
Sys.setenv(PROJ_INCLUDE="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/proj-6.3.2-rh7bjpql5dq4sr2z7gqlx3hhnnxtnsw3/include")
Sys.setenv(CFLAGS = paste0("-I/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/proj-6.3.2-rh7bjpql5dq4sr2z7gqlx3hhnnxtnsw3/include", Sys.getenv("CFLAGS")))
Sys.setenv(LDFLAGS = paste0("-L/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/proj-6.3.2-rh7bjpql5dq4sr2z7gqlx3hhnnxtnsw3/lib64", Sys.getenv("LDFLAGS")))

# Package gdal found at: /modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/gdal-3.8.5-ovb27rzosy4gicjgna36sf64rryc5mhn
Sys.setenv(GDAL_CONFIG="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/gdal-3.8.5-ovb27rzosy4gicjgna36sf64rryc5mhn/bin/gdal-config")
Sys.setenv(GDAL_LIB="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/gdal-3.8.5-ovb27rzosy4gicjgna36sf64rryc5mhn/lib64")
Sys.setenv(GDAL_BIN="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/gdal-3.8.5-ovb27rzosy4gicjgna36sf64rryc5mhn/bin")
Sys.setenv(GDAL_ROOT="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/gdal-3.8.5-ovb27rzosy4gicjgna36sf64rryc5mhn")

# Package geos found at: /modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/geos-3.12.1-scckvgvkgalfcivyoza7mnb5j4flsvkg
                                                                                                                                          Sys.setenv(LD_LIBRARY_PATH = paste(
  "/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/gdal-3.8.5-ovb27rzosy4gicjgna36sf64rryc5mhn/lib64",
  "/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/proj-6.3.2-rh7bjpql5dq4sr2z7gqlx3hhnnxtnsw3/lib64",
  "/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-8.5.0/sqlite-3.43.2-pfuqkkv2x4tjoiuq6c43nsxrtaqxidrh/lib",
  Sys.getenv("LD_LIBRARY_PATH"),
  sep = ":"
))
```



