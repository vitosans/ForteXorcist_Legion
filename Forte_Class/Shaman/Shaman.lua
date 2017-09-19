--ForteXorcist v1.980.8 by Xus 28-09-2012 for 5.0

if FW.CLASS == "SHAMAN" then
	local FW = FW;
	local FWL = FW.L;
	local SH = FW:ClassModule("Shaman");
		
	local ST = FW:Module("Timer");
	local CA = FW:Module("Casting");
	local CD = FW:Module("Cooldown");
	
	-- Register ID renames first!

	
	if ST then
		local F = ST.F;
		ST:SetDefaultHasted(1)

		-- Shared Spells
		:AddBuff(108271) -- Astral Shift
		:AddBuff(58875) -- Spirit Walk
		
		:AddSpell(2484, 20, "Crowd", F.AOE):SetTickSpeed(2) -- Earthbind Totem
		
		:AddSpell(192077, 15, "Buff", F.BUFF) -- Wind Rush Totem
    :AddBuff(192082) -- Wind Rush Totem Effect
    
		:AddSpell(192058, 2,"Crowd", F.AOE) -- Lightning Surge Totem
    :AddDebuff(11805, 5, "Crowd", F.AOE) -- Lightning Surge Totem Effect
    
    :AddSpell(51485, 20, "Crowd", F.AOE):SetTickSpeed(2) -- Earthgrab Totem
    
    :AddSpell(196932, 10, "Crowd", F.AOE) -- Voodoo Totem
    
    :AddSpell(57944, 3,"Crowd",  F.UNIQUE) --Wind Shear Effect
    :AddSpell(51514,  60, "Crowd", F.UNIQUE):SetDurationPVP(10) -- Hex
-----------------------------------------------  
			
		--Enhancement Spells
		:AddBuff(193796) -- Flame Tongue
		:AddBuff(196834) -- Frost Tongue
    :AddBuff(187878) -- Crash Lightning
    :AddSpell(51533,  15,"Pet",  F.BUFF) -- Feral Spirit
		
		:AddBuff(201898) -- Windsong
    :AddBuff(201897) -- Boulderfist
		:AddBuff(215864, 10, "Heal"):SetTickSpeed(2) -- Rainfall
		:AddBuff(192106) -- Lightning Shield 
		:AddSpell(192246, 6, "Default", F.AOE) -- Crashing Storm
		:AddBuff(197211) -- Fury of Air
		:AddBuff(114051) -- Ascendance/Enh
		:AddBuff(197992) -- Landslide
		:AddDebuff(188089) -- Earthen Spike

-----------------------------------------------  		
		
		-- Elemental Spells
		:AddSpell(188389, 15, "Default",	F.TICKS):SetTickSpeed(2) -- Flame Shock
		:AddSpell(196840,  5,"Crowd") -- Frost Shock
		--:AddSpell(198103, 60, "Default", F.AOE) -- Earth Elemental
		--:AddSpell(198067, 60, "Default", F.AOE) -- Fire Elemental
		:AddSpell(182387, 6, "Default", F.TICKS) -- Earthquake
		--:AddSpell(61882,  10,"Default", F.AOE_DMG):SetTickSpeed(1) -- Earthquake
	    
    :AddBuff(170374) -- Earthen Rage
    :AddBuff(210643) -- Totem Mastery
    :AddBuff(108281) -- Ancestral Guidance
    :AddBuff(16166) -- Elemental Mastery
    :AddBuff(117014) -- Elemental Blast
    :AddSpell(192222, 15, "Default", F.AOE):SetTickSpeed(1) -- Liquid Magma Totem
    :AddSpell(192249, 30, "Default", F.AOE) -- Storm Elemental
    :AddBuff(114050) -- Ascendance/Ele
    :AddDebuff(210689) -- Lightning Rod
    :AddDebuff(210714) -- Icefury
    
-----------------------------------------------   
		
		-- Restoration Spells
		:AddSpell(73920,  10,"Heal",  F.AOE_HOT):SetTickSpeed(2) -- Healing Rain
		:AddSpell(5394, 15, "Heal", F.AOE_HOT):SetTickSpeed(2) -- Healing Stream Totem
		:AddSpell(108280, 10, "Heal", F.AOE_HOT):SetTickSpeed(2) -- Healing Tide Totem
		:AddSpell(61295,  18,"Heal",  F.HOT) -- Riptide
		:AddSpell(98008,  6,"Heal",  F.AOE_HOT):SetTickSpeed(1)
		:AddBuff(79206) -- Spiritwalker's Grace
		
		:AddBuff(73685) -- Unleash Life
		:AddSpell(207399, 30, "Heal",  F.AOE_HOT) -- Ancestral Protection Totem
		:AddSpell(198838, 15, "Heal", F.AOE_HOT) -- Earthen Shield Totem
		:AddSpell(157153, 15, "Heal", F.AOE_HOT) -- Cloudburst Totem
		:AddBuff(114052) -- Ascendance/Resto
				
-----------------------------------------------

		:AddCasterBuffs()
		:AddMeleeBuffs()
		
	 do
      -- Code to track totems
      local select = select;
      local strfind = strfind;
      local index_to_group = {"TotemFire","TotemEarth","TotemWater","TotemAir"};
      local function SH_TotemUpdate(event,index)
        if not index or index < 1 or index > 4 then return; end 
        -- Fire = 1 Earth = 2 Water = 3 Air = 4
        local _, name, startTime, duration, icon = GetTotemInfo(index);
        local group = index_to_group[index];
        local i = ST.ST:find(group,21);
        if i then
          if name ~= "" then
            ST.ST:remove(i);
          else
            ST:Fade(i,(ST.ST[i][1]-GetTime()<0.75) and 2 or 3);
          end
        end
        if name ~= "" then
          ST:AddManualSpellOfType(name,ST.DEFAULT);
          ST.ST:insert(startTime+duration,0,duration,name,0,ST.DEFAULT,icon,name,0,0,"none",0,ST.PRIOR_NONE,0,1,0,0,00000,0,startTime+duration,group,1.0,0,0,0,1,"",0);
        end
      end
      FW:RegisterToEvent("PLAYER_TOTEM_UPDATE", SH_TotemUpdate);
      
      FW:RegisterDelayedLoadEvent(function(self)
        for i=1,4,1 do
          SH_TotemUpdate(self,i);
        end
      end);
    end
  			
		FW:SetMainCategory(FWL.SPELL_TIMER):SetSubCategory(FWL.MY_SPELLS)
			:AddOption("CO2",FWL.TOTEM_FIRE,	"",	"TotemFire",99):SetFunc(ST.FilterChange)
			:AddOption("CO2",FWL.TOTEM_EARTH,	"",	"TotemEarth",99):SetFunc(ST.FilterChange)
			:AddOption("CO2",FWL.TOTEM_WATER,	"",	"TotemWater",99):SetFunc(ST.FilterChange)
			:AddOption("CO2",FWL.TOTEM_AIR,		"",	"TotemAir",99):SetFunc(ST.FilterChange)
		
		FW.InstanceDefault.Timer.TotemFire = 	{[0]=true,1.00,0.37,0.00};
		FW.InstanceDefault.Timer.TotemEarth = 	{[0]=true,1.00,0.56,0.00};
		FW.InstanceDefault.Timer.TotemWater = 	{[0]=true,0.00,1.00,0.67};
		FW.InstanceDefault.Timer.TotemAir = 	{[0]=true,0.00,1.00,1.00};
	end

	if CD then
		CD:AddCasterPowerupCooldowns();
		CD:AddMeleePowerupCooldowns();
	end
end