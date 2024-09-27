
#technically these should be put in the packages.yaml of for R
#this would automatically set the values upon the run or R. 
# Setup Environment values in R from Spack values

# Package sqlite found at: /modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/sqlite-3.43.2-sbe3wzqidh2ge5i4zhkchxkmspzp4tv3
Sys.setenv(SQLITE_ROOT="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/sqlite-3.43.2-sbe3wzqidh2ge5i4zhkchxkmspzp4tv3")
sqlite3_lib="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/sqlite-3.43.2-sbe3wzqidh2ge5i4zhkchxkmspzp4tv3/lib/libsqlite3.so"
sqlite3_pkgconfig="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/sqlite-3.43.2-sbe3wzqidh2ge5i4zhkchxkmspzp4tv3/lib/pkgconfig/sqlite3.pc"
Sys.setenv(PKG_CONFIG_PATH = paste0(dirname(sqlite3_pkgconfig), ":", Sys.getenv("PKG_CONFIG_PATH")))
Sys.setenv(LIBS = paste0("-L", dirname(sqlite3_lib), " -lsqlite3"))

# Package proj found at: /modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/proj-6.3.2-okxqx5yqamp5qhv3tj5omacgghgsis7g
Sys.setenv(PROJ_ROOT="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/proj-6.3.2-okxqx5yqamp5qhv3tj5omacgghgsis7g")
Sys.setenv(PROJ_BIN="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/proj-6.3.2-okxqx5yqamp5qhv3tj5omacgghgsis7g/bin")
Sys.setenv(PROJ_INCLUDE="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/proj-6.3.2-okxqx5yqamp5qhv3tj5omacgghgsis7g/include")
Sys.setenv(CFLAGS = paste0("-I/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/proj-6.3.2-okxqx5yqamp5qhv3tj5omacgghgsis7g/include", Sys.getenv("CFLAGS")))
Sys.setenv(LDFLAGS = paste0("-L/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/proj-6.3.2-okxqx5yqamp5qhv3tj5omacgghgsis7g/lib64", Sys.getenv("LDFLAGS")))

# Package gdal found at: /modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/gdal-3.8.5-pcuml7s7u4locr34fin6qltymq3g5iu5
Sys.setenv(GDAL_CONFIG="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/gdal-3.8.5-pcuml7s7u4locr34fin6qltymq3g5iu5/bin/gdal-config")
Sys.setenv(GDAL_LIB="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/gdal-3.8.5-pcuml7s7u4locr34fin6qltymq3g5iu5/lib64")
Sys.setenv(GDAL_BIN="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/gdal-3.8.5-pcuml7s7u4locr34fin6qltymq3g5iu5/bin")
Sys.setenv(GDAL_ROOT="/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/gdal-3.8.5-pcuml7s7u4locr34fin6qltymq3g5iu5")

# Package geos found at: /modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/geos-3.12.1-jvvegp6fw3a3rxed7dwkon74if2rnhrw

Sys.setenv(LD_LIBRARY_PATH = paste(
  "/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/gdal-3.8.5-pcuml7s7u4locr34fin6qltymq3g5iu5/lib64",
  "/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/proj-6.3.2-okxqx5yqamp5qhv3tj5omacgghgsis7g/lib64",
  "/modeling/spack/opt/spack/linux-rocky8-haswell/gcc-9.2.0/sqlite-3.43.2-sbe3wzqidh2ge5i4zhkchxkmspzp4tv3/lib",
  Sys.getenv("LD_LIBRARY_PATH"),
  sep = ":"
))

# Retrieve and print the LD_LIBRARY_PATH
current_ld_library_path <- Sys.getenv("LD_LIBRARY_PATH")
print(current_ld_library_path)