require("SMH")

local config = {
	Prefix = "WarforgingUI",
	Functions = {
		[1] = "OnWarforgeRequest" 
	}
}
 
function OnWarforgeRequest(player, argTable)
	local args = {}
	for i = 1, 8 do
		if argTable[1][i] ~= nil then
			args[i] = tonumber(argTable[1][i])
		else
			args[i] = -1	
		end
	end
	local lvl, id = player:WarforgeItems(table.unpack(args))
	player:SendServerResponse(config.Prefix, 1, lvl, id)
end

RegisterClientRequests(config)
