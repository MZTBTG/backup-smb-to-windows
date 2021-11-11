#!/usr/bin/env bash

echo -e '==>   Backup automatizado V1.1  <==\n\n\033[05;31mCriado MZTBTG!\033[m\n'

bkp="/mnt/backup"

if [[ ! -z $1 ]] && [[ ! -z $2 ]]
then
  if [[ -d $bkp ]]
  then
    echo "==> A pasta backup já foi criada."
  else
    mkdir $bkp
    echo "==> Criado a pasta de backup."
  fi
  verif=$(ls $bkp |wc -l |cut -d ' ' -f 1)
  if [ $verif -eq 0 ]
  then  
    echo "==> Montando a pasta de backup."
    mount //192.168.184.6/backup-clientes $bkp -o vers=1.0 # Edite alguns parâmetros aqui
    echo "==> Pasta de backup montada."
  else
    echo "==> O backup já foi montado anteriormente."
  if [ $? -eq 0 ]
  then
    if [[ -d $bkp/$1 ]]
    then
      echo "==> A pasta do cliente já foi criada."
    else
      mkdir $bkp/$1
      sleep 1
      echo "==> Pasta $1 criada em $bkp."
    fi
    cd /media/$2
    if [ $? -eq 0 ]
    then
      shopt -s extglob
      eval '
        if [[ "$3" == "quiet" ]]
        then
          echo "==> Você verá apenas mensagens de erro."
          echo "==> Iniciando backup:"
          sleep 1
          cp -rnPa !(\$Recycle.Bin|Windows|pagefile.sys|hiberfil.sys|System\ Volume\ Information) $bkp/$1
        else
          echo "==> Iniciando backup:"
          sleep 1
          cp -rnvPa !(\$Recycle.Bin|Windows|pagefile.sys|hiberfil.sys|System\ Volume\ Information) $bkp/$1
        fi
    '
    # ====================== Inicio do bloco de comparação ==========================
    echo -e "\n+--------------------------------------------------------------------+"
    echo -e "|                          \033[01;32mBackup concluido\033[m                          |"
    echo "|                                                                    |"
    echo "|Para saber se a fonte dos dados está com erro, verifique o arquivo  |"
    echo "|\"registro de erro\" localizado na pasta de backup do nosso cliente.|"
    echo "|                                                                    |"
    echo "|Vamos iniciar a verificação dos arquivos.                           |"
    echo '|Abra um novo terminal e digite "ssh 192.168.184.6".                 |'
    echo '|Digite agora a palavra "yes" para confirmar.                        |'
    echo '|Pessa a senha para um de nossos técnicos e coloque logo em seguida. |'
    echo "|                                                                    |"
    echo "|Copie o código seguinte digitando Ctrl+Shift+C e cole no terminal.  |"
    echo -e "+--------------------------------------------------------------------+\n"
    echo "cd /backup/clientes/$1;du -h --max-depth=1"
    echo -e "\n==> Compare da forma correta os resultados.\n"
    du -h --max-depth=1 2>$bkp/$1/registro\ de\ erro
    error=$(wc -l $bkp/$1/registro\ de\ erro |cut -d ' ' -f 1)
    echo -ne "\n==> A fonte de dados possui $error erro(s)."
    # ======================= Fim do bloco de comparação ===========================
    echo -e "\n\033[05;32mSeu backup foi concluido\033[m\n"
    else
      echo -e '\n\033[01;31mO nome do caminho que você digitou está incorreto. Confira sua sintaxe e tente novamente.\033[m\n'
    fi
  else
    echo -e '\n\033[01;31mOcorreu um erro ao montar o backup. Verifique sua conexão com internet ou os cabos.\033[m\n'
  fi
else
  echo -e "Modo de uso:\nDigite sudo $0 ano-mes-dia-nomeDoComputador sdxx"
  echo 'Caso você queira uma transferência de dados levemente mais rápida, digite "quiet" no final da sintaxe.'
fi
