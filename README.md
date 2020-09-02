**README**

"run_analysis" is a simple scrpit written in R language that 
performs a simple analysis in test and train datasets, contained
in the UCI HAR Dataset folder and returns a new dataframe that contains
the mean of all mean and std variables, grouped by activity and type
(see CodeBook.md for further details).

You can run this script after sourced it by typing "run()".
If your UCI folder isn't in your working directory, you can also
open type and train datasets by yourself and pass them by calling
"runscript(name_of_typedataset_variable, name_of_traindataset_variable)" 
example: runscript(testds, trainds)
