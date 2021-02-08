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



df1 <- readRDS('/Users/josemiguelavendanoinfante/R/shiny/app_covid_ven/data/df1.rds')
df_gr_estados <- readRDS('/Users/josemiguelavendanoinfante/R/shiny/app_covid_ven/data/df_gr_estados.rds')
df1_tiddy <- readRDS('/Users/josemiguelavendanoinfante/R/shiny/app_covid_ven/data/df1_tiddy.rds')
fecha_nueva <- readRDS('/Users/josemiguelavendanoinfante/R/shiny/app_covid_ven/data/fecha_nueva.rds')
#actualizacion <- readRDS('data/fecha_actualizacion.rds')
#print(actualizacion)
df_grafico_edades <- readRDS('/Users/josemiguelavendanoinfante/R/shiny/app_covid_ven/data/df_grafico_edades.rds')
actualizacion <- readRDS('/Users/josemiguelavendanoinfante/R/shiny/app_covid_ven/data/fecha_actualizacion.rds')%>%
  format.Date(.,'%d/%m/%Y')
disponible <- max(df1$fecha)%>%
  format.Date(.,'%d/%m/%Y')