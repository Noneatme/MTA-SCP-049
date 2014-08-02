-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: MapLoader					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

MapLoader = {};
MapLoader.__index = MapLoader;

mainMapElement = createElement("mainMapRootElement")
--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function MapLoader:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// onServerSendMapContent///
-- ///// Returns: void		//////
-- ///////////////////////////////

function MapLoader:OnServerSendMapContent( mapContent )
	if type( mapContent ) == 'table' then
		if #mapContent ~= 0 then
			for i, content in ipairs( mapContent ) do
				if content[1] == 'object' then
				-- OBJ
				if(content[5] and content[8] and content[9] and content[10]) then
					local obj = createObject( content[5], content[8], content[9], content[10], content[11], content[12], content[13] )
					if(obj) then
						setElementInterior(obj, tonumber(content[2] ))
						setElementAlpha( obj, (tonumber(content[3])))
						
						if(getElementModel(obj) == 630) then
							setElementDoubleSided( obj, true) -- 4
						
						else
							setElementDoubleSided( obj, (toboolean(content[4]) or false)) -- 4
						
						end
						setObjectScale( obj, (tonumber(content[6]) or 1) )
						-- PARENT
						setElementParent( obj, mainMapElement )
						setElementDimension(obj, tonumber(content[7]))
						
						setElementCollisionsEnabled(obj, (toboolean(content[14]) or true))
						end
					end
				end
			end
			
		end
	end
end

-- ////////////////////////////////
-- DESTROY EVERYTHING 
-- ///////////////////////////////

function MapLoader:DestroyEverything()
	for index, sound in pairs(getElementsByType("sound", getResourceRootElement())) do
		destroyElement(sound)
	end
	
	for index, ele in pairs(getElementsByType("object", getResourceRootElement())) do
		destroyElement(ele);
	end
	
	for index, ele in pairs(getElementsByType("marker", getResourceRootElement())) do
		destroyElement(ele);
	end
	
	for index, ele in pairs(getElementsByType("ped", getResourceRootElement())) do
		destroyElement(ele);
	end
	
	for index, ele in pairs(getElementsByType("colshape", getResourceRootElement())) do
		destroyElement(ele);
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MapLoader:Constructor(...)
	addEvent('onServerSendMapContent', true)
	
	self.mapLoadFunc = function(...) self:OnServerSendMapContent(...) end;
	
	addEventHandler('onServerSendMapContent', getLocalPlayer(), self.mapLoadFunc)
	logger:OutputInfo("[CALLING] MapLoader: Constructor");
end

-- EVENT HANDLER --

function toboolean( string )
	if string == 'false' or string == "false" then
		return false
	elseif string == 'true' or string == "true" then
		return true
	end
end