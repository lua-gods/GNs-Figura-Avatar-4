---@diagnostic disable: invisible
--[[______   __
  / ____/ | / /  by: GNanimates / https://gnon.top / Discord: @gn68s
 / / __/  |/ / name: GNUI Screen
/ /_/ / /|  /  desc: handles all the inputs
\____/_/ |_/ source: link ]]

local Box   = require("./box")    ---@type GNUI.BoxAPI
local utils = require("../utils") ---@type GNUI.UtilsAPI
local Draw  = require("../backend/draw")  ---@type GNUI.DrawBackendAPI
local Input = require("../backend/input") ---@type GNUI.InputBackendAPI

---@class GNUI.ScreenAPI
local ScreenAPI = {}



---@class GNUI.Screen : GNUI.Box
---@field drawBackend GNUI.DrawBackend
---@field updateQueue {[1]:GNUI.Box,[2]:boolean}[] #{box,isPreUpdate}
---@field protected __index function
local Screen = {}
Screen.__index = function(t,k)
	return rawget(t,k) or Screen[k] or Box.methods[k]
end
Screen.__type = "GNUI.Box.Screen"


---@param cfg (GNUI.Screen|{})?
---@return GNUI.Screen
function ScreenAPI.new(cfg)
	local self = Box.new(cfg) ---@cast self GNUI.Screen
	self.updateQueue = {}
	self.screen = self
	Draw.newDrawBackend(self)
	Input.RENDER:register(function ()self:renderUpdate()end)
	setmetatable(self,Screen)
	return self
end


---@param box GNUI.Box
---@param pre boolean?
---@return GNUI.Screen
function Screen:queryUpdate(box,pre)
	table.insert(self.updateQueue,{box,pre})
	return self
end


---Updates all the update queries of child box hierarchy
---@return self
function Screen:renderUpdate()
	for i, query in ipairs(self.updateQueue) do
		local box = query[1]
		if query[2] then
			box:forcePreUpdate()
		else
			box:forcePostUpdate()
			-- TODO: Draw Backend stuff here
			--self.drawBackend
		end
	end
	self.updateQueue = {}
	return self
end


ScreenAPI.methods = Screen
return ScreenAPI