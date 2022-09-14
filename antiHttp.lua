--[[>
DARKCEIUS' ANTI HTTP POSTS
prevent scripts from running http posts.
<--]]

if not syn then
	return
end

function cprint(color, text)
	rconsoleprint("@@".. string.upper(color) .. "@@")
	rconsoleprint(text)
end

cprint("green", "Successfully started Dark's Anti HTTPs")
cprint("green", "You can index the required module to temporarly stop the script or disable output prints.")
cprint("green", "<module>.printLinks: boolean ; <module>.stopped: boolean")

local httpService = game:GetService("HttpService")
local scriptSettings = {
	printLinks = true,
	stopped = false,
}

do
	local original = httpService.GetAsync
	hookfunction(httpService.GetAsync, function(self, ...)
		if scriptSettings.stopped then
			return original(self, ...)
		end
		if scriptSettings.printLinks then
			local link = tostring(...)
			cprint("red", "A script tried calling HttpService:GetAsync with the following link: \""..link.."\"")
		end
		return nil
	end)
end

do
	local original = httpService.PostAsync
	hookfunction(httpService.PostAsync, function(self, ...)
		if scriptSettings.stopped then
			return original(self, ...)
		end
		if scriptSettings.printLinks then
			local link = tostring(...)
			cprint("red", "A script tried calling HttpService:PostAsync with the following link: \""..link.."\"")
		end
		return nil
	end)
end

do
	local original = game.HttpGet
	hookfunction(game.HttpGet, function(self, ...)
		local link = tostring(...)
		
		if scriptSettings.stopped or link == "https://raw.githubusercontent.com/darkceius/random-stuff/main/antiHttp.lua" then
			return original(self, ...)
		end
		if scriptSettings.printLinks then
		
			cprint("red", "A script tried calling game:HttpGet with the following link: \""..link.."\"")
		end
		return nil
	end)
end

do
	local original = game.HttpPost
	hookfunction(game.HttpPost, function(self, ...)
		if scriptSettings.stopped then
			return original(self, ...)
		end
		if scriptSettings.printLinks then
			local link = tostring(...)
			cprint("red", "A script tried calling game:HttpPost with the following link: \""..link.."\"")
		end
		return nil
	end)
end

do
	local original = syn.request
	hookfunction(syn.request, function(self, ...)
		if scriptSettings.stopped then
			return original(self, ...)
		end
		if scriptSettings.printLinks then
			local dataTable = ...
			if typeof(dataTable) == "table" then
				local url = tostring(dataTable.Url)
				local method = tostring(dataTable.Method)
				cprint("red", "A script tried calling syn.request. METHOD: ".. method .. " URL: \"".. url .. "\"")
			end
		end
		return nil
	end)
end


return scriptSettings
