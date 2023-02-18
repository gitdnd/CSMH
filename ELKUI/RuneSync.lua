-- Require the Server Message Handler
require("SMH")

local config = {
	Prefix = "RuneSync",
	Functions = {
		[1] = "OnFullCacheRequest", 
	}
}

local RuneSync = {
	cache = {}
}

function RuneSync.LoadData(guid) 
    RuneSync.cache[guid] = {} 
end

function RuneSync.OnLogin(event, player)
	player:SendServerResponse(config.Prefix, 2, player:GetRuneState())
end
 
 

function RuneSync.OnElunaStartup(event)
	for _, player in pairs(GetPlayersInWorld()) do
		RuneSync.LoadData(player:GetGUIDLow())
	end
end

function RuneSync.SendRuneState(event, player)
	player:SendServerResponse(config.Prefix, 2, player:GetRuneState())
end
 
 
function OnFullCacheRequest(player, argTable)
	player:SendServerResponse(config.Prefix, 1, RuneSync.cache[player:GetGUIDLow()])
end 

RegisterPlayerEvent(3, RuneSync.OnLogin)
RegisterServerEvent(33, RuneSync.OnElunaStartup)
RegisterPlayerEvent(45, RuneSync.SendRuneState)
RegisterClientRequests(config)

