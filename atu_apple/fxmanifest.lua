fx_version 'cerulean'
game 'gta5'

author 'Atu.#7878'
description 'Apple job for ESX fivem server using ox_lib, ox_target and ox_inv'
version '1.0.0'

shared_script {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

client_script 'Client/*.lua'

server_script 'Server/*.lua'

lua54 'yes'