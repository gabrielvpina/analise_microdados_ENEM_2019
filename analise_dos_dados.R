# Esse arquivo utilizará os microdados_filtrados, que foram gerados
# no script tratamento_de_dados.R

# Importando pacotes gráficos
library(ggplot2)
library(hrbrthemes)
library(tidyverse)
library(RColorBrewer)
library(readr)
library(dplyr)
library(viridis)

# Importando dados

microdados_filtrados <- read_csv("DADOS/microdados_filtrados.csv")


#Microdados sem NAs

microdados_sem_NA <- na.omit(microdados_filtrados)

# Exportar microdados sem NAs 

write.csv(microdados_sem_NA,"DADOS/microdados_sem_NA.csv", row.names = FALSE)


# Respondendo perguntas do arquivo planejamento_da_analise


# Qual a proporção entre participantes homens e mulheres? [TP_SEXO]

microdados_filtrados %>% count(TP_SEXO)

# 3.031.760 mulheres declaradas vs 2.063.411 homens declarados.

# 3031760 + 2063411 = 5095171

# 3031760/5095171*100
# 59.50262

# 2063411/5095171*100
# 40.49738

# PORCENTAGEM DOS PARTICIPANTES = 59.5% de mulheres e 40.5% de homens.

# Criando data frame
data <- data.frame(
  Sexo=c("Mulheres", "Homens"),  
  Quantidade=c(3031760, 2063411)
)

# Barplot
ggplot(data, aes(x=Sexo, y=Quantidade, fill=Sexo)) + 
  geom_bar(stat = "identity", width=0.35) +
  scale_fill_brewer(palette = "Set1") +
  ggtitle("Inscritos no EMEM 2019, por sexo") +
  theme_minimal(base_size = 12) +
  theme(legend.position="none") +
  xlab(" ")+
  ylab("Inscritos") +
  scale_y_continuous(breaks = c(1000000, 2000000, 3000000, 3500000),
                     labels = c("1M","2M","3M","3.5M"))


#-----------------------------------------------------------------------------

# Qual a proporção entre participantes de diferentes raças? [TP_COR_RACA]

raca_cor <- microdados_filtrados %>% count(TP_COR_RACA)

# 0	Não declarado
# 1	Branca
# 2	Preta
# 3	Parda
# 4	Amarela
# 5	Indígena 

# Ajustando dados
colnames(raca_cor) <- c("N","Total")

raca_cor$Raça <- c("Não declarado", "Branca",
                   "Preta", "Parda", "Amarela", "Indígena")

# Gerando gráfico

ggplot(raca_cor, aes(x=Raça, y=Total, fill=Raça)) + 
  geom_bar(stat = "identity", width=0.39) +
  theme_minimal(base_size = 12) +
  theme(legend.position="none") +
  ggtitle("Inscritos no EMEM 2019, por raça") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  xlab(" ")+
  scale_y_continuous(breaks = c(50000,500000, 1000000,1500000,2000000),
                     labels = c("50K","500K","1M","1.5M","2M"))



#-------------------------------------------------------------------------------

# ### Qual o estado civil declarado pelos
# participantes? [TP_ESTADO_CIVIL]

# Ajustando dados

estado_civil <- microdados_filtrados %>% count(TP_ESTADO_CIVIL)

colnames(estado_civil) <- c("Estado Civil","Total")

estado_civil$`Estado Civil` <- c("Não declarado", "Solteiro(a)",
                   "Casado(a)",
                   "Divorciado(a)", "Viúvo(a)")


# Gerando gráfico

ggplot(estado_civil, aes(x=`Estado Civil`, y=Total, fill=`Estado Civil`)) + 
  geom_bar(stat = "identity", width=0.39) +
  theme_minimal(base_size = 12) +
  theme(legend.position="none") +
  ggtitle("Estado Civil declarado pelos inscritos") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  xlab(" ")+
  scale_y_continuous(breaks = c(1000000,2000000,3000000,4000000),
                     labels = c("1M","2M","3M","4M"))


#----------------------------------------------------------------------------

# ### Quantos particiantes já concluíram o ensino médio? 
# quantos ainda estão fazendo? E quantos não fizeram? [TP_ST_CONCLUSAO]

# Ajustando dados

nivel_conclusao <- microdados_filtrados %>% count(TP_ST_CONCLUSAO)

colnames(nivel_conclusao) <- c("Ensino médio","Total")

nivel_conclusao$`Ensino médio` <- c("Concluiu o E.M.",
                                    "Concluirá o E.M. em 2019",
                                    "Concluirá o E.M. depois de 2019",
                                    "Não Concluiu o E.M.")

# Gerando gráfico

ggplot(nivel_conclusao, aes(x=`Ensino médio`, y=Total, fill=`Ensino médio`)) + 
  geom_bar(stat = "identity", width=0.39) +
  theme_minimal(base_size = 12) +
  theme(legend.position="none") +
  ggtitle("Situação de conclusão do Ensino Médio (EM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  xlab(" ")+
  scale_y_continuous(breaks = c(1000000,2000000,3000000),
                     labels = c("1M","2M","3M"))


#------------------------------------------------------------------------------

# ### Dos participantes que já conluíram o ensino médio, qual a 
# distribuição do ano de conclusão? [TP_ANO_CONCLUIU]

# Ajustando dados

ano_conclusao <- microdados_filtrados %>% count(TP_ANO_CONCLUIU)

colnames(ano_conclusao) <- c("Ano de Conclusão","Total")

ano_conclusao$`Ano de Conclusão` <- c("Não Informado", 2018:2007, "Antes de 2007")


# Gerando gráfico

ggplot(ano_conclusao, aes(x=`Ano de Conclusão`, y=Total, fill=`Ano de Conclusão`)) + 
  geom_bar(stat = "identity", width=0.39) +
  theme_minimal(base_size = 12) +
  theme(legend.position="none") +
  ggtitle("Ano de conclusão do Ensino Médio (EM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  xlab(" ")+
  scale_y_continuous(breaks = c(500000, 1000000,1500000,2000000),
                     labels = c("500K","1M","1.5M","2M"))


#----------------------------------------------------------------------------

# ### Qual foi o percentual de presença nas provas objetivas?
# [TP_PRESENCA_CN, TP_PRESENCA_CH, TP_PRESENCA_LC, TP_PRESENCA_MT]

# porcentagem de presença:

porcentagem_presenca <- nrow(microdados_sem_NA)/nrow(microdados_filtrados)*100
porcentagem_presenca


#-----------------------------------------------------------------------------

# ### Quais foram as médias das notas nas provas objetivas? 
# [NU_NOTA_CN, NU_NOTA_CH, NU_NOTA_LC, NU_NOTA_MT]

# média das notas 

notas <- c(mean(microdados_sem_NA$NU_NOTA_CN),mean(microdados_sem_NA$NU_NOTA_CH),
           mean(microdados_sem_NA$NU_NOTA_LC), mean(microdados_sem_NA$NU_NOTA_MT))

# desvio padrão 

sd <- c(sd(microdados_sem_NA$NU_NOTA_CN),sd(microdados_sem_NA$NU_NOTA_CH),
                 sd(microdados_sem_NA$NU_NOTA_LC), sd(microdados_sem_NA$NU_NOTA_MT))

# Labels

provas <- c("Ciências da Natureza", "Ciências Humanas","Linguagens e Códigos",
            "Matemática")

df_notas <- tibble(provas,notas,sd)


# Gerando gráfico de barras

ggplot(df_notas, aes(x=provas, y=notas, fill=provas)) +
  geom_bar(stat = "identity", width=0.39) +
  geom_errorbar(aes(x=provas, ymin=notas-sd, ymax=notas+sd),  width=0.2) +
  theme_minimal(base_size = 12) +
  theme(legend.position="none") +
  ggtitle("Média de notas nas provas objetivas") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  xlab(" ")


# -----------------------------------------------------------------------------


# ### Quais unidades da federação obtiveram as maiores notas? [SG_UF_PROVA]

# Criando dataframe

notas_UF <- tibble(microdados_sem_NA$SG_UF_PROVA, microdados_sem_NA$NU_NOTA_CN ,
                   microdados_sem_NA$NU_NOTA_CH, microdados_sem_NA$NU_NOTA_LC, 
                   microdados_sem_NA$NU_NOTA_MT, microdados_sem_NA$NU_NOTA_REDACAO)

# Renomeando as colunas
colnames(notas_UF)<- c("UF","CN", "CH","LC","MT","Redacao")

# Agrupando notas por estados
UF_medias <-group_by(notas_UF, UF)

# Média das notas por estado
UF_medias <- summarize(UF_medias, CN=mean(CN), CH=mean(CH),
          LC=mean(LC), MT=mean(MT), Redacao=mean(Redacao))


# Gerando gráfico de barras

ggplot(UF_medias, aes(x=UF, y=Redacao)) +
  geom_bar(stat = "identity", width=0.39) +
  theme_minimal(base_size = 12) +
  theme(legend.position="none") +
  ggtitle("Média das redações por estado") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  xlab(" ")+
  ylab("Redação")


# ---------------------------------------------------------------------------

### Quais unidades da federação obtiveram as maiores notas? [SG_UF_PROVA]

# Cosultar dataframe UF_medias


# ----------------------------------------------------------------------------


### Qual foi a nota média da prova de redação? [NU_NOTA_REDACAO]

redacao_media <- mean(microdados_sem_NA$NU_NOTA_REDACAO)
redacao_media

# Valor = 579.7666 pontos


# -----------------------------------------------------------------------------


### Qual competência da redação apresentou a menor média de notas,
# qual apresentou a maior? [NU_NOTA_COMP1, NU_NOTA_COMP2, NU_NOTA_COMP3,
# NU_NOTA_COMP4, NU_NOTA_COMP5]

# Notas das competências (de 0 a 200)
competencias <- tibble(microdados_sem_NA$NU_NOTA_COMP1, 
                       microdados_sem_NA$NU_NOTA_COMP2,
                       microdados_sem_NA$NU_NOTA_COMP3,
                       microdados_sem_NA$NU_NOTA_COMP4,
                       microdados_sem_NA$NU_NOTA_COMP5)

colnames(competencias) <- c("comp1","comp2","comp3","comp4","comp5") 

# Média das notas de cada competencia
comp_medias <- summarize(competencias, COMP1=mean(comp1), COMP2=mean(comp2),
                       COMP3=mean(comp3), COMP4=mean(comp4), COMP5=mean(comp5))

# renomeando colunas
colnames(comp_medias) <- c("Escrita Formal", "Desenvolvimento do Tema",
                         "Interpretação do Tema", "Construção Argumentativa",
                         "Proposta de Intervenção")

view(comp_medias)

# Competências por UFs

competencias <- tibble(microdados_sem_NA$SG_UF_PROVA,
                       microdados_sem_NA$NU_NOTA_COMP1, 
                       microdados_sem_NA$NU_NOTA_COMP2,
                       microdados_sem_NA$NU_NOTA_COMP3,
                       microdados_sem_NA$NU_NOTA_COMP4,
                       microdados_sem_NA$NU_NOTA_COMP5)

# renomeando colunas
colnames(competencias) <- c("UF","EF", "DT",
                           "IT", "CA",
                           "PI")

# Agrupando notas por estados
competencias_UF <-group_by(competencias, UF)


# Média das competencias por estado
competencias_UF <- summarize(competencias_UF, EF=mean(EF), DT=mean(DT),
                       IT=mean(IT), CA=mean(CA), PI=mean(PI))

# renomeando colunas
colnames(competencias_UF) <- c("UF","Escrita Formal", "Desenvolvimento do Tema",
                           "Interpretação do Tema", "Construção Argumentativa",
                           "Proposta de Intervenção")

# Médias das Notas das Competências por estados brasileiros
view(competencias_UF)


#---------------------------------------------------------------------------------


### Apresentar os níveis diferentes de educação dos pais entre os candidatos
# [Q001, Q002]


# Contando cada resposta do questionário
educacao_pai <- microdados_filtrados %>% count(Q001)
colnames(educacao_pai)<- c("pais","n_pais")
educacao_pai

educacao_mae <- microdados_filtrados %>% count(Q002)
colnames(educacao_mae)<- c("maes","n_maes")
educacao_mae

# parents <- tibble(educacao_pai, educacao_mae$n_maes)
# colnames(parents) <- c("nivel","pais","maes")

# Criando data frame para vizualização
total <- c(educacao_pai$n_pais,educacao_mae$n_maes)

nivel <- rep(educacao_pai$pais,2)

pais <- c(rep("Pai",8),rep("Mãe",8))

nivel_pais <- tibble(pais,nivel,total)


# Gerando gráfico de barras

ggplot(nivel_pais, aes(x=nivel, y=total, fill=pais)) +
  geom_bar(stat = "identity", width=0.45, position = "dodge") +
  theme_minimal(base_size = 12) +
  scale_y_continuous(breaks = c(250000,500000,750000,1000000,1250000,1500000),
                     labels = c("250K","500K","750K","1M","1.25M","1.5M"))+
  theme(legend.title = element_blank()) +
  ggtitle("Nível de Educação dos Pais") +
  xlab("Nível de Educação")+
  ylab("")

# A	Nunca estudou.
# B	Não completou a 4ª série/5º ano do Ensino Fundamental.
# C	Completou a 4ª série/5º ano, mas não completou a 8ª série/9º ano do Ensino Fundamental.
# D	Completou a 8ª série/9º ano do Ensino Fundamental, mas não completou o Ensino Médio.
# E	Completou o Ensino Médio, mas não completou a Faculdade.
# F	Completou a Faculdade, mas não completou a Pós-graduação.
# G	Completou a Pós-graduação.
# H	Não sei.

# -----------------------------------------------------------------------------------------


### Qual a classe de trabalho dos pais dos participantes? [Q003, Q004]

# Contando cada resposta do questionário
trabalho_pai <- microdados_filtrados %>% count(Q003)
colnames(trabalho_pai)<- c("pais","n_pais")
trabalho_pai

trabalho_mae <- microdados_filtrados %>% count(Q004)
colnames(trabalho_mae)<- c("maes","n_maes")
trabalho_mae

# Criando data frame para vizualização
total <- c(trabalho_pai$n_pais,trabalho_mae$n_maes)

nivel <- rep(trabalho_pai$pais,2)

pais <- c(rep("Pai",6),rep("Mãe",6))

nivel_pais <- tibble(pais,nivel,total)


# Gerando gráfico de barras

ggplot(nivel_pais, aes(x=nivel, y=total, fill=pais)) +
  geom_bar(stat = "identity", width=0.45, position = "dodge") +
  theme_minimal(base_size = 12) +
  scale_y_continuous(breaks = c(500000,1000000,1500000,2000000),
                     labels = c("500K","1M","1.5M","2M"))+
  theme(legend.title = element_blank()) +
  ggtitle("Ocupação dos Pais") +
  xlab("")+
  ylab("")


# A	Grupo 1: Lavrador, agricultor sem empregados, bóia fria, criador de animais (gado, porcos, galinhas, ovelhas, cavalos etc.), apicultor, pescador, lenhador, seringueiro, extrativista.
# B	Grupo 2: Diarista, empregado doméstico, cuidador de idosos, babá, cozinheiro (em casas particulares), motorista particular, jardineiro, faxineiro de empresas e prédios, vigilante, porteiro, carteiro, office-boy, vendedor, caixa, atendente de loja, auxiliar administrativo, recepcionista, servente de pedreiro, repositor de mercadoria.
# C	Grupo 3: Padeiro, cozinheiro industrial ou em restaurantes, sapateiro, costureiro, joalheiro, torneiro mecânico, operador de máquinas, soldador, operário de fábrica, trabalhador da mineração, pedreiro, pintor, eletricista, encanador, motorista, caminhoneiro, taxista.
# D	Grupo 4: Professor (de ensino fundamental ou médio, idioma, música, artes etc.), técnico (de enfermagem, contabilidade, eletrônica etc.), policial, militar de baixa patente (soldado, cabo, sargento), corretor de imóveis, supervisor, gerente, mestre de obras, pastor, microempresário (proprietário de empresa com menos de 10 empregados), pequeno comerciante, pequeno proprietário de terras, trabalhador autônomo ou por conta própria.
# E	Grupo 5: Médico, engenheiro, dentista, psicólogo, economista, advogado, juiz, promotor, defensor, delegado, tenente, capitão, coronel, professor universitário, diretor em empresas públicas ou privadas, político, proprietário de empresas com mais de 10 empregados.
# F	Não sei.


#----------------------------------------------------------------------------------------------------------------------------------------------------------------




# ###Comparar a classe de trabalho dos pais de participantes
# de diferentes raças. [Q003, Q004, TP_COR_RACA]


# Criando dataframe
df <- tibble(microdados_filtrados$TP_COR_RACA,
             microdados_filtrados$Q003,microdados_filtrados$Q004)

colnames(df) <- c("Raça","Pai","Mãe")


# Agrupando por raça
recorte <-group_by(df, Raça)
                     
pai <- recorte %>% count(Pai)
mae <- recorte %>% count(Mãe)

# dataframe

Raça <- c(rep("Não declarado",6),rep("Branca",6),rep("Preta",6),
          rep("Parda",6),rep("Amarela",6),rep("Indígena",6))

pais <- c(rep("pai",36),rep("mae",36))

n_pais <- c(pai$n,mae$n)

grupos <- tibble(rep(Raça,2),rep(pai$Pai,2),pais,n_pais)
colnames(grupos) <- c("Raça","Ocupacao","Pais","n_pais")



# Grafico

ggplot(grupos, aes(x=Ocupacao, y=n_pais, fill=Raça,group=Pais)) +
  geom_bar(stat = "identity", width=0.45) +
  facet_grid(. ~ Raça) +
  theme_bw(base_size = 12) +
  scale_y_continuous(breaks = c(500000,1000000,1500000),
                     labels = c("500K","1M","1.5M"))+
  theme(legend.position="none") +
  ggtitle("Ocupação de ambos os pais, por raça") +
  xlab("")+
  ylab("")


grupo_maes <- grupos[37:72, ]


# Somente a ocupação das mães dos inscritos

ggplot(grupo_maes, aes(x=Ocupacao, y=n_pais, fill=Raça,group=Pais)) +
  geom_bar(stat = "identity", width=0.45) +
  facet_grid(. ~ Raça) +
  theme_bw(base_size = 12) +
  scale_y_continuous(breaks = c(250000,500000,750000,1000000),
                     labels = c("250K","500K","750K","1M"))+
  theme(legend.position="none") +
  ggtitle("Ocupação das Mães, por raça") +
  xlab("")+
  ylab("")


# ----------------------------------------------------------------------------------------------



### Qual a renda familiar mensal dos participantes? [Q006]


renda <- microdados_filtrados %>% count(Q006)
renda

renda$categoria <- c("A - Nenhuma renda",
                     "B - Até R$ 998,00",
             "C R$ 998,01 até R$ 1.497,00",
             "D R$ 1.497,01 até R$ 1.996,00",
             "E R$ 1.996,01 até R$ 2.495,00",
             "F R$ 2.495,01 até R$ 2.994,00",
             "G R$ 2.994,01 até R$ 3.992,00",
             "H R$ 3.992,01 até R$ 4.990,00",
             "I R$ 4.990,01 até R$ 5.988,00",
             "J R$ 5.988,01 até R$ 6.986,00",
             "K R$ 6.986,01 até R$ 7.984,00",
             "L R$ 7.984,01 até R$ 8.982,00",
             "M R$ 8.982,01 até R$ 9.980,00",
             "N R$ 9.980,01 até R$ 11.976,00",
             "O R$ 11.976,01 até R$ 14.970,00",
             "P R$ 14.970,01 até R$ 19.960,00",
             "Q Mais de R$ 19.960,00")


#A	Nenhuma renda.
#B	Até R$ 998,00.
#C	De R$ 998,01 até R$ 1.497,00.
#D	De R$ 1.497,01 até R$ 1.996,00.
#E	De R$ 1.996,01 até R$ 2.495,00.
#F	De R$ 2.495,01 até R$ 2.994,00.
#G	De R$ 2.994,01 até R$ 3.992,00.
#H	De R$ 3.992,01 até R$ 4.990,00.
#I	De R$ 4.990,01 até R$ 5.988,00.
#J	De R$ 5.988,01 até R$ 6.986,00.
#K	De R$ 6.986,01 até R$ 7.984,00.
#L	De R$ 7.984,01 até R$ 8.982,00.
#M	De R$ 8.982,01 até R$ 9.980,00.
#N	De R$ 9.980,01 até R$ 11.976,00.
#O	De R$ 11.976,01 até R$ 14.970,00.
#P	De R$ 14.970,01 até R$ 19.960,00.
#Q	Mais de R$ 19.960,00.

ggplot(renda, aes(x=categoria, y=n)) +
  geom_bar(stat = "identity", width=0.45) +
  theme_bw(base_size = 12) +
  scale_y_continuous(breaks = c(250000,500000,750000,1000000,1250000),
                     labels = c("250K","500K","750K","1M","1.25M"))+
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("Renda familiar mensal dos inscritos") +
  xlab("Classificação")+
  ylab("N° de inscritos")


# --------------------------------------------------------------------------------


### Quantos participantes possuem um computador em casa? [Q024]

# contando os inscritos 
computador <- microdados_filtrados %>% count(Q024)
computador$Q024 <- c(
  "A - Não",
  "B - Sim, um",
  "C - Sim, dois",
  "D - Sim, três",
  "E - Sim, 4 ou mais"
)

# grafico

ggplot(computador, aes(x=Q024, y=n, fill=Q024)) +
  geom_bar(stat = "identity", width=0.45) +
  theme_bw(base_size = 12) +
  scale_y_continuous(breaks = c(500000,1000000,1500000,2000000),
                     labels = c("500K","1M","1.5M","2M"))+
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("Possui computador na residência?") +
  xlab(" ")+
  ylab("N° de inscritos")


#--------------------------------------------------------------------------------


### Quantos participantes possuem acesso à internet em casa? [Q025]

# contando os inscritos 
internet <- microdados_filtrados %>% count(Q025)
internet$Q025 <- c("Não","Sim")


# grafico

ggplot(internet, aes(x=Q025, y=n, fill=Q025)) +
  geom_bar(stat = "identity", width=0.45) +
  theme_bw(base_size = 12) +
  scale_y_continuous(breaks = c(1000000,2000000,3000000,4000000),
                     labels = c("1M","2M","3M","4M"))+
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("Possui acesso à internet na residência?") +
  xlab(" ")+
  ylab("N° de inscritos")


#------------------------------------------------------------------------------------


### Quantos participantes possuem um celular em casa? [Q022]


# contando os inscritos 
celular <- microdados_filtrados %>% count(Q022)
celular$Q022 <- c(
  "A - Não",
  "B - Sim, um",
  "C - Sim, dois",
  "D - Sim, três",
  "E - Sim, 4 ou mais"
)

# grafico

ggplot(celular, aes(x=Q022, y=n, fill=Q022)) +
  geom_bar(stat = "identity", width=0.45) +
  theme_bw(base_size = 12) +
  scale_y_continuous(breaks = c(500000,1000000,1500000,2000000),
                     labels = c("500K","1M","1.5M","2M"))+
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("Possui celular na residência?") +
  xlab(" ")+
  ylab("N° de inscritos")


#--------------------------------------------------------------------------------


# Questões referentes às diferenças de desempenho entre os participantes: 


#--------------------------------------------------------------------------------

# Vamos usar a média das notas das provas objetivas + redação

### Qual impacto da faixa etária nas notas finais? [TP_FAIXA_ETARIA]

df <- tibble(
  microdados_sem_NA$TP_FAIXA_ETARIA,
  microdados_sem_NA$NU_NOTA_CN,
  microdados_sem_NA$NU_NOTA_CH,
  microdados_sem_NA$NU_NOTA_LC,
  microdados_sem_NA$NU_NOTA_MT,
  microdados_sem_NA$NU_NOTA_REDACAO,
)

colnames(df) <- c("Idade","CN", "CH","LC", "MT","Redacao")

# Agrupando notas por idade
notas <-group_by(df, Idade)

# Média das notas
nota_media <- summarize(notas, nota = (CN + CH + LC + MT + Redacao)/5)

#
x <- group_by(nota_media, Idade)
x1 <- summarize(x, nota=mean(nota)) 
x1$Idade <- c(
  "1 - Menor de 17 anos",
  "2 - 17 anos",
  "3 - 18 anos",
  "4 - 19 anos",
  "5 - 20 anos",
  "6 - 21 anos",
  "7 - 22 anos",
  "8	- 23 anos",
  "9	- 24 anos",
  "10 - 25 anos",
  "11 - Entre 26 e 30 anos",
  "12 - Entre 31 e 35 anos",
  "13 - Entre 36 e 40 anos",
  "14 - Entre 41 e 45 anos",
  "15 - Entre 46 e 50 anos",
  "16 - Entre 51 e 55 anos",
  "17 - Entre 56 e 60 anos",
  "18 - Entre 61 e 65 anos",
  "19 - Entre 66 e 70 anos",
  "20 - Maior de 70 anos"
)


#1	Menor de 17 anos
#2	17 anos
#3	18 anos
#4	19 anos
#5	20 anos
#6	21 anos
#7	22 anos
#8	23 anos
#9	24 anos
#10	25 anos
#11	Entre 26 e 30 anos
#12	Entre 31 e 35 anos
#13	Entre 36 e 40 anos
#14	Entre 41 e 45 anos
#15	Entre 46 e 50 anos
#16	Entre 51 e 55 anos
#17	Entre 56 e 60 anos
#18	Entre 61 e 65 anos
#19	Entre 66 e 70 anos
#20	Maior de 70 anos


# grafico
ggplot(x1, aes(x=Idade, y=nota, fill=Idade)) +
  geom_bar(stat = "identity", width=0.45) +
  theme_bw(base_size = 12) +
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("") +
  xlab(" ")+
  ylab("")


#------------------------------------------------------------------


### Houve diferença significativa no desempenho entre
# participantes de sexos diferentes? [TP_SEXO]

df <- tibble(
  microdados_sem_NA$TP_SEXO,
  microdados_sem_NA$NU_NOTA_CN,
  microdados_sem_NA$NU_NOTA_CH,
  microdados_sem_NA$NU_NOTA_LC,
  microdados_sem_NA$NU_NOTA_MT,
  microdados_sem_NA$NU_NOTA_REDACAO,
)

colnames(df) <- c("Sexo","CN", "CH","LC", "MT","Redacao")

# Agrupando notas por idade
notas <-group_by(df, Sexo)

# Média das notas
nota_media <- summarize(notas, nota = (CN + CH + LC + MT + Redacao)/5)

# dataframe para grafico
x <- group_by(nota_media, Sexo)
x1 <- summarize(x, nota=mean(nota)) 
x1$sd <- summarize(x, nota=sd(nota)) 



# grafico
ggplot(x1, aes(x=Sexo, y=nota, fill=Sexo)) +
  geom_bar(stat = "identity", width=0.45) +
  geom_errorbar(aes(x=Sexo, ymin=nota-sd$nota, ymax=nota+sd$nota),  width=0.2) +
  theme_ipsum(base_size = 12) +
  theme(legend.position="none") +
  ggtitle("Média de notas, por sexo") +
  xlab(" ")+
  ylab("")


#--------------------------------------------------------------------


### Houve diferença diferença significativa no desempenho
# entre participantes de de diferentes raças? [TP_COR_RACA]


df <- tibble(
  microdados_sem_NA$TP_COR_RACA,
  microdados_sem_NA$NU_NOTA_CN,
  microdados_sem_NA$NU_NOTA_CH,
  microdados_sem_NA$NU_NOTA_LC,
  microdados_sem_NA$NU_NOTA_MT,
  microdados_sem_NA$NU_NOTA_REDACAO)

  colnames(df) <- c("Raça","CN", "CH","LC", "MT","Redacao")
  
  # Agrupando notas por idade
  notas <-group_by(df, Raça)
  
  # Média das notas
  nota_media <- summarize(notas, nota = (CN + CH + LC + MT + Redacao)/5)
  
  # dataframe para grafico
x <- group_by(nota_media, Raça)
x1 <- summarize(x, nota=mean(nota)) 
x1$sd <- summarize(nota_media, nota=sd(nota)) 
  
  # 0	Não declarado
  # 1	Branca
  # 2	Preta
  # 3	Parda
  # 4	Amarela
  # 5	Indígena 
  
x1$Raça <- c("Não declarado","Branca","Preta","Parda",
                     "Amarela","Indígena")

# Gráfico
ggplot(x1, aes(x=Raça, y=nota, fill=Raça)) +
  geom_bar(stat = "identity", width=0.45) +
  geom_errorbar(aes(x=Raça, ymin=nota-sd$nota, ymax=nota+sd$nota),  width=0.2) +
  theme_ipsum(base_size = 12) +
  theme(legend.position="none") +
  ggtitle("Média de notas, por raça") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  xlab(" ")+
  ylab("")

#-------------------------------------------------------------------


### Como foi o desempeho de participantes em diferentes
# etapas da conclusão do ensino médio? [TP_ST_CONCLUSAO]


df <- tibble(
  microdados_sem_NA$TP_ST_CONCLUSAO,
  microdados_sem_NA$NU_NOTA_CN,
  microdados_sem_NA$NU_NOTA_CH,
  microdados_sem_NA$NU_NOTA_LC,
  microdados_sem_NA$NU_NOTA_MT,
  microdados_sem_NA$NU_NOTA_REDACAO)

colnames(df) <- c("Conclusao","CN", "CH","LC", "MT","Redacao")



# Agrupando notas por idade
notas <-group_by(df, Conclusao)

# Média das notas
nota_media <- summarize(notas, nota = (CN + CH + LC + MT + Redacao)/5)

# dataframe para grafico
x <- group_by(nota_media, Conclusao)
x1 <- summarize(x, nota=mean(nota)) 
x1$sd <- summarize(nota_media, nota=sd(nota)) 

x1$Conclusao <- as.character(x1$Conclusao)

x1$Conclusao <-c("Concluiu o E.M.",
                 "Concluirá o E.M. em 2019",
                 "Concluirá o E.M. depois de 2019",
                 "Não Concluiu o E.M.")


# Gráfico
ggplot(x1, aes(x=Conclusao, y=nota, fill=Conclusao)) +
  geom_bar(stat = "identity", width=0.45) +
  geom_errorbar(aes(x=Conclusao, ymin=nota-sd$nota, ymax=nota+sd$nota),  width=0.2) +
  theme_ipsum(base_size = 12) +
  theme(legend.position="none") +
  ggtitle("Média de notas, por conclusão do E.M.") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  xlab(" ")+
  ylab("")


#--------------------------------------------------------------------


### Existem diferenças entre participantes que concluiram
# o ensino médio recentemente (em relação à prova) e os que
# já concluíram a mais tempo? [TP_ANO_CONCLUIU]

df <- tibble(
  microdados_sem_NA$TP_ANO_CONCLUIU,
  microdados_sem_NA$NU_NOTA_CN,
  microdados_sem_NA$NU_NOTA_CH,
  microdados_sem_NA$NU_NOTA_LC,
  microdados_sem_NA$NU_NOTA_MT,
  microdados_sem_NA$NU_NOTA_REDACAO)

colnames(df) <- c("Conclusao","CN", "CH","LC", "MT","Redacao")



# Agrupando notas por idade
notas <-group_by(df, Conclusao)

# Média das notas
nota_media <- summarize(notas, nota = (CN + CH + LC + MT + Redacao)/5)

# dataframe para grafico
x <- group_by(nota_media, Conclusao)
x1 <- summarize(x, nota=mean(nota)) 
x1$sd <- summarize(nota_media, nota=sd(nota)) 

x1$Conclusao <- c("Não Informado", 2018:2007, "Antes de 2007")

# Gráfico
ggplot(x1, aes(x=Conclusao, y=nota, fill=Conclusao)) +
  geom_bar(stat = "identity", width=0.45) +
  geom_errorbar(aes(x=Conclusao, ymin=nota-sd$nota, ymax=nota+sd$nota),  width=0.2) +
  theme_ipsum(base_size = 12) +
  theme(legend.position="none") +
  ggtitle("Média de notas, por conclusão do E.M.") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  xlab(" ")+
  ylab("")


#------------------------------------------------------------------


### Houve diferença significativa entre estudantes da 
# rede pública e privada? [TP_ESCOLA]

df <- tibble(
  microdados_sem_NA$TP_ESCOLA,
  microdados_sem_NA$NU_NOTA_CN,
  microdados_sem_NA$NU_NOTA_CH,
  microdados_sem_NA$NU_NOTA_LC,
  microdados_sem_NA$NU_NOTA_MT,
  microdados_sem_NA$NU_NOTA_REDACAO)

colnames(df) <- c("Escola","CN", "CH","LC", "MT","Redacao")



# Agrupando notas por idade
notas <-group_by(df, Escola)

# Média das notas
nota_media <- summarize(notas, nota = (CN + CH + LC + MT + Redacao)/5)

# dataframe para grafico
x <- group_by(nota_media, Escola)
x1 <- summarize(x, nota=mean(nota)) 
x1$sd <- summarize(nota_media, nota=sd(nota))

x1$Escola <- c("Não Respondeu","Pública","Privada")

# Gráfico
ggplot(x1, aes(x=Escola, y=nota, fill=Escola)) +
  geom_bar(stat = "identity", width=0.45) +
  geom_errorbar(aes(x=Escola, ymin=nota-sd$nota, ymax=nota+sd$nota),  width=0.2) +
  theme_ipsum(base_size = 12) +
  theme(legend.position="none") +
  ggtitle("Média de notas, por ano conclusão do E.M.") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  xlab(" ")+
  ylab("")


#--------------------------------------------------------------------


### Houve diferença entre participantes que já realizaram a 
# prova com o intuito apenas de treinar seus conhecimentos? 
# [IN_TREINEIRO]


df <- tibble(
  microdados_sem_NA$IN_TREINEIRO,
  microdados_sem_NA$NU_NOTA_CN,
  microdados_sem_NA$NU_NOTA_CH,
  microdados_sem_NA$NU_NOTA_LC,
  microdados_sem_NA$NU_NOTA_MT,
  microdados_sem_NA$NU_NOTA_REDACAO)

colnames(df) <- c("Treineiro","CN", "CH","LC", "MT","Redacao")

# Agrupando notas por idade
notas <-group_by(df, Treineiro)

# Média das notas
nota_media <- summarize(notas, nota = (CN + CH + LC + MT + Redacao)/5)

# dataframe para grafico
x <- group_by(nota_media, Treineiro)
x1 <- summarize(x, nota=mean(nota)) 
x1$sd <- summarize(nota_media, nota=sd(nota))

x1$Treineiro <- c("Não")

# Na tabela microdados_sem_NA não possuía canditados classificados
# como "treineiros"


#-------------------------------------------------------------------


### A ocupação dos pais influencia nas notas
# dos participantes? [Q003, Q004]

df <- tibble(
  microdados_sem_NA$Q003,
  microdados_sem_NA$Q004,
  microdados_sem_NA$NU_NOTA_CN,
  microdados_sem_NA$NU_NOTA_CH,
  microdados_sem_NA$NU_NOTA_LC,
  microdados_sem_NA$NU_NOTA_MT,
  microdados_sem_NA$NU_NOTA_REDACAO)

colnames(df) <- c("Pai","Mãe","CN", "CH","LC", "MT","Redacao")

# Agrupando notas por idade
notas_pai <-group_by(df, Pai)

notas_mae <-group_by(df, Mãe)

# Média das notas
nota_media_pai <- summarize(notas_pai, nota = (CN + CH + LC + MT + Redacao)/5)

nota_media_mae <- summarize(notas_mae, nota = (CN + CH + LC + MT + Redacao)/5)

# dataframe para grafico
x_pai <- group_by(nota_media_pai, Pai)
x1_pai <- summarize(x_pai, nota=mean(nota)) 
x1_pai$sd <- summarize(x_pai, nota=sd(nota))


x_mae <- group_by(nota_media_mae, Mãe)
x1_mae <- summarize(x_mae, nota=mean(nota)) 
x1_mae$sd <- summarize(x_mae, nota=sd(nota))


# Gráfico pai
ggplot(x1_pai, aes(x=Pai, y=nota, fill=Pai)) +
  geom_bar(stat = "identity", width=0.45) +
  geom_errorbar(aes(x=Pai, ymin=nota-sd$nota, ymax=nota+sd$nota),  width=0.2) +
  theme_ipsum(base_size = 12) +
  theme(legend.position="none") +
  ggtitle("Média de notas, por ocupação do Pai") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  xlab(" ")+
  ylab("")

# Gráfico mae
ggplot(x1_mae, aes(x=Mãe, y=nota, fill=Mãe)) +
  geom_bar(stat = "identity", width=0.45) +
  geom_errorbar(aes(x=Mãe, ymin=nota-sd$nota, ymax=nota+sd$nota),  width=0.2) +
  theme_ipsum(base_size = 12) +
  theme(legend.position="none") +
  ggtitle("Média de notas, por ocupação da Mãe") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  xlab(" ")+
  ylab("")


#-------------------------------------------------------------------

### Qual a diferença entre o desempenho de 
# participantes com diferentes rendas mensais? [Q006]


df <- tibble(
  microdados_sem_NA$Q006,
  microdados_sem_NA$NU_NOTA_CN,
  microdados_sem_NA$NU_NOTA_CH,
  microdados_sem_NA$NU_NOTA_LC,
  microdados_sem_NA$NU_NOTA_MT,
  microdados_sem_NA$NU_NOTA_REDACAO)

colnames(df) <- c("Renda","CN", "CH","LC", "MT","Redacao")

# Agrupando notas por idade
notas <-group_by(df, Renda)

# Média das notas
nota_media <- summarize(notas, nota = (CN + CH + LC + MT + Redacao)/5)

# dataframe para grafico
x <- group_by(nota_media, Renda)
x1 <- summarize(x, nota=mean(nota)) 
x1$sd <- summarize(nota_media, nota=sd(nota))

x1$Renda <- c("A - Nenhuma renda",
              "B - Até R$ 998,00",
              "C R$ 998,01 até R$ 1.497,00",
              "D R$ 1.497,01 até R$ 1.996,00",
              "E R$ 1.996,01 até R$ 2.495,00",
              "F R$ 2.495,01 até R$ 2.994,00",
              "G R$ 2.994,01 até R$ 3.992,00",
              "H R$ 3.992,01 até R$ 4.990,00",
              "I R$ 4.990,01 até R$ 5.988,00",
              "J R$ 5.988,01 até R$ 6.986,00",
              "K R$ 6.986,01 até R$ 7.984,00",
              "L R$ 7.984,01 até R$ 8.982,00",
              "M R$ 8.982,01 até R$ 9.980,00",
              "N R$ 9.980,01 até R$ 11.976,00",
              "O R$ 11.976,01 até R$ 14.970,00",
              "P R$ 14.970,01 até R$ 19.960,00",
              "Q Mais de R$ 19.960,00")

# Gráfico mae
ggplot(x1, aes(x=Renda, y=nota, fill=Renda)) +
  geom_bar(stat = "identity", width=0.45) +
  geom_errorbar(aes(x=Renda, ymin=nota-sd$nota, ymax=nota+sd$nota),  width=0.2) +
  theme_ipsum(base_size = 12) +
  theme(legend.position="none") +
  ggtitle("Média de notas, por Renda") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  xlab(" ")+
  ylab("")






