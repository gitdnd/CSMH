-- Require the Server Message Handler
require("SMH")

local config = {
	Prefix = "NeoTalentUI",
	Functions = {
		[1] = "OnFullCacheRequest",
		[2] = "OnDevelopRequest", 
		[3] = "GetTalentDevelopmentRequest", 
	}
}

local NeoTalentUI = {
	cache = {}
}

function NeoTalentUI.LoadData(guid) 
    NeoTalentUI.cache[guid] = {} 
end

function NeoTalentUI.OnLogin(event, player)
	if not(NeoTalentUI.cache[player:GetGUIDLow()]) then
		NeoTalentUI.LoadData(player:GetGUIDLow())
	end 
end
 
 

function NeoTalentUI.OnElunaStartup(event)
	-- Re-cache online players' data in case of a hot reload
	for _, player in pairs(GetPlayersInWorld()) do
		NeoTalentUI.LoadData(player:GetGUIDLow())
	end
end
 
 
function OnFullCacheRequest(player, argTable)
	player:SendServerResponse(config.Prefix, 1, NeoTalentUI.cache[player:GetGUIDLow()])
end

function OnDevelopRequest(player, argTable)
	if argTable[1] == nil then
		return
	end
    player:DevelopTalent(argTable[1]) 
end  
 
function GetTalentDevelopmentRequest(player, argTable)
	if argTable[1] == nil then
		return
	end
	local tal = player:GetTalentDevelopment(argTable[1])  
	if(tal ~= nil) then

		player:SendServerResponse(config.Prefix, 2, tal)
		
	end
end  

RegisterPlayerEvent(3, NeoTalentUI.OnLogin)
RegisterServerEvent(33, NeoTalentUI.OnElunaStartup)
RegisterClientRequests(config)

