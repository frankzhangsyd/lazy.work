lazy.work
=========

Some R functions to save your time at Work

Install
-------

    devtools::install_github("frankzhangsyd/lazy.work")

Main Usages
-----------

### Alteryx Related

**ayx\_fl**:convert a vector of column names and a function
symbol`("+","-","*","/")` across all.

ie:

    ayx_fl(c("a","b"))

    ## [1] "[a]+[b]"
