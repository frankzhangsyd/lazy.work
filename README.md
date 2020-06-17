lazy.work
=========

Some R functions to save your time at Work

![](https://www.r-pkg.org/badges/version/lazy.work)

Install
-------

    devtools::install_github("frankzhangsyd/lazy.work")

Main Usages
-----------

### Alteryx Related

**ayx\_fl** : Convert a vector of column names and a function
symbol`("+","-","*","/")` across all.

ie:

    ayx_fl(c("a","b"))

    ## [1] "[a]+[b]"

**ayx\_documentation** : Extract information of
*Input*,*Output*,*Formula* tools in Alteryx and save to user pointed
excel path. (have to end with `xlsx`)

ie:

    ayx_documentation("Your/path/of/the/alteryx/workflow.yxmd",
                      "Your/path/of/the/output/excel/file.xlsx")

### Excel related

**excel\_column\_letters**: A character vector contains all the column
names (ie A,B,C,D) for excel.

    # First 5 columns
    excel_column_letters[1:5]

    ## [1] "A" "B" "C" "D" "E"

    # Generate between two columns

    excel_column_letters[which(excel_column_letters == "AE"):which(excel_column_letters == "AH")]

    ## [1] "AE" "AF" "AG" "AH"
