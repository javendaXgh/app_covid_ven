library(shinydashboard)
library(shinyjs)
library(plotly)
library(highcharter)
library(emo)
library(stringr)
library(ggplot2)

titulo <- paste0('                Datos COVID 19 Venezuela ',emo::ji("venezuela"))

textos <- 'toda la información y datos son obtenidos de la página https://covid19.patria.org.ve/estadisticas-venezuela/ y 
han sido procesados  y acumulados por José Miguel Avendaño I, sin modificar ni añadir ningún valor adicional.
Este sitio funciona como complemento y ofrece visualizaciones parecidas o adicionales a las
ya mostradas en dicha página. No se contempla con los datos contenidos acá realizar
proyecciones o estimaciones sobre el avance del COVID 19 en Venezuela.

La calidad de los datos se asume en que son los oficiales. La actualización de esta página queda sujeta a 
que la información sea actualizada en la fuente de datos señalada.

Esta página está en su version beta y cualquier falla o discrepancia con los datos 
originales se agradece informarla a la dirección de correo javenda@gmail.com
'
ui <- dashboardPage(
  #setBackgroundColor(color = "#003049"),
  
  dashboardHeader(title = titulo,titleWidth = 600 ),
  
  dashboardSidebar('datos obtenidos de la pagina patria'),
  dashboardBody(
    tags$head(tags$style(HTML(' 
                                /* logo */
                                .skin-blue .main-header .logo {
                                background-color: #003049;
                                font-size: 40px;
                                font-weight: bold;
                                }
                                
                                .col-sm-12 {
                                padding-right:20px;
                                } 
                                /* navbar (rest of the header) */
                                .skin-blue .main-header .navbar {
                                background-color: #003049;
                                }
                                /* navbar (rest of the header) */
                                .skin-blue .main-header .navbar {
                                background-color: #003049;
                                }
                                /* navbar (rest of the header) */
                                .sidebar-toggle  {
                                background-color: #003049;
                                }
                                
                                .sidebar-toggle
                              /* body */
                                .content-wrapper, .right-side {
                                background-color: #003049;
                                }
                                /* valueBoxOutput */
                                .content-wrapper, #progressBox .inner  {
                                background-color: #4a4e69;
                                }
                                /* valueBoxOutput */
                                .content-wrapper, #approvalBox .inner  {
                                background-color: #0077b6;
                                }
                                /* valueBoxOutput */
                                .content-wrapper, #contagiados .inner  {
                                background-color: #d62828;
                                }
                                .content-wrapper, .inner  {
                                align: center;
                                }
                                /* valueBoxOutput */
                                .content-wrapper, valueBoxOutput  {
                                background-color: #003049;
                                }
                                
                              
                              '
                              ))),
    useShinyjs(),
    fluidRow(
      # A static valueBox
      
      
      # Dynamic valueBoxes
      
      valueBoxOutput(width = 3,"contagiados"),
      valueBoxOutput(width = 3,"progressBox"),
      valueBoxOutput(width = 3,"approvalBox"),
      valueBoxOutput(width = 3,"fecha")

      
      #,tags$style(HTML("#approvalBox{color: #4a4e69;}"))
      
      
    
    ),
    fluidRow(
      
      # Clicking this will increment the progress amount
      box(plotlyOutput("todos"), status = "primary", solidHeader = F
          , collapsible = T, width = 12
          , column( 12,align="right" )),
      
      
      
      #box(width = 1),
      box(width=6,plotlyOutput('fig6')),#6382745 edades nuevos estados 9
      box(width=6, plotlyOutput('fig3')),
     
      box(width = 6, plotlyOutput('fig8')),
      box(width = 6, plotlyOutput('fig2')),
      box(width = 6, plotlyOutput('fig7')),
      box(width = 6, plotlyOutput('fig4')),
      box(width = 6, plotlyOutput('fig5')),
      box(width = 6, plotlyOutput('edades')),
      box(width = 6, highchartOutput('nuevos_estados'),align='left'),
      box(width = 6, highchartOutput('fig9'), align='left')
      
      #p(id='l1',strong(textos), width=6),
      #tags$style(HTML("#l1{color: #fefae0;}, "))
    ,
    fluidRow(
      box(width = 12, div(class = "my-class", p(textos), align='center'))
    )
    )
  )
)

server <- function(input, output) {
  addClass(selector = "body", class = "sidebar-collapse")
  #shinyjs::removeClass(selector = "body", class = "sidebar-collapse")

  
  source('high_charter_options.R')
  source('0_carga_datos.R')
  source('1_generacion_graficosR.R')

  output$todos <- renderPlotly({
    todos})
  
  output$fig2 <- renderPlotly({
    fig2})
  output$fig3 <- renderPlotly({
    fig3})
  output$fig4 <- renderPlotly({
    fig4})
  output$fig5 <- renderPlotly({
    fig5})
  output$fig6 <- renderPlotly({
    fig6})
  output$fig7 <- renderPlotly({
    fig7})
  output$fig8 <- renderPlotly({
    fig8})
  output$edades <- renderPlotly({
    edades})
  
  output$nuevos_estados <- renderHighchart({
    nuevos_estados})
  output$fig9 <- renderHighchart({
    fig9})
  
  
  output$contagiados <- renderValueBox({
    valueBox(
      str_replace_all(formatC(df1[dim(df1)[1],3], format="f", big.mark=",", digits=0),',','.')
      , "Contagiados", icon = icon("ambulance", lib = "font-awesome"),#icon("remove", lib = "glyphicon")
      color = "red"
    )
  })
  
  
  output$progressBox <- renderValueBox({
    valueBox(
      str_replace_all(formatC(df1[dim(df1)[1],7], format="f", big.mark=",", digits=0),',','.')
      , "Fallecidos", icon = icon("arrow-alt-circle-down", lib = "font-awesome")
      #,color = "black"
    )
  })
  
  output$approvalBox <- renderValueBox({
    valueBox(
      str_replace_all(formatC(df1[dim(df1)[1],5], format="f", big.mark=",", digits=0),',','.')
      , "Recuperados", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "yellow"
    )
  }) 

  output$fecha <- renderValueBox({
    valueBox(actualizacion, paste("con info hasta:",disponible), icon = icon("ok", lib = "glyphicon"),
      color = "green"
    )
  })

  
}

shinyApp(ui, server)