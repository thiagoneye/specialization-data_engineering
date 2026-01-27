import pandas as pd
import seaborn as srn
import statistics  as sts
import warnings

# Suprimir todos os avisos
warnings.filterwarnings('ignore')

#importar dados
dataset = pd.read_csv("C:/ProjetoChurn/Destino/2-CHURN_PERFIL_ENRIQUECIDO.csv", sep=";")

#dar conformidade ao nome das colunas
dataset.columns = ["id","genero","idade","uf","indcliente","anomes","estadocivil","escolaridade","mensalidade","participacao"]

#TRATA  IDADE - PROBLEMA OUTLIERS
#calculo da mediana
mediana = int(sts.median(dataset['idade']))
#substituir pelo resultado da mediana
dataset.loc[(dataset['idade'] <  0 )  | ( dataset['idade'] >  100), 'idade'] = mediana
#FIM IDADE

#TRATA UF - PROBLEMA DOMINIO - MODA
# Definindo a lista de estados do Nordeste brasileiro
nordeste = ['AL', 'BA', 'CE', 'MA', 'PB', 'PE', 'PI', 'RN', 'SE']
# Tratando o domínio categórico, substituindo pela moda (maior frequência - 'BA')
group = dataset.groupby(['uf']).size()
# Ordenando os resultados em ordem descendente
result = group.sort_values(ascending=False)
# Pegando a moda (primeiro valor do resultado ordenado)
moda = result.index[0]
# Substituindo os valores não pertencentes ao Nordeste pela moda ('BA')
dataset.loc[~dataset['uf'].isin(nordeste), 'uf'] = moda
#FIM UF

# TRATA ESTADO CIVIL -NULL - MODA
# Calcula a moda
moda = dataset['estadocivil'].mode()[0]
# Substituir os valores ausentes pela moda
dataset['estadocivil'] = dataset['estadocivil'].fillna(moda)
# FIM ESTADO CIVIL

# TRATA ESCOLARIDADE -NULL - MODA
# Tratando o domínio categórico, substituindo pela moda (maior frequência - bacharelado)
group = dataset.groupby(['escolaridade']).size()
# Ordenando os resultados em ordem descendente
result = group.sort_values(ascending=False)
# Pegando a moda (primeiro valor do resultado ordenado)
moda = result.index[0]
#atualize eenche NAs com bacharelado (moda)
dataset['escolaridade'].fillna(moda)
# FIM ESCOLARIDADE

# INICIO MENSALIDADE -NULL - USO DE NORMALIZAÇÃO POR MEDIA CONDICIONAL
# Calculando a média condicional da coluna "mensalidade" com base na coluna "idade"
mean_mensalidade = dataset.groupby('idade')['mensalidade'].mean()
# Preenchendo as mensalidades nulas com as médias correspondentes
for idade, media in mean_mensalidade.items():
    dataset.loc[(dataset['idade'] == idade) & (dataset['mensalidade'].isnull()), 'mensalidade'] = media
# FIM MENSALIDADE -NULL

# INICIO PARTICIPACAO - NULL E OUTLIERS - SUBSTITUIR MEDIAANA
#calular a mediana null 
# Calcular a mediana, ignorando os NaNs
mediana = sts.median(dataset['participacao'].dropna())

# Substituir NaNs pela mediana
dataset['participacao'] = dataset['participacao'].fillna(mediana)

# Calcular o desvio padrão
desv = sts.stdev(dataset['participacao'])

# Definir outliers como 4 desvios padrão acima da média e atribuir a mediana
dataset['participacao'] = dataset['participacao'].apply(lambda x: mediana if x >= 4 * desv else x)

# FIM PARTICIPACAO


#TRATA TIPOS DE DADOS
dataset['mensalidade'] = dataset['mensalidade'].astype('int64')
dataset['participacao'] = dataset['participacao'].astype('int64')

dataset.to_csv('C:/IAAM_PID/PDI/Target/PERFIL_CHURN_TRATADO.csv', index=False, sep=";")
