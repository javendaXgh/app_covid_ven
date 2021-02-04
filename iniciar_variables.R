library(dplyr)

#####################df1
df1 <- jsonlite::fromJSON('https://covid19.patria.org.ve/api/v1/timeline')%>%
  mutate(fecha=as.Date(Date))%>%
  mutate(Activos=as.integer(Active$Count))%>%
  mutate(conf_acu=as.integer(Confirmed$Count))%>%
  mutate(conf_nvos=as.integer(Confirmed$New))%>%
  mutate(recu_acu=as.integer(Recovered$Count))%>%
  mutate(recu_nvos=as.integer(Recovered$New))%>%
  mutate(falle_acu=as.integer(Deaths$Count))%>%
  mutate(falle_nvos=as.integer(Deaths$New))%>%
  select(-c(Confirmed,Recovered,Deaths,Active, Date, DateTS))

#####################df2

#f2 <- jsonlite::fromJSON('https://covid19.patria.org.ve/api/v1/summary')
df2 <- readRDS('df_2_20200121.rds')
fecha_nueva <- df1[dim(df1)[1],1]-1
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

############crear dfs de df2

###df_genero
df_genero <- data.frame(fecha=fecha_nueva,male=genero[1],female=genero[2], acum_male=genero[3], acum_female=genero[4])

#df_gr_edades
df_gr_edades <- data.frame(fecha=fecha_nueva,
                           por_grupo_edad[1],
                           por_grupo_edad[2],
                           por_grupo_edad[3],
                           por_grupo_edad[4],
                           por_grupo_edad[5],
                           por_grupo_edad[6],
                           por_grupo_edad[7],
                           por_grupo_edad[8],
                           por_grupo_edad[9],
                           por_grupo_edad[10])

nombres_df_gr_edades <- c('fecha',names_grupo_edad)
names(df_gr_edades) <- nombres_df_gr_edades
names2 <- c('fecha','activos', 'casos acumulados', 'casos nuevos', 'recuperados acumulados','recuperados nuevos', 'fallecidos acumulados', 'fallecidos nuevos')

######
df_estados <- data.frame('fecha'=fecha_nueva,estados[1],estados[2],estados[3],estados[4],estados[5],estados[6],
                         estados[7],estados[8],estados[9],estados[10],estados[11],estados[12],
                         estados[13],estados[14],estados[15],estados[16],estados[17],estados[18],
                         estados[19],estados[20],estados[21],estados[22],estados[23],estados[24],
                         estados[25],0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
nombres_df_estados <- c('fecha', names_estados)
names(df_estados) <- nombres_df_estados

names2 <- c('fecha','activos', 'casos acumulados', 'casos nuevos', 'recuperados acumulados','recuperados nuevos', 'fallecidos acumulados', 'fallecidos nuevos')


#fecha_vieja<- df[dim(df)[1]-1,1]
#incializar dfs

df_gr_edades
df_genero
df_estados

