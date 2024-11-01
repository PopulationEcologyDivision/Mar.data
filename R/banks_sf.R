#' banks_sf
#'
#' An sf polygon showing the areas of Banquereau Bank, Grand Banks, Sable Bank, Middle Bank,
#' Emerald Bank, LaHave Bank, Browns Bank, St Pierre Bank, Green Bank, Burgeo Bank and Georges Bank.
#' The lines in this file correspond with 100m isobaths from a file called CHS100.ll.
#' @note  Note that 2 edits were done to the data extracted from CHS100.ll:
#' 1 - Georges Bank extended far to the west and south of the Maritimes region, so it was cut off
#' vertically in a GIS around -69 W
#' 2 - Emerald and Sable Bank were connected in the 100m isobath file, so the single polygon was manually
#' "split" in a location that most closely aligns with published images of the 2 banks.  This corresponds
#' with the 2 closest vertices in an isthmus that joined the 2 polygons.
#'
#' @format sf polygon
#' \describe{
#' \item{Name}{Name of the Bank}
#' \item{ID}{Polygon Identifier}
#' }
#' @name banks_sf
#' @docType data
"banks_sf"
