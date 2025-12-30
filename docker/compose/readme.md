# Docker Compose

Docker Compose é uma ferramenta para definir e rodar vários containers juntos, de forma organizada e reproduzível.

A ideia é evitar executar vários comandos como:

```bash
docker run -d --name db ...
docker run -d --name api ...
docker run -d --name frontend ...
```

Tem a opção de escrever um único arquivo YAML, de forma declarativa, descrevendo uma aplicação multi-container.

Quando roda **docker compose up**:
- Cria uma network automaticamente
- Sobe containers definidos
- Conecta serviços entre si
- Define ordem básica de inicialização
- Reaproveita imagens já existentes
- Mantém nomes previsíveis para containers e rede

#### Limitações do Docker Compose

Porém, Compose não é orquestrador como o Kubernetes, que faz produção em escala, ele é indicado para:
- desenvolvimento
- testes
- ambientes simples
- subir stack local (API+DB)

Ele não:
- não gerencia cluster
- não faz scaling real
- não faz auto-restart inteligente para produção

---

#### Docker Compose YAML
Exemplo com Node.js + PostgreSQL

```yaml

Define a versao do Docker Compose
version: '3.3'

Services é o inicio do servico que vao rodar no container (no caso: node-app e db)
Cada serviço definido equivale a 1 container
services:
  node-app:

Define se quer usar uma imagem pronta ou fazer um build: 

Aqui define que essa etapa de build terá a imagem construida localmente a partir de um Dockerfile que está na pasta .app.
    build:
      context: ./app
      dockerfile: dockerfile
      
Definicao das portas. Mapeamento no formato HOST:CONTAINER
    ports:
      - "3000:3000"

Nome do container
    container_name: node_compose_app

Configura o container para se reiniciar automaticamente, a menos que tenha sido parado manualmente.
    restart: unless-stopped

Defini dependencia de inicialização entre containers (nao garante que o serviço esteja pronto, apenas iniciado)
    depends_on:
      - db

Definimos uma variavel de ambiente para a aplicação se conectar ao db
    environment:
      - DATABASE_URL=postgres://devuser:devpass@db:5432/devdb


Nesse caso, nao fazemos um build, pois estamos pegando do Docker Hub uma imagem pronta
  db:
    image: postgres:15

Nome do container
    container_name: postgres_compose_db

Configura o container para se reiniciar automaticamente, a menos que tenha sido parado manualmente.
    restart: unless-stopped

Definicao das portas padrao do Postegres
    ports:
      - "5432:5432"

Mapeamos as variaveis usadas no Postegres para criar um db
    environment:
      POSTGRES_USER: devuser
      POSTGRES_PASSWORD: devpass
      POSTGRES_DB: devdb

Cria armazenamento persistente, mantendo dados mesmo se o container for removido/reiniciado.
    volumes:
      - pagdata:/var/lib/postgresql/data

E aqui criamos o volume
volumes:
    pgdata:

```

---

### Inicialização da aplicação

#### Executando a aplicação do Docker Compose
- Abrir o Docker Desktop (que precisa estar em execução)

```bash

docker compose up -d

curl http://localhost:3000

docker exec -it postgres_compose_db psql -U devuser -d devdb

docker compose logs -f node-app

docker compose down -v
```

