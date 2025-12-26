# Docker – Criando um Dockerfile Multistage

O **Docker Multistage Build** permite criar imagens otimizadas para produção,
separando o ambiente de **build** do ambiente de **execução**.

A ideia é:
- Usar uma imagem mais pesada no início (com ferramentas de desenvolvimento)
- Gerar uma imagem final menor, contendo apenas o necessário para rodar a aplicação

Isso resulta em:
- Imagens menores
- Builds mais rápidos
- Mais segurança
- Melhor performance em produção

---

#### STAGE 1 - BUILDER

Neste estágio, utilizamos uma imagem completa do **Node.js 18** para instalar
dependências e preparar a aplicação.

```Dockerfile
FROM node:18 AS builder


Define o diretório de trabalho dentro do container.
Tudo o que for copiado ou executado a partir daqui será feito dentro de /app.

WORKDIR /app


Copia apenas o package.json.
Isso permite que o Docker reaproveite o cache caso as dependências não mudem.

COPY src/package.json ./


Installa as dependencias listadas no package.json. 
Essa etapa ocorre apenas no estágio BUILDER.

RUN npm install


Copia todo o código da aplicação para o container.

COPY src/ .
```

#### STAGE 2 - RUNTIME

Neste estágio, usamos uma imagem mínima (node:18-alpine), contendo apenas
o necessário para rodar a aplicação.

```Dockerfile
FROM node:18-alpine


Define novamente o diretório de trabalho como /app.

WORKDIR /app


Copia os arquivos gerados no estágio builder para o estágio final.
Isso inclui:
    - Código da aplicação
    - node_modules
    - package.json e package-lock.json

COPY --from=builder /app .


Documenta que a aplicação usa a porta 3000.
O expose não publica a porta, apenas informa qual porta é usada internamente.

EXPOSE 3000 


Define o comando padrão que será executado quando o container iniciar.
(Nesse caso, executa o script definido no package.json: "start": "node index.js")
A porta não é definida aqui, pois quem controla a porta é o código da aplicação, normalmente via variável de ambiente (process.env.PORT).

CMD ["npm", "start"] 
```

---

### Inicialização da aplicação

#### Executando a aplicação do Docker
- Abrir o Docker Desktop (que precisa estar em execução)

```bash
docker build -t api-abacaxi-1.0 .

docker images

docker run -d -p 3000:3000 api-abacaxi-1.0

docker ps

curl http://localhost:3000

docker logs <container-id>

docker exec -it <container-id> sh

ls

exit
``` 


