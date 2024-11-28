# Projeto de Integração ELK com MySQL

Este projeto configura um ambiente de integração entre Elasticsearch, Logstash, Kibana (ELK Stack) e MySQL usando Docker Compose. O objetivo é extrair dados de um banco de dados MySQL e indexá-los no Elasticsearch para visualização no Kibana.

## Serviços

### Elasticsearch

- Imagem: `docker.elastic.co/elasticsearch/elasticsearch:8.12.0`
- Porta: `9200`
- Volumes: `./data/elasticsearch_data:/usr/share/elasticsearch/data`

### Kibana

- Imagem: `docker.elastic.co/kibana/kibana:8.12.0`
- Porta: `5601`
- Dependências: `elasticsearch`

### MySQL

- Imagem: `mysql:8.0`
- Porta: `3307`
- Volumes:
  - `./data/mysql_data:/var/lib/mysql`
  - `./data/init.sql:/docker-entrypoint-initdb.d/init.sql:ro`

### Logstash

- Imagem: `docker.elastic.co/logstash/logstash:8.12.0`
- Volumes:
  - `./logstash/pipeline/logstash.conf:/usr/share/logstash/pipeline/logstash.conf:ro`
  - `./logstash/lib/mysql-connector-java-8.0.30.jar:/usr/share/logstash/mysql-connector-java-8.0.30.jar:ro`
- Dependências: `elasticsearch`, `mysql`

## Configuração do Logstash

O arquivo de configuração do Logstash está localizado em `logstash.conf`. Ele define a entrada de dados a partir do MySQL e a saída para o Elasticsearch.

## Inicialização do Banco de Dados

O script SQL de inicialização está localizado em `init.sql`. Ele cria as tabelas `roles` e `users` e insere dados iniciais.

## Como Executar

1. Certifique-se de ter o Docker e o Docker Compose instalados.
2. Execute o comando `docker-compose up` na raiz do projeto.
3. Acesse o Kibana em [http://localhost:5601](http://localhost:5601) para visualizar os dados indexados.

## .gitignore

Os diretórios `elasticsearch_data` e `mysql_data` estão ignorados no controle de versão para evitar o versionamento de dados persistentes.
