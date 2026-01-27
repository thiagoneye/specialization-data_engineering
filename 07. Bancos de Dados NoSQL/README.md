# Guia de Arquitetura de Dados: Do Conceito à Prática

Este documento compila conceitos fundamentais de arquitetura de dados, topologias de bancos de dados e padrões de concorrência, contextualizados para Engenharia de Dados e aplicações industriais.

---

## 1. Topologias de Arquitetura

*Como os servidores se organizam e se comunicam.*

### 1.1. Master-Replica (Leader-Follower)

Estrutura hierárquica comum em bancos relacionais (ex: PostgreSQL).

* **Master (Primary):** Fonte da verdade. Recebe todas as escritas (`INSERT`, `UPDATE`, `DELETE`).
* **Replica (Secondary):** Cópia do Master (geralmente *Read-Only*). Usada para escalar leituras (analytics) e para *Failover* (assumir se o Master cair).
* **Sincronização:**
    * *Síncrona:* Garante Zero Data Loss, mas aumenta latência de escrita.
    * *Assíncrona:* Escrita rápida, sujeita a *Replication Lag* (atraso).

### 1.2. Masterless (Peer-to-Peer)

Estrutura distribuída "democrática" (ex: Cassandra, DynamoDB).

* **Funcionamento:** Todos os nós são iguais; qualquer um aceita leitura/escrita.
* **Quorum:** Mecanismo de votação para garantir consistência. Regra para consistência forte: $R + W > N$.
* **Vantagem:** Alta disponibilidade, sem Ponto Único de Falha (SPOF).
* **Desafio:** Resolução de conflitos de dados.

---

## 2. Teoremas Fundamentais

### 2.1. ACID vs. BASE

Filosofias opostas de design.

| Característica | ACID (ex: PostgreSQL) | BASE (ex: Cassandra, MongoDB) |
| :--- | :--- | :--- |
| **Sigla** | **A**tomicidade, **C**onsistência, **I**solamento, **D**urabilidade | **B**asic **A**vailability, **S**oft-state, **E**ventual consistency |
| **Foco** | Integridade rigorosa (Transações) | Disponibilidade e Velocidade |
| **Visão** | Pessimista (trava para evitar erro) | Otimista (resolve conflitos depois) |
| **Uso Ideal** | ERP, Financeiro, Pedidos | IoT, Logs, Big Data, Redes Sociais |

### 2.2. Teorema CAP

Em sistemas distribuídos, escolha apenas dois:

1.  **C (Consistency):** Todos veem o mesmo dado ao mesmo tempo.
2.  **A (Availability):** O sistema sempre responde (mesmo com dados velhos).
3.  **P (Partition Tolerance):** O sistema aguenta falhas de rede (Obrigatório em clusters).

> **Regra Prática:** A escolha real é entre **CP** (Consistência > Disponibilidade) ou **AP** (Disponibilidade > Consistência).

### 2.3. Backup vs. Réplica

* **Backup:** Cópia fria/offline (Snapshot). Alta perda potencial (RPO). Recuperação lenta.
* **Réplica:** Cópia quente/online (Stream). Baixíssima perda. Recuperação rápida (Failover).

---

## 3. Tipos de Bancos de Dados

### 3.1. SQL (Relacional)

* **Estrutura:** Tabelas, Foreign Keys, JOINs.
* **Uso:** Dados de negócio estruturados.
* **Exemplos:** PostgreSQL, Oracle, SQL Server.

### 3.2. NoSQL (Not Only SQL)

#### A. Chave-Valor (Key-Value)

* **Modelo:** Dicionário (`Chave` -> `Blob`). O banco não vê o conteúdo do valor.
* **Uso:** Cache (Redis), Sessão de usuário.
* **Performance:** $O(1)$ (Máxima velocidade).

#### B. Documentos (Document Store)

* **Modelo:** JSON/BSON estruturado. O banco indexa os campos internos.
* **Uso:** Catálogos flexíveis, CMS, Logs estruturados.
* **Exemplos:** MongoDB, Firestore.

#### C. Grafos (Graph Database)

* **Modelo:** Nós (Entidades) e Arestas (Relacionamentos).
* **Diferencial:** Conexões físicas (Index-free adjacency). Performance constante em profundidade.
* **Uso:** Rastreabilidade, Redes Sociais, Recomendação.
* **Exemplos:** Neo4j, Amazon Neptune.

### 3.3. NewSQL

* **Conceito:** Escalabilidade horizontal do NoSQL + Garantias ACID do SQL.
* **Exemplo:** CockroachDB (para sistemas globais críticos).

---

## 4. Padrões de Concorrência

### O Problema do Produtor-Consumidor

Padrão para desacoplar processos usando um **Buffer** (Fila).

* **Produtor:** Gera dados (ex: Sensor).
* **Consumidor:** Processa dados (ex: Banco de Dados).
* **Buffer:** Fila intermediária (ex: Kafka, RabbitMQ).
* **Regras:** Bloquear produtor se buffer cheio; bloquear consumidor se buffer vazio; exclusão mútua no acesso.

---

## 5. Resumo Contextualizado (Indústria & Dados)

1.  **ERP / Negócio:** Utilize **SQL (PostgreSQL)** com **Master-Replica** para garantir integridade (ACID) em pedidos e produção.
2.  **Projetos de IoT/ML (ex: Vulkan):** Utilize **NoSQL (Time-Series ou Key-Value)** para ingestão de alta velocidade (BASE/AP) dos sensores.
3.  **Rastreabilidade Total:** Considere **Bancos em Grafos** para mapear a cadeia complexa (Matéria-prima -> Processo -> Produto Final).
4.  **Engenharia de Dados:** Utilize o padrão **Produtor-Consumidor** em pipelines Python para evitar perda de dados durante picos de carga ou oscilações de rede.
