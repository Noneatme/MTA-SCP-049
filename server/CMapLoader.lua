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
-- ///// LoadResourceMap	//////
-- ///// Returns: void	//////
-- ///////////////////////////////

function MapLoader:LoadResourceMap( player, dim )
	local resourceName = getResourceName( getThisResource() )
		if resourceName then
		local metaRoot = xmlLoadFile(':'..resourceName..'/meta.xml')
			if metaRoot then
				for i, v in ipairs( xmlNodeGetChildren( metaRoot ) ) do 
					if xmlNodeGetName( v ) == 'custommap' then
					local mapPath = xmlNodeGetAttribute(v,'src')
					local mapRoot = xmlLoadFile(':'..resourceName..'/'..mapPath)
						if mapRoot then
						local mapContent = {}
							for i, v in ipairs( xmlNodeGetChildren( mapRoot ) ) do 
							local typ = xmlNodeGetName( v )
								if typ == 'object' then
								table.insert( mapContent, { typ, -- 1
															xmlNodeGetAttribute(v,'interior'), -- 2
															xmlNodeGetAttribute(v,'alpha'), -- 3
															xmlNodeGetAttribute(v,'doublesided'), -- 4
															xmlNodeGetAttribute(v,'model'), -- 5
															xmlNodeGetAttribute(v,'scale'), -- 6
															dim, -- 7
															xmlNodeGetAttribute(v,'posX'), -- 8
															xmlNodeGetAttribute(v,'posY'), -- 9
															xmlNodeGetAttribute(v,'posZ'), -- 10
															xmlNodeGetAttribute(v,'rotX'),-- 11
															xmlNodeGetAttribute(v,'rotY'), -- 12
															xmlNodeGetAttribute(v,'rotZ'),	-- 13
															xmlNodeGetAttribute(v,'collisions'),-- 14
															 } ) -- 13
															
								end
							end
					triggerClientEvent(player, 'onServerSendMapContent', player, mapContent )
					xmlUnloadFile( mapRoot )
					end
				end
			end
		xmlUnloadFile( metaRoot )
		end
	end
end



-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MapLoader:Constructor(...)
	
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
