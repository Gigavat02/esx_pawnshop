fx_version 'adamant'
game 'gta5'

lua54 'yes'

author 'Gigavat'
description 'Pawnshop for buying and selling items'
version '1.0'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

server_scripts {
	'server/main.lua'
}

client_scripts {
	'client/main.lua',
	'client/ped.lua'
}

dependencies {
	'es_extended',
    'ox_lib',
    'ox_target',
    'ox_inventory'
}