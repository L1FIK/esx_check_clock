fx_version "cerulean"

game {"gta5"}

author "LIFIK.app"

description "Script for checking the current time in Fivem"

client_script {
    'client/main.lua'
}

server_script {
    "server/main.lua",
    '@oxmysql/lib/MySQL.lua'
}