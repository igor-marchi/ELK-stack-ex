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
3. Execute o comando `sudo docker network connect elk-stack-node-api-ex_default containers-db-1` na raiz do projeto. Este comando conecta o contêiner do banco de dados MySQL à rede padrão criada pelo Docker Compose, permitindo que o Logstash acesse o MySQL.
4. Acesse o Kibana em [http://localhost:5601](http://localhost:5601) para visualizar os dados indexados.

## Como Visualizar Dados no Kibana

1. **Acesse o Kibana:**

   - Abra o navegador e vá para [http://localhost:5601](http://localhost:5601).

2. **Verifique os Índices Criados:**

   - Navegue até a seção de gerenciamento de índices em [http://localhost:5601/app/management/data/index_management/indices](http://localhost:5601/app/management/data/index_management/indices).
   - Verifique se os índices `users` e `products` foram criados corretamente.

3. **Crie um Padrão de Índice (Index Pattern):**

   - Vá para [http://localhost:5601/app/management/kibana/indexPatterns](http://localhost:5601/app/management/kibana/indexPatterns).
   - Clique em "Create index pattern".
   - No campo "Index pattern", digite `users` e clique em "Next step".
   - Selecione o campo `@timestamp` como o campo de filtro de tempo e clique em "Create index pattern".
   - Repita o processo para o índice `products`.

4. **Visualize os Dados no Discover:**

   - Navegue até a seção Discover em [http://localhost:5601/app/discover](http://localhost:5601/app/discover).
   - No menu suspenso de seleção de índice, escolha `users` para visualizar os dados dos usuários.
   - Explore os dados utilizando os filtros e visualizações disponíveis.
   - Para visualizar os dados dos produtos, selecione o índice `products` no menu suspenso de seleção de índice.

5. **Crie Visualizações e Dashboards:**
   - Vá para [http://localhost:5601/app/visualize](http://localhost:5601/app/visualize) para criar visualizações baseadas nos dados dos índices.
   - Utilize gráficos de barras, linhas, tortas, entre outros, para representar os dados.
   - Para criar dashboards, vá para [http://localhost:5601/app/dashboards](http://localhost:5601/app/dashboards) e combine várias visualizações em um único painel.

## .gitignore

Os diretórios `elasticsearch_data` e `mysql_data` estão ignorados no controle de versão para evitar o versionamento de dados persistentes.
