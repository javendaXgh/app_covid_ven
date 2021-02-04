
#############variables



########
actualizacion <- function(){
  source('variables.R')
  
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
  
  if(dim(df1)[1]>0){
    df1_actualizada <- df1
    fecha_nueva <- df1[dim(df1)[1],1]
    fecha_actualizacion <- Sys.Date()
    fecha_vieja <- readRDS('fecha_vieja.rds')
    
    if(fecha_vieja<fecha_nueva){
      df2 <- jsonlite::fromJSON('https://covid19.patria.org.ve/api/v1/summary')
      if(length(df2)>0){
        df_gr_edades <- readRDS('data/df_gr_edades.rds')
        df_genero<- readRDS('data/df_genero.rds')
        df_estados<- readRDS('data/df_estados.rds')
        por_grupo_edad <-as.integer( unlist(df2[[1]][2]))
        df_gr_edades[(dim(df_gr_edades)[1]+1),1] <- fecha_nueva
        df_gr_edades[dim(df_gr_edades)[1],2:(length(names_grupo_edad)+1)] <- por_grupo_edad
        
        ##genero
        genero <- c(as.integer(unlist(df2[[1]][[3]][1])),as.integer(unlist(df2[[1]][[3]][2])))
        df_genero[dim(df_genero)[1]+1,1] <- fecha_nueva
        df_genero[dim(df_genero)[1],2:3] <-genero
        df_genero[,4] <- c(0,diff(df_genero[,2]))
        df_genero[,5] <- c(0,diff(df_genero[,3]))
        ##estados
        estados <- as.integer(unlist(df2[[1]][[4]]))
        df_estados[dim(df_estados)[1]+1,1] <- fecha_nueva
        df_estados[dim(df_estados)[1],2:26] <-estados
        df_estados_dif <- apply(df_estados[,2:26],2,diff)
        df_estados_dif <- rbind(rep(0,25),df_estados_dif)
        df_estados[,27:51] <- df_estados_dif
        
        #######transformacion df1
        df1_tiddy <- df1%>%
          data.table::setnames(
            old = df1 %>% names(),
            new = names2)%>%
          pivot_longer(
            cols = starts_with(names(df1)[2:8]),
            names_to = "tipo",
            #names_prefix = "wk",
            values_to = "valor",
            values_drop_na = TRUE)
        
        
        #############
        
        df_gr_estados <- data.frame(estados=names(df_estados)[2:26],
                                    totales=as.integer(df_estados[dim(df_estados)[1],2:26]),
                                    nuevos=as.integer(df_estados[dim(df_estados)[1],27:51]),
                                    stringsAsFactors = FALSE)
        df_estados_raw <- df_estados[,c(1:26)]
        
        
        ##############
        df_grafico_edades <- data.frame(grupo=str_replace_all(names(df_gr_edades)[2:11],'_|rango',' ') ,valor=as.numeric(df_gr_edades[dim(df_gr_edades)[1],2:11]))
        
        
        ##############
        df_grafico_genero <- data.frame(sexo=c('masculino','femenino'), 
                                        valores=as.numeric(df_genero[dim(df_genero)[1],2:3]))
        
        fecha_vieja <- fecha_nueva
        saveRDS(df_estados,paste0('bd/estados/df_estados_',fecha_nueva,'.rds'))
        saveRDS(df_estados,paste0('data/df_estados.rds'))
        saveRDS(df_genero,paste0('bd/genero/df_genero_',fecha_nueva,'.rds'))
        saveRDS(df_gr_edades,paste0('bd/edades/df_gr_edades_',fecha_nueva,'.rds'))
        saveRDS(df2,paste0('bd/df2/df2_',fecha_nueva,'.rds'))
        saveRDS(df1_actualizada, paste0('bd/df1/df1_',fecha_nueva,'.rds'))
        saveRDS(df1,'data/df1.rds')
        saveRDS(df1_tiddy,'data/df1_tiddy.rds')
        saveRDS(df_gr_estados,'data/df_gr_estados.rds')
        saveRDS(df_genero,'data/df_genero.rds')
        saveRDS(df_gr_edades,'data/df_gr_edades.rds')
        saveRDS(fecha_actualizacion,'data/fecha_actualizacion.rds')
        saveRDS(fecha_nueva,'data/fecha_nueva.rds')
        saveRDS(df_grafico_edades,'data/df_grafico_edades.rds')
        saveRDS(df_grafico_genero,'data/df_grafico_genero.rds')
        saveRDS(fecha_nueva,'fecha_vieja.rds')
        xlsx::write.xlsx(df1, 'data/datos_historicos.xls')
        xlsx::write.xlsx(df_estados_raw,'data/historico_estados.xls')
        rmarkdown::render('covid_intento.RMD') 
        file.copy('covid_intento.html','/Users/josemiguelavendanoinfante/R/sites/javenda_site/static/covid19venezuela.html', overwrite = TRUE)
      }
    }
  }
}

actualizacion()


ver <- readRDS('bd/df2/df2_2021-02-02.rds')

