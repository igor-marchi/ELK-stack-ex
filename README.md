# Projeto de Integração ELK com MySQL

Este projeto configura um ambiente de integração entre Elasticsearch, Logstash, Kibana (ELK Stack) e MySQL usando Docker Compose. O objetivo é extrair dados de um banco de dados MySQL e indexá-los no Elasticsearch para visualização no Kibana.

## Serviços

### Elasticsearch

- Imagem: `docker.elastic.co/elasticsearch/elasticsearch:8.12.0`
- Porta: `9200`
- Volumes: `./data/elasticsearch_data:/usr/share/elasticsearch/data`
- Configuração: Executado como um nó único com segurança desativada para simplificação.

### Kibana

- Imagem: `docker.elastic.co/kibana/kibana:8.12.0`
- Porta: `5601`
- Dependências: `elasticsearch`
- Configuração: Conectado ao Elasticsearch para visualização dos dados indexados.

### MySQL

- Imagem: `mysql:8.0`
- Porta: `3307`
- Volumes:
  - `./data/mysql_data:/var/lib/mysql`
  - `./data/init.sql:/docker-entrypoint-initdb.d/init.sql:ro`
- Configuração: Banco de dados inicializado com tabelas e dados de exemplo.

### Logstash

- Imagem: `docker.elastic.co/logstash/logstash:8.12.0`
- Volumes:
  - Arquivos de configuração das pipelines para `users` e `products`.
  - Conector JDBC para MySQL.
- Dependências: `elasticsearch`, `mysql`
- Configuração: Duas pipelines separadas para processar dados de `users` e `products` do MySQL e indexá-los no Elasticsearch.

## Configuração do Logstash

Os arquivos de configuração do Logstash estão localizados na pasta `logstash/pipeline`. Eles definem a entrada de dados a partir do MySQL e a saída para o Elasticsearch. As pipelines são configuradas para rodar a cada minuto e rastrear atualizações nas tabelas `users` e `products`.

## Inicialização do Banco de Dados

O script SQL de inicialização está localizado em `data/init.sql`. Ele cria as tabelas `roles`, `users` e `products`, e insere dados iniciais para facilitar o teste e a demonstração.

## Como Executar

1. Certifique-se de ter o Docker e o Docker Compose instalados.
2. Execute o comando `docker-compose up` na raiz do projeto.
3. Acesse o Kibana em [http://localhost:5601](http://localhost:5601) para visualizar os dados indexados.

## .gitignore

Os diretórios `elasticsearch_data` e `mysql_data` estão ignorados no controle de versão para evitar o versionamento de dados persistentes.
