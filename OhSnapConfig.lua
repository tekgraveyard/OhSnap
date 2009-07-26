local LibSimpleOptions = LibStub("LibSimpleOptions-1.0")

local anchor
local function Options(self, anchor)
    local title, subText = self:MakeTitleTextAndSubText("OhSnap", "OhSnap Configuration")
   
	local checkbox = self:MakeToggle(
		'name', 'Show anchor',
		'description', 'Visibility of text anchor',
		'default', true,
		'getFunc', function() return OhSnapDB["ShowAnchor"] end,
		'setFunc', function(value) OhSnap:ToggleAnchor(value) end
	)
	checkbox:SetPoint("TOPLEFT", self, "TOPLEFT", 15, -70)

	local button = self:MakeToggle(
		'name', 'Test mode',
		'description', 'Show messages on friendly targets (ie. Target Dummies)',
		'default', false,
		'getFunc', function() return OhSnapDB["TestMode"] end,
		'setFunc', function(value) OhSnapDB["TestMode"] = value; OhSnap:Update() end
	)
	button:SetPoint("TOPLEFT", self, "TOPLEFT", 15, -100)
end

local function FontOptions(self,anchor,i)
	local title, subText = self:MakeTitleTextAndSubText("OhSnap", "Priority "..i.." Options")
	local f = CreateFrame("Frame")
	
	local lock = self:MakeToggle(
		'name', 'Enabled',
		'description', 'Enable Priority 1',
		'default', true,
		'getFunc', function() value = OhSnapDB[i][4] return OhSnapDB[i][4] end,
		'setFunc', function(value) OhSnapDB[i][4] = value; OhSnap:Update() end
	)
	lock:SetPoint("TOPLEFT", self, "TOPLEFT", 15, -70)

	local slider = self:MakeSlider(
		'name', "Size",
		'description', "Size of font",
		'minText', '8',
		'maxText', '24',
		'minValue', 8,
		'maxValue', 24,
		'step', 1,
		'default', OhSnap.Defaults[i][2],
		'getFunc', function(value) value = OhSnapDB[i][2] return OhSnapDB[i][2] end,    
		'setFunc', function(value) OhSnapDB[i][2] = value; OhSnap:Update() end,
		'currentTextFunc', function(value) return value
	end)
	slider:SetPoint("TOPLEFT", self, "TOPLEFT", 25, -120)

	local dropdown = self:MakeDropDown(
		'name', "Font",
		'description', "Select font to be used",
		'values', {
			'Fonts\\FRIZQT__.TTF', "Frizqt",
			'Fonts\\ARIALN.TTF', "Arialn",
			'Fonts\\skurri.ttf', "Skurri",
			'Fonts\\MORPHEUS.ttf', "Morpheus",
		 },
		'default', OhSnapDB[i][1],
		'getFunc', function() 
			return OhSnapDB[i][1] 
		end,
		'setFunc', function(value)
			if value == 'Fonts\\FRIZQT__.TTF' or value == 'Fonts\\ARIALN.TTF' or value == 'Fonts\\skurri.ttf' or value == 'Fonts\\MORPHEUS.ttf' then OhSnapDB[i][1] = value; OhSnap:Update() end
	end)
	dropdown:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -170)	

	local dropdown = self:MakeDropDown(
		'name', "Outline",
		'description', "Font Outline",
		'values', {
			'THICKOUTLINE', "Thick",
			'OUTLINE', "Thin",
			'', "None",
		 },
		'default', OhSnapDB[i][3],
		'getFunc', function() 
			return OhSnapDB[i][3] 
		end,
		'setFunc', function(value)
			if value == 'THICKOUTLINE' or value == 'OUTLINE' or value == '' then OhSnapDB[i][3] = value; OhSnap:Update() end
	end)
	dropdown:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -220)	
	
	local lock = self:MakeToggle(
		'name', 'Name',
		'description', 'Enable name',
		'default', true,
		'getFunc', function() value = OhSnapDB[i][5] return OhSnapDB[i][5] end,
		'setFunc', function(value) OhSnapDB[i][5] = value; OhSnap:Update() end
	)
	lock:SetPoint("TOPLEFT", self, "TOPLEFT", 15, -270)

	local lock = self:MakeToggle(
		'name', 'Icon',
		'description', 'Enable spell icon',
		'default', true,
		'getFunc', function() value = OhSnapDB[i][6] return OhSnapDB[i][6] end,
		'setFunc', function(value) OhSnapDB[i][6] = value; OhSnap:Update() end
	)
	lock:SetPoint("TOPLEFT", self, "TOPLEFT", 15, -300)

	local lock = self:MakeToggle(
		'name', 'Comment',
		'description', 'Enable spell comment',
		'default', true,
		'getFunc', function() value = OhSnapDB[i][7] return OhSnapDB[i][7] end,
		'setFunc', function(value) OhSnapDB[i][7] = value; OhSnap:Update() end
	)
	lock:SetPoint("TOPLEFT", self, "TOPLEFT", 15, -330)
	
end

LibSimpleOptions.AddOptionsPanel("OhSnap", function(self) Options(self, anchor) end)
for i=1,4 do
	LibSimpleOptions.AddSuboptionsPanel("OhSnap", "Priority "..i.." Options", function(self) FontOptions(self, anchor, i) end)
end
