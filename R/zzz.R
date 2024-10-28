.onAttach <- function(libname, pkgname) {
#   localVer = utils::packageDescription('Mar.data')$Version
#   packageStartupMessage(paste0("Version: ", localVer))
  packageStartupMessage("You may also want to install 'PopulationeEcologyDivision/Mar.data.extended' for a bathymetry layer (too big to add here)")
}

.onLoad <- function(libname, pkgname){
  options(stringsAsFactors = FALSE)
#  Mar.utils::updateCheck(gitPkg = 'Maritimes/Mar.data')
}
