#!/bin/bash

# Exemplo do uso
# Adicionar build step Executar Shell
# sh /var/lib/jenkins/status_task_sonar.sh ${WORKSPACE}/projeto/.sonar/report-task.txt 10 30

ARQUIVO=$1
TENTATIVAS=$2
TEMPO_ESPERA=$3

CONTEUDO=$(cat $ARQUIVO)

TASK_ID=${CONTEUDO##*id=}


SONAR_USER=usuario
SONAR_PASSWORD=senha
SONAR_URL=sonar.meusite.com.br
SONAR_PORTA=9000

while [ $TENTATIVAS -gt 0 ]; do

        echo "Tentativas restantes: "$TENTATIVAS
        URL_REST_STATUS='http://'$SONAR_USER':'$SONAR_PASSWORD'@'$SONAR_URL':'$SONAR_PORTA'/api/ce/task?id='$TASK_ID
        RETORNO_STATUS=$(curl $URL_REST_STATUS)

        P1=${RETORNO_STATUS%%submittedAt*}
        P2=${P1##*status}
        P3=${P2##*:}
        P4=${P3%%,*}
        P5=${P4#\"}
        STATUS=${P5%\"}

        echo "Status da tarefa no Sonar:"
        if [ $STATUS = "PENDING" ]; then
                echo "PENDENTE - Aguardando nova tentativa."
                sleep $TEMPO_ESPERA
        fi

        if [ $STATUS = "IN_PROGRESS" ]; then
                echo "EM PROGRESSO - Aguardando nova tentativa."
                sleep $TEMPO_ESPERA

        fi

        if [ $STATUS = "SUCCESS" ]; then
                echo "SUCESSO - Tarefa executada com sucesso."
                exit 0
        fi

        if [ $STATUS = "FAILED" ]; then
                echo "FALHOU - Houve uma falha ao executar a tarefa no Sonar. Verifique os logs do Sonar."
                exit 137
        fi

        TENTATIVAS=$(($TENTATIVAS - 1))

done

echo "Nao foi possivel verificar o status da tarefa no Sonar em tempo habil. Aumente a quantidade de tentativas/sleep ou tente novamente mais tarde."
exit 137

