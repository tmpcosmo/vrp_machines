-- Drink and Food Machines for vRP2 - by Apoc#4519
description 'vrp_machines'

dependency "vrp"

client_scripts{ 
  "@vrp/lib/utils.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "vrp.lua"
}

files{
  "cfg/machines.lua"
}