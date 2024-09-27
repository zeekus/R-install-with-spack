# Define a vector with package names
packages <- c("terra", "sf", "raster", "dplyr", "tidyr", "readxl")

# Function to check if a package is installed
check_packages <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    return(FALSE)
  }
  return(TRUE)
}

# Apply the function to all packages
installed_status <- sapply(packages, check_packages)

# Summarize the results
if (all(installed_status)) {
  cat("All packages are installed.\n")
} else {
  cat("The following packages are missing:\n")
  missing_packages <- packages[!installed_status]
  print(missing_packages)
  
}
