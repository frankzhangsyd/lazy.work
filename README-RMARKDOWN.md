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

### Manipulation of files

**file\_copy2\_folder** :copy files or files in a folder to another
place with adding prefix or suffix.

ie:

    file_copy2_folder(from = "my folder path",to = c("destination_folder1","destination_folder2"),affix_type = "prefix",affix = "Prefix_",from_is_folder = TRUE)

**file\_cut2\_folder** :copy files or files in a folder to another place
with adding prefix or suffix.

ie:

    file_cut2_folder(from = "my folder path",to = "destination_folder1",affix_type = "prefix",affix = "Prefix_",from_is_folder = TRUE)
