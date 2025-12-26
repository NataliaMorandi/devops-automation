# Docker - Basics

## Comandos Essenciais

### Listar containers em execução (ps = process status)
	docker ps

### Baixar uma imagem
	docker pull nginx

### Listar imagens locais
	docker images

### Subir um container
	docker run -d --name webserver -p 8080:80 nginx 

    -d → roda em segundo plano (detached)
    --name webserver → nome do container
    -p 8080:80 → mapeamento de portas
        8080 → porta do host (Mac)
        80 → porta interna do container (NGINX)

### Verificar containers novamente
	docker ps

### Testar acesso ao container
	curl http://localhost:8080 

    Retorna o HTML da página padrão do NGINX

### Acessar o container (debug)
	docker exec -it webserver bash 
    
    Para entrar no container: deve ser feito só para debug, inspeção ou troubleshooting. 
    Não para setup definitivo (ex: instalar Python, Node ou pacotes).
		exit
    
### Parar o container 
	docker stop webserver

### Remover o container (mas não remove a imagem)  
	docker rm webserver

### Verificar imagens novamente  
	docker images

### Remover uma imagem
	docker rmi -f <numero image id> 
    
    Agora sim remove a imagem com rmi e -f força a remoção, mesmo que a imagem esteja associada a containers.