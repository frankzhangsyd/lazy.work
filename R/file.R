#' Cut Files to folder
#'
#' @param from A vector of orgin files's full paths
#' @param to folder full path. Only length one
#' @param affix_type "prefix" or "suffix". Default no affix
#' @param affix a character
#' @param from_is_folder TRUE or FALSE. Default is FALSE
#' @import tools

#' @export
#' @examples
#' \dontrun{
#' file_cut2_folder("E:/folder","E:/dest1",affix_type = "suffix",affix = "_copied",from_is_folder = TRUE)
#'}

file_cut2_folder <- function(from, to, affix_type = c("prefix", "suffix"), affix,from_is_folder=FALSE) {

  if (isTRUE(from_is_folder)) {
    from <- list.files(from,full.names = TRUE)
  }

  if (any(!file.exists(from))) {
    stop("File origin doesn't exist")
  }

  if (length(to)>1) {
    stop("Destination folder is more than one")
  }
  todir_group <- unique(to)


  if (missing(affix_type)) {
    affix_type <- "NA"
  } else {
    if (missing(affix)) stop("affix is missing, please specify")
    affix_type <- match.arg(affix_type)
  }

  dirs <- todir_group
  # create dest folders if doesn't exist
  for (dirs in todir_group) {
    if (!isTRUE(file.info(dirs)$isdir)) dir.create(dirs, recursive = TRUE)

    if (affix_type == "NA") {
      dest_path <- paste0(dirs, "/", basename(from))
    }

    if (affix_type == "prefix") {
      dest_path <- paste0(dirs, "/", affix, basename(from))
    }

    if (affix_type == "suffix") {
      dest_path <- paste0(dirs, "/", vapply(basename(from), function(x) gsub(paste0(".", file_ext(x)), "", x), FUN.VALUE = character(1)), affix, ".", file_ext(basename(from)))
    }
    print(dest_path)
    if (any(file.exists(dest_path))) {
      res <- menu(c("Yes", "No"), title = cat("Do you want overwrite existing destination files ?", dest_path[file.exists(dest_path)], sep = "\n"))


      if (res == 2) {
        return("No action")
      } else if (res == 1) {
        file.rename(from = from, to = dest_path)
      }
    } else {
      file.rename(from = from, to = dest_path)
    }
  }
}

#' Copy Files to folders
#'
#' @param from A vector of orgin files's full paths
#' @param to folder full paths. can be a vector
#' @param affix_type "prefix" or "suffix". Default no affix
#' @param affix a character
#' @param from_is_folder TRUE or FALSE. Default is FALSE
#' @import tools

#' @export
#'
#' @examples
#' \dontrun{
#' file_copy2_folder("E:/folder",c("E:/dest1","E:/test2"),affix_type = "suffix",affix = "_copied",from_is_folder = TRUE)
#'}
file_copy2_folder <- function(from, to, affix_type = c("prefix", "suffix"), affix,from_is_folder=FALSE) {
  if (isTRUE(from_is_folder)) {
    from <- list.files(from,full.names = TRUE)
  }

  if (any(!file.exists(from))) {
    stop("File origin doesn't exist")
  }

  todir_group <- unique(to)


  if (missing(affix_type)) {
    affix_type <- "NA"
  } else {
    if (missing(affix)) stop("affix is missing, please specify")
    affix_type <- match.arg(affix_type)
  }

  dirs <- todir_group
  # create dest folders if doesn't exist
  for (dirs in todir_group) {
    if (!isTRUE(file.info(dirs)$isdir)) dir.create(dirs, recursive = TRUE)

    if (affix_type == "NA") {
      dest_path <- paste0(dirs, "/", basename(from))
    }

    if (affix_type == "prefix") {
      dest_path <- paste0(dirs, "/", affix, basename(from))
    }

    if (affix_type == "suffix") {
      dest_path <- paste0(dirs, "/", vapply(basename(from), function(x) gsub(paste0(".", file_ext(x)), "", x), FUN.VALUE = character(1)), affix, ".", file_ext(basename(from)))
    }

    if (any(file.exists(dest_path))) {
      res <- menu(c("Yes", "No"), title = cat("Do you want overwrite existing destination files ?", dest_path[file.exists(dest_path)], sep = "\n"))


      if (res == 2) {
        return("No action")
      } else if (res == 1) {
        file.copy(from = from, to = dest_path, overwrite = TRUE)
      }
    } else {
      file.copy(from = from, to = dest_path)
    }
  }

  if (all(file.exists(dest_path))) {
    return("all file successfully copied")
  }
}
