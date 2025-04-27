@echo off
setlocal

set SERVER_IP=http://localhost:30120/idan-api
set ENDPOINT=Kick

set PLAYER_ID=2
set REASON=Testing your mother pussy

echo Sending test request to %SERVER_IP%/%ENDPOINT%...
curl -X POST %SERVER_IP%/%ENDPOINT% -H "Content-Type: application/json" -d "{\"id\":\"%PLAYER_ID%\", \"reason\":\"%REASON%\"}"

echo.
pause