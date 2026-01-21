# Protocolos e Tecnologia: TCP, MQTT e Eclipse Mosquitto

Para entender o papel do Mosquitto, é necessário distinguir as camadas de comunicação. Uma confusão comum é comparar **TCP** (Transporte) com **MQTT** (Aplicação).

Abaixo está a hierarquia técnica e o detalhamento do broker.

---

## 1. TCP (Transmission Control Protocol) - A "Estrada"

O TCP opera na **Camada 4 (Transporte)** do modelo OSI. Ele é a fundação sobre a qual o MQTT funciona.

* **Função:** Garantir que um fluxo de bytes chegue de A para B na ordem correta e sem erros.
* **Características Chave:**
    * **Conexão Orientada:** Exige "aperto de mão" (*3-way handshake*) antes da troca de dados.
    * **Confiabilidade:** Reenvia automaticamente pacotes perdidos; a aplicação não precisa gerenciar isso.
    * **Pesado (Overhead):** Cabeçalho mínimo de 20 bytes; manter a conexão consome recursos do SO.
    * **Ponto-a-Ponto:** Conexão direta entre dois sockets (IP + Porta).

## 2. MQTT (Message Queuing Telemetry Transport) - O "Entregador"

O MQTT opera na **Camada 7 (Aplicação)**, rodando **sobre** o TCP.

* **Função:** Padronizar a troca de mensagens de forma eficiente, ideal para redes instáveis ou limitadas.
* **Características Chave:**
    * **Pub/Sub:** Desacopla o *Publisher* (quem envia) do *Subscriber* (quem recebe).
    * **Leveza Extrema:** Cabeçalho de controle mínimo de **2 bytes**.
    * **Agnóstico de Dados:** Payload binário (aceita JSON, XML, Texto, Imagem).
    * **Keep-Alive:** Mantém a conexão TCP ativa via "pings" periódicos.

> **Analogia:** O **TCP** é a linha telefônica (garante o canal aberto e limpo). O **MQTT** é a linguagem falada na chamada (curta e padronizada).

---

## 3. Eclipse Mosquitto: O Coração da Operação

O **Eclipse Mosquitto** é um **Broker** de mensagens MQTT Open Source (escrito em C), conhecido por ser leve e performático. Ele atua como a torre de controle central.

### Funcionalidades Técnicas Essenciais

**A. Níveis de QoS (Quality of Service)**
Define a garantia de entrega:
* **QoS 0 (At most once):** "Dispare e esqueça". Sem confirmação. Mais rápido, menos seguro.
* **QoS 1 (At least once):** Garante entrega (via `PUBACK`), mas pode duplicar mensagens. Padrão da indústria.
* **QoS 2 (Exactly once):** Entrega única garantida. Lento, alto overhead.

**B. Retained Messages (Mensagens Retidas)**
Com a flag `Retain=True`, o Mosquitto armazena a **última** mensagem do tópico.
* *Uso:* Novos assinantes recebem o último estado (ex: temperatura atual) imediatamente ao conectar, sem esperar nova leitura.

**C. LWT (Last Will and Testament)**
Mecanismo para detectar falhas de conexão.
* O cliente define um "testamento" ao conectar. Se a conexão cair sem um *Graceful Disconnect*, o Broker publica automaticamente a mensagem de falha no tópico especificado.

**D. Bridge Mode (Conexão entre Brokers)**
Permite conectar múltiplos brokers.
* *Cenário Industrial:* Um Mosquitto na fábrica (Edge) recebe dados brutos e replica apenas dados filtrados/agregados para um Mosquitto na Nuvem ou Cluster Kafka.

---

## Resumo da Arquitetura Típica

1.  **Sensor:** Abre conexão **TCP** e envia pacote **MQTT CONNECT**.
2.  **Mosquitto:** Aceita e mantém a sessão.
3.  **Sensor:** Publica dados (ex: `temp=25`) em um tópico.
4.  **Mosquitto:** Verifica os assinantes e roteia a mensagem instantaneamente.