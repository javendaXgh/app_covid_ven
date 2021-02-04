
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
             color = 'rgb(107, 107, 107)')))%>%
  layout(legend = list(orientation = "h",   # show entries horizontally
                       xanchor = "center",  # use center of legend as anchor
                       x = .5,y=-.2))     




nuevos_estados <- hchart(df_gr_estados,'bar',hcaes(x=estados, y=nuevos,hoover=nuevos),color='#2a9d8f')%>%
  hc_title(text = paste("Casos nuevos por estado en fecha",fecha_nueva%>%format.Date(.,'%d/%m/%Y')))%>%
  config(locale = 'es')

fig2 <- plot_ly(df1, x = ~fecha, y = ~`fallecidos nuevos`, type = 'bar',marker = list(color = '#4a4e69'), name='Fallecidos nuevos')%>%
  layout(xaxis = list(title = "Fallecidos Nuevos"),yaxis = list(title = ""),margin = list(b = 100))%>% 
  config(locale = 'es')

#fig2 #"Fallecidos Nuevos"

fig3 <- plot_ly(df1, x = ~fecha, y = ~`confirmados nuevos`, type = 'bar',  marker = list(color = '#d62828'), name='Confirmados nuevos')%>%
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

fig6 <- plot_ly(df1, x = ~fecha, y = ~`confirmados (acumulados)`,  mode = 'lines',marker = list(color = '#d62828') )%>% 
  layout(xaxis = list(title = "Confirmados (acumulados)"),yaxis = list(title = ""),margin = list(b = 100))%>% 
  config(locale = 'es')
#fig6 #"confirmados acumulado"

fig7 <- plot_ly(df1, x = ~fecha, y = ~`recuperados (acumulados)`,  mode = 'lines',marker=list(color = '#0077b6') )%>% 
  layout(xaxis = list(title = "Recuperados (acumulados)"),yaxis = list(title = ""),margin = list(b = 100))%>% 
  config(locale = 'es')
#fig7#"recuperados acumulado"

fig8 <- plot_ly(df1, x = ~fecha, y = ~`fallecidos (acumulados)`,  mode = 'lines',marker=list(color = '#4a4e69') )%>% 
  layout(xaxis = list(title = "Fallecidos (acumulados)"),yaxis = list(title = ""),margin = list(b = 100))%>% 
  config(locale = 'es')

fig9 <- hchart(df_gr_estados, "treemap", hcaes(x = estados, value = totales, color = totales, hoover=totales))%>%
  hc_title(text = "Total de casos acumulados por estado") #%>% 
#hc_size(height = 700)


edades <- plot_ly(df_grafico_edades, x = ~grupo, y = ~valor, type = 'bar', color=~valor,textposition = 'auto',text=~valor)%>%
  layout(title = 'Distribución por edades',title = list(font = 'arial'),
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

