
local Notification = ZO_Object:Subclass()

function Notification:New(...)
	local obj = ZO_Object.New(self)
	obj:Initialize(...)
	return obj
end

function Notification:Initialize(id, displayTime, parent)
	self.id = id
	self.parent = parent
	self.displayTime = displayTime
	self.freeToUse = false
	self.ctrl = WINDOW_MANAGER:CreateControl("RNotification"..id, self.parent, CT_LABEL)
	self.fadeInAnimation = GetAnimationManager():CreateTimelineFromVirtual("CenterAnnounceFadeIn", self.ctrl)
	self.ctrl:SetFont('ZoFontCenterScreenAnnounceSmall')
end

function Notification:GetId()
	return self.id
end

function Notification:IsFreeToUse()
	return self.freeToUse
end

function Notification:GetCtrl()
	return self.ctrl
end

function Notification:SetText(str)
	self.ctrl:SetText(str)
end

function Notification:SetHidden(hidden)
	self.hidden = hidden
	self.ctrl:SetHidden(hidden)
end

function Notification:Show(text, displayTime)
	self.text = text
	self.fadeInAnimation:PlayFromStart()
	self:SetHidden(false)
	self:SetText(text)
	self.freeToUse = false
	zo_callLater(function()
		self:SetHidden(true)
		self.freeToUse = true
		d("Hiding: "..self.id)
	end, displayTime and displayTime or self.displayTime)
	return self.id
end

--[[
function Notification:Countdown(text, displayTime)
	displayTime = displaytime and displayTime or self.displayTime
	self.text = text
	self.fadeInAnimation:PlayFromStart()
	self:SetHidden(false)
	self.freeToUse = false
	function everySecond()
		self:SetText(text .. ": ".. (displayTime/1000))
		local mod = displayTime % 1000
		local ms = mod > 0 and mod or 1000
		if (displayTime >= 0) then
			zo_callLater(everySecond, ms)
		else
			self:SetHidden(true)
--			self:SetText("")
			self.freeToUse = true
			d("Hiding: "..self.id)
		end		
		displayTime = displayTime - ms
	end
	everySecond()
	return self.id
end
]]--
-- countdown priority 1, blinking notification 2 and simple notification 3
function Notification:GetPriority()
	return 3
end

local NotificationsPool = ZO_Object:Subclass()

function NotificationsPool:New(...)
	local obj = ZO_Object.New(self)
	obj:Initialize(...)
	return obj
end

function NotificationsPool:Initialize(displayTime, parent)
	self.pool = {}
	self.displayTime = displayTime
	if (parent == nil) then
		self.parent = RaidNotifierUICenterAnnounce
	else
		self.parent = parent
	end
	
--	self.bg = WINDOW_MANAGER:CreateControl(nil, self.parent, CT_BACKDROP)
--	self.bg:SetAnchorFill(self.parent)
--	self.bg:SetEdgeTexture(nil, 1, 1, 0.5, 0.5)	
end

local pool = nil

function NotificationsPool.GetInstance(displayTime)
	if (not pool) then
		if (displayTime == nil) then
			displayTime = 3000
		end
		pool = NotificationsPool:New(displayTime)
	end
	return pool
end

function NotificationsPool:Add(text, displayTime, isCountdown)
	local notify = nil
	local notifyId = 0
	for i = #self.pool, 1, -1 do
		if (self.pool[i]:IsFreeToUse()) then
			d("Used already created notification "..self.pool[i]:GetId())
			notify = self.pool[i]
			notifyId = i
			break;
		end
	end

	if (notify == nil) then
		local id = #self.pool + 1
		notify = Notification:New(id, 4000, self.parent)
		notify:SetText("X") -- we need anything to get text height
		self.pool[id] = notify
		notifyId = id
		d("Created new notification "..id)
	end

	local curr = nil
	local currId = nil
	local ctrl = nil
	local height = notify:GetCtrl():GetTextHeight()
	for i = 1, #self.pool, 1 do
		if (curr and notifyId >= i) then
			local tmp = curr
			curr = self.pool[i]
			self.pool[i] = tmp
		else
			curr = self.pool[i]
		end
		ctrl = curr:GetCtrl()
		if (not ctrl:IsHidden()) then
			ctrl:SetAnchor(TOP, self.parent, TOP, 0, height)
			height = height + ctrl:GetTextHeight()
		end
	end
	self.pool[1] = notify
	notify:GetCtrl():SetAnchor(TOP, self.parent, TOP, 0, 0)
	if (isCountdown) then
		return notify:Countdown(text, displayTime)
	else
		return notify:Show(text, displayTime)
	end
end

RaidNotifier = RaidNotifier or {}
RaidNotifier.Notification = Notification
RaidNotifier.NotificationsPool = NotificationsPool
