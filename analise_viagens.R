#Carregamento 
passagens <- read.csv(
  file = "C:/Users/jlvol/OneDrive/Área de Trabalho/Projeto git R/2020_Passagem.csv",
  sep = ";",
  dec = ","
)

#Observando os dados carregados
head(passagens)
View(passagens)
dim(passagens)


#Dados estatísticos básico
summary(passagens)
summary(passagens$Valor.da.passagem)


#Verificando o tipo de dados de cada coluna
#install.packages("dplyr")
library(dplyr)
glimpse(passagens)

#As datas aparecem como factor, iremos fazer a conversão
passagens$Data.compra <- as.Date(passagens$Data.da.emissão.compra, "%d/%m/%Y")
passagens$Data.compra.formatada <- format(passagens$Data.compra, "%Y-%m") 
passagens$Data.compra.formatada

#Explorando os dados obtidos
hist(passagens$Valor.da.passagem)
boxplot(passagens$Valor.da.passagem)
sd(passagens$Valor.da.passagem)

#Valores vazios
colSums(is.na(passagens))

#Em algumas partes, usa-se a expressão "Sem Informação" ao invés da informação vazia

nomeColunas <- colnames(passagens)

print("Pais...Destino.volta")
sum(passagens$Pais...Destino.volta == "Sem Informação")

#Valores inconsistentes
#Considerando-se que uma passsagem custa mais do que R$ 10.00
sum(passagens$Valor.da.passagem < 10)

#Analisando algumas colunas
str(passagens$Meio.de.transporte)
table(passagens$Meio.de.transporte)



####Questionamentos:
  


#1º Qual a passagem rodoviária mais cara?
maior_valor_rodoviaria <- max(passagens$Valor.da.passagem[passagens$Meio.de.transporte == "Rodoviário"])
maior_valor_rodoviaria
posicao_maior_valor <- which(passagens$Valor.da.passagem==maior_valor_rodoviaria)
passagens[posicao_maior_valor,]


#2º Quais os países com média de passagem mais caras (destino)?

passagens2 <- group_by(passagens, País...Destino.ida)

summarise(passagens2, media_gasta= mean(Valor.da.passagem,na.rm=TRUE)) %>% arrange(desc(media_gasta))

#3º Quais os países mais visitados?

count(passagens,País...Destino.ida) %>%
  arrange(desc(n))

#4º Quais os meios de transporte mais utilizados?

count(passagens,Meio.de.transporte) %>%
  arrange(desc(n))

#5º Em qual dia se comprou mais passagens no ano?

count(passagens,Data.compra) %>%
  arrange(desc(n))
#[1]    2020-03-06 2116

#6º Em qual mês se comprou mais passagens no ano?

meses_compras <- count(passagens,Data.compra.formatada) %>%
  arrange(desc(n))
meses_compras 
#[1]    2020-02 21774

library(ggplot2)
ggplot(meses_compras,aes(y=Data.compra.formatada, x= n) )+
  geom_bar(stat = "identity",fill = "tomato")+
  theme_classic() +
  xlab("Quantidade") + 
  ylab("Meses do ano") 
