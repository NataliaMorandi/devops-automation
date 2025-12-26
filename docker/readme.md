# Objetivo

Aprender os conceitos básicos de Docker, incluindo imagens, containers, Dockerfile e boas práticas de uso em ambiente DevOps.

## Sobre Docker: 

Permite empacotar uma aplicação com todas suas dependências em um ambiente isolado chamado container.
- Imagem: é o blueprint (modelo imutável) da aplicação com tudo que ela precisa rodar.
- Container: é a instância em execução dessa imagem.
Docker é composto por CLI, Daemon (roda em segundo plano gerenciando os containers) e Registry/Hub (repositório onde buscamos e publicamos imagens).

Ciclo de vida: build > run > stop > start > rm

Dockerfile: é um arquivo com instruções que definem como a imagem da sua aplicação será construída.

Registries: são repositórios onde armazenamos as imagens Docker para compartilhamento e deploy.
	ex: Docker Hub, Amazon Elastic Container Registry, Azure Container Registry

Docker Compose: ferramenta que permite definir e rodar vários containers juntos usando um único arquivo docker-compose.yml (já que podemos ter um container para db, outro para backend, outro para frontend, etc, do mesmo projeto). Ideal para subir ambientes completos de forma automatizada. (No caso de milhares de containers, dá para usar outro orquestrador que é o Kubernetes). 