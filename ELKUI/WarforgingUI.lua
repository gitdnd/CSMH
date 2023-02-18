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
		if argTable[i] ~= nil then
			args[i] = argTable[i]
		else
			args[i] = -1	
		end
	end
	player:WarforgeItems(args)
end

RegisterClientRequests(config)
