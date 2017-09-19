--ForteXorcist v1.980.8 by Xus 28-09-2012 for 5.0
-- Module started by Lurosara and some additions by 'Joseph Toth'

-- TODO:
-- Forte_Timer:
--   Feral: Feral Charge Effect (Possibly too painful to implement in a reasonable manner.)

if FW.CLASS == "DRUID" then
	local FW = FW;
	local FWL = FW.L;
	local DR = FW:ClassModule("Druid");
		
	local ST = FW:Module("Timer");
	local CA = FW:Module("Casting");
	local CD = FW:Module("Cooldown");
	--

	
	if ST then
		local F = ST.F;
		ST:SetDefaultHasted(1)
		
		-- Shared Spells
	  :AddSpell(339,  30,"Crowd", F.UNIQUE):SetDurationPVP(12) -- Entangling Roots
	  :AddSpell( 8921,  22,"Default", F.TICKS):SetTickSpeed(2) -- Moonfire
		:AddBuff(22812) -- Barkskin
		:AddBuff(61684) -- Dash
		:AddSpell(29166,  10,"Buff",  F.BUFF) -- Innervate
		:AddBuff(5215):SetStacks(0) -- Prowl
		:AddSpell(106839, 4,"Crowd",  F.UNIQUE) -- Skull Bash
		:AddSpell(106832, 15, "Default", F.UNIQUE + F.TICKS):SetTickSpeed(3):SetHasted(0) -- Thrash
		
		-- Shared Talents
		:AddBuff(102280) -- Displacer Beast	
    :AddSpell(102359, 30, "Crowd", F.UNIQUE) -- Mass Entanglement
    :AddSpell(5211, 5, "Crowd", F.UNIQUE) -- Mighty Bash
    :AddDebuff(61391) -- Typhoon Daze
    
-----------------------------------------------  
  				
		-- Balance Spells
    :AddBuff(164545) -- Solar Empowerment
    :AddBuff(164547) -- Lunar Empowerment
    :AddBuff(197637) -- Stellar Empowerment
		:AddSpell(93402,  18,"Default",	F.TICKS):SetTickSpeed(2) -- Sunfire
		:AddBuff(191034, 8, "Default", F.TICKS):SetTickSpeed(1):SetHasted(0) -- Starfall
		:AddSpell(78675,  8,"Crowd",  F.AOE) -- Solar Beam
		
		-- Balance Talents
		:AddSpell(205636,  10,"Pet",    F.SUMMON) -- Force of Nature
		:AddBuff(202425) -- Warrior of Elune
		:AddBuff(102560) -- Incarnation: Chosen of Elune
		:AddBuff(202737) -- Blessing of Elune
		:AddBuff(202739) -- Blessing of An'she
		:AddBuff(202770, "Default")

-----------------------------------------------

    -- Resto Spells
		:AddSpell(188550,   15,"Heal",	F.HOT):SetTickSpeed(1) -- Lifebloom
		:AddSpell( 8936,   12,"Heal",	F.HOT):SetTickSpeed(2) -- Regrowth
		:AddSpell(  774,  15,"Heal",	F.HOT) -- Rejuvenation
		:AddSpell(48503,  15,"Heal",	F.BUFF) -- Living Seed
		:AddSpell(48438,   7,"Heal",	F.HOT):SetTickSpeed(1) -- Wild Growth
		:AddSpell(145205, 30, "Heal", F.AOE):SetTickSpeed(2) -- Efflorescence
		:AddBuff(102342) -- Ironbark
		:AddBuff(16870) -- Clearcasting
		
		-- Resto Talents
		:AddBuff(207383) -- Abundance
		:AddSpell(102351, 30, "Buff",  F.BUFF):SetStacks(0):SetTickSpeed(2):SetHasted(0) -- Cenarion Ward
    :AddBuff(158478):SetStacks(0) -- Soul of the Forest
    :AddBuff(117679) -- Incarnation: Tree of Life
    :AddSpell(200390, 6, "Heal", F.HOT + F.REFRESH):SetTickSpeed(3) -- Cultivation
    :AddSpell(155777,  15,"Heal",  F.HOT) -- Rejuvenation-Germination
    :AddSpell(207386, 6, "Heal", F.HOT + F.REFRESH):SetTickSpeed(2) -- Spring Blossoms
   
-----------------------------------------------    
    
		-- Feral Spells	
		:SetDefaultHasted(0)
		:AddSpell(210722, 9, "Default", F.TICKS) -- Ashamane's Frenzy
		--:AddSpell( 9005,   3,"Default"):AddExtraSpell(9007) -- Pounce
		--:AddSpell( 9007,  18,"Default", F.TICKS) -- Pounce Bleed
		:AddSpell(163505, 4, "Crowd"):AddExtraSpell(155722) -- Rake Stun
		:AddSpell( 155722, 15,"Default", F.TICKS):SetTickSpeed(2)--:AddExtraSpell(163505) -- Rake
    :AddSpell( 1079,  24,"Default", F.TICKS):SetTickSpeed(2) -- Rip
    :AddSpell(22570,   1,"Default", F.UNIQUE):SetSpellModComb({1,2,3,4,5}) -- Maim
    :AddSpell(58180,  12,"Crowd") -- Infected Wounds (Movement speed slowed by 50%.)
    :AddSpell(49376, 3, "Crowd", F.CROWD)        
    :AddBuff(5217) -- Tiger's Fury
    :AddBuff(50334) -- Berserk
    :AddBuff(77761) -- Stampeding Roar
    
    :AddBuff(102543) -- Incarnation: King of the Jungle
    :AddBuff(52610) -- Savage Roar
    :AddSpell(202060) -- Elune's Guidance
    :AddBuff(155672) -- Bloodtalons
    
----------------------------------------------- 

	 -- Implement Stance Check
		-- Guardian Spells
		:AddSpell( 6795,   3,"Crowd", F.UNIQUE) -- Growl
		:AddBuff(22842) -- Frenzied Regeneration
    :AddSpell(   99,   3,"Crowd", F.AOE) -- Incapacitating Roar
		:AddBuff(192081) -- Ironfur
		:AddBuff(192083) -- Mark of Ursol
		:AddBuff(61336) -- Survival Instincts
		
		:AddBuff(155835) -- Bristling Fur
		:AddSpell(236748, 3, "Crowd", F.AOE) -- Intimidating Roar
		:AddBuff(102558) -- Incarnation: Guardian of Ursoc
		:AddSpell(204066, 8, "Default", F.AOE) -- Lunar Beam	
		
----------------------------------------------- 		
				
		:AddCasterBuffs()
		:AddMeleeBuffs()
		
		--[[local clearcasting = FW:SpellName(12536);
		ST:RegisterOnBuffGain(function(buff)
			if buff == clearcasting then
				FW:PlaySound("TimerClearcastingSound");
			end
		end);]]

	end
	--
	-- Cooldown Timer
	--
	if CD then
		-- Note: One day, this will correctly track Clearcasting/Nature's Gasp/Nature's Grace.
		
		-- Balance buffs
		--CD:AddCooldownBuff(22812); -- barkskin
		--CD:AddCooldownBuff(53307); -- thorns

		-- Resto buffs
		CD:AddCooldownBuff(1126); -- Mark of the Wild
		CD:AddCooldownBuff(16864); -- Omen of Clarity
		
		CD:AddHiddenCooldown(nil,48517,30); -- Eclipse (Solar)
		CD:AddHiddenCooldown(nil,48518,30); -- Eclipse (Lunar)
		
		---16886CD:AddHiddenCooldown(nil,16886,60); -- Nature's Grace 
		
		-- Powerups
		CD:AddCasterPowerupCooldowns();
		CD:AddMeleePowerupCooldowns();
	end
	if ST then
	--[[FW:SetMainCategory(FWL.SOUND);
		FW:SetSubCategory(FWL.SPELL_TIMER,FW.ICON.DEFAULT,2);
			FW:AddOption("SND",FWL.CLEARCASTING,"","TimerClearcastingSound");]]
	end
	if CA then
	
		local bs = FW:SpellName(22812);
		local si = FW:SpellName(61336);
		local fr = FW:SpellName(22842);
		
		local rebirth = FW:SpellName(20484);
		local innervate = FW:SpellName(29166);
		local tranquility = FW:SpellName(740);
		
		CA:RegisterOnSelfCastSuccess(
			function(s, t)
				if s == bs then
					CA:CastShow("BSStart");
				elseif s == si then
					CA:CastShow("SIStart");
				elseif s == fr then
					CA:CastShow("FRStart");
				elseif s == rebirth then
					CA:CastShow("RebirthStart",t);
				elseif s == innervate then
					CA:CastShow("InnervateStart",t);
				elseif s == tranquility then
					CA:CastShow("TranquilityStart");
				end
			end
		);

		FW:SetMainCategory(FWL.RAID_MESSAGES);

			FW:SetSubCategory("Self Damage Reduction",FW.ICON.SPECIFIC,2);
				FW:AddOption("MS2",bs,	 "",	"BSStart"); 
				FW.Default.BSStart = {[0]=1,"+++ Barkskin (10 sec) +++"};

				FW:AddOption("MS2",si,	"",	"SIStart"); 
				FW.Default.SIStart = {[0]=1,"+++ Survival Instincts (12 sec) +++"};

				FW:AddOption("MS2",fr,	"",	"FRStart"); 
				FW.Default.FRStart = {[0]=1,"+++ Frenzied Regeneration (20 sec) +++"};
				
			FW:SetSubCategory("Other",FW.ICON.SPECIFIC,2);
				FW:AddOption("MS2",rebirth,	"",	"RebirthStart"); 
				FW.Default.RebirthStart = {[0]=1,">>> Rebirth on %s <<<"};

				FW:AddOption("MS2",innervate,	"",	"InnervateStart"); 
				FW.Default.InnervateStart = {[0]=1,">>> Innervate on %s <<<"};

				FW:AddOption("MS2",tranquility,	 "",	"TranquilityStart"); 
				FW.Default.TranquilityStart = {[0]=1,">>> Tranquility up <<<"};

	end
end
