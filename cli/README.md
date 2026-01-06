# COMANDOS BASICOS EM LINUX
˜               → indica o diretório home
apropos         → procura comandos por descrição (“a propósito de”)
arch            → architecture: mostra a arquitetura do processador
apt             → Advanced Package Tool (gerenciador de pacotes)
awk             → processamento de texto por padrões
cal             → calendar
cat             → concatenate e exibe arquivos
cd              → change directory
chmod           → change mode (modifica permissões)
chown           → change owner
cp              → copy (cp -r copia diretórios)
date            → exibe ou altera data e hora
df              → disk free (uso do disco)
diff            → difference: compara arquivos linha por linha
du              → disk usage (uso de espaço)
echo            → imprime mensagens ou valores
fdisk           → Fixed Disk: gerencia partições de disco
finger          → informações sobre usuários logados
fsck            → file system check: verifica e repara sistemas de arquivos
grep            → global regular expression print (busca padrões em arquivos)
groupadd        → cria grupos
groupdel        → remove grupos
halt            → encerra o sistema imediatamente
help            → ajuda de comandos internos do shell
hwclock         → Hardware Clock: mostra/ajusta relógio de hardware
id              → Identification: mostra ID do usuário e grupos
ifconfig        → Interface Configuration: configura/exibe interfaces de rede
info            → documentação GNU
init 0          → desliga o sistema
init 6          → reinicia o sistema
kill            → encerra processo pelo PID
killall         → encerra processo pelo nome
last            → histórico de logins
locate          → localiza arquivos (base indexada)
ls              → list: lista arquivos
ls -a           → list all: lista arquivos ocultos
ls -l           → list long: formato longo
ls -m           → lista com vírgulas
lsusb           → list USB: lista dispositivos USB
lspci           → list PCI: lista dispositivos PCI
man             → manual
mkdir           → Make Directory: cria diretórios
mount           → monta dispositivos
mv              → move/renomeia arquivos
PATH            → variável de ambiente com diretórios executáveis
passwd          → password: altera senha do usuário
ping            → Packet Internet Groper: testa conectividade (ICMP)
ps              → Process Status: lista processos
pwd             → Print Working Directory: print working directory
rm              → remove arquivos/diretórios
route           → mostra tabela de roteamento
runlevel        → mostra nível de execução
sudo            → Superuser Do: executa comando como root
su -            → Switch User: troca para root
tar             → Tape Archive: compacta/descompacta arquivos
top             → Table Of Processes: monitor de processos em tempo real
touch           → cria arquivos vazios / atualiza timestamp
uname           → Unix Name: informações do sistema e kernel
umount          → Unmount: desmonta sistemas de arquivos
useradd         → cria usuários
userdel         → remove usuários
usermod         → modifica usuários
w               → Who + What: quem está logado e o que faz
wc              → word count
whatis          → descreve comando
whereis         → localiza binários/manuais/fontes
which           → caminho do executável
who             → quem está logado
whoami          → usuário atual

# COMANDOS BASICOS DO LINUX QUE NÃO EXISTEM NO MACOS
apt             → brew
groupadd        → dscl
groupdel        → dscl
useradd         → dscl
userdel         → dscl
usermod         → dscl
hwclock         → X
lspci           → X
lsusb           → X
runlevel        → X
lsb_release     → X
ifconfig        → existe, mas é considerado obsoleto
route           → existe, mas pouco usado hoje
fdisk           → existe, mas com comportamento diferente
init            → existe, mas não é usado como no Linux
finger          → pode não vir instalado
locate          → precisa ativar base de dados

# OPÇÕES DE COMANDOS (todos funcionam no mac também)
    -r → recursive
    -f → force
    -h → human-readable
    -i → interactive

### CLASSES DE USUARIOS
    U → user: proprietario/owner do arquivo
    G → group: usuarios que pertencem ao mesmo grupo do arquivo
    O → others: todos os outros que nao sao donos nem estao no grupo
    A → all: todos os outros

### NOTACAO NUMERICA
    r = 4    w = 2    x = 1
    A permissao total para cada classe é a soma desses valores
    7: 4+2+1 = rwx tudo permitido
    5: 4+1 = r-x ler e executar
    4: 4 = r-- só leitura

### PERMISSOES POSSIVEIS
    r → read
    w → write
    x → execute: permite rodar arquivos (se for executavel)

### ENCADEAMENTOS
    && → encadeamento: só executa o segundo comando se o primeiro tiver sucesso
    || → encadeamento: só executa o segundo comando se o primeiro não tiver sucesso

    
### EDICAO DE TEXTO
    less nome_do_arquivo → permite visualizar arquivos grandes
    <espaço> → **avança uma pagina**
    b → **volta uma pagina**
    /palavra → **busca no texto**
    q → **sair**
    head → mostra primeiras linhas
    head -n2 0 nome_do_arq → **mostra as primeiras 20 linhas**
    tail → mostra ultimas linhas
    -e → ativa interpretação de caracteres espericias como \n, \t
    -i → ignora maiusculas e minusculas

### ESTRUTURA TIPICA DO ROOT DIRECTORY NO LINUX / :
/bin        → programas essenciais (executáveis básicos como ls, cp, mv,...)
/boot       → arquivos de inicialização do sistema (kernel, GRUB)
/dev        → dispositivos do sistema (discos, USB, etc)
/etc        → arquivos de configuração
/home       → diretorios pessoais dos usuários 
/lib        → bibliotecas 
/lost+found → recuperação de arquivos em partições ext4
/media      → mídia removível 
/mnt        → montagem temporária
/opt        → softwares opcionais 
/proc       → kernel/processos
/root       → diretorio pessoal do usuario root
/run        → informaçoes temporarias do sistema em execução
/sbin       → programas essenciais de administraçao do sistema
/srv        → dados de serviços (servidores web, FTP, etc)
/sys        → kernel/hardware
/tmp        → temporários 
/usr        → programas/bibliotecas 
/var        → arquivos variaveis (logs, cache, spool)
/initrd.img → imagem usada na inicialização
/vmlinuz    → kernel linux comprimido

### ESTRUTURA TIPICA DO ROOT DIRECTORY NO MACOS / :
/Applications   → aplicativos instalados (Safari, Xcode, etc)
/Library        → bibliotecas e configurações globais do sistema
/System         → arquivos essenciais do macOS (protegido)
/Users          → diretórios pessoais dos usuários
/Volumes        → discos e volumes montados (HDs, pendrives)
/bin            → comandos básicos (ls, cp, mv, cat...)
/sbin           → comandos administrativos
/usr            → binários, bibliotecas e ferramentas do sistema
/etc            → configs (na prática é link simbólico)
/tmp            → arquivos temporários
/var            → logs, cache e dados variáveis
/dev            → dispositivos (disco, terminal, etc)


### GERENCIADORES DE PACOTES POR DISTRIBUIÇÃO DE SISTEMA


Debian/Ubuntu → apt
Red Hat/CentOS/Rocky/Alma/Amazon Linux → dnf (moderno) ou yum (legado)
Arch Linux → pacman
macOS → brew
Alpine Linux → apk
