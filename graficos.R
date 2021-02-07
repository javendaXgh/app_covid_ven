
propuesta <- df1 %>%
  pivot_longer(
    cols = starts_with(names(df1)[2:8]),
    names_to = "tipo",
    #names_prefix = "wk",
    values_to = "valor",
    values_drop_na = TRUE
  )%>%
  rename(names2)





#######

ggplot(df_grafico_genero, aes(x=sexo, y=valores, fill=sexo,label =valores )) +  
  geom_bar( stat = "identity")+
  scale_fill_manual(values = c("#2a9d8f", "#f4a261") ) +
  geom_text(size = 3, position = position_stack(vjust = 0.5))+
  theme(legend.position="none")
  


