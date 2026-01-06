### Ansible
É uma ferramenta de automação de configuração que permite instalar pacotes, configurar servidores e executar comandos de forma simples e declarativa.

Não precisa de agente e funciona via SSH.

#### Para que é usado: 
Foco do Ansible é configuração de ambientes. Ele automatiza:
- Instação de pacotes
- Configuração do sistema
- Prepara ambientes (garante que o ambiente sempre vai estar igual em todos deploys)

Essencial em pipelines, provisionamento e padronização.

#### BLOCOS PRINCIPAIS DO ANSIBLE
- Inventory.ini → lista de hosts que vão receber as configurações
- Playbook.yml → arquivo YAML com as tarefas
- Tasks → cada etapa do playbook é chamada de task, e dentro de cada task tem vários módulos, com ações que serão executadas
- Módulos → o que realiza de fato cada ação (ex: instalar pacote, copiar arquivo)

exemplo: 
    inventory/nome_dos_hosts
    playbooks/update-playbook.yml
    roles/defaults/main.yml → default config and service management
        /tasks/check.yml update.yml rollback.yml 
        /vars/main.yml → default variables

#### INSTALAÇÃO
```bash
brew install ansible
ansible --version
ansible all -i hosts -m ping
ansible all -i hosts -m setup
ansible -playbook playbook.yml
```

O comando PING não testa ICMP, ele testa se o Ansible consegue: 
- Conectar a host remoto
- Autenticar (SSH, WinRM, etc)
- Executar código Python remoto
- Receber resposta do host

O comando SETUP serve para coletar dados detalhados sobre cada maquina, como:
- OS
- IP
- hostname
- arquitetura
- etc
Esses dados são chamados de Ansible Facts e podem ser usados nos playbooks como variáveis.


