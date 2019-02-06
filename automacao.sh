#!/bin/bash
echo "Executando processo de automacao!"
cd /home/grogatto/Documentos/Projetos/Cateno/Iris/workspace/build
nohup json-server --watch db.json > my.log 2>&1 &
echo $! > save_pid.txt
newman run /home/grogatto/Documentos/Projetos/Cateno/Iris/workspace/build/Regression_Cateno_1.postman_collection.json -e /home/grogatto/Documentos/Projetos/Cateno/Iris/workspace/build/Cateno.postman_environment.json --export-environment /home/grogatto/Documentos/Projetos/Cateno/Iris/workspace/temporario/Cateno.postman_environment2.json --reporters html,cli --reporter-html-template /home/grogatto/Documentos/Projetos/Cateno/Iris/workspace/build/htmlreqres.hbs --reporter-html-export /home/grogatto/Documentos/Projetos/Cateno/Iris/workspace/relatorios/primeira_rotina_api_cateno-file.html --ignore-redirects
cd /home/grogatto/Documentos/Projetos/Cateno/Iris/workspace/gmail
mvn clean test
newman run /home/grogatto/Documentos/Projetos/Cateno/Iris/workspace/build/Regression_Cateno_2.postman_collection.json -e /home/grogatto/Documentos/Projetos/Cateno/Iris/workspace/temporario/Cateno.postman_environment2.json --export-environment /home/grogatto/Documentos/Projetos/Cateno/Iris/workspace/temporario/Cateno.postman_environment3.json --reporters html,cli --reporter-html-template /home/grogatto/Documentos/Projetos/Cateno/Iris/workspace/build/htmlreqres.hbs --reporter-html-export /home/grogatto/Documentos/Projetos/Cateno/Iris/workspace/relatorios/segunda_rotina_api_cateno-file.html --ignore-redirects
cd /home/grogatto/Documentos/Projetos/Cateno/Iris/workspace/cateno_automation
mvn clean test
cd /home/grogatto/Documentos/Projetos/Cateno/Iris/workspace/build
kill -9 `cat save_pid.txt`
rm save_pid.txt
exit