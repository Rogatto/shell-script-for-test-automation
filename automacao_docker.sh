#!/bin/bash
echo "Executando processo de automacao!"
cd /tmp/workspace/build
nohup json-server --watch db.json > my.log 2>&1 &
echo $! > save_pid.txt
newman run /tmp/workspace/build/Regression_1.postman_collection.json -e /tmp/workspace/build/ev.postman_environment.json --export-environment /tmp/workspace/temporario/ev.postman_environment2.json --reporters html,cli --reporter-html-template /tmp/workspace/build/htmlreqres.hbs --reporter-html-export /tmp/workspace/build/Relatorios/primeira_rotina_api-file.html --ignore-redirects
cd /tmp/workspace/gmail
mvn clean test
newman run /tmp/workspace/build/Regression_2.postman_collection.json -e /tmp/workspace/temporario/ev.postman_environment2.json --export-environment /tmp/workspace/temporario/ev.postman_environment3.json --reporters html,cli --reporter-html-template /tmp/workspace/build/htmlreqres.hbs --reporter-html-export /tmp/workspace/build/Relatorios/segunda_rotina_api-file.html --ignore-redirects
cd /tmp/workspace/automation
mvn clean test
cd /tmp/workspace/build
kill -9 `cat save_pid.txt`
rm save_pid.txt
exit
