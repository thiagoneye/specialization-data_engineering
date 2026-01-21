# Arquiteturas Modernas de Dados: Fluxo Discreto e Contínuo

Para um Engenheiro de Dados moderno, especialmente em ambientes como Databricks, é crucial ir além do ETL básico e compreender como os grandes sistemas lidam com a dualidade **Batch (Discreto)** e **Streaming (Contínuo)**.

Abaixo estão as três principais arquiteturas que dominam o mercado, evoluindo da complexidade para a integração.

---

## 1. Lambda Architecture (A Clássica Híbrida)

Proposta por Nathan Marz, foi a primeira tentativa robusta de "domar" o Big Data. Parte da premissa de que o processamento em tempo real é aproximado e o lote é a fonte da verdade.

* **Como funciona:** O dado de entrada é duplicado em dois caminhos:
    * **Batch Layer (Camada de Lote):** Armazena o *Master Dataset* (imutável) e processa visualizações precisas periodicamente (ex: Jobs noturnos).
    * **Speed Layer (Camada Rápida):** Processa dados recentes com baixa latência para compensar o atraso do Batch (ex: Spark Streaming, Flink).
    * **Serving Layer:** Une os resultados para responder às consultas.
* **Vantagem:** Alta tolerância a falhas; o Batch corrige eventuais erros do Stream.
* **Desvantagem:** Violação do princípio *DRY (Don't Repeat Yourself)*. Exige manutenção de dois códigos base diferentes para a mesma lógica de negócio.

## 2. Kappa Architecture (Stream-First)

Criada pelo LinkedIn (Jay Kreps) como reação à complexidade da Lambda. A ideia radical é: **Tudo é um stream**.

* **Como funciona:** Elimina a Camada de Lote.
    * Todo processamento ocorre no motor de streaming (ex: Kafka + Flink).
    * **Histórico:** Para reprocessar dados antigos, aumenta-se a retenção do Kafka e faz-se um *Replay* dos dados desde o início com alta vazão.
* **Vantagem:** Código base único. Lógica de negócio unificada.
* **Desvantagem:** Requer ferramentas maduras de streaming; o "Replay" de grandes volumes via mensageria é tecnicamente desafiador.

## 3. Data Lakehouse & Medallion Architecture (O Padrão Databricks)

Esta arquitetura une a flexibilidade do Data Lake com a governança do Data Warehouse (transações ACID via Delta Lake).

* **Como funciona:** O fluxo é organizado em camadas de qualidade (*Medallion Architecture*), não necessariamente por latência. O mesmo motor (Spark) processa Batch e Stream.
    * **Bronze (Raw):** Ingestão bruta (Batch ou Stream). Dado "sujo".
    * **Silver (Refined):** Limpeza, desduplicação e tipagem. É a "Verdade Única".
    * **Gold (Business):** Agregações finais para BI e Analytics.
* **Diferencial:** Com ferramentas como **Delta Live Tables (DLT)**, tabelas estáticas e streams são tratados como a mesma abstração.
* **Vantagem:** Simplificação massiva. O consumidor final não precisa saber a origem da latência do dado.

---

## Quadro Comparativo

| Característica             | Lambda                                   | Kappa                      | Lakehouse (Medallion)                  |
| :------------------------- | :--------------------------------------- | :------------------------- | :------------------------------------- |
| **Filosofia**              | Batch e Stream são mundos separados.     | Tudo é Stream.             | Unificação no armazenamento (Storage). |
| **Complexidade de Código** | Alta (duas lógicas).                     | Baixa (uma lógica).        | Baixa (uma lógica via Spark/Delta).    |
| **Infraestrutura Típica**  | Hadoop/S3 + Storm.                       | Kafka + Stream Processor.  | Object Storage (S3) + Delta Lake.      |
| **Uso Industrial**         | Sistemas legados ou críticos (correção). | Monitoramento IoT, Fraude. | Analytics Corporativo, Data Science.   |
