local tags = game:GetService("CollectionService")
local ts = game:GetService("TweenService")

local plr: Player = game.Players.LocalPlayer

local css = {}

local function PlayTween(obj, ti, properties)
	local tween = ts:Create(obj, ti, properties)
	tween:Play()
	tween.Completed:Connect(function()
		tween:Destroy()
	end)
end

local function HasProperty(obj, prop)
	local hasprop = pcall(function()
		local objprop = obj[prop]
	end)
	return hasprop
end


local function HoverEffect(obj: TextButton, classinfo)
	if obj:IsAncestorOf(game.StarterGui) then return end
	local hoverinfo = classinfo.onhover
	local original = {}
	for prop, _ in hoverinfo do
		original[prop] = obj[prop]
	end


	local propsToTween = {}
	if classinfo.transition then
		for _,v in classinfo.transition do
			propsToTween[v] = hoverinfo[v]
		end
	end

	local instantChanges = {}
	for i,v in hoverinfo do
		if not propsToTween[i] then 
			instantChanges[i] = v 
		end
	end

	obj.MouseEnter:Connect(function()
		PlayTween(obj, TweenInfo.new(classinfo.transition_time or .5), propsToTween)
		for i,v in instantChanges do
			obj[i] = v
		end
	end)

	obj.MouseLeave:Connect(function()
		for i,v in original do
			if classinfo.transition and table.find(classinfo.transition, i) then
				local props = {}
				props[i] = v
				PlayTween(obj, TweenInfo.new(classinfo.transition_time or .5), props)
			else
				obj[i] = v
			end
		end
	end)
end

local function ActiveEffect(obj: TextButton, classInfo)
	if obj:IsAncestorOf(game.StarterGui) then return end

	local activeInfo = classInfo.onhover
	local original = {}
	for prop, _ in activeInfo do
		original[prop] = obj[prop]
	end


	local propsToTween = {}
	if classInfo.transition then
		for _,v in classInfo.transition do
			propsToTween[v] = activeInfo[v]
		end
	end

	local instantChanges = {}
	for i,v in activeInfo do
		if not propsToTween[i] then 
			instantChanges[i] = v 
		end
	end

	obj.MouseButton1Down:Connect(function()
		PlayTween(obj, TweenInfo.new(classInfo.transition_time or .5), propsToTween)
		for i,v in instantChanges do
			obj[i] = v
		end
	end)

	plr:GetMouse().Button1Up:Connect(function()
		for i,v in original do
			if classInfo.transition and table.find(classInfo.transition, i) then
				local props = {}
				props[i] = v
				PlayTween(obj, TweenInfo.new(classInfo.transition_time or .5), props)
			else
				obj[i] = v
			end
		end
	end)
end


local function manageclass(classname, classinfo)
	local classitems = tags:GetTagged(classname)


	for _,v in classitems do
		for property, value in classinfo do
			if HasProperty(v,property) and not v:FindFirstChild(property) then v[property] = value end
		end


		if classinfo.onhover then 
			HoverEffect(v, classinfo) 
		end

		if classinfo.active then
			ActiveEffect(v, classinfo)
		end
	end
end



function css.init(stylesheet: {}?)
	if not stylesheet then
		local desc = game.ReplicatedStorage:GetDescendants()
		for _,c in desc do
			if c.Name:match(".rcss") and c:IsA("ModuleScript") then
				css.init(require(c))
			end
		end
		return
	end

	for class, info in stylesheet do
		manageclass(class, info)
	end
end

return css