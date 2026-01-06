# COMANDOS BASICOS EM LINUX

#!/bin/bash
echo "Ola, mundo!" 

echo -e "linha 1\nlinha 2\nlinha 3" > original_movido.txt
echo -e "erro: falha\ninfo: ok\aviso: cuidado" > log.txt
echo -e "nome idade\n joao 30\n" > dados.txt
echo -e "maria 25" >> dados.txt

cat dados.txt
nome idade
 joao 30

maria 25

head -n 1 log.txt
erro: falha

grep "linha" original_movido.txt
linha 1
linha 2
linha 3

grep -r "idade" .
./dados.txt:nome idade

sed 's/linha/LINHA/g' original_movido.txt
LINHA 1
LINHA 2
LINHA 3

awk '{print $2}' dados.txt
idade
10
17
25
42

wc -w dados.txt
      14 dados.txt

sort dados.txt
bruno 17
camila 34
gabriela 97
joao 10
maria 25
nome idade
paloma 42

uptime
16:51  up 10 mins, 2 users, load averages: 34,69 77,46 41,96

