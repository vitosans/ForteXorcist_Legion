--ForteXorcist v1.980.8 by Xus 28-09-2012 for 5.0

if FW.CLASS == "WARRIOR" then
	local FW = FW;
	local FWL = FW.L;
	local WR = FW:ClassModule("Warrior");
	
	local ST = FW:Module("Timer");
	local CA = FW:Module("Casting");
	local CD = FW:Module("Cooldown");
	
	if ST then
		local F = ST.F;
		ST:SetDefaultHasted(0) -- set abilities to not use haste in their durations by default
		
		--Shared Spells
		:AddBuff(1719) -- Battle Cry
		:AddBuff(18499) -- Berserker Rage
		:AddSpell(  355,   3,"Crowd") -- Taunt
		:AddSpell(6552, 4,"Crowd",  F.UNIQUE) -- Pummel
		
		-- Shared Talents
		:AddSpell(46968,   3,"Crowd", F.AOE) -- Shockwave
		:AddSpell(107570, 4,"Crowd", F.UNIQUE) -- Storm Bolt

		
		:AddBuff(107574) -- Avatar
    
-------------------------------------------------

    --Protection Spells
    :AddSpell( 1160,  8,"Crowd", F.AOE) -- Demoralizing Shout 
    :AddBuff(190456) -- Ignore Pain
    :AddBuff(2565) -- Shield Block
    :AddBuff(871) -- Shield Wall
    :AddBuff(12975) -- Last Stand
    :AddBuff(23920) -- Spell Reflection
    :AddSpell( 6343,  10, "Crowd", F.AOE) -- Thunder Clap
    :AddBuff(32216) -- Victory Rush
    :AddSpell(115768, 15,"Default", F.TICKS) -- Deep Wounds
    
    --Protection Talents
    :AddSpell(237744, 2, "Crowd") -- Warbringer Stun
    :AddBuff(202289) -- Renewed Fury
    :AddBuff(202603) -- Into the Fray 
    :AddBuff(228920) -- Ravager Buff
    :AddSpell(228920, 7, "Default", F.TICKS) -- Ravager/Protection
    :AddBuff(227744) -- Ravager Buff
    :AddBuff(202573)
    :AddBuff(202574) -- Vengeance
       
-------------------------------------------------

    --Fury Spells
    ST:SetDefaultHasted(1)    
    :AddBuff(97462) -- Commanding Shout
    :AddSpell(100, 6, "Crowd") -- Charge Slow
    :AddBuff(184364) -- Enraged Regeneration
    :AddSpell( 5246,   8,"Crowd", F.AOE) -- Intimidating Shout
    :AddSpell(12323,   15,"Crowd", F.AOE) -- Piercing Howl
    :AddBuff(184361) -- Enrage
    :AddBuff(85739) -- Meat Cleaver
    :AddBuff(206333) -- Taste for Blood
    
    -- Fury Talents
    :AddBuff(215556) -- War Machine
    :AddBuff(215569) -- Wrecking Ball
    :AddBuff(202224) -- Furious Charge
    :AddBuff(206315) -- Massacre
    :AddBuff(215571) -- Frothing Berserker
    :AddBuff(12292) -- Bloodbath
    :AddBuff(206313) -- Frenzy   
    :AddSpell(46924, 6, "Default", F.TICKS) -- Bladestorm
    :AddBuff(118000) -- Dragon Roar
    
-------------------------------------------------
    
    -- Arms Spells
    :AddBuff(845) -- Cleave
    :AddSpell(167105,   8, "Default") -- Colossus Smash
    :AddBuff(118038) -- Die by the Sword
    :AddSpell( 1715,  15,"Crowd") -- Hamstring
    :AddSpellRemap(12294,115804) -- Mortal Strike to Mortal Wounds
    :AddSpell(115804, 10,"Default"):AddExtraSpell(115768)-- Mortal Wounds
    :AddSpell(227847, 6, "Default", F.TICKS) -- Bladestorm/Arms
    
    -- Arms Talents
		:AddBuff(60503) -- Overpower
		:AddSpell(772, 15, "Default", F.TICKS) -- Rend
		:AddBuff(197690) -- Defensive Stance
		:AddBuff(207982) -- Focused Rage
		:AddSpell(215538, 6, "Default", F.TICKS):SetTickSpeed(2) -- Trauma
		:AddSpell(152277, 7, "Default", F.TICKS) -- Ravager/Arms
		
		:AddMeleeBuffs()
		
	end
	if CD then
		CD:AddCooldownBuff(6673); -- Battle Shout
		--CD:AddHiddenCooldown(nil,60503,6); -- Taste for Blood
		CD:AddMeleePowerupCooldowns();
	end
	if CA then
	
		local sw = FW:SpellName(871);
		local ls = FW:SpellName(12975);
		local rc = FW:SpellName(97462);
		local er = FW:SpellName(55694);
		
		local intervene = FW:SpellName(3411);
		local vigilance = FW:SpellName(114030);
		--local recklessness = FW:SpellName(1719);
		
		CA:RegisterOnSelfCastSuccess(
			function(s, t)
				if s == sw then
					CA:CastShow("SWStart");
				elseif s == ls then
					CA:CastShow("LSStart");
				elseif s == rc then
					CA:CastShow("RCStart");
				elseif s == er then
					CA:CastShow("ERStart");
				elseif s == intervene then
					CA:CastShow("InterveneStart" , t);
				elseif s == vigilance then
					CA:CastShow("VigilanceStart" , t);
				--elseif s == recklessness then
					--CA:CastShow("RecklessnessStart");
				end
			end
		);

		FW:SetMainCategory(FWL.RAID_MESSAGES);
			FW:SetSubCategory("Raid Damage Reduction",FW.ICON.SPECIFIC,2);
				FW:AddOption("MS2",rc,	 		"","RCStart"); 
				FW:AddOption("MS2",intervene,	"","InterveneStart"); 
				
			FW:SetSubCategory("Self Damage Reduction",FW.ICON.SPECIFIC,2);
				FW:AddOption("MS2",sw,"","SWStart"); 
				FW:AddOption("MS2",ls,"","LSStart"); 
				FW:AddOption("MS2",er,"","ERStart"); 
				
			FW:SetSubCategory("Other",FW.ICON.SPECIFIC,2);
				FW:AddOption("MS2",vigilance,		"","VigilanceStart"); 
				--FW:AddOption("MS2",recklessness,	"","RecklessnessStart"); 
		
		FW.Default.RCStart = 				{[0]=1,"+++ Rallying Cry (10 sec) +++"};		
		FW.Default.InterveneStart = 		{[0]=1,"+++ Intervene on %s (10 sec) +++"};				
		FW.Default.SWStart = 				{[0]=1,"+++ Shield Wall (12 sec) +++"};				
		FW.Default.LSStart = 				{[0]=1,"+++ Last Stand (20 sec) +++"};		
		FW.Default.ERStart = 				{[0]=1,"+++ Enraged Regeneration (10 sec) +++"};
		FW.Default.VigilanceStart = 		{[0]=0,">>> Vigilance on %s (12 sec) <<<"};
		--FW.Default.RecklessnessStart = 		{[0]=1,">>> Taking 20% more damage with Recklessness (12 sec) <<<"};	
	end
	
end
