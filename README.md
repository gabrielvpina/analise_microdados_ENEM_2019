# Análise de Microdados ENEM
> Fonte dos microdados: https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/enem

# Etapa 1: Tratamento dos dados
Foram coletados microdados do ENEM do ano de 2019, os dados vieram em formato .csv separados por ' ; ' e em codificação 'latin1'. A tabela de microdados tem, quando descompactada, 2,2 GB de tamanho. Para o tratamento dos dados foi utilizado o software RStudio, essa escolha se deu pela melhor manipulação de arquivos grandes pelo software. 

![RStudio](https://img.shields.io/badge/r-%23276DC3.svg?style=for-the-badge&logo=r&logoColor=white)

O tratamento dos dados foi guiado pelo arquivo [Planejamento da análise](https://github.com/gabrielvpina/analise_microdados_ENEM_2019/blob/main/Planejamento_da_analise.md), onde as perguntas que nós queremos responder irão determinar quais dados vamos preservar e quais vamos descartar.

