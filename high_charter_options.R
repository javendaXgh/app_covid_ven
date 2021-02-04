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