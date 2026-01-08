#### HOSTS AND CONNECTION
```yaml
  hosts: localhost
  connection: local
```
Usados para rodar codigos na minha propria maquina, sem precisar de inventory e SSH
Se nao escrever 'connection: local' o ansible tenta usar SSH
Se connection nao é definido, por default do Ansible será usar chaves SSH e executar comandos remotamente
Dentro de container seria 'connection: docker'


#### GATHER_FACTS: YES
```yaml
  gather_facts: yes
```

Diz ao ansible se deve coletar informações sobre o host antes de executar as tarefas.
Essas informações são chamadas de facts. Ex de facts: 
- OS
- distro
- versão do OS
- arquitetura
- memória
- CPUs
- hostname
- IPs
- usuário
- etc

O default do ansible é ser 'gather_facts: yes'
Com isso, o Ansible executa 'ansible.builtin.setup:' e cria várias variáveis automaticamente, como: 
- ansible_os_family
- ansible_distribution
- ansible_hostname
- ansible_architecture
- ansible_memtotal_mb

Para que serve:
- Executar tarefas condicionais, como por exemplo: 
```yaml
- name: Instalar pacote no macOS
  homebrew:
    name: git
  when: ansible_distribution == "MacOSX"
```
- Saber se o host tem recursos suficientes
- Usar caminhos corretos por sistema

Quando não usar:
- playbook simples
- não usa variáveis de sistema
- quer execução mais rápida
- está rodando comandos diretos


#### BECOME 
Adicionando o 'become: yes' o Ansible vira root. Isso é necessário quando precisamos de permissão para instalar pacotes ou alterar configurações globais ou criar usuários no sistema e etc. Ele é o mecanismo de elevação de privilégio, equivalente a um 'sudo comando'
```yaml
  became: yes
```


#### BECOME_USER
Executa como outro usuário.
```yaml
  became_user: root
```

#### SET_FACT
Cria variáveis em tempo de execução.
Útil para:
- guardar cálculos
- evitar repetir expressões grandes
- criar lógica mais legível
```yaml
- set_fact:
    sistema_recente: "{{ ansible_uptime_seconds < 300 }}"
    when: sistema_recente
```


#### COPY 
Copy cria um arquivo e escreve o conteúdo de uma vez. 
Feito para arquivos locais/remotos.
É seguro, não depende de shell
E não recria/altera se o conteúdo não mudar (idempotente)
```yaml
- name: Criar arquivo ponto.txt com data e hora
  copy:
    dest: ~/desktop/ponto.txt
    content: |
      Inicio de uso do computador:
      {{ ansible_date_time.date }} {{ ansible_date_time.time }}
```


#### TEMPLATE 
Usa Jinja2 com mais flexibilidade, é usado quando:
- Arquivo é grande
- Precisa de lógica, condições, loops
- Padrão profissional
```yaml
template:
  src: ponto.txt.j2
  dest: ~/desktop/ponto.txt
````
```txt
Inicio de uso do computador:
{{ ansible_date_time.date }} {{ ansible_date_time.time }}
```


#### LINEINFILE
Edita uma linha específica.
- É usado quando quer acrescentar ou garantir uma linha
- logs simples
- arquivos de config
(não é bom para arquivos grandes)
```yaml
lineinfile:
  path: ~/desktop/ponto.txt
  line: "{{ ansible_date_time.date }} {{ ansible_date_time.time }}"
  create: yes
```

#### BLOCKINFILE
Insere um bloco inteiro com marcador. Use quando:
- Quer que o Ansible controle um bloco
- Editar arquivos compartilhados
```yaml
blockinfile:
  path: ~/desktop/ponto.txt
  block: |
    Inicio de uso do computador:
    {{ ansible_date_time.date }} {{ ansible_date_time.time }}
```

#### SHELL ou COMMAND
Deve ser evitado, pois:
- Não é idempotente
- Pode duplicar conteúdo
- Depende do shell
- Difícil de manter
```yaml
shell: |
  echo "Inicio de uso do computador" >> ~/desktop/ponto.txt
  date >> ~/desktop/ponto.txt
```


#### WHEN
Condicional.
```yaml
when: ansible_os_family == "Darwin"
```


#### VARS
Define variáveis no playbook.
```yaml
vars:
  app_port: 8080
```


#### VARS_FILES
Importa variáveis de arquivos
```yaml
vars_file:
  - vars.yml
```


#### TASKS
Lista de ações a executar.
```yaml
vars_file:
  - vars.yml
```


#### HANDLERS
Tasks que só rodam quando notificadas.
```yaml
notify: restart nginx
```


#### NOTIFY
Chama um handler.


#### DEBUG
Mostra valores no output.
```yaml
debug:
  var: ansible_hostname
```


#### LOOP (substituiu o WITH_ITEMS)
Repete uma task.
```yaml
loop:
  - git
  - curl
  - wget
```


#### FAILED_WHEN
Define quando algo é considerado falha.
```yaml
failed_when: resultado.rc != 0
```

#### CHECK_MODE
Simula execução (dry run).
```yaml
ansible-playbook play.yml --check
```

#### TAGS
Permite rodar partes do playbooks.
```yaml
tags:
  - setup
```


#### CONTENT
Conteúdo inline do aquivo. O conteúdo é o arquivo inteiro. Se o arquvio já existir, ele será sobreescrito. Quando usar:
- Arquivo pequeno
- Conteúdo simples
- Sem necessidade de template externo
```yaml
copy:
  dest: /tmp/teste.txt
  content: |
    Linha 1
    Linha 2
```


#### BLOCK
Define um bloco de texto (normalmente em blockinfile). O conteúdo é apenas um pedaço do arquivo. O Ansible:
- Adiciona marcadores
- Controla só aquele bloco
- Não mexe no resto do arquivo
```yaml
blockinfile:
  path: /tmp/app.conf
  block: |
    server=localhost
    port=8080
```

#### REGISTER
Guarda a saída de uma task em uma variável. Quase sempre o que vem dentro de um register é:
- stdout → saída padrão
- stderr → erro
- rc → return code (0 = sucesso)
- changed → se alterou algo
```yaml
- name: Verificar uptime
  command: uptime
  register: resultado_uptime
debug:
  var: resultado_uptime.stdout
```

#### CHANGED_WHEN: FALSE
Força o Ansible a não marcar a task como 'changed'. Usado quando:
- a task só consulta algo
- não se quer 'poluir' o relatório
- evita gatilhos de notify
```yaml
- command: uptime
  changed_when: false
```

#### IGNORE_ERRORS: YES
Continua o playbook mesmo se a task falhar. Usado quando:
- erro é aceitável
- você vai tratar o resultado depois
```yaml
- command: cat /arquivo_inexistente
  ignore_errors: yes
```

#### DEST
Abreviação de destination.
Usado em módulos que criam ou manipulam ou copiam arquivos. Aparece em:
- copy
- template
- unarchive
- get_url
- fetch
```yaml
dest: /tmp/arquivo.txt
```

#### PATH
Usado quando editamos ou verificamos algo que já está no sistema, apenas gerenciando estado (permissão, existência, atributo). Aparece nos módulos:
- file
- stat (verifica algo no filesystem)
- replace
- find
```yaml
path: /etc/ssh/sshd_config
```


#### APPEND
Sem 'append:yes' o usuario perde todos os outros grupos, ficando apenas no grupo novo em que foi recem adicionado.
Com 'append:yes', o usuario é adicionado ao grupo novo, mas se mantém nos grupos existentes. 


#### STATE
Descreve como o recurso deve estar no final, não o que o Ansible deve "fazer" passo a passo.
- Diz o estado desejado
- o Ansible decide o que executar para chegar lá
É um ponto crucial da automação declarativa.
```yaml
- name: Garantir que o git esteja instalado
  homebrew:
    name: git
    state: present
```
Se não estiver instalado > instala, se já estiver instalado > não faz nada
Estados mais comuns: 
**present** 'isso deve existir', usado em pacotes, arquivos, usuários, grupos
**absent** 'isso NÃO deve existir' remove pacote, deletar arquivo, apagar usuário
**started** serviço deve estar rodando
**stopped** serviço deve estar parado
**restarted** reinicia o serviço
**reloaded** recarrega config sem restart total

o STATE muda conforme o módulo. Cada módulo aceita estados diferentes.
file → touch ou directory ou file ou absent ou link
```yaml
file:
  path: /tmp/teste.txt
  state: touch
```

user → present
```yaml
user:
  name: joao
  state: present
```

service → started
```yaml
service:
  name: nginx
  state: started
```

Não usar state com alguns módulos:
- command
- shell
- debug
- set_fact
Pois não controlam recursos e só executam ações.


#### ansible-playbook -i hosts playbooks/usuario-devops.yaml 
-i hosts → arquivo de inventory


#### ansible -i hosts targets -m shell -a "ls -l /opt" 
targets → grupo de hosts
-m shell → módulo
-a → argumentos dos módulo

#### ansible -i hosts targets -m shell -a "cat /opt/app/status.txt"


#### ansible -i hosts targets -m shell -a "id devops"
id devops → está executando em id devops
em todos os hosts do grupo targets


