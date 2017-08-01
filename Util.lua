local RaidNotifier = RaidNotifier
local Util = RaidNotifier.Util

-- Very basic ref counter for now
local RefCounter = ZO_Object:Subclass()
function RefCounter:New(...)
	local object = ZO_Object.New(self)
	object:Initialize(...)
	return object
end
function RefCounter:Initialize(name, onFirstRefFn, onLastRefFn)
	self.name = name
	self.numRefs = 0
	self.onLastRefFn = onLastRefFn
	self.onFirstRefFn  = onFirstRefFn
end
function RefCounter:Incr()
	self.numRefs = self.numRefs + 1
	if self.numRefs == 1 then -- was zero, now none-zero
		self.onFirstRefFn()
	end
end
function RefCounter:Decr()
	self.numRefs = self.numRefs - 1
	if self.numRefs == 0 then
		self.onLastRefFn()
	end
end
Util.RefCounter = RefCounter


do

	--local LGPS = LibStub("LibGPS2")
	--local Lib3D = LibStub("Lib3D")

	local GetMapPlayerPosition = GetMapPlayerPosition

	function Util.GetRawDistance(ax,ay, bx,by)
		return math.sqrt((ax-bx)*(ax-bx)+(ay-by)*(ay-by))
	end

	--[[ don't need these for now
	function Util.GetDistanceInMeters(ax,ay, bx,by, zoneId)
		if not zoneId or zoneId == 0 then
			zoneId = GetZoneId(GetUnitZoneIndex("player"))
		end
		if zoneId and zoneId > 0 then
			ax,ay = LGPS:LocalToGlobal(ax,ay)
			bx,by = LGPS:LocalToGlobal(bx,by)
			return Util.GetRawDistance(ax,ay, bx,by) * Lib3D:GetGlobalToWorldFactor(zoneId)
		else
			return 0 -- indicates invalid value
		end
	end
	
	function Util.GetDistanceToUnitInMeters(unit, zoneId)
		local pX,pY = GetMapPlayerPosition("player")
		local uX,uY = GetMapPlayerPosition(unit)
		return Util.GetDistanceInMeters(pX,pY, uX,uY, zoneId)
	end
	--]]

end


function Util.GetArgValue(str, value)
	if (str == "enable" or str == "on" or str =="1") then
		return true
	elseif (str == "disable" or str == "off" or str =="0") then
		return false
	elseif (str == nil or str == "") then
		return not value
	else
		return value
	end
end

-- convert value to valid integer for comparison
function Util.SafeInt(value)
	return value == true and 1 or (value or 0)
end

function Util.HSL2RGB(h,s,l)
   local m1, m2
   if l<=0.5 then 
      m2 = l*(s+1)
   else 
      m2 = l+s-l*s
   end
   m1 = l*2-m2

   local function _h2rgb(m1, m2, h)
      if h<0 then h = h+1 end
      if h>1 then h = h-1 end
      if h*6<1 then 
         return m1+(m2-m1)*h*6
      elseif h*2<1 then 
         return m2 
      elseif h*3<2 then 
         return m1+(m2-m1)*(2/3-h)*6
      else
         return m1
      end
   end

   return _h2rgb(m1, m2, h+1/3), _h2rgb(m1, m2, h), _h2rgb(m1, m2, h-1/3)
end