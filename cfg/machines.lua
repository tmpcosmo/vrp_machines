cfg = {}

cfg.solid_sound = "sounds/eating.ogg" --default on vRP2
cfg.liquid_sound = "sounds/drinking.ogg" --default on vRP2

cfg.consume_machines = {
    --liquid
    {title="Sprunk", type="liquid", consume={water=0.5,food=0}, price=5},	--Change "consume" to affect player's health
    {title="eCola", type="liquid", consume={water=0.5,food=0}, price=5},	--Change "price" to whatever you want
    {title="Coffee", type="liquid", consume={water=0.5,food=0}, price=5},
    {title="Water", type="liquid", consume={water=0.5,food=0}, price=5},
    --solid
    {title="HotDog", type="solid", consume={water=0.2,food=0.5}, price=5},
    {title="Burger", type="solid", consume={water=-0.3,food=0.5}, price=5},
    {title="Phat Chips", type="solid", consume={water=-0.3,food=0.5}, price=5}
  
}

return cfg