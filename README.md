# qb-nudler
Nudler jobb laget av Tobias#4245 :)

# items to add in qb-core/shared/items.lua
	['currynudler'] 				 = {['name'] = 'currynudler', 			 	  	  	['label'] = 'Curry Nudler', 					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'currynudler.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Nudler med curry smak!'},
	['kyllingnudler'] 				 = {['name'] = 'kyllingnudler', 			  	  	['label'] = 'Kylling Nudler', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'kyllingnudler.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Kyllingnudler! :O'},
	['kjøttnudler'] 				 = {['name'] = 'kjøttnudler', 			  			['label'] = 'Kjøtt Nudler', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'kjøttnudler.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Kjøttnudler :O'},

# Add to qb-smallresources/config: ConsumablesEat
    ["currynudler"] = math.random(35, 54),
    ["kyllingnudler"] = math.random(40, 50),
    ["kjøttnudler"] = math.random(40, 50),
	
# 	qb-smallresources/server: Consumables.lua

QBCore.Functions.CreateUseableItem("currynudler", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if not Player.Functions.RemoveItem(item.name, 1, item.slot) then return end
    TriggerClientEvent("consumables:client:Eat", source, item.name)
end)

QBCore.Functions.CreateUseableItem("kyllingnudler", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if not Player.Functions.RemoveItem(item.name, 1, item.slot) then return end
    TriggerClientEvent("consumables:client:Eat", source, item.name)
end)

QBCore.Functions.CreateUseableItem("kjøttnudler", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if not Player.Functions.RemoveItem(item.name, 1, item.slot) then return end
    TriggerClientEvent("consumables:client:Eat", source, item.name)
end)

Add images to lj-inventory/html/images and delete them after you have finished this step!

MLO Used: https://www.youtube.com/watch?v=0e5LvATh2m0

restart your server and eat your noodles!

# License

    QBCore Framework
    Copyright (C) 2021 Joshua Eger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>
