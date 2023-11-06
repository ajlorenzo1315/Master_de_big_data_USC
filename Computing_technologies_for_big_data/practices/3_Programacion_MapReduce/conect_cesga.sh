#!/bin/bash

# Inicializa las variables con valores predeterminados
vpn=""
curso=""
copy=""
# Analiza los argumentos de línea de comandos
while getopts "c:" opt; do
  case $opt in c)
      curso="$OPTARG"
      ;;
    \?)
      echo "Opción inválida: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [ "$vpn" == 'vpn' ]; then
  expect -c "
  spawn sudo ./snx -s pasarela.cesga.es -u curso$curso
  expect \"Please enter your password:\"
  send \"M.B.D$curso\r\"
  expect \"Do you accept? [y]es/ [N]o:\"
  send \"y\r\"
  expect eof
  "
fi

if [ "$copy" == '1' ]; then
expect -c "
spawn scp ./patentes/apat63_99.txt curso$curso@hadoop3.cesga.es:~
expect {
  \"The authenticity of host\" {
    send \"yes\r\"
    exp_continue
  }
  \"curso$curso@hadoop3.cesga.es's password:\" {
    send \"M.B.D$curso\r\"
    exp_continue
  }
  
}

"

expect -c "
spawn scp ./patentes/cite75_99.txt curso$curso@hadoop3.cesga.es:~
expect {
  \"The authenticity of host\" {
    send \"yes\r\"
    exp_continue
  }
  \"curso$curso@hadoop3.cesga.es's password:\" {
    send \"M.B.D$curso\r\"
    exp_continue
  }
  
}
"
fi


expect -c "
spawn scp -r 01-citingpatents curso$curso@hadoop3.cesga.es:~
expect {
  \"The authenticity of host\" {
    send \"yes\r\"
    exp_continue
  }
  \"curso$curso@hadoop3.cesga.es's password:\" {
    send \"M.B.D$curso\r\"
    exp_continue
  }
  
}
"



if [ "$copy" == '1' ]; then

expect -c "
spawn ssh curso$curso@hadoop3.cesga.es
expect {
  \"The authenticity of host\" {
    send \"yes\r\"
    exp_continue
  }
  \"curso$curso@hadoop3.cesga.es's password:\" {
    send \"M.B.D$curso\r\"
    exp_continue
  }
  interact
}
"
fi