local Skull = require("lib.skull")
local Color = require("lib.color")


function hash(str)
	local hash = 0
	for i = 1, #str do
		local c = str:byte(i)
		hash = (hash * math.pi + c) % 100000 -- keep it within 5 digits
	end
	return hash
end


local SCALE = 0.845

--models.info.hat:scale(SCALE,SCALE,SCALE)


---@type SkullIdentity|{}
local identity = {
	name = "toiletpaper",
	modelBlock = models.info.Item,
	modelHat = models.info.Item,
	modelHud = Skull.makeIcon(models.info.icon),
	modelItem = models.info.Item,
	
	processHat = {
		ON_ENTER = function (skull, model)
		end
	},
	
	processEntity = {
		ON_ENTER = function (skull, model)
			local i = 0
			for key, value in pairs(Skull.getSkullIdentities()) do
				model:newText(key.."title"):pos(7,i*-3-6,-6):text(toJson{text=key,color="black"}):scale(0.15)
				local desc = model:newText(key.."requirements"):pos(7,i*-3-7.4,-6):scale(0.1)
				
				if value.support then
					desc:text(toJson{text="Place on: "..value.support,color="black"})
				else
					desc:text(toJson{text="Rename to: "..value.name,color="black"})
				end
				
				i = i + 1
				model.Middle:scale(1,(i*3+2)/16,1)
			end
		end,
		ON_PROCESS = function (skull, model)
			local scroll = client:getCameraRot().x / 180
			model:setPos(0,16 + scroll * 64,16)
		end
	}
}

Skull.registerIdentity(identity)