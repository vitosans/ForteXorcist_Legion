--ForteXorcist v1.980.8 by Xus 28-09-2012 for 5.0
-- Forte Mage Module attempt by Amros of Gilneas

if FW.CLASS == "MAGE" then
    local FW = FW;
    local FWL = FW.L;
    local MG = FW:ClassModule("Mage");

    local ST = FW:Module("Timer");
    local CA = FW:Module("Casting");
    local CD = FW:Module("Cooldown");

    if ST then
        local F = ST.F;
        ST:SetDefaultHasted(1)

        -- Shared Spells
        :AddSpell(  118,  50, "Crowd", F.UNIQUE):SetDurationPVP(10) -- Polymorph
        :AddSpell( 2139,   6, "Crowd", F.UNIQUE) -- Counterspell	
        :AddSpell(  122,   8,"Crowd", F.AOE) -- Frost Nova
        :AddBuff(45438) -- Ice Block
        :AddBuff(66) -- Invisibility
        -- Shared Talents
        :AddSpell(55342,  40, "Pet", F.SUMMON) -- Mirror Image
        :AddBuff(116011) -- Rune of Power
        :AddBuff(1463) -- Incanter's Flow

        :AddSpell(113724, 10,"Crowd", F.AOE) -- Ring of Frost

        -----------------------------------------------

        -- Fire Spells
        :AddBuff(235313) -- Blazing Barrier
        :AddSpell(31661,   4,"Crowd", F.UNIQUE) -- Dragon's Breath    
        :AddSpell( 2120,   8,"Default", F.AOE_DMG):SetTickSpeed(2) -- Flamestrike
        :AddBuff(190319) -- Combustion
        :AddBuff(86949) -- Cauterize
        :AddBuff(157642) -- Enhanced Pyrotechnics
        :AddBuff(48107) -- Heating Up
        :AddBuff(48108) -- Hot Streak!
        :AddSpell(12654,   9,"Default", F.TICKS):SetTickSpeed(1) -- Ignite


        -- Fire Talents
        :AddSpell(44457,  4,"Default", F.TICKS) -- Living Bomb
        :AddSpell(226757, 8, "Default", F.TICKS):SetTickSpeed(2) -- Conflagration
        :AddSpell(157981, 4, "Crowd") -- Blast Wave
        :AddBuff(236058) -- Frenetic Speed  
        :AddSpell(153561, 3, "Default", F.AOE) -- Meteor
        :AddSpell(155158, 8, "Default", F.TICKS) -- Meteor Burn

        -- Artifact Traits
        :AddSpell(194522,  9,"Default", F.TICKS):SetTickSpeed(1) -- Blast Furnace
        -----------------------------------------------

        -- Arcane Spells
        --:AddBuff(190740) -- Arcane Charge
        :AddCooldown(44425,004) -- Arcane Barrage
        :AddBuff(12042) -- Arcane Power
        :AddBuff(12051):SetTickSpeed(2) -- Evocation
        :AddBuff(110960) -- Greater Invisibility
        :AddBuff(205025) -- Presence of Mind
        :AddBuff(235450) -- Pristmatic Barrier
        :AddSpell(31589, 15,"Crowd", F.UNIQUE) -- Slow
        :AddBuff(79683) -- Arcane Missiles Proc

        -- Arcane Talents
        :AddBuff(205022) -- Arcane Familiar
        :AddBuff(235711) -- Chrono Shift
        :AddSpell(114923, 12,"Default", F.TICKS):SetTickSpeed(1) -- Nether Tempest
        :AddDebuff(205039) -- Erosion
        :AddSpell(153626, 2, "Pet", F.AOE_DMG) -- Arcane Orb

        -- Arcane Artifact
        :AddSpell(224968, 6, "Default", F.TICKS):SetTickSpeed(1) -- Mark of Aluneth		
        -----------------------------------------------

        -- Frost Spells
        :AddSpell(  120,   5,"Crowd", F.AOE) -- Cone of Cold
        :AddDebuff(228358)--, 1, "Crowd") -- Winter's Chill
        :AddSpell(84714,  15, "Pet",   F.SUMMON):SetTickSpeed(1) -- Frozen Orb
        :AddBuff(11426) -- Ice Barrier
        :AddBuff(12472) -- Icy Veins
        :AddBuff(190447) -- Brain Freeze
        :AddBuff(112965) -- Fingers of Frost
        :AddBuff(205473) -- Icicles

        -- Frost Talents  
        :AddSpell(205021, 10, "Default", F.TICKS):SetTickSpeed(1) -- Ray of Frost
        :AddBuff(205027) -- Bone Chilling
        :AddBuff(108839) -- Ice Floes
        :AddSpell(157997, 2, "Crowd") -- Ice Nova
        :AddSpell(112948,  12,"Default") -- Frost Bomb
        :AddBuff(199844) -- Glacial Spike

        -- Frost Artifact




        :AddSpell(102051,  8,"Crowd",	F.UNIQUE):SetDurationPVP(4) -- Frostjaw
        :AddSpell(44614, 000,"Crowd") -- Frostfire Bolt

        :AddCooldown(2136,011) -- Fire Blast


        :AddCasterBuffs()

        local poly = FW:SpellName(118);
        ST:RegisterOnTimerBreak(function(unit,mark,spell)
            if spell == poly then
                if mark~=0 then unit=FW.RaidIcons[mark]..unit;end
                CA:CastShow("PolymorphBreak",unit);
            end
        end);
        ST:RegisterOnTimerFade(poly,"PolymorphFade");

        --[[local clearcasting = FW:SpellName(12536);
        ST:RegisterOnBuffGain(function(buff)
            if buff == clearcasting then
                FW:PlaySound("TimerClearcastingSound");
            end
        end);]]

    end
    if CD then
        CD:AddHiddenCooldown(nil,86949,60); -- Cauterize
        CD:AddCasterPowerupCooldowns();
    end

    FW:SetMainCategory(FWL.RAID_MESSAGES);

    if ST then

        FW:SetSubCategory(FWL.BREAK_FADE,FW.ICON.SPECIFIC,2);
        FW:AddOption("INF",FWL.BREAK_FADE_HINT1);
        FW:AddOption("MS2",FWL.POLYMORPH_BREAK,		"",    "PolymorphBreak");
        FW:AddOption("MS2",FWL.POLYMORPH_FADE,		"",    "PolymorphFade");

        --[[FW:SetMainCategory(FWL.SOUND);
        FW:SetSubCategory(FWL.SPELL_TIMER,FW.ICON.DEFAULT,2);
            FW:AddOption("SND",FWL.CLEARCASTING,"","TimerClearcastingSound");]]
    end

    FW.Default.PolymorphBreak = 	{[0]=0,">> Polymorph on %s Broke Early! <<"};
    FW.Default.PolymorphFade = 		{[0]=0,">> Polymorph on %s Fading in 3 seconds! <<"};

end
