# Comparativo Técnico: Apache Kafka vs. Eclipse Mosquitto

Embora ambos sejam frequentemente chamados de "Message Brokers" e usem o padrão Pub/Sub, eles foram projetados para problemas fundamentalmente diferentes.

**Resumo:** O Mosquitto conecta "Coisas" (IoT). O Kafka conecta "Sistemas" (Big Data).

---

## 1. Eclipse Mosquitto (O Especialista em IoT)

O Mosquitto é uma implementação leve e Open Source do protocolo **MQTT**.

* **Foco:** Conectividade de borda (Edge), dispositivos com baixo poder de processamento e redes instáveis (3G/4G/Satélite).
* **Arquitetura:** Centralizada. O Broker é inteligente e gerencia o roteamento para os clientes.
* **Persistência:** Quase nula. Focado em mensagens efêmeras. Se o broker cair e a mensagem não tiver *Retain flag* ou QoS específico, o dado se perde.
* **Padrão de Consumo:** **Push** (o Broker empurra a mensagem para o cliente assim que ela chega).

## 2. Apache Kafka (O Backbone de Dados)

O Kafka é uma plataforma distribuída de **Streaming de Eventos**.

* **Foco:** Alto *Throughput* (vazão), processamento massivo de dados, persistência e durabilidade.
* **Arquitetura:** Distribuída (Cluster). O Broker é "burro" (apenas armazena o Log) e o consumidor é "inteligente" (controla o que lê via Offset).
* **Persistência:** Alta. O Kafka escreve tudo em disco (Logs de commits). Permite "rebobinar" e reler dados passados.
* **Padrão de Consumo:** **Pull** (o Consumidor pede dados ao Broker quando consegue processar).

---

## Quadro Comparativo

| Característica     | Eclipse Mosquitto (MQTT)         | Apache Kafka                          |
| :----------------- | :------------------------------- | :------------------------------------ |
| **Protocolo**      | MQTT (leve, cabeçalho minúsculo) | TCP proprietário (binário, pesado)    |
| **Cenário Ideal**  | Sensores, IoT, Celulares         | Data Lakes, Microsserviços, Analytics |
| **Latência**       | Baixíssima (tempo real)          | Baixa (focada em lotes de ms)         |
| **Carga Útil**     | Pequena (bytes ou KBs)           | Média/Grande (KBs ou MBs)             |
| **Escalabilidade** | Vertical (limitada a conexões)   | Horizontal (Clustering massivo)       |
| **Armazenamento**  | Memória (principalmente)         | Disco (Log Append-Only)               |

---

## O Cenário de Integração (Arquitetura Comum)

Para um Engenheiro de Dados, raramente é uma escolha de excludente. Em cenários industriais, eles trabalham juntos:

1.  **A Borda (Edge):** Sensores enviam dados via **Mosquitto** (devido à leveza e capacidade de conexões simultâneas).
2.  **A Ponte (Bridge):** O **Kafka Connect** (com conector MQTT Source) lê os dados do Mosquitto.
3.  **O Core:** O **Kafka** armazena os dados de forma durável para processamento posterior (Spark/Databricks).

> **Regra de Ouro:** Use o Mosquitto para tirar o dado do sensor. Use o Kafka para levar o dado até o Data Lake.