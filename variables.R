library(dplyr)
library(tidyverse)

names2 <- c('fecha','activos', 'confirmados (acumulados)', 'confirmados nuevos', 
            'recuperados (acumulados)','recuperados nuevos', 'fallecidos (acumulados)', 
            'fallecidos nuevos')

df2 <- readRDS('df_2_20200121.rds')
###nombres  data.frames
names_grupo_edad <- names(unlist(df2[[1]][2]))%>%
  substr(.,12,nchar(.))%>%
  paste0('rango_edad_',.)

names_genero <- names(unlist(df2[[1]][3]))%>%
  substr(.,10,nchar(.))
names_genero2 <- paste0(names_genero,'_nuevos')
names_genero <- c(names_genero,names_genero2)

names_estados <- names((unlist(df2[[1]][4])))%>%
  substr(.,9,nchar(.))
names_estados2 <- paste0(names_estados,'_nuevos')
names_estados <- c(names_estados,names_estados2)


############vectores poblado df2
por_grupo_edad <-as.integer( unlist(df2[[1]][2]))
genero <- c(as.integer(unlist(df2[[1]][[3]][1])),as.integer(unlist(df2[[1]][[3]][2])),0,0)
estados <- c(as.integer(unlist(df2[[1]][[4]])),rep(0,25))



