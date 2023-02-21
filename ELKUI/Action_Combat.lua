require("SMH")

local config = {
	Prefix = "Action_Combat",
	Functions = {
		[1] = "OnBonusILVLRequest",
		[2] = "ServerEPress" 
	}
}
 
function OnBonusILVLRequest(player, argTable)
	local item = tonumber(argTable[1])
	if item ~= nil and item ~= 0 then
		local lvl, id = player:GetBonusILVL(item)
		local succ = player:SendServerResponse(config.Prefix, 1, lvl, id)
	end
end
function ServerEPress(player)
	player:EPress()
end

RegisterClientRequests(config)
