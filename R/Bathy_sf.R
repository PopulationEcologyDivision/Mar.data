#' @title Bathy_sf metadata
#' @name Bathy_sf
#' @aliases Bathy_sf
#' @description An sf polygon showing bathymetric features as polygons. This file is based
#' off of the gebco_2021_polys file from https://www.opendem.info/download_bathymetry.html.
#' That file has bathymetries starting at -25m, leaving "halos" around all land.
#' To fix this, an accurate coastline was downloaded from
#' https://osmdata.openstreetmap.de/data/coastlines.html, and the areas between
#' the land in this file and the gebco polygons were inferred to be 0-25 m.  For
#' convenience, the land areas were left in the file, identified as type="land",
#' and assigned the values of 1 and 0 as the DEP_MIN_M and DEP_MAX_M, respectively.
#' the The following contours are included:
#' *     1 :      0 m (i.e. all land);
#' *     0 :  -  25 m;
#' *  -  25 : -  50 m;
#' *  -  50 : - 100 m;
#' *  - 100 : - 200 m
#' *  - 200 : - 250 m;
#' *  - 250 : - 500 m;
#' *  - 500 : - 750 m;
#' *  - 750 : -1050 m;
#' *  -1050 : -1250 m;
#' *  -1250 : -1500 m;
#' *  -1500 : -1750 m
#' *  -1750 : -2000 m
#' *  -2000 : -2500 m
#' *  -2500 : -3000 m
#' *  -3000 : -3500 m
#' *  -3500 : -4000 m
#' *  -4000 : -4500 m
#' *  -4500 : -5000 m
#' *  -5000 : -5500 m
#' *  -5500 : -6000 m
#' @format sf polygon
#' \describe{
#' \item{DEP_MIN_M}{The minimum depth (m) found within the polygon}
#' \item{DEP_MAX_M}{The maximum depth (m) found within the polgon}
#' \item{FEAT_TYPE}{Identifier differentiating 'marine' and 'land' features}
#' }
#' @examples
#' if (require(ggplot2) && require(sf)) {
#'   #plot the bathymetry
#'   ggplot(Bathy_sf) +
#'     geom_sf(aes(fill = DEP_MIN_M), color = NA) +
#'     scale_fill_gradientn(colors = c("darkgreen", "darkblue", "lightblue"),
#'     values = scales::rescale(c(1, min(Bathy_sf$DEP_MIN_M, na.rm = TRUE), max(Bathy_sf$DEP_MIN_M, na.rm = TRUE))),
#'     guide = "colorbar") +
#'     theme_minimal() +
#'     labs(title = "Bathy_sf Plot", fill = "DEP_MIN_M")
#'   #just plot the coastline
#'   ggplot() +
#'     geom_sf(data = Bathy_sf[Bathy_sf$DEP_MIN_M == 0, ], fill='darkgreen') +
#'     theme_minimal() +
#'     labs(title = "Bathy_sf Coastline Plot", fill = "DEP_MIN_M")
#' }
"Bathy_sf"
