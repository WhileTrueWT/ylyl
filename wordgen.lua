#!/usr/bin/lua

-- code stolen from citrons
math.randomseed(os.time())

local function R(bee, dist)
	dist = dist or 2
	return function()
		local i = 1
		repeat
			if math.random() * dist > 1 then
				break
			end
			i = i + 1
		until i >= #bee
		if type(bee) == 'string' then
			return bee:sub(i,i)
		else
			local the = bee[i]
			if type(the) == 'function' then
				the = the()
			end
			return the
		end
	end
end

local function _(the)
	return function()
		local a = {}
		for i,v in ipairs(the) do
			if type(v) == 'function' then
				a[i] = v()
			else
				a[i] = v
			end
		end
		return table.concat(a)
	end
end

local C = R({'k', 's', 'n', 't', 'm', 'd', 'j', 'x', 'p', 'z', 'ś', 'þ', 'ź', 'g'}, 1.15)
local V = R("aoieu", 1.3)
local N = R({"","n", "r", "s"}, 4.5)
local S = _{R({C,""}, 10),V,N}

local W = _({S,R({S,"",_{S,S},_{S,S,S}},2.5)})

local the = ... and tonumber(...) or 10
	
for i=0,the do
	print(W())
end

