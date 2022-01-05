library(shiny)
library(ggplot2)
library(rsconnect)


#setwd("/Users/amywebster/Documents/Baugh_PaperRevisions/AMA1_revisions/ShinyApp")
gene_averages<-read.csv("GeneAverages_input.csv",header = T)
Gene<-unique(gene_averages$genes)
# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel(div(HTML("Gene expression levels throughout starvation during L1 arrest in <i>Caenorhabditis elegans</i> nematodes"))),  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      
      selectizeInput(inputId = "var",
                  label = "Search and select gene(s):",
                  choices = Gene,
                  multiple=TRUE,
                  selected = "Y55D5A.5 daf-2")
      
    ),
    
 
    
    # Main panel for displaying outputs ----
    
    mainPanel(
     tabsetPanel(
       tabPanel("Plot",plotOutput(outputId = "distPlot"),downloadButton('downloadPdf',"Download Plot")),
       tabPanel("Experimental summary and citation",htmlOutput("hello"))
       #textOutput("selected_var")
     )
      # Output: Histogram ----
     
     
      
    )
  ),

)

server <- function(input, output) {
  

  output$distPlot <- renderPlot({
    
    
    ggplot(gene_averages[gene_averages$genes %in% input$var,],aes(x=hours,y=log2(x),color=genes),group=interaction(genes,samplenumber))+
      geom_point()+geom_line()+theme(aspect.ratio = 1)+theme_classic(base_size = 15)+
      labs(y="log2(counts-per-million reads)",x="Time starved (hours)")+theme(aspect.ratio = 1)
    
  })
  
  output$hello <- renderText({
    "<br><br>Please see our <a href = https://www.biorxiv.org/content/10.1101/2021.04.30.441514v1.full.pdf>publication</a> for full experimental details. <br><br>In brief, gravid adults were hypochlorite treated to obtain embryos, which were resuspended in S-basal (without cholesterol) at a density of 1/uL, then allowed to hatch and starve for the number of hours indicated. Bulk populations consisting of thousands of starved L1s were collected for mRNA-seq analysis for each of twelve time points spaninng early and late arrest. 4 biological replicates were collected for each time point.
    The only genes available to plot are those that met our filtering criteria and were differentially expressed at a false-discovery rate of 0.05 in an ANOVA-like test across all time points.
    <br><br>To run this app locally, please find the relevant files on our Github folder (amykwebster/StarvationTimeSeriesPlots). You will need R to run the application.
    <br><br>If you use results from this application in your publications, please cite us: <br>
     Webster AK, Chitrakar R, Baugh LR. Alternative somatic and germline gene-regulatory strategies during starvation-induced developmental arrest.
    bioRxiv 2021.04.30.441514; doi: https://doi.org/10.1101/2021.04.30.441514 "
    })
  
  plotInput <- 
    function(){
      ggplot(gene_averages[gene_averages$genes %in% input$var,],aes(x=hours,y=log2(x),color=genes),group=interaction(genes,samplenumber))+
       geom_point()+geom_line()+theme(aspect.ratio = 1)+theme_classic(base_size = 15)+
       labs(y="log2(counts-per-million reads)",x="Time starved (hours)")+theme(aspect.ratio = 1)
      }


  output$downloadPdf <- downloadHandler(
    filename = "save.png",
    content = function(file) {
      device <- function(..., width, height) {
        grDevices::png(..., width = width, height = height,
                       res = 300, units = "in")
      }
      ggsave(file, plot = plotInput(), device = device)
    }
  )
}


# Create Shiny app ----
shinyApp(ui = ui, server = server)


