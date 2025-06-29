local Skull = require("lib.skull")

function applyMatrixToVec3(matrix, vector)
	local x = vector.x
	local y = vector.y
	local z = vector.z

	local newX = matrix.v11 * x + matrix.v12 * y + matrix.v13 * z + matrix.v14 * 1
	local newY = matrix.v21 * x + matrix.v22 * y + matrix.v23 * z + matrix.v24 * 1
	local newZ = matrix.v31 * x + matrix.v32 * y + matrix.v33 * z + matrix.v34 * 1
	local w    = matrix.v41 * x + matrix.v42 * y + matrix.v43 * z + matrix.v44 * 1

	if w ~= 0 and w ~= 1 then
		newX = newX / w
		newY = newY / w
		newZ = newZ / w
	end

	return vec(newX, newY, newZ)
end

local HALF = vec(0.5,0.5,0.5)

---@type SkullIdentity|{}
local identity = {
	name = "Matrix",
	support="minecraft:piston",
	modelBlock = models.skall.block,
	modelHat = models.skull.hat,
	modelHud = Skull.makeIcon(models.skull.icon),
	modelItem = models.skull.hat,
	
	processBlock = {
		ON_ENTER = function (skull, model)
			local ogPos = {}
			
			local vertices = model.Model:getAllVertices()["textures.plushie"]
			for i, vertex in ipairs(vertices) do
				ogPos[i] = vertex:getPos()
			end
			skull.ogPos = ogPos
		end,
		ON_PROCESS = function (skull, model)
			local mat = matrices.mat4(
				vec(1,0,0,0),
				vec(0.1,1,0,0),
				vec(0,0,1,math.sin(client:getSystemTime()/200)*0.1),
				vec(0,0,0,0.5)
			)
			
			
			local ogPos = skull.ogPos
			
			local vertices = model.Model:getAllVertices()["textures.plushie"]
			for i, vertex in ipairs(vertices) do
				vertex:pos(applyMatrixToVec3(mat,ogPos[i]))
			end
		end
	}
}

Skull.registerIdentity(identity)