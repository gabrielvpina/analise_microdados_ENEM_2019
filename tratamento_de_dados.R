# Importar aquivo .csv no RStudio.
library(readr)


microdados_2019 <- read_delim("DADOS/MICRODADOS_ENEM_2019.csv", 
                              delim = ";", quote = "\\\"", escape_double = FALSE, 
                              locale = locale(encoding = "latin1"), 
                              trim_ws = TRUE)

# Indicar posição de cada uma das colunas.

colnames(microdados_2019)


# Selecionar somente as colunas de interesse, para assim facilitar o manuseio dos dados.

microdados_filtrados <- data_frame(
  microdados_2019[ ,2:6],
  microdados_2019[ ,8:9],
  microdados_2019[ ,23:27],
  microdados_2019[ ,32:35],
  microdados_2019[ ,45:57],
  microdados_2019[ ,73],
  microdados_2019[ ,75:76]
)

# Exportar os dados filtrados para arquivo .csv
write.csv(microdados_filtrados,"DADOS/microdados_filtrados.csv", row.names = FALSE)
