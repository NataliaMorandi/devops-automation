# Docker - Criando um Dockerfile

Em requirements.txt adicionamos o nome das duas bibliotecas que precisamos instalar dentro do container para a aplicação funcionar.

No Dockerfile, cada linha gera uma camada, um layer. 
E se a linha não mudou, o Docker reusa a camada do cache.
Se a linha muda, todas as linhas abaixo perdem o cache. 
E assim, o build fica muito mais lento, pois roda de novo linhas que já haviam sido lidas.

Por isso, a ordem das linhas é muito importante. Então:
>>> colocar o que muda menos em cima (como por exemplo, as dependências)
>>> adicionar o que muda mais, nas ultimas linhas


#### FROM: define a imagem
#### Nesse caso, Uusamos uma imagem oficial do Python, slim (mais leve, ideal para produção. Já vem com Python instalado)
FROM python:3.11-slim

#### WORKDIR: define o diretorio de trabalho do container >>> que vai ser criado DENTRO DO CONTAINER
#### tudo que for copiado ou executado, no codigo, a partir dessa linha, será dentro do /app
WORKDIR /app

## Copia só o requirements.txt primeiro (boas praticas) e o . significa que será no /app
COPY requirements.txt .

## installa as dependencias listadas no requirements.txt
## --no-cache-dir evita arquivos temporarios dentro da imagem (o que geraria um build mais pesado)
## container é descartavel, esse cache nao sera reutilizado, entao esses arquivos nunca serao usados novamento. Logo, nao precisa guardar no cache
RUN pip install --no-cache-dir -r requirements.txt

## copia todos arquivos da pasta para /app
COPY . . 

## Documenta que o container usa a porta 8000, mas nao abre a porta sozinho. 
## Ele serve como referenca para quem vai rodar o container
EXPOSE 8000

## Inicia o seridor Uvicorn, usa o arquivo main.py e procura nele uma variavel chamada app (por isso o from fastapi import FastAPI app = FastAPI())
## --host 0.0.0.0 escuta todas as interfaces, permitindo acesso de fora do container
## --port 8000 porta onde o Uvicorn vai escutar dentro do container, deve bater com EXPOSE 8000 (-p 8000:8000 ao rodar o container)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"] 