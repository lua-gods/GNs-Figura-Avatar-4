---@diagnostic disable: assign-type-mismatch
--[[______  __ NOTE: Figura trims off all comments automatically by default. so all of this comment will be stripped out before being processed by Figura.
  / ____/ | / / by: GNamimates | Discord: "@gn8." | Youtube: @GNamimates
 / / __/  |/ / name: Tween Library
/ /_/ / /|  /  desc: Complete set of Easing Equations 
\____/_/ |_/ https://github.com/lua-gods/GNs-Avatar-3/blob/main/libraries/tween.lua
Disclaimer for Robert Penner's Easing Equations license:

TERMS OF USE - EASING EQUATIONS

Open source under the BSD License.

Copyright © 2001 Robert Penner
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

   * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
   * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
   * Neither the name of the author nor the names of contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

-- For all easing functions:
-- t = elapsed time
-- b = begin
-- c = change == ending - beginning
-- d = duration (total time)
local x = math.pow
local g = math.sin
local cs = math.cos
local pi = math.pi
local sq = math.sqrt
local ab = math.abs
local m  = math.asin

local function linear(t, b, c, d)
  return c * t / d + b
end

local function inQuad(t, b, c, d)
  t = t / d
  return c * x(t, 2) + b
end

local function outQuad(t, b, c, d)
  t = t / d
  return -c * t * (t - 2) + b
end

local function inOutQuad(t, b, c, d)
  t = t / d * 2
  if t < 1 then
   return c / 2 * x(t, 2) + b
  else
   return -c / 2 * ((t - 1) * (t - 3) - 1) + b
  end
end

local function outInQuad(t, b, c, d)
  if t < d / 2 then
   return outQuad (t * 2, b, c / 2, d)
  else
   return inQuad((t * 2) - d, b + c / 2, c / 2, d)
  end
end

local function inCubic (t, b, c, d)
  t = t / d
  return c * x(t, 3) + b
end

local function outCubic(t, b, c, d)
  t = t / d - 1
  return c * (x(t, 3) + 1) + b
end

local function inOutCubic(t, b, c, d)
  t = t / d * 2
  if t < 1 then
   return c / 2 * t * t * t + b
  else
   t = t - 2
   return c / 2 * (t * t * t + 2) + b
  end
end

local function outInCubic(t, b, c, d)
  if t < d / 2 then
   return outCubic(t * 2, b, c / 2, d)
  else
   return inCubic((t * 2) - d, b + c / 2, c / 2, d)
  end
end

local function inQuart(t, b, c, d)
  t = t / d
  return c * x(t, 4) + b
end

local function outQuart(t, b, c, d)
  t = t / d - 1
  return -c * (x(t, 4) - 1) + b
end

local function inOutQuart(t, b, c, d)
  t = t / d * 2
  if t < 1 then
   return c / 2 * x(t, 4) + b
  else
   t = t - 2
   return -c / 2 * (x(t, 4) - 2) + b
  end
end

local function outInQuart(t, b, c, d)
  if t < d / 2 then
   return outQuart(t * 2, b, c / 2, d)
  else
   return inQuart((t * 2) - d, b + c / 2, c / 2, d)
  end
end

local function inQuint(t, b, c, d)
  t = t / d
  return c * x(t, 5) + b
end

local function outQuint(t, b, c, d)
  t = t / d - 1
  return c * (x(t, 5) + 1) + b
end

local function inOutQuint(t, b, c, d)
  t = t / d * 2
  if t < 1 then
   return c / 2 * x(t, 5) + b
  else
   t = t - 2
   return c / 2 * (x(t, 5) + 2) + b
  end
end

local function outInQuint(t, b, c, d)
  if t < d / 2 then
   return outQuint(t * 2, b, c / 2, d)
  else
   return inQuint((t * 2) - d, b + c / 2, c / 2, d)
  end
end

local function inSine(t, b, c, d)
  return -c * cs(t / d * (pi / 2)) + c + b
end

local function outSine(t, b, c, d)
  return c * g(t / d * (pi / 2)) + b
end

local function inOutSine(t, b, c, d)
  return -c / 2 * (cs(pi * t / d) - 1) + b
end

local function outInSine(t, b, c, d)
  if t < d / 2 then
   return outSine(t * 2, b, c / 2, d)
  else
   return inSine((t * 2) -d, b + c / 2, c / 2, d)
  end
end

local function inExpo(t, b, c, d)
  if t == 0 then
   return b
  else
   return c * x(2, 10 * (t / d - 1)) + b - c * 0.001
  end
end

local function outExpo(t, b, c, d)
  if t == d then
   return b + c
  else
   return c * 1.001 * (-x(2, -10 * t / d) + 1) + b
  end
end

local function inOutExpo(t, b, c, d)
  if t == 0 then return b end
  if t == d then return b + c end
  t = t / d * 2
  if t < 1 then
   return c / 2 * x(2, 10 * (t - 1)) + b - c * 0.0005
  else
   t = t - 1
   return c / 2 * 1.0005 * (-x(2, -10 * t) + 2) + b
  end
end

local function outInExpo(t, b, c, d)
  if t < d / 2 then
   return outExpo(t * 2, b, c / 2, d)
  else
   return inExpo((t * 2) - d, b + c / 2, c / 2, d)
  end
end

local function inCirc(t, b, c, d)
  t = t / d
  return(-c * (sq(1 - x(t, 2)) - 1) + b)
end

local function outCirc(t, b, c, d)
  t = t / d - 1
  return(c * sq(1 - x(t, 2)) + b)
end

local function inOutCirc(t, b, c, d)
  t = t / d * 2
  if t < 1 then
   return -c / 2 * (sq(1 - t * t) - 1) + b
  else
   t = t - 2
   return c / 2 * (sq(1 - t * t) + 1) + b
  end
end

local function outInCirc(t, b, c, d)
  if t < d / 2 then
   return outCirc(t * 2, b, c / 2, d)
  else
   return inCirc((t * 2) - d, b + c / 2, c / 2, d)
  end
end

local function inElastic(t, b, c, d, a, p)
  if t == 0 then return b end

  t = t / d

  if t == 1  then return b + c end

  if not p then p = d * 0.3 end

  local s

  if not a or a < ab(c) then
   a = c
   s = p / 4
  else
   s = p / (2 * pi) * a(c/a)
  end

  t = t - 1

  return -(a * p(2, 10 * t) * s((t * d - s) * (2 * pi) / p)) + b
end

-- a: amplitud
-- p: period
local function outElastic(t, b, c, d, a, p)
  if t == 0 then return b end

  t = t / d

  if t == 1 then return b + c end

  if not p then p = d * 0.3 end

  local s

  if not a or a < ab(c) then
   a = c
   s = p / 4
  else
   s = p / (2 * pi) * a(c/a)
  end

  return a * p(2, -10 * t) * s((t * d - s) * (2 * pi) / p) + c + b
end

-- p = period
-- a = amplitud
local function inOutElastic(t, b, c, d, a, p)
  if t == 0 then return b end

  t = t / d * 2

  if t == 2 then return b + c end

  if not p then p = d * (0.3 * 1.5) end
  if not a then a = 0 end

  local s

  if not a or a < ab(c) then
   a = c
   s = p / 4
  else
   s = p / (2 * pi) * a(c / a)
  end

  if t < 1 then
   t = t - 1
   return -0.5 * (a * p(2, 10 * t) * s((t * d - s) * (2 * pi) / p)) + b
  else
   t = t - 1
   return a * p(2, -10 * t) * s((t * d - s) * (2 * pi) / p ) * 0.5 + c + b
  end
end

-- a: amplitud
-- p: period
local function outInElastic(t, b, c, d, a, p)
  if t < d / 2 then
   return outElastic(t * 2, b, c / 2, d, a, p)
  else
   return inElastic((t * 2) - d, b + c / 2, c / 2, d, a, p)
  end
end

local function inBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  t = t / d
  return c * t * t * ((s + 1) * t - s) + b
end

local function outBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  t = t / d - 1
  return c * (t * t * ((s + 1) * t + s) + 1) + b
end

local function inOutBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  s = s * 1.525
  t = t / d * 2
  if t < 1 then
   return c / 2 * (t * t * ((s + 1) * t - s)) + b
  else
   t = t - 2
   return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
  end
end

local function outInBack(t, b, c, d, s)
  if t < d / 2 then
   return outBack(t * 2, b, c / 2, d, s)
  else
   return inBack((t * 2) - d, b + c / 2, c / 2, d, s)
  end
end

local function outBounce(t, b, c, d)
  t = t / d
  if t < 1 / 2.75 then
   return c * (7.5625 * t * t) + b
  elseif t < 2 / 2.75 then
   t = t - (1.5 / 2.75)
   return c * (7.5625 * t * t + 0.75) + b
  elseif t < 2.5 / 2.75 then
   t = t - (2.25 / 2.75)
   return c * (7.5625 * t * t + 0.9375) + b
  else
   t = t - (2.625 / 2.75)
   return c * (7.5625 * t * t + 0.984375) + b
  end
end

local function inBounce(t, b, c, d)
  return c - outBounce(d - t, 0, c, d) + b
end

local function inOutBounce(t, b, c, d)
  if t < d / 2 then
   return inBounce(t * 2, 0, c, d) * 0.5 + b
  else
   return outBounce(t * 2 - d, 0, c, d) * 0.5 + c * .5 + b
  end
end

local function outInBounce(t, b, c, d)
  if t < d / 2 then
   return outBounce(t * 2, b, c / 2, d)
  else
   return inBounce((t * 2) - d, b + c / 2, c / 2, d)
  end
end


local easing = {
  linear = linear,
  inQuad = inQuad,    outQuad = outQuad,     inOutQuad = inOutQuad,    outInQuad = outInQuad,
  inCubic = inCubic,   outCubic = outCubic,    inOutCubic = inOutCubic,   outInCubic = outInCubic,
  inQuart = inQuart,   outQuart = outQuart,    inOutQuart = inOutQuart,   outInQuart = outInQuart,
  inQuint = inQuint,   outQuint = outQuint,    inOutQuint = inOutQuint,   outInQuint = outInQuint,
  inSine = inSine,    outSine = outSine,     inOutSine = inOutSine,    outInSine = outInSine,
  inExpo = inExpo,    outExpo = outExpo,     inOutExpo = inOutExpo,    outInExpo = outInExpo,
  inCirc = inCirc,    outCirc = outCirc,     inOutCirc = inOutCirc,    outInCirc = outInCirc,
  inElastic = inElastic,outElastic = outElastic, inOutElastic = inOutElastic,outInElastic = outInElastic,
  inBack = inBack,    outBack = outBack,     inOutBack = inOutBack,    outInBack = outInBack,
  inBounce = inBounce,  outBounce = outBounce,  inOutBounce = inOutBounce,  outInBounce = outInBounce
}

---@type GNtween[]
local queries = {}

---@alias EaseTypes string
---| "linear"
---| "inQuad"
---| "outQuad"
---| "inOutQuad"
---| "outInQuad"
---| "inCubic"
---| "outCubic"
---| "inOutCubic"
---| "outInCubic"
---| "inQuart"
---| "outQuart"
---| "inOutQuart"
---| "outInQuart"
---| "inQuint"
---| "outQuint"
---| "inOutQuint"
---| "outInQuint"
---| "inSine"
---| "outSine"
---| "inOutSine"
---| "outInSine"
---| "inExpo"
---| "outExpo"
---| "inOutExpo"
---| "outInExpo"
---| "inCirc"
---| "outCirc"
---| "inOutCirc"
---| "outInCirc"
---| "inElastic"
---| "outElastic"
---| "inOutElastic"
---| "outInElastic"
---| "inBack"
---| "outBack"
---| "inOutBack"
---| "outInBack"
---| "inBounce"
---| "outBounce"
---| "inOutBounce"
---| "outInBounce"

local tween = {}
tween.ease = easing
local queue_free = {}

local function free(id)
	queue_free[#queue_free+1] = id
end

models:newPart("TweenHandler").midRender = function ()
	local system_time = client:getSystemTime()
	for id, ease in pairs(queries) do
		local time = (system_time - ease.start) / 1000
		if time < ease.duration then
			ease.tick(easing[ease.type](time, ease.from, ease.to-ease.from, ease.duration),time/ease.duration)
		else
			ease.tick(ease.to,1)
			free(id)
		end
	end
	if #queue_free > 0 then
		for _, id in pairs(queue_free) do
			local ease = queries[id]
			if ease then
				queries[id] = nil
				if ease.on_finish then ease.on_finish() end
			end
		end
		queue_free = {}
	end
end

---@class GNtween
---@field from number
---@field to number
---@field duration number
---@field start number
---@field type EaseTypes
---@field tick fun(value : number,transition : number)
---@field on_finish function?
---@field id string|number

---@param from number|Vector.any
---@param to number|Vector.any
---@param duration number
---@param ease EaseTypes
---@param tick fun(value : number,transition : number)
---@param finish function?
---@param id any?
---@return GNtween
function tween.tweenFunction(from, to, duration, ease, tick, finish, id)
	---@type GNtween
	local compose = {
		start = client:getSystemTime(),
		from = from or 0,
		to = to or 1,
		duration = duration,
		type = ease,
		tick = tick,
		on_finish = finish,
		id = nil,
	}
	
	
	if id then
		compose.id = id
		queries[id] = compose
	else
		for i = 1, #queries+1, 1 do
			if not queries[i] then
				compose.id = i
				queries[i] = compose
				break
			end
		end
	end
	return compose
end




return tween