# StarvationTimeSeriesPlots
Components necessary to run RShiny app facilitating plotting of gene expression over time throughout starvation.

There are a few options available to run the app on your computer, which are outlined in additional detail here: https://shiny.rstudio.com/tutorial/written-tutorial/lesson7/

Option 1
To run the app locally, download the app.R file and .csv file containing gene expression information, and put these into a new directory on your computer (e.g. StarvationTimeSeriesPlots).
Ensure that you have the shiny package installed on your computer: install.packages("shiny")
Once it is installed: library(shiny)
Then you can run the following command, where the StarvationTimeSeriesPlots is the folder containing the app and necessary files to run it and 'path/to/' is replaced by the full path on your computer to the folder: runApp("/path/to/StarvationTimeSeriesPlots")

Option 2
Once Shiny is installed on your R session, you can use runGithub to launch the app from this Github folder. You can run the app with the following command:
runGitHub("StarvationTimeSeriesPlots", "amykwebster",ref = "main")
