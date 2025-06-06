---@diagnostic disable: discard-returns
local Skull = require("lib.skull")


function hash(str)
	local hash = 0
	for i = 1, #str do
		local c = str:byte(i)
		hash = (hash * math.pi + c) % 100000 -- keep it within 5 digits
	end
	return hash
end


local identity = Skull.registerIdentity{
	name = "Benchmark",
	support = "minecraft:observer",
	modelBlock = models.skull.block,
	modelHat = models.skull.hat,
	modelHud = Skull.makeIcon(models.skull.icon),
	modelItem = models.skull.entity,
	
	processBlock = {
		---@param skull SkullInstanceBlock
		---@param model ModelPart
		ON_ENTER = function (skull, model)
			model:setColor(1,0,0)
			skull.billBoard = skull.blockModel:newPart("billBoard"):scale(0.25,0.25,0.25):pos(0,16,0)
		end,
	
		---@param skull SkullInstanceBlock
		---@param model ModelPart
		ON_PROCESS = function (skull, model,delta)
			model.ht:setRot(math.random(-5,5),math.random(-5,5),math.random(-5,5))
			local skulls = Skull.getSkullBlockInstances()
			skull.billBoard:removeTask():setRot(0,180-client:getCameraRot().y)
			
			local i = 0
			
			---@param id string
			---@param targetSkull SkullInstanceBlock
			for id, targetSkull in pairs(skulls) do
				i = i + 1
				skull.billBoard:newText(id):pos(-25,i*10-50,0):text(id)
			end
			
		end,
	
		---@param skull SkullInstanceBlock
		---@param model ModelPart
		ON_EXIT = function (skull, model)
			
		end
	},

	processEntity = {
		ON_ENTER = function (skull, model)
			model:setColor(1,0,0)
		end,
	},
	processHat = {
		---@param skull SkullInstanceHat
		---@param model ModelPart
		ON_ENTER = function (skull, model)
			model:setColor(1,0,0)
		end,
	},
	processHud = {
		---@param skull SkullInstanceHud
		---@param model ModelPart
		ON_ENTER = function (skull, model)
			model:getTask("Icon"):setColor(1,0,0)
		end,
	},
}

