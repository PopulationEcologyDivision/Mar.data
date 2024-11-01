library(sf)
library(dplyr)
#create sf files

Areas_Halibut_sf <- sf::st_read("C:/git/Maritimes/Mar.data/data-raw/Science/Halibut/Areas_Halibut_sf.shp")

#Shapefiles
NAFOSubunits_sf   <- sf::st_read("C:/git/Maritimes/Mar.data/data-raw/NAFO/NAFO_BEST_KasiaUS2022.shp")
NAFOSubunits_sf$OBJECTID_1<-NAFOSubunits_sf$OBJECTID<-NAFOSubunits_sf$ORIG_FID<- NAFOSubunits_sf$Shape_Le_1 <-NAFOSubunits_sf$Shape_Leng<- NAFOSubunits_sf$Shape_Area<-NULL
colnames(NAFOSubunits_sf)[colnames(NAFOSubunits_sf)=="AREA"] <- "AREA_ID"

# create sp files
# NAFOSubunits      <- rgdal::readOGR("C:/git/Maritimes/Mar.data/data-raw/NAFO/NAFO_BEST_UPDATED.shp")
# NAFOSubunits@data$OBJECTID <- NAFOSubunits@data$Shape_Leng<- NAFOSubunits@data$Shape_Area <- NULL

# NAFOSubunitsLnd      <- rgdal::readOGR("C:/git/Maritimes/Mar.data/data-raw/NAFO/NAFO_BEST_UPDATED20210416a.shp")
# NAFOSubunitsLnd@data$OBJECTID_1 <- NAFOSubunitsLnd@data$Shape_Leng<- NAFOSubunitsLnd@data$Shape_Area <- NULL
# colnames(NAFOSubunitsLnd@data)[colnames(NAFOSubunitsLnd@data)=="NAFO_BEST"]<- "NAFO"

NAFOSubunitsLnd_sf   <- sf::st_read("C:/git/Maritimes/Mar.data/data-raw/NAFO/NAFO_BEST_UPDATED20210416a.shp")
NAFOSubunitsLnd_sf$OBJECTID<- NAFOSubunitsLnd_sf$Shape_Leng<- NAFOSubunitsLnd_sf$Shape_Area<-NULL
colnames(NAFOSubunitsLnd_sf)[colnames(NAFOSubunitsLnd_sf)=="NAFO_BEST"]<- "NAFO"

Strata_Mar_sf      <- sf::st_read("C:/git/Maritimes/Mar.data/data-raw/Strata/MaritimesRegionEcosystemAssessmentStrata(2014-).shp")
Strata_Mar_4VSW_sf  <- sf::st_read("C:/git/Maritimes/Mar.data/data-raw/Strata/4VsW.shp")

Areas_Shrimp_sf      <- sf::st_read ("C:/git/Maritimes/Mar.data/data-raw/Science/Shrimp/shrimpBoxesPoly.shp")
Areas_Shrimp_sf$LAT <- Areas_Shrimp_sf$LON <- Areas_Shrimp_sf$trekMin <- Areas_Shrimp_sf$trekMax <- Areas_Shrimp_sf$cnt <- Areas_Shrimp_sf$BOX_ID <- NULL

Areas_Scallop_sf     <- sf::st_read ("C:/git/Maritimes/Mar.data/data-raw/Science/Scallop/ScallopSFAs.shp")
Areas_Scallop_sf$OBJECTID<- Areas_Scallop_sf$Shape_Leng<- Areas_Scallop_sf$Shape_Area<-NULL

SPAs_Scallop_sf     <- sf::st_read ("C:/git/Maritimes/Mar.data/data-raw/Science/Scallop/ScallopSPAs.shp")

Grids_Lobster_sf <-  sf::st_read ("C:/git/Maritimes/Mar.data/data-raw/Science/Lobster/GridsMMM.shp")

GeorgesBankDiscardZones_sf <-  sf::st_read ("I:/Science/Population Ecology/Georges Bank/Discards/2021 2022/zones.shp")

#Snowcrab dat files were converted to shapefiles via dat2Shp.R
Areas_Snowcrab_sf <- sf::st_read("C:/git/Maritimes/Mar.data/data-raw/Science/Snowcrab/SCAreas.shp")
Areas_Snowcrab_sf$OBJECTID <-Areas_Snowcrab_sf$Shape_Leng <- Areas_Snowcrab_sf$Shape_Area <- NULL
Areas_Snowcrab_Slope_sf <- sf::st_read("C:/git/Maritimes/Mar.data/data-raw/Science/Snowcrab/SCSlope.shp")

#PBS-like CSVs
Areas_Surfclam <- read.csv("C:/git/Maritimes/Mar.data/data-raw/Science/Surfclam/newareas.csv")
Areas_Surfclam_sf <-     df_to_sf(Areas_Surfclam)
colnames(Areas_Surfclam_sf)[colnames(Areas_Surfclam_sf)=="PID"] <- "AREA"

#### LICENCE AREAS
#### Make licence areas sf
#first pull the polygons provided by Leslie
surfClamAreas_ <-read.csv("data-raw/Science/Surfclam/OffshoreClamConditions.csv")
surfClamAreas_sf <- Mar.utils::df_to_sf(surfClamAreas_, lat.field = "Y", lon.field = "X", primary.object.field = "PID", order.field = "POS")
surfClamAreas_sf$Name <- c("Sable Bank", "Middle Bank", "Banquereau Bank")
surfClamAreas_sf$PID <- NULL

Bathy_sf      <- sf::st_read("C:/git/Maritimes/Mar.data/data-raw/geophysical/GEBBCO_PED.shp")
usethis::use_data(Bathy_sf, overwrite = TRUE, compress = "xz")

#then make a separate one from the NAFO areas 3LNO
Grand <- Mar.data::NAFOSubunits_sf[Mar.data::NAFOSubunits_sf$NAFO_1 %in% c('3L', '3N', '3O'),]
Grand_single <- st_union(Grand$geometry)
Grand_single_df <- data.frame('Name' = 'Grand Bank')
Grand_single <- st_sf(Grand_single_df, geometry = st_sfc(Grand_single, crs = st_crs(Grand)))

SurfClamFAs_sf <- rbind(Grand_single, surfClamAreas_sf)

LFAs <- read.csv("C:/git/Maritimes/Mar.data/data-raw/Science/Lobster/LFAPolys.csv")
LFAs_sf <-     df_to_sf(LFAs)
colnames(LFAs_sf)[colnames(LFAs_sf)=="PID"] <- "LFA"

hex_sf <- sf::st_as_sf(hex)
grid2Min_sf <-  sf::st_as_sf(grid2Min)

coastline =  maps::map(database = "world", regions = c("Canada", "USA", "France", "Greenland"), fill = T, resolution = 0)
coast_lores_sf = sf::st_as_sf(coastline)

save(GeorgesBankDiscardZones_sf,file = "data/GeorgesBankDiscardZones_sf.rda")
# save(Areas_Surfclam_sf,file = "data/Areas_Surfclam_sf.rda")
save(Areas_Halibut_sf,file = "data/Areas_Halibut_sf.rda")
# rm(coast_lores)
save(coast_lores_sf,file = "data/coast_lores_sf.rda")
save(hex_sf,file = "data/hex_sf.rda")
save(LFAs_sf,file = "data/LFAs_sf.rda")
save(Grids_Lobster_sf,file = "data/Grids_Lobster_sf.rda")
save(Strata_Mar_4VSW_sf,file = "data/Strata_Mar_4VSW_sf.rda")
save(Strata_Mar_sf,file = "data/Strata_Mar_sf.rda")

# save(NAFOSubunits,file = "data/NAFOSubunits.rda")
save(NAFOSubunits_sf,file = "data/NAFOSubunits_sf.rda")

# save(NAFOSubunitsLnd,file = "data/NAFOSubunitsLnd.rda")
save(NAFOSubunitsLnd_sf,file = "data/NAFOSubunitsLnd_sf.rda")

save(Areas_Scallop_sf,file = "data/Areas_Scallop_sf.rda")
save(SPAs_Scallop_sf,file = "data/SPAs_Scallop_sf.rda")
save(Areas_Shrimp_sf,file = "data/Areas_Shrimp_sf.rda")
save(Areas_Snowcrab_sf,file = "data/Areas_Snowcrab_sf.rda")
save(Areas_Snowcrab_Slope_sf,file = "data/Areas_Snowcrab_Slope_sf.rda")

# Below is how I orginally created the banks layer
#' ### BANKS -  get the isobaths demarking the various banks
#' c100 = read.table("data-raw/geophysical/CHS100.ll", header=T) #this is specific to how my system is set up
#' Banq100  <- na.omit(subset(c100,SID==2392)) # 100m isobath for Banqureau
#' Grand100 <- na.omit(subset(c100,SID==1518)) # 100m isobath for Grand Bank
#' Sable100 <- na.omit(subset(c100,SID==2943)) # 100m isobath for Sable Bank
#' Middle100 <- na.omit(subset(c100,SID==2658)) # 100m isobath for Middle Bank
#' Emerald100 <- na.omit(subset(c100,SID==2943)) # 100m isobath for Emerald Bank
#' LaHave100 <- na.omit(subset(c100,SID==3742)) # 100m isobath for Lahave Bank
#' Browns100 <- na.omit(subset(c100,SID==3900)) # 100m isobath for Browns Bank
#' StPierre100 <- na.omit(subset(c100,SID==1693)) # 100m isobath for StPierre Bank
#' Green100 <- na.omit(subset(c100,SID==2047)) # 100m isobath for Green Bank
#' Burgeo100 <- na.omit(subset(c100,SID==1787)) # 100m isobath for Burgeo Bank
#'
#' Banq100$Name <- "Banquereau Bank"
#' Grand100$Name <- "Grand Banks"
#' Sable100$Name <- "Sable Bank"
#' Middle100$Name <- "Middle Bank"
#' Emerald100$Name <- "Emerald Bank"
#' LaHave100$Name <- "LaHave Bank"
#' Browns100$Name  <- "Browns Bank"
#' StPierre100$Name <- "St Pierre Bank"
#' Green100$Name <- "Green Bank"
#' Burgeo100$Name <- "Burgeo Bank"
#'
#' banks <- rbind(Banq100,Grand100,Sable100,Middle100,Emerald100,LaHave100,Browns100 ,StPierre100,Green100,Burgeo100)
#' banks_sf <- st_as_sf(banks, coords = c("X", "Y"), crs = 4326)
#'
#' #'Georges was messed up in the ll file, since it was not a single polygon.  I cut it off in QGIS,
#' #'so it has a vertical western boundary
#' Georges100 <- st_read("data-raw/geophysical/georges.shp")
#' Georges100$Name <- "Georges Bank"
#' Georges100$fid <- NULL
#' Georges100_sf <- Georges100 %>%
#'   group_by(Name, SID) %>%
#'   summarise(geometry = st_combine(geometry), do_union = FALSE) %>%
#'   st_cast("LINESTRING")
#' Georges100_sf <- dplyr::ungroup(Georges100_sf)
#'
#' banks_sf<- rbind(banks_sf, Georges100)
#' banks_sf <- banks_sf %>%
#'   group_by(Name, SID) %>%
#'   summarise(geometry = st_combine(geometry), do_union = FALSE) %>%
#'   st_cast("LINESTRING")
#' banks_sf <- dplyr::ungroup(banks_sf)
#' banks_sf <- st_cast(banks_sf, "POLYGON")
#' banks_sf <- st_make_valid(banks_sf)
#'
#' sf::st_write(banks_sf,"banks_sf.shp")
#' However, Emerald and Sable Bank were connected, and so the same feature got added twice, with 2 different names
#' I endeavoured to "split" the polygon in a location that most closely aligns with published images of the 2 banks.
#' I opened it in GIS, and split it via the 2 closest vertices in the isthmus that joined the 2 polygons.
banks_sf <-  sf::st_read ("C:/git/Maritimes/Mar.data/data-raw/geophysical/banks_sf.shp")

#' usethis::use_data(GeorgesBankDiscardZones_sf, overwrite = TRUE)
# usethis::use_data(Areas_Surfclam_sf, overwrite = TRUE)
usethis::use_data(SurfClamFAs_sf, overwrite = TRUE)
usethis::use_data(Areas_Halibut_sf, overwrite = TRUE)

# usethis::use_data(coast_lores, overwrite = TRUE)
usethis::use_data(coast_lores_sf, overwrite = TRUE)
usethis::use_data(hex_sf, overwrite = TRUE,compress = "xz")
usethis::use_data(grid2Min_sf, overwrite = TRUE, compress = "xz")
usethis::use_data(LFAs_sf, overwrite = TRUE)
usethis::use_data(Grids_Lobster_sf, overwrite = TRUE)
usethis::use_data(Strata_Mar_4VSW_sf, overwrite = TRUE)
usethis::use_data(Strata_Mar_sf, overwrite = TRUE)
# usethis::use_data(NAFOSubunits, overwrite = TRUE)
usethis::use_data(NAFOSubunits_sf, overwrite = TRUE)
# usethis::use_data(NAFOSubunitsLnd, overwrite = TRUE)
usethis::use_data(NAFOSubunitsLnd_sf, overwrite = TRUE)
usethis::use_data(Areas_Scallop_sf, overwrite = TRUE)
usethis::use_data(SPAs_Scallop_sf, overwrite = TRUE)
usethis::use_data(Areas_Shrimp_sf, overwrite = TRUE)
usethis::use_data(Areas_Snowcrab_sf, overwrite = TRUE)
usethis::use_data(Areas_Snowcrab_Slope_sf, overwrite = TRUE)
usethis::use_data(banks_sf, overwrite = TRUE)
