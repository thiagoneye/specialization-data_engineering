# Data Lakehouse & Medallion Architecture

Esta arquitetura define o "padrão ouro" do **Databricks** e da engenharia de dados moderna. Ela une o mundo do SQL (BI) com o mundo do Python (IA/ML), sendo essencial para cenários que envolvem SciML e análise industrial.

É importante distinguir os conceitos:
* **Data Lakehouse:** É a *tecnologia* (Arquitetura de Plataforma).
* **Medallion:** É o *padrão de design* (Organização dos Dados).

---

## 1. O Conceito: Data Lakehouse

Historicamente, as empresas operavam com dois silos:
1.  **Data Warehouses (DW):** Caros, estruturados, ótimos para SQL/BI, mas limitados para dados não estruturados e ML.
2.  **Data Lakes:** Baratos, flexíveis, ótimos para ML, mas propensos a se tornarem "pântanos de dados" sem qualidade ou transações confiáveis.

O **Lakehouse** é a fusão destes dois mundos.

### Características Técnicas Chave
* **Formatos Abertos:** Os dados residem em arquivos abertos (geralmente **Parquet**) no Storage (S3/ADLS), evitando *vendor lock-in*.
* **Camada Transacional (ACID):** Tecnologias como **Delta Lake** adicionam um registro de transações (`_delta_log`) sobre os arquivos. Isso permite:
    * *Updates/Deletes* (impossíveis em Lakes puros).
    * *Schema Enforcement* (garantia de qualidade).
    * *Time Travel* (versionamento de dados).
* **Motor Unificado:** O mesmo motor (Spark/Photon) atende tanto Dashboards Power BI quanto treinamentos de Deep Learning.

---

## 2. O Design Pattern: Medallion Architecture

Para organizar o Lakehouse, utiliza-se a arquitetura "Multi-hop", onde a qualidade do dado aumenta à medida que ele avança pelas camadas.

### A. Camada Bronze (Raw / Ingestão)
Aterrissagem dos dados brutos.
* **Objetivo:** Ingestão rápida e preservação do histórico original.
* **Estado:** Dado "sujo" (JSON aninhado, erros de sensor).
* **Regra de Ouro:** **Nunca altere o dado na Bronze.** É necessário poder reprocessar tudo caso as regras de negócio mudem. Apenas colunas de metadados são adicionadas (ex: data de ingestão).

### B. Camada Silver (Refined / Limpeza)
O coração do Lakehouse ("Visão Enterprise").
* **Objetivo:** Filtrar, limpar, tipar e enriquecer.
* **Transformações Típicas:**
    * Tipagem (String $\to$ Date/Float).
    * *Explode* de arrays/JSONs.
    * Deduplicação (*Drop Duplicates*).
    * *Joins* para enriquecimento (ex: cruzar ID do sensor com cadastro da máquina).
* **Uso:** Fonte primária para Cientistas de Dados (SciML).

### C. Camada Gold (Curated / Business)
Camada de consumo final, otimizada para leitura.
* **Objetivo:** Agregações e KPIs de negócio.
* **Estrutura:** Modelagem Dimensional (Star Schema) ou tabelas agregadas.
* **Uso:** Conectada diretamente ao **Power BI** para relatórios gerenciais.

---

## 3. Exemplo Prático: Monitoramento de Vulcanização

Cenário hipotético de fluxo de dados na indústria:

1.  **Fonte:** Sensor de Temperatura envia dados via MQTT.
2.  **Bronze (`tb_sensor_bronze`):**
    * Databricks Autoloader ingere o JSON bruto.
    * *Conteúdo:* `{"id": "prensa_01", "ts": 1700005, "val": "180.5", "err_code": null}`.
3.  **Silver (`tb_sensor_silver`):**
    * Filtra erros (`err_code is null`).
    * Converte `val` para Float (Celsius).
    * Cruza com tabela de ativos (identifica modelo da máquina).
    * *Resultado:* Tabela limpa e granular.
4.  **Gold (`tb_oee_gold`):**
    * Calcula média horária de temperatura.
    * Define status de disponibilidade para cálculo de OEE.
    * *Resultado:* Dados prontos para dashboard executivo.

---

## 4. Relevância para Pesquisa (Mestrado/SciML)

Para pesquisas em Deep Learning e Simulações Numéricas, o Lakehouse oferece vantagens críticas:

1.  **Time Travel (Reprodutibilidade):**
    Para reproduzir um experimento científico, é vital usar a mesma versão dos dados. O Delta Lake permite isso nativamente:
    ```python
    # Lendo a tabela como ela existia na versão 5
    df = spark.read.format("delta").option("versionAsOf", 5).load("/mnt/silver/dados")
    ```
2.  **Unificação Batch + Stream:**
    Treine modelos com histórico (Batch/Silver) e faça inferência em tempo real (Stream/Bronze) usando a mesma API do Spark.
3.  **Schema Evolution:**
    Permite que o esquema dos dados evolua (ex: novos sensores) sem quebrar pipelines de pesquisa existentes.