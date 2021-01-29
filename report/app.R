if (!require(librarian)){
  install.packages("librarian")
  library(librarian)
}
shelf(glue, shiny, DT)
options(shiny.port = 1234)

web_url = "http://127.0.0.1:4321/"

ui <- navbarPage(
  windowTitle = "MarineEnergy.app",
  title = div(a(
    img(src="images/logo-horizontal.svg",       class="default"),
    img(src="images/logo-horizontal-white.svg", class="white"),
    href  = web_url,
    class = "navbar-brand")),
  id = 'nav',
  tags$head(
    includeHTML("www/head.html")),
  tags$body(
    includeHTML("www/body.html")),
  tabPanel(
    "Projects",
    "TBD"),
  tabPanel(
    "Regulations",
    "TBD"),
  tabPanel(
    "Interactions",
    "TBD"),
  tabPanel(
    "Configure",
    "TBD"),
  tabPanel(
    "Management",
    "TBD"),
  tabPanel(
    "Literature",
    selectInput(
      "species", 
      "Select Species", choices = c("setosa", "virginica"), 
      multiple = T, selected = NULL),
    dataTableOutput("tbl1")),
  tabPanel(
    "Spatial",
    "TBD"),
  tabPanel(
    "Reports",
    "TBD"),
  div(
    class = "footer",
    includeHTML("www/footer.html"))
)

server <- function(input, output, session) {
  observe({
    query <- parseQueryString(session$clientData$url_search)
    if(!is.null(query$nav)) {
      nav <- strsplit(query$nav,"/")[[1]]
      updateTabsetPanel(session, 'nav', nav)
    }
  })
  
  output$distPlot <- renderPlot({
    hist(rnorm(100), col = 'darkgray', border = 'white')
  })
  
  output$tbl1 <- renderDataTable({
    tmp <- iris
    if(!is.null(input$species))
      tmp <- iris[which(iris$Species %in% input$species), ]
    
    datatable(tmp)
  })
}

shinyApp(ui = ui, server = server)