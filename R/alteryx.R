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
#' @param x the path of Alteryx workflow
#' @param output the path of output file. Must be a .xlsx file
#'
#' @export
#' @import data.table
#' @import writexl
#' @import xml2
#'
#'
#' @examples
#' ayx_documentation("myworkflow.yxdb","documentation.xlsx")
ayx_documentation <- function(x,output){
  ayx_xml <- read_xml(x)
  nodes_set <- xml_find_all(ayx_xml,"//Node")

  result <- rbindlist(lapply(nodes_set,ayx_extract_node))
  names(result) <- c("Tool Name","Annotation","File","Formula","Formula Field")
  write_xlsx(result[rowMeans(result=="",na.rm = TRUE)!=1,],output)
}

#' Extract information of a simple node AKA:tools
#'
#' @param node
#'

#' @import xml2
#'
ayx_extract_node <- function(node){

  if (!xml_attr(xml_find_all(node,".//GuiSettings"),"Plugin")[1] %in% c("AlteryxBasePluginsGui.DbFileOutput.DbFileOutput",
                                                                        "AlteryxBasePluginsGui.DbFileOutput.DbFileOutput",
                                                                        "AlteryxBasePluginsGui.Formula.Formula")) {
    return(list(node_name="",
                node_annotation="",
                node_file="",
                node_formula_exp="",
                node_formula_field_name=""))
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

