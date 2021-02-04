#procesamiento cendes
library(dplyr)
libro <- readxl::read_excel('bd/historico_cendes/26_01_2021_COVID_19_PROGRESION_VENEZUELA.xlsx',
                            sheet ='PROGRESION',col_names = FALSE)%>%
  .[c(-4,-5,-31:-49),-c(2:22)]%>%
  as.data.frame()
estados <- libro[4:28,1]

libro[1,1] <- NA

si_fechas <- !is.na(libro[1,])
fechas_historico <- as.Date(as.integer(libro[1,][!is.na(libro[1,])]),origin = "1899-12-30")

valores <- grepl('CONTAGIOS',libro[2,])

historico_estados <- libro[,acumulado]%>%
  t(.)%>%
  .[,-1:-3]%>%
  as.data.frame()


historico_estados<- apply(libro1,2,as.integer)%>%
  as.data.frame()

colnames(historico_estados) <- estados

historico_estados <- cbind(fechas_historico,historico_estados[1:dim(historico_estados)[1]-1,])


ggplot(data=historico_estados,aes(x=fechas, y=BOLIVAR))+
  geom_line() 

df_estados
View(df_estados)
df_estados[1:2,1:10]
historico_estados[4:5,1:10]

### Cifras:
#<i class="fa fa-file"></i>

```{r}


#valueBox(width = 3,actualizacion, paste("con info hasta:",disponible))#, icon = icon("ok", lib ="glyphicon"))


```