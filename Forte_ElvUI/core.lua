local main_bg_color = {0 , 0 , 0 , 1}
local main_border_color = {0, 0, 0 , 1}
local main_border2_color = {0.5, 0.5, 0.5 ,0.5}

local pixel_perfect = true

local ES = FW:Module("ElvUI");
local FW = FW;
local FWL = FW.L;

local function SetSkin(frame,x1,parentalpha)
	x1 = x1 or 0
	if not frame.elvbg then
		frame.elvbg = CreateFrame("Frame", nil, frame)		
		frame.elvbg:SetPoint("TOPRIGHT", frame, "TOPRIGHT",0+x1, 0+x1)
		frame.elvbg:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0-x1, 0-x1)
		frame.elvbg:SetFrameLevel(frame:GetFrameLevel())	
		
		if FW.Settings.PixelPerfect then
			
			frame.elvbg:SetBackdrop({
				bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=],
				edgeFile = [=[Interface\ChatFrame\ChatFrameBackground]=], 
				edgeSize = 1,
				tile = false,
				tileSize = 0,
				insets = {	top = 0, 
							left = 0, 
							bottom = 0, 
							right = 0
						},
			})
			
		else 
			
			frame.elvbg:SetBackdrop({
				bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=],
				edgeFile = [=[Interface\ChatFrame\ChatFrameBackground]=], 
				edgeSize = 2,
				tile = false,
				tileSize = 0,
				insets = {	top = -1, 
							left = -1, 
							bottom = -1, 
							right = -1
						},
			})
			
			
			frame.elvbg.elvbg = CreateFrame("Frame", nil, frame.elvbg)
			frame.elvbg.elvbg:SetFrameLevel(frame.elvbg:GetFrameLevel()+1)
			frame.elvbg.elvbg:SetBackdrop({
				bgFile = "",
				edgeFile = [=[Interface\ChatFrame\ChatFrameBackground]=], 
				edgeSize = 1,
				tile = false,
				tileSize = 0,
				insets = {	top = 1, 
							left = 1, 
							bottom = 1, 
							right = 1
						},
				})
			frame.elvbg.elvbg:SetBackdropColor(0,0,0,0)
			frame.elvbg.elvbg:SetBackdropBorderColor(unpack(main_border2_color))
			frame.elvbg.elvbg:SetPoint("TOPRIGHT", frame.elvbg, "TOPRIGHT", 0, 0)
			frame.elvbg.elvbg:SetPoint("BOTTOMLEFT", frame.elvbg, "BOTTOMLEFT", 0, 0)
		end
		
		if parentalpha then
		
			local r1, g1, b1,a1 = unpack(main_bg_color)
			frame.elvbg:SetBackdropColor(r1, g1, b1, frame:GetAlpha())
			frame.elvbg:SetBackdropBorderColor(unpack(main_border_color))
		else
			frame.elvbg:SetBackdropColor(unpack(main_bg_color))
			frame.elvbg:SetBackdropBorderColor(unpack(main_border_color))
		end
	end
end

function SkinForteXorcist_Timer()
	for k,v in pairs(FW.Frames) do
		if v.instanceof == "Timer" then
			if not v.hooked then
				v.hooked = true
				hooksecurefunc(v, 'NewGroup', function(self, index)
				hooksecurefunc(self.groups[index], 'NewBar', function(self, index)
					if not self.bars[index].elv then
						self.bars[index].elv = true							
						hooksecurefunc(self.bars[index], 'Show', function(self)								
							if not self.elvbg then
								SetSkin(self, 2+(FW.Settings.PixelPerfect and -1 or 0))
								SetSkin(self.button, 2+(FW.Settings.PixelPerfect and -1 or 0))									
								if not self.button.OldSetPoint then
									self.button.OldSetPoint = self.button.SetPoint
									self.button.SetPoint = function(self, oX, parent, oY, xN, yN)
										if parent.elvbg then
											if parent.parent.parent.s.IconRight then self:OldSetPoint(oX, parent, oY, xN+5+(FW.Settings.PixelPerfect and -3 or 0), yN)
											else self:OldSetPoint(oX, parent, oY, xN-5-(FW.Settings.PixelPerfect and -3 or 0), yN) end
										end     
									end
								end									
								self:Update()
							end
						end)
					end
				end)
				end)
			end					
		end		
	end
end

function SkinForteXorcist_Cooldown()
	for k,v in pairs(FW.Frames) do
		if v.instanceof == "Cooldown" then
			SetSkin(v, 1+(FW.Settings.PixelPerfect and -2 or 0))
			v:Update()
			hooksecurefunc(v, 'NewBar', function(self, index)
					if not self.bars[index].elv then
						self.bars[index].elv = true							
						hooksecurefunc(self.bars[index], 'Show', function(self)								
							if not self.elvbg then
								SetSkin(self.icon, 2+(FW.Settings.PixelPerfect and -1 or 0))
								self.icon.spark:SetTexture("")
								self.splashiconspark:SetTexture("")							
								self:Update()
							end
						end)
					end
				end)
		end
	end
end

function SkinForteXorcist_Splash()
	for k,v in pairs(FW.Frames) do
		if v.instanceof == "Splash" then
			hooksecurefunc(v, 'NewIcon', function(self, index)
					if not self.icons[index].elv then
						self.icons[index].elv = true							
						hooksecurefunc(self.icons[index], 'Show', function(self)								
							if not self.elvbg then							
								SetSkin(self, 2+(FW.Settings.PixelPerfect and -1 or 0), true)
								self.spark:SetTexture("")							
								self:Update()
							end
						end)
					end
				end)
		end
	end
end

function Forte_RebuildSettings()
	if not FW.Settings.RebuildSettings then
		print("Forte|cff1784d1ElvUI|r loaded first time. Rebuild settings.")
		FW.Settings.RebuildSettings = true
		
		FW.Settings.Timer.Instances[1].Backdrop = {
								"Interface\\AddOns\\Forte_Core\\Textures\\Background",
								"Interface\\AddOns\\Forte_Core\\Textures\\Border",
								false,16,1,1}
								
		FW.Settings.Timer.Instances[1].BackdropSpacingHeight = 4
		FW.Settings.Timer.Instances[1].Texture = "Interface\\AddOns\\Forte_Core\\Textures\\Flat"
		FW.Settings.Timer.Instances[1].Space = 5
		FW.Settings.Timer.Instances[1].NormalBgColor = {0.00,0.00,0.00,0.00}
		
		FW.Settings.Cooldown.Instances[1].IconSize[0]=true
		FW.Settings.Cooldown.Instances[1].BgColor = {0,0,0,0}
		FW.Settings.Cooldown.Instances[1].Texture = "Interface\\AddOns\\Forte_Core\\Textures\\Flat"
		FW.Settings.Cooldown.Instances[1].Backdrop = {
								"Interface\\AddOns\\Forte_Core\\Textures\\Background",
								"Interface\\AddOns\\Forte_Core\\Textures\\Border",
								false, 5, 1, 2}
	end
end

FW:RegisterDelayedLoadEvent(Forte_RebuildSettings);
FW:RegisterDelayedLoadEvent(SkinForteXorcist_Splash);
FW:RegisterDelayedLoadEvent(SkinForteXorcist_Cooldown);
FW:RegisterDelayedLoadEvent(SkinForteXorcist_Timer);


FW:SetMainCategory(FWL.ADVANCED,FW.ICON.DEFAULT,99,"DEFAULT")
	:SetSubCategory("|cff1784d1ElvUI|r Skin",FW.ICON.DEFAULT,4)
		:AddOption("CHK","Pixel Perfect Mode","1pix border",	"PixelPerfect"):SetFunc(ReloadUI)
		:AddOption("CHK","Rebuild Settings","Allow Skin rebuild your settings",	"RebuildSettings"):SetFunc(ReloadUI)
		
FW.Default.PixelPerfect = false;
FW.Default.RebuildSettings = false;