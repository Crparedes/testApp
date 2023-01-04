library(shiny)

ui <- fluidPage(
  tags$h2('Uploading of a CSV file:'), fileInput("file", "Upload file", accept = '.csv'),
  tags$h3('File metadata:'), tableOutput("fileMetDat"),
  tags$hr(),
  tags$h3('File data:'), tableOutput("fileData")
)

server <- function(input, output, session) {
  
  output$fileMetDat <- renderTable({
    if(is.null(input$file)){return ()}
    input$file
  })
  
  output$fileData <- renderTable({
    if(is.null(input$file)){return ()}
    read.csv(input$file$datapath, sep = ';')
  })
}

shinyApp(ui, server)