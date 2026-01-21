# Engenharia de Dados: Fluxo Discreto vs. Contínuo

Para um Engenheiro de Dados, dominar a distinção e a implementação de fluxos de dados **Discretos** (Batch) e **Contínuos** (Streaming) é fundamental para desenhar arquiteturas eficientes.

A escolha entre um e outro dita as ferramentas, o custo e a latência do projeto.

---

## 1. Fluxo Discreto (Batch Processing)

No processamento em lote, os dados são acumulados durante um período e processados de uma única vez em blocos finitos.

* **O Conceito:** O foco é no **Throughput** (vazão) e não na latência. Processa-se grandes volumes de dados históricos ou acumulados (ex: D-1, hora em hora).
* **Competências Essenciais:**
    * **Orquestração:** Domínio de ferramentas como **Apache Airflow**, Prefect ou Dagster para agendar e monitorar dependências (DAGs).
    * **Particionamento:** Estratégias de divisão de arquivos no Data Lake (ex: `ano=2024/mes=12/dia=30`) para otimização de leitura (pruning).
    * **Carga Incremental vs. Full:** Identificação de quando recarregar tudo ou apenas deltas (CDC - Change Data Capture).
    * **Ferramentas Comuns:** Apache Spark (modo batch), dbt, Snowflake, BigQuery.
* **Caso de Uso:** Relatórios financeiros, treinamento de modelos de ML (offline), cargas de Data Warehouse.

## 2. Fluxo Contínuo (Stream Processing)

No processamento contínuo, os dados são processados item a item (ou em micro-lotes) imediatamente após sua geração.

* **O Conceito:** O foco é na **Latência** mínima (tempo real ou *near real-time*). O dado é tratado como uma sequência infinita (unbounded).
* **Competências Essenciais:**
    * **Pub/Sub:** Entendimento profundo de Brokers de mensagens, especialmente **Apache Kafka** (tópicos, particionamento, offsets, consumer groups).
    * **Windowing (Janelamento):** Agrupamento de dados infinitos para cálculo.
        * *Tumbling Windows:* Janelas fixas sem sobreposição.
        * *Sliding Windows:* Janelas deslizantes com sobreposição.
    * **Semântica de Entrega:**
        * *At-least-once:* Garante entrega, possível duplicação (padrão).
        * *Exactly-once:* Entrega única garantida (complexo, necessário para financeiro).
    * **Gerenciamento de Estado (Stateful):** Manutenção de contexto entre eventos.
    * **Ferramentas Comuns:** Apache Kafka, Apache Flink, Spark Structured Streaming, Databricks Autoloader, Eclipse Mosquitto.
* **Caso de Uso:** Detecção de fraude, IoT, personalização em tempo real.

---

## 3. Comparativo Técnico

| Característica   | Fluxo Discreto (Batch)            | Fluxo Contínuo (Streaming)                           |
| :--------------- | :-------------------------------- | :--------------------------------------------------- |
| **Latência**     | Minutos a Dias                    | Milissegundos a Segundos                             |
| **Input**        | Arquivos estáticos (CSV, Parquet) | Eventos/Mensagens (JSON, Avro)                       |
| **Complexidade** | Baixa/Média                       | Alta (requer tratamento de falhas complexo)          |
| **Recuperação**  | Re-executar o job inteiro         | Replay de mensagens (Kafka Offsets) ou Checkpointing |
| **Custo**        | Paga pelo tempo de processamento  | Infraestrutura "ligada" 24/7                         |

---

## 4. Arquiteturas Híbridas

Muitas vezes, é necessário lidar com ambos os mundos simultaneamente:

1.  **Lambda Architecture:** Mantém duas camadas separadas (*Batch Layer* para precisão histórica e *Speed Layer* para dados recentes). Robusta, mas exige manutenção de dois códigos base.
2.  **Kappa Architecture:** Tudo é tratado como stream. Para reprocessar histórico, "rebobina-se" o stream. É o padrão moderno, facilitado por ferramentas como Apache Flink e Delta Lake.

## Resumo das Skills Necessárias

Para se destacar, o Engenheiro de Dados deve saber:
1.  Decidir o **trade-off** entre Batch (custo/simplicidade) e Streaming (valor do tempo real/complexidade).
2.  Lidar com **Backpressure** (quando a entrada supera a capacidade de processamento).
3.  Escolher formatos de serialização: **Avro/Protobuf** (Streaming) vs. **Parquet/Delta** (Batch).