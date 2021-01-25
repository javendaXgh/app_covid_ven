library(shinydashboard)
library(shinyjs)
library(plotly)
library(highcharter)
library(emo)
library(stringr)


ui <- dashboardPage(
  dashboardHeader(title = "Datos COVID 19 Venezuela"),
  dashboardSidebar('datos obtenidos de la pagina patria'),
  dashboardBody(
    useShinyjs(),
    fluidRow(
      # A static valueBox
      
      
      # Dynamic valueBoxes
      valueBoxOutput(width = 3,"contagiados"),
      valueBoxOutput(width = 3,"progressBox"),
      valueBoxOutput(width = 3,"approvalBox"),
      valueBoxOutput(width = 3,"fecha")
    
    ),
    fluidRow(
      # Clicking this will increment the progress amount
      box(width = 12,plotlyOutput("todos")),
      box(width = 6, plotlyOutput('fig6')),
      box(width = 6, plotlyOutput('fig3')),
      box(width = 6, plotlyOutput('fig7')),
      box(width = 6, plotlyOutput('fig4')),
      box(width = 6, plotlyOutput('fig8')),
      box(width = 6, plotlyOutput('fig2')),
      box(width = 6, plotlyOutput('fig5')),
      box(width = 6, plotlyOutput('edades')),
      box(width = 6, highchartOutput('nuevos_estados')),
      box(width = 6, highchartOutput('fig9'))
    )
  )
)

server <- function(input, output) {
  addClass(selector = "body", class = "sidebar-collapse")
  #shinyjs::removeClass(selector = "body", class = "sidebar-collapse")

  
  lang <- getOption("highcharter.lang")
  lang$months <- c('Enero', 'Febrero', 'Marzo','Abril', 'Mayo',"Junio",'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre')
  lang$shortMonths <- c('ene','feb','mar','abr','may','jun','jul','ago','sep','oct','nov','dic')
  lang$downloadJPEG <- 'descargar imagen JPEG'
  lang$downloadPDF <- 'descargar documento PDF'
  lang$downloadPNG <- 'descargar SVG imagen vectorizada'
  lang$drillUpText <-  "Regresar a {series.name}"
  lang$loading <- 'Cargando...'
  lang$weekdays <- c('Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado')
  #lang$exportButtonTitle <- "Exportar"
  #lang$printButtonTitle <- "Importar"
  #lang$rangeSelectorFrom <-  "Desde"
  #lang$rangeSelectorTo <-  "Hasta"
  lang$rangeSelectorZoom <-  "Período"
  lang$downloadPNG <- 'Descargar imagen PNG'
  
  lang$printChart <- 'Imprimir'
  lang$resetZoom <- 'Reiniciar zoom'
  lang$decimalPoint <-  '.'
  #lang$noData <- 'sin datos que mostrar'
  lang$resetZoomTitle <- 'reiniciar zoom nivel 1:1'
  
  lang$decimalPoint <- "."
  options(highcharter.lang = lang)
  df1 <- readRDS('data/df1.rds')
  df_gr_estados <- readRDS('data/df_gr_estados.rds')
  df1_tiddy <- readRDS('data/df1_tiddy.rds')
  fecha_nueva <- readRDS('data/fecha_nueva.rds')
  #actualizacion <- readRDS('data/fecha_actualizacion.rds')
  #print(actualizacion)
  df_grafico_edades <- readRDS('data/df_grafico_edades.rds')
  actualizacion <- readRDS('data/fecha_actualizacion.rds')%>%
    format.Date(.,'%d/%m/%Y')
  
  todos <- plot_ly(df1_tiddy, x = ~fecha, y = ~valor,  mode = 'lines',  hoverinfo=~tipo, color=~tipo,
                   #,marker=list(color=c('#fb8500','#d62828','#d62828','#0077b6','#0077b6','#4a4e69'))
                   legend = list(x = 0, y = 1, bgcolor = 'rgba(255, 255, 255, 0)', bordercolor = 'rgba(255, 255, 255, 0)'))%>% 
    #layout(xaxis = list(title = ""),yaxis = list(title = ""),margin = list(b = 100))%>% 
    config(locale = 'es')%>%
    layout(title = paste('Datos oficiales COVID 19 en Venezuela ',emo::ji("venezuela")),
           xaxis = list(
             title = "",
             tickfont = list(
               size = 14,
               color = 'rgb(107, 107, 107)')),
           yaxis = list(
             title = 'valores',
             titlefont = list(
               size = 16,
               color = 'rgb(107, 107, 107)'),
             tickfont = list(
               size = 14,
               color = 'rgb(107, 107, 107)')))
  
  
  
  
  nuevos_estados <- hchart(df_gr_estados,'bar',hcaes(x=estados, y=nuevos,hoover=nuevos),color='#2a9d8f')%>%
    hc_title(text = paste("Casos nuevos por estado a la fecha",fecha_nueva))%>%
    config(locale = 'es')
  
  fig2 <- plot_ly(df1, x = ~fecha, y = ~`fallecidos nuevos`, type = 'bar',marker = list(color = '#4a4e69'), name='Fallecidos nuevos')%>%
    layout(xaxis = list(title = "Fallecidos Nuevos"),yaxis = list(title = ""),margin = list(b = 100))%>% 
    config(locale = 'es')
  
  #fig2 #"Fallecidos Nuevos"
  
  fig3 <- plot_ly(df1, x = ~fecha, y = ~`casos nuevos`, type = 'bar',  marker = list(color = '#d62828'), name='Confirmados nuevos')%>%
    layout(xaxis = list(title = "Confirmados Nuevos"),yaxis = list(title = ""),margin = list(b = 100))%>% 
    config(locale = 'es')
  #fig3# "Confirmados Nuevos"
  
  fig4 <- plot_ly(df1, x = ~fecha, y = ~`recuperados nuevos`, type = 'bar',  marker = list(color = '#0077b6'), name='Confirmados nuevos')%>%
    layout(xaxis = list(title = "Recuperados Nuevos"),yaxis = list(title = ""),margin = list(b = 100))%>% 
    config(locale = 'es')
  #fig4 #"Recuperados Nuevos"
  
  fig5 <- plot_ly(df1, x = ~fecha, y = ~activos,  type = 'bar',  marker = list(color = '#fb8500'))%>% 
    layout(xaxis = list(title = "Activos por día"),yaxis = list(title = ""),margin = list(b = 100))%>% 
    config(locale = 'es')
  
  #fig5  #"Activos por día"
  
  fig6 <- plot_ly(df1, x = ~fecha, y = ~`casos acumulados`,  mode = 'lines',marker = list(color = '#d62828') )%>% 
    layout(xaxis = list(title = "confirmados acumulado"),yaxis = list(title = ""),margin = list(b = 100))%>% 
    config(locale = 'es')
  #fig6 #"confirmados acumulado"
  
  fig7 <- plot_ly(df1, x = ~fecha, y = ~`recuperados acumulados`,  mode = 'lines',marker=list(color = '#0077b6') )%>% 
    layout(xaxis = list(title = "recuperados acumulado"),yaxis = list(title = ""),margin = list(b = 100))%>% 
    config(locale = 'es')
  #fig7#"recuperados acumulado"
  
  fig8 <- plot_ly(df1, x = ~fecha, y = ~`fallecidos acumulados`,  mode = 'lines',marker=list(color = '#4a4e69') )%>% 
    layout(xaxis = list(title = "fallecidos acumulado"),yaxis = list(title = ""),margin = list(b = 100))%>% 
    config(locale = 'es')
  
  fig9 <- hchart(df_gr_estados, "treemap", hcaes(x = estados, value = totales, color = totales, hoover=totales))%>%
    hc_title(text = "Casos acumulados por estado") %>% 
    hc_size(height = 700)
  
  
  edades <- plot_ly(df_grafico_edades, x = ~grupo, y = ~valor, type = 'bar', color=~valor,textposition = 'auto',text=~valor)%>%
    layout(title = 'Distribución por edad',title = list(font = 'arial'),
           titlefont=list(size=20, color='#0077b6'),
           xaxis = list(
             title = "",
             tickfont = list(
               size = 14,
               color = 'rgb(107, 107, 107)')),
           yaxis = list(
             title = '',
             titlefont = list(
               size = 16,
               color = 'rgb(107, 107, 107)'),
             tickfont = list(
               size = 14,
               color = 'rgb(107, 107, 107)')),
           barmode = 'group', bargap = 0.15, bargroupgap = 0.1)
  
  
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
      , "Fallecidos", icon = icon("arrow-alt-circle-down", lib = "font-awesome"),
      color = "black"
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
    valueBox(actualizacion, "fecha actualización", icon = icon("ok", lib = "glyphicon"),
      color = "green"
    )
  })

  
}

shinyApp(ui, server)