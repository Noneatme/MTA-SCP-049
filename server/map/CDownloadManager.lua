-- #######################################
-- ## Project: MTA SCP-049				##
-- ## Name: DownloadManager.lua			##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions
local cSetting = {};	-- Local Settings

DownloadManager = {};
DownloadManager.__index = DownloadManager;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function DownloadManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// OnRequestFiles		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function DownloadManager:OnRequestFiles(player, ...)
	triggerClientEvent(player, "onDownloadManagerRequestFileSucess", player, self.downloadTable, self.sizeTable, self.typeTable, ...);

end

-- ///////////////////////////////
-- ///// LoadFiles			//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function DownloadManager:LoadFiles()
	local resourceName = getResourceName(getThisResource());
	outputDebugString("INFO: Lade meta.xml von Resource: "..resourceName.." fuer manuellen Download");
	local metaRoot = xmlLoadFile(":"..resourceName.."/meta.xml")
	if(metaRoot) then
		for i, v in ipairs(xmlNodeGetChildren(metaRoot)) do
			if(xmlNodeGetName(v) == "customfile") then
				local path 		= xmlNodeGetAttribute(v,"src");
				local typ 		= xmlNodeGetAttribute(v,"type");
				
				local file 		= fileOpen(path);
				if(file) then
					self.downloadTable[i] = path;
					self.sizeTable[path] = fileGetSize(file);
					self.dataTable[path] = fileRead(file, fileGetSize(file));
					self.typeTable[path] = (typ or "-");
					
					fileClose(file);
				else
					outputDebugString("WARNING: Bad File: "..path)
					outputDebugString("[ERROR] Could not find custom File: "..path.."!");
					stopResource(getThisResource());
				end
			end
		end
	end
end



-- ///////////////////////////////
-- ///// RequestDownload	//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function DownloadManager:RequestDownload(player, tblDownload, sRequestedCategory)
	local bytes = 0;


	for index, path in pairs(tblDownload) do
		bytes = bytes+string.len((self.dataTable[path] or "false"))
	end
	triggerClientEvent(player, "onDownloadManagerGetTotalBytes", player, bytes);

	local last = table.length(tblDownload)
	local current = 1;
	
	for index, path in pairs(tblDownload) do
		triggerLatentClientEvent(player, "onDownloadManagerStartDownload", self.bytesPerSecond, false, player, path, (self.dataTable[path] or "false"), current, last, sRequestedCategory)
		
		current = current+1;
	end


end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function DownloadManager:Constructor(...)
	-- Klassenvariablen --
	self.downloadTable			= {}
	self.sizeTable				= {}
	self.dataTable				= {}
	self.typeTable				= {}
	
	self.bytesPerSecond			= 2000000; -- Uebertragungsrate


	-- Methoden --
	addEvent("onDownloadManagerRequestFiles", true)
	addEvent("onDownloadManagerRequestDownload", true)
	self.onRequestFilesFunc 	= function(...) self:OnRequestFiles(source, ...) end;
	self.requestDownloadFunc 	= function(...) self:RequestDownload(source, ...) end;

	-- Events --
	self:LoadFiles();

	-- Handlers --
	addEventHandler("onDownloadManagerRequestDownload", getRootElement(), self.requestDownloadFunc)
	addEventHandler("onDownloadManagerRequestFiles", getRootElement(), self.onRequestFilesFunc)
	--logger:OutputInfo("[CALLING] DownloadManager: Constructor");

	function table.length(T)
		local count = 0
		for _ in pairs(T) do count = count + 1 end
		return count
	end
end

-- EVENT HANDLER --
