local lang = vRP.lang
local cfg = module("vrp_machines", "cfg/machines")
local vRPmachines = class("vRPmachines", vRP.Extension)

function vRPmachines:__construct()
    vRP.Extension.__construct(self)
end

local liquid_seq = {
  {"mp_player_intdrink","intro_bottle",1},
  {"mp_player_intdrink","loop_bottle",1},
  {"mp_player_intdrink","outro_bottle",1}
}

local solid_seq = {
  {"mp_player_inteat@burger", "mp_player_int_eat_burger_enter",1},
  {"mp_player_inteat@burger", "mp_player_int_eat_burger",1},
  {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp",1},
  {"mp_player_inteat@burger", "mp_player_int_eat_exit_burger",1}
}

RegisterServerEvent('machine:buy')
AddEventHandler('machine:buy', function(item)
	local user = vRP.users_by_source[source]
	for k,v in pairs(cfg.consume_machines) do
		if v.title == item then
			if user:tryPayment(v.price,true) then
				user:tryPayment(v.price)
				vRP.EXT.Base.remote._notify(user.source,lang.money.paid({v.price}))
				if v.type == "liquid" then
					vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
					vRP.EXT.Audio.remote._playAudioSource(-1, cfg.liquid_sound, 1, 0,0,0, 30, user.source)
					vRP.EXT.Base.remote._notify(user.source,lang.edible.liquid.notify({v.title}))
				elseif v.type == "solid" then
					vRP.EXT.Base.remote._playAnim(user.source,true,solid_seq,false)
					vRP.EXT.Audio.remote._playAudioSource(-1, cfg.solid_sound, 1, 0,0,0, 30, user.source)
					vRP.EXT.Base.remote._notify(user.source,lang.edible.solid.notify({v.title}))
				end
				user:varyVital("water",v.consume.water)
				user:varyVital("food",v.consume.food)
			else
				vRP.EXT.Base.remote._notify(user.source,lang.money.not_enough())
			end
		end
	end
end)