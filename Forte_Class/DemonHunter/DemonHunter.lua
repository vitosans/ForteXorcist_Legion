--ForteXorcist v1.980.8 by Xus 28-09-2012 for 5.0

if FW.CLASS == "DEMONHUNTER" then
    local FW = FW;
    local FWL = FW.L;
    local DH = FW:ClassModule("DemonHunter");

    local ST = FW:Module("Timer");
    local CA = FW:Module("Casting");
    local CD = FW:Module("Cooldown");

    if ST then
        local F = ST.F;
        ST:SetDefaultHasted(0) -- set abilities to not use haste in their durations by default

        -- Havoc Spells
        :AddDebuff(198813) -- Vengeful Retreat
        :AddDebuff(179057) -- Chaos Nova
        :AddSpell(198013, 2, "Default", F.TICKS):SetTickSpeed(0.2) -- EyeBeam
        :AddBuff(188499) -- Blade Dance
        :AddBuff(210152) -- Death Sweep
        :AddSpell(196718, 8, "Buff", F.BUFF) -- Darkness
        :AddBuff(187827) -- Metamorphosis
        :AddDebuff(200166) -- Metamorphosis Stun
        :AddBuff(198589) -- Blur
        :AddSpell(206473, 10, "Default", F.TICKS):SetTickSpeed(2) -- Bloodlet
        :AddDebuff(206491) -- Nemesis Debuff on target
        :AddBuff(208608) -- Nemesis Buff on player /beasts
        :AddBuff(211048) -- Chaos Blades

        --Vengeance Spells
        :AddBuff(203819) -- Demon Spikes
        :AddDebuff(185245) -- Torment
        :AddDebuff(207744) -- Fiery Brand
        :AddSpell(178740, 6, "Buff", F.TICKS):SetTickSpeed(1) -- Immolation Aura
        :AddBuff(203981) -- Soulshards
        :AddSpell(202137, 2,"Default", F.AOE) -- Sigil of Silence
        :AddDebuff(204490) -- Sigil of Silence Effect
        :AddSpell(204596, 2,"Default", F.AOE) -- Sigil of Flame
        :AddDebuff(204598, 6, "Default", F.TICKS):SetTickSpeed(2) -- Sigil of Flame Effect
        :AddSpell(207684, 2,"Default", F.AOE) -- Sigil of Misery
        :AddDebuff(207685, 30, "Default", F.AOE) -- Sigil of Misery Effect

        -- Shared Spells
        :AddBuff(188501) -- Spectral Sight
        :AddSpell(183752, 3,"Crowd",  F.UNIQUE) -- Consume Magic
        :AddBuff(131347) -- Glide
        :AddSpell(217832,  60, "Crowd", F.UNIQUE):SetDurationPVP(10) -- Imprison

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
