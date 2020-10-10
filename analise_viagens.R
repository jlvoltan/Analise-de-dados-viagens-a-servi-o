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



