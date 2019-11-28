local Border, Bor = ...;

STDUI_BOR = LibStub("StdUi"):NewInstance();

local window = STDUI_BOR:Window(UIParent, 200, 100);
window:RegisterEvent("ADDON_LOADED");

local colorInput;
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
			border = {r= .24, g= .24, b= .24, a= 1}
		};
	end
end

local function SetBackdropBorderColors(color)
	window:SetBackdropBorderColor(color.r, color.g, color.b, color.a);
	colorInput.target:SetBackdropBorderColor(color.r, color.g, color.b, color.a);
	button:SetBackdropBorderColor(color.r, color.g, color.b, color.a);
end

local function BorderWindow_OnEvent(self, event, msg)
	if (event == "ADDON_LOADED") and (msg == "Border") then
		--database initialize if nil
		InitBorderDB();
		
		--synchronize StdUi and BorderDB
		STDUI_BOR.config.backdrop.border = BorderDB.border;
		
		--main window
		InitFrame(window);
		local row;
		local rowConfig = { margin = {bottom = 2} };
		
		--main window widgets
		colorInput = STDUI_BOR:ColorInput(window, "Border Color", 128, 20, BorderDB.border);
		colorInput:SetPoint("CENTER");
		
		row = window:AddRow(rowConfig);
		row:AddElement(colorInput);
		
		button = STDUI_BOR:Button(window, 128, 20, "Print Border Color");
		button:SetPoint("CENTER");
		
		row = window:AddRow(rowConfig);
		row:AddElement(button);
		
		window:DoLayout();
		SetBackdropBorderColors(BorderDB.border);
		
		--widget event handlers
		colorInput.OnValueChanged = function(_, color)
			BorderDB.border.r = color.r;
			BorderDB.border.g = color.g;
			BorderDB.border.b = color.b;
			BorderDB.border.a = color.a;
			
			STDUI_BOR.config.backdrop.border = BorderDB.border;
			SetBackdropBorderColors(color);
		end
		
		button:SetScript("OnClick", function()
			local color = BorderDB.border;
			
			print(color.r, ' ', color.g, ' ', color.b, ' ', color.a);
		end);
	end
end

window:SetScript("OnEvent", BorderWindow_OnEvent);