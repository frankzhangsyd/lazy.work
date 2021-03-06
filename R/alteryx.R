#' Generate formula strings for Alteryx
#'
#' Genetate a string which can be copied into Alteryx formula tool
#' @param x a vecotr of column names in Alteryx
#' @param f the function will be applied across columns. Default is "+"
#' @return a single string which can be copied into Alteryx formula
#' @export
#' @examples
#' fields <- c("a", "b", "c", "d")
#' ayx_fl(fields,"+")

ayx_fl <- function(x,f=c("+","-","*","/")){
  stopifnot(is.character(x))
  f <- match.arg(f)
  paste(paste0("[",x,"]"),collapse = f)
}

#' Output Alteryx tools related information
#'
#' Currently only picks up input,output and formulas tools
#'
#'
#' @param ayx_path the path of Alteryx workflow
#' @param output_xlsx the path of output file. Must be a .xlsx file
#'
#' @export
#' @import data.table
#' @import writexl
#' @import xml2
#' @import tools
#'
#' @examples
#' \dontrun{
#' ayx_documentation("myworkflow.yxdb","documentation.xlsx")
#' }
ayx_documentation <- function(ayx_path,output_xlsx){

  if (!isTRUE(length(ayx_path)==1 && length(output_xlsx)==1)) {
    stop("Input and output length must be one")
  }


  if (file_ext(ayx_path)!="yxmd") {
    stop("Required Alteryx Workflow path ending with yxmd")
  }

  if (file_ext(output_xlsx)!="xlsx") {
    stop("Output must be a target place ending with xlsx")
  }

  ayx_xml <- read_xml(ayx_path)
  nodes_set <- xml_find_all(ayx_xml,"//Node")
  list_result <- lapply(nodes_set,ayx_extract_node)
  result <- rbindlist(list_result[!vapply(list_result,function(x) all(is.na(x)),logical(1))])
  names(result) <- c("Tool_Name","Annotation","File","Formula","Formula Field")
  write_xlsx(list(Input =  result[Tool_Name=="AlteryxBasePluginsGui.DbFileInput.DbFileInput",],
                  Output =  result[Tool_Name=="AlteryxBasePluginsGui.DbFileOutput.DbFileOutput",],
                  Formula =  result[Tool_Name=="AlteryxBasePluginsGui.Formula.Formula",]),
             output_xlsx)
  # write_xlsx(result,
  #            output_xlsx)
}

#' Extract information of a simple node AKA:tools
#'
#' @param node
#'

#' @import xml2
#'
ayx_extract_node <- function(node){

  if (!xml_attr(xml_find_all(node,".//GuiSettings"),"Plugin")[1] %in% c("AlteryxBasePluginsGui.DbFileInput.DbFileInput",
                                                                        "AlteryxBasePluginsGui.DbFileOutput.DbFileOutput",
                                                                        "AlteryxBasePluginsGui.Formula.Formula")) {
    return(NA)
  } else {
    node_name <- xml_attr(xml_find_all(node,".//GuiSettings"),"Plugin")
    node_annotation <- xml_text(xml_find_all(node,".//DefaultAnnotationText"))
    node_file <- xml_text(xml_find_all(node,".//File"))
    node_formula_exp <- xml_attr(xml_find_all(node,".//FormulaField"),attr = "expression")
    node_formula_field_name <- xml_attr(xml_find_all(node,".//FormulaField"),attr = "field")
    return(list(node_name=node_name,
                node_annotation=node_annotation,
                node_file=node_file,
                node_formula_exp=node_formula_exp,
                node_formula_field_name=node_formula_field_name))
  }

}

