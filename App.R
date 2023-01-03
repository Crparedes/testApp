library(shiny)

ui <- fluidPage(
  actionButton('brwz', label = tags$b('Pausar')),
  # Upload zip files
  fileInput("file", "Upload Zip file"),
  # action button to unzip the file
  actionButton("unzip", "Unzip Files"),
  
  # to display the metadata of the zipped file
  tableOutput("filedf"),
  
  # to display the list of unzipped files
  tableOutput("zipped")
  
)

server <- function(input, output, session) {
  
  observeEvent(input$brwz, browser())
  
  output$filedf <- renderTable({
    if(is.null(input$file)){return ()}
    input$file # the file input data frame object that contains the file attributes
  })
  
  
  # Unzipping files on click of button and then rendering the result to dataframe
  observeEvent(input$unzip,
               output$zipped <- renderTable({
                 unzip(input$file$datapath, list = TRUE, exdir = getwd())
               })
               
  )
  
  
}

shinyApp(ui, server)