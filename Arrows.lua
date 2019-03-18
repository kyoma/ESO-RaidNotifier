
local TrackingArrow = ZO_Object:Subclass()
function TrackingArrow:New(...)
	local object = ZO_Object.New(self)
	object:Initialize(...)
	return object
end
function TrackingArrow:Initialize(arrowTexture, parent, x, y, size, id)

	self.id = id == nil and 1 or id
	self.ctrl = WM:CreateControl(nil, parent, CT_TEXTURE)
	if (size) then
		self.ctrl:SetDimensions(size[0], size[1])
	end
	self.ctrl:SetAnchor(CENTER, "GuiRoot", CENTER, x, y)
	self:SetTexture(arrowTexture)
	self.ctrl:SetClampedToScreen(true)
end

function TrackingArrow:GetControl()
	return self.ctrl
end

function TrackingArrow:SetTexture(texture)
	self.ctrl:SetTexture(texture)
end

function TrackingArrow:GetTexture()
	return self.ctrl:GetTextureFileName()
end

function TrackingArrow:SetHidden(ok)
	self.ctrl:SetHidden(ok)
end

function TrackingArrow:SetColor(r, g, b, a)
	self.ctrl:SetColor(r, g, b, a)
end

function TrackingArrow:StartTracking(playerTag, trackTime)
	local function Update()
		local rotationAngle = self.Util:GetRotationAngle(playerTag)
		self.ctrl:SetTextureRotation(rotationAngle)
	end

	if trackTime ~= nil and trackTime > 0 then
		self:SetHidden(false)

		EVENT_MANAGER:RegisterForUpdate(self.Name .. "_TrackingArrow_" .. self.id, 50, Update)
		zo_callLater(function() self:Stop() end, trackTime)
	end
end

function TrackingArrow:Stop()
	EVENT_MANAGER:UnregisterForUpdate(self.Name .. "_TrackingArrow" .. self.id)
	self:SetHidden(true)
end


-- static methods
function TrackingArrow.GetNormalizedAngle(angle)
	return angle - 2 * math.pi * math.floor((angle + math.pi) / 2 * math.pi)
end

function TrackingArrow.GetRotationAngle(unitTag)
	local self = TrakcingArrow
	local playerX, playerY = GetMapPlayerPosition("player")
	local targetX, targetY = GetMapPlayerPosition(unitTag)
	return self.GetNormalizedAngle(-1 * (self.GetNormalizedAngle(GetPlayerCameraHeading()) - math.atan2(playerX - targetX, playerY - targetY)))
end
