--[[______   __
  / ____/ | / /  by: GNanimates / https://gnon.top / Discord: @gn68s
 / / __/  |/ / name: Animation Name
/ /_/ / /|  /  desc: overhauls the animation system in Figura
\____/_/ |_/ source: link ]]
--[────────────────────────────────────────-< AvatarNBT Documentation >-────────────────────────────────────────]--


---@class AvatarNBT.Vector3 : Vector3
---@field [0] number
---@field [1] number
---@field [2] number

---@class AvatarNBT.Model
---@field chld AvatarNBT.Model[]
---@field name string
---@field anim Animation.Track?
---@field piv AvatarNBT.Vector3

---@class AvatarNBT.AnimationData
---@field scl AvatarNBT.AnimationTrack
---@field rot AvatarNBT.AnimationTrack
---@field pos AvatarNBT.AnimationTrack

---@class AvatarNBT.AnimationTrack
---@field [number] AvatarNBT.Keyframe

---@class AvatarNBT.Keyframe
---@field pre AvatarNBT.Vector3
---@field time number
---@field int "linear"|"step"
---@field i integer

---@class AvatarNBT.AnimationIdentity
---@field name string
---@field len number # length
---@field mdl string # Model name
---@field loop "loop"|"hold"|nil # Loop type, nil if none

--[────────────────────────-< Library Documentation >-────────────────────────]--

---@class Animation.Track
---@field id integer
---@field data AvatarNBT.AnimationData
---@field len number
---@field loop "loop"|"hold"|nil


---@class ModelPart
---@field isPlaying boolean
---@field isHolding boolean # if teh animation is paused at the end of the animation
---@field animation Animation.Track
---@field speed number
---@field weight number
---@field time number

--[────────────────────────────────────────-< NBT Animation Parsing >-────────────────────────────────────────]--

-- NOTE: The typings are only related to the animation library, not everything is included.
---@type {animations:AvatarNBT.AnimationIdentity[],models:{name:"models",child:AvatarNBT.Model[]}}
local nbt=avatar:getNBT()



local animationIdentities={} ---@type table<integer,AvatarNBT.AnimationIdentity>
local animationIdentityLookup={} ---@type table<string,integer>
local animiationTimelines={} ---@type table<ModelPart,AvatarNBT.AnimationData>

local modelOriginals={} ---@type table<ModelPart,ModelPart>

local animationStates={} ---@type table<ModelPart,ModelPart> # I promise this makes sense


for id, animation in ipairs(nbt.animations) do
	local name=animation.mdl .. "." .. animation.name
	---@cast animation AvatarNBT.AnimationIdentity
	animationIdentities[id]=animation
	animationIdentityLookup[name]=id
	animation.tracks={}
end


---@param track AvatarNBT.AnimationTrack
local function parseAnimationTrack(track)
	table.sort(track, function(a,b) return a.time < b.time end)
	for i, keyframe in ipairs(track) do
	---@diagnostic disable-next-line: assign-type-mismatch
		keyframe.pre=vec(table.unpack(keyframe.pre))
		keyframe.i=i
	end
	return track
end

local function makeDefaults(model)
	animationStates[model]=animationStates[model] or {
		isPlaying=false,
		isHolding=false,
		speed=1,
		weight=1,
		time=0,
	}
end

--- Convert the model tree to a nested map for efficiency
---@param entry AvatarNBT.Model
---@param model ModelPart
local function parseNBTModelData(entry,model)
	makeDefaults(model)
	if entry.anim then
		---@param index integer
		for index, timeline in ipairs(entry.anim) do
			local id=timeline.id+1
			local identity=animationIdentities[id]
			if timeline.data then
				timeline.data.scl=timeline.data.scl and parseAnimationTrack(timeline.data.scl)
				timeline.data.rot=timeline.data.rot and parseAnimationTrack(timeline.data.rot)
				timeline.data.pos=timeline.data.pos and parseAnimationTrack(timeline.data.pos)
			end
			timeline.len=identity.len or 0
			timeline.loop=identity.loop
			--timeline.identity=animationIdentities[id]
			animiationTimelines[id]=animiationTimelines[id] or {}
			animiationTimelines[id][model]=timeline
		end
	end
	
	if entry.chld then
		for index, child in ipairs(entry.chld) do
			local name=child.name
			parseNBTModelData(child,model[name])
		end
	end
end


parseNBTModelData(nbt.models,models)


--[────────────────────────────────────────-< Animation Player >-────────────────────────────────────────]--

local animationCache={} ---@type table<ModelPart,table> # cache data
local activeAnimations={} ---@type table<ModelPart,Animation.Track>
local AnimationProcessor=models:newPart("AnimationProcessor","WORLD")

local POS_MUL=vec(-1, 1, 1)
local ROT_MUL=vec(-1, -1, 1)

local TRACKS={"pos","rot","scl"}


---@param trackData AvatarNBT.AnimationTrack
---@param time number
---@param cache table
---@param apply fun(ckey:AvatarNBT.Keyframe,cnext:AvatarNBT.Keyframe)
local function applyTrack(trackData, time, cache, apply,recursive)
	if not trackData then return end
	recursive=recursive and (recursive+1) or 0
	if recursive > 50 then
		error("Unable to find keyframe!")
	end
	---@type AvatarNBT.Keyframe
	local ckey=cache.currentKeyframe
	
	
	-- fallback keyframe to start
	if not ckey then
		ckey=trackData[1]
		cache.currentKeyframe=ckey
	end
	---@type AvatarNBT.Keyframe
	local cnext=trackData[ckey.i+1]
	--print(time,ckey.time,ckey.i,cnext.time,cnext.i)
	if ckey then
		if (not (cnext) and ckey.time <= time) or (ckey.time <= time and cnext.time >= time) then
			apply(ckey,cnext or ckey)
			cache.currentKeyframe=ckey
		else
			if ckey.time > time then -- backtrack
			local cprev=trackData[ckey.i-1]
				cache.currentKeyframe=cprev
				if not cprev then
					cache.currentKeyframe=ckey
					apply(ckey,ckey)
				else
					cache.currentKeyframe=cprev
					applyTrack(trackData, time, cache, apply, recursive)
				end
			elseif cnext.time < time then -- advance
				cache.currentKeyframe=cnext
				applyTrack(trackData, time, cache, apply, recursive)
			end
		end
	end
end



local function lerp(k1,k2,time)
	if k1.int == "step" then
		return k1.pre
	else
		local len=math.max(k2.time-k1.time,0.0001)
		return math.lerp(k1.pre, k2.pre, (time-k1.time) / len)
	end -- TODO: cat maul roam
end



local lastTime=client:getSystemTime()
AnimationProcessor.postRender	= function ()
	local time=client:getSystemTime()
	local delta=(time-lastTime) / 1000
	lastTime=time
	
	for model, track in pairs(activeAnimations) do
		local modelID=modelOriginals[model] or model
		local state=animationStates[model]
		local cache=animationCache[model]
		local time=state.time
		local amp=state.weight
		-- Figura needs an offsetPos, like how setScale and setOffsetScale exist
		
		applyTrack(track.data.scl, time, cache.scl, function(k1,k2)
			model:setScale((lerp(k1,k2,time)-1)*amp+1)
		end)
		
		applyTrack(track.data.rot, time, cache.rot, function(k1,k2)
			model:setRot(lerp(k1,k2,time)*ROT_MUL*amp)
		end)
		
		applyTrack(track.data.pos, time, cache.pos, function(k1,k2)
			model:setPos(lerp(k1,k2,time)*POS_MUL*amp)
		end)
		
		state.time=state.time+delta*state.speed
		
		if state.time >= track.len then
			if track.loop == "loop" then
				state.time=0
			elseif track.loop == "hold" then
				state.isPlaying=false
				state.isHolding=true
			else
				state.isPlaying=false
				state.time=0
			end
		end
	end
end



--[────────────────────────────────────────-< Extra ModelPart APIs >-────────────────────────────────────────]--
local ogCopy=models.copy

---@class ModelPart
local ModelPart={}
ModelPart.__index=ModelPart


---@param self ModelPart
---@param callback fun(self:ModelPart,...:any)
local function applyNested(self,callback,...)
	callback(self,...)
	for _, child in ipairs(self:getChildren()) do
		applyNested(child,callback,...)
	end
end



---@param animationName string
function ModelPart:play(animationName)
	local id=animationIdentityLookup[animationName]
	if not id then return end
	
	applyNested(self,function (self, id)
		local sourceModel=modelOriginals[self] or self
		local timeline=animiationTimelines[id][sourceModel]
		
		if timeline then
			animationCache[self]={pos={}, rot={}, scl={}}
			activeAnimations[self]=timeline
			local state=animationStates[self]
			state.isPlaying=true
			state.animation=timeline
			state.time=0
		end
	end,id)
end



function ModelPart:stop()
	applyNested(self,function (self)
		activeAnimations[self]=nil
		local state=animationStates[self]
		self:setRot():setScale():setPos()
		if state then
			state.isPlaying=false
			state.animation=nil
		end
	end)
end

---@param speed number
function ModelPart:setSpeed(speed)
	applyNested(self,function (self)
		local state=animationStates[self]
		if state then
			state.speed=speed
		end
	end)
end


function ModelPart:setBlend(amplifier)
	applyNested(self,function (self)
		local state=animationStates[self]
		if state then
			state.weight=amplifier
		end
	end)
end


---@param name string
---@return ModelPart
function ModelPart:copy(name)
	local clone=ogCopy(self,name)
	makeDefaults(clone)
	-- make sure all the clones point to the original reference
	if modelOriginals[self] then
		modelOriginals[clone]=modelOriginals[self]
	else
		modelOriginals[clone]=self
	end
	return clone
end


local ogIndex=figuraMetatables.ModelPart.__index
figuraMetatables.ModelPart.__index=function (self, key)
	return ModelPart[key] or ogIndex(self,key)
end

--[────────────────────────────────────────-< Playground >-────────────────────────────────────────]--
--[[
local deepCopy=require("lib.deepCopy")

models.testion:setParentType("SKULL")


models.player:setPos(-24,0,0)



--models.player:play("player.Kazotskykick2")

local cloneMap={}

local i=0
local j=0
for key, value in pairs(animations.player) do
	i=i+1
	if i > 5 then
		i=0
		j=j+1
	end
	local clone=deepCopy(models.player)
	
	local animName="player."..key
	
	cloneMap[animName]=clone
	models:addChild(clone)
	clone:setPos(24*i,0,24*j)
	clone.base:play(animName)
end

keybinds:fromVanilla("key.sneak"):onPress(function (modifiers, self)
	for key, value in pairs(cloneMap) do
		value.base:stop()
	end
end):onRelease(function (modifiers, self)
	for key, value in pairs(cloneMap) do
		value.base:play(key)
	end
end)

--models.player.base.LeftLeg:play("player.Kazotskykick")
--models.player.base.RightLeg:play("player.Kazotskykick")

--animations.player.Kazotskykick:play()

--models.testion:play("testion.animationName")


--]]