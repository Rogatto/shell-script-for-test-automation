#!/bin/bash
echo "Executando processo de automacao!"
cd /home/grogatto/Documentos/Projetos/workspace/build
nohup json-server --watch db.json > my.log 2>&1 &
echo $! > save_pid.txt
newman run /home/grogatto/Documentos/Projetos/workspace/build/Regression_1.postman_collection.json -e /home/grogatto/Documentos/Projetos/workspace/build/environment_postman.postman_environment.json --export-environment /home/grogatto/Documentos/Projetos/workspace/temporario/ev.postman_environment2.json --reporters html,cli --reporter-html-template /home/grogatto/Documentos/Projetos/workspace/build/htmlreqres.hbs --reporter-html-export /home/grogatto/Documentos/Projetos/workspace/relatorios/primeira_rotina_api-file.html --ignore-redirects
cd /home/grogatto/Documentos/Projetos/workspace/gmail
mvn clean test
newman run /home/grogatto/Documentos/Projetos/workspace/build/Regression_2.postman_collection.json -e /home/grogatto/Documentos/Projetos/workspace/temporario/ev.postman_environment2.json --export-environment /home/grogatto/Documentos/Projetos/workspace/temporario/ev.postman_environment3.json --reporters html,cli --reporter-html-template /home/grogatto/Documentos/Projetos/workspace/build/htmlreqres.hbs --reporter-html-export /home/grogatto/Documentos/Projetos/workspace/relatorios/segunda_rotina_api-file.html --ignore-redirects
cd /home/grogatto/Documentos/Projetos/workspace/automation
mvn clean test
cd /home/grogatto/Documentos/Projetos/workspace/build
kill -9 `cat save_pid.txt`
rm save_pid.txt
exit
