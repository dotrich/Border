local Border, Bor = ...;

STDUI_BOR = LibStub("StdUi"):NewInstance();

local window = STDUI_BOR:Window(UIParent, 200, 40);
window:RegisterEvent("ADDON_LOADED");

local button;

local function InitFrame(frame)
	frame:ClearAllPoints();
	frame:SetPoint("CENTER");
	frame.closeBtn:Hide();

	STDUI_BOR:EasyLayout(frame);
end

local function InitBorderDB()
	if (BorderDB == nil) then
		BorderDB = {
			highlight = {r= 1, g= 0, b= 0, a= 1}
		};
	end
end

local function BorderWindow_OnEvent(self, event, msg)
	if (event == "ADDON_LOADED") and (msg == "Border") then
		--database initialize if nil
		InitBorderDB();
		
		--synchronize StdUi and BorderDB
		STDUI_BOR.config.backdrop.highlight = BorderDB.highlight;
		STDUI_BOR.config.highlight.color = BorderDB.highlight;
		
		--main window
		InitFrame(window);
		local rowConfig = { margin = {top = 10, bottom = 10} };
		
		---button
		button = STDUI_BOR:Button(window, 128, 20, "Print Highlight Color");
		button:SetPoint("CENTER");		
		local row = window:AddRow(rowConfig);
		row:AddElement(button);
		
		--finalize layout
		window:DoLayout();
		
		--handlers
		button:SetScript("OnClick", function()		
			local color = BorderDB.highlight;
			print(color.r, ' ', color.g, ' ', color.b, ' ', color.a);
		end);
	end
end

window:SetScript("OnEvent", BorderWindow_OnEvent);