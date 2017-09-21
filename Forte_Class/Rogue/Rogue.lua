--ForteXorcist v1.980.8 by Xus 28-09-2012 for 5.0

if FW.CLASS == "ROGUE" then
    local FW = FW;
    local FWL = FW.L;
    local PR = FW:ClassModule("Rogue");

    local ST = FW:Module("Timer");
    local CA = FW:Module("Casting");
    local CD = FW:Module("Cooldown");


    if ST then
        local F = ST.F;
        ST:SetDefaultHasted(0) -- set abilities to not use haste in their durations by default

        -- Shared
        :AddSpell( 2094, 60,"Crowd", F.UNIQUE) -- Blind
        :AddSpell( 1833, 04,"Crowd", F.UNIQUE) -- Cheap Shot
        :AddBuff(31224) -- Cloak of Shadows
        :AddBuff(185311) -- Crimson Vial
        :AddBuff(1966) -- Feint
        :AddSpell(1766,   5, "Crowd", F.UNIQUE) -- Kick
        :AddSpell( 6770, 000,"Crowd", F.UNIQUE) -- Sap
        :AddBuff(114018) -- Shroud of Concealment
        :AddBuff(2983) -- Sprint
        :AddBuff(57934) -- Tricks of the Trade
        :AddBuff(1856) -- Vanish

        -- Shared Talents
        :AddBuff(31230) -- Cheat Death
        :AddBuff(193538) -- Alacrity


        -----------------------------------------------  


        -- Outlaw Spells
        :AddBuff(13750) -- Adrenaline Rush
        :AddBuff(13877) -- Blade Flurry
        :AddSpell(199740, 300,"Pet",  F.CHARM) -- Bribe
        :AddSpell(  1776, 4, "Crowd",  F.UNIQUE) -- Gouge
        :AddSpell(185763, 6, "Crowd") -- Pistol Shot Slow
        :AddBuff(199754) -- Riposte
        -- Rolling the Bones
        :AddSpellRemap(199603,193316)
        :AddSpellRemap(193358,193316)
        :AddSpellRemap(193357,193316)
        :AddSpellRemap(193359,193316)
        :AddSpellRemap(199600,193316)
        :AddSpellRemap(193356,193316)
        :AddBuff(199603) -- Jolly Roger
        :AddBuff(193358) -- Grand Melee
        :AddBuff(193357) -- Shark Infested Waters
        :AddBuff(193359) -- True Bearing
        :AddBuff(199600) -- Buried Treasure
        :AddBuff(193356) -- Broadside

        -- Outlaw Talents
        :AddSpell(196937, 15, "Crowd", F.UNIQUE) -- Ghostly Strike
        :AddSpell(199743, 000,"Crowd", F.UNIQUE) -- Parley
        :AddSpell(185767, 2, "Default", F.AOE_DMG) -- Cannonball Barrage
        :AddBuff(51690) -- Killing Spree
        :AddBuff(5171) -- Slice and Dice  

        -----------------------------------------------  

        -- Assassination Spells
        :AddBuff(32645) -- Envenom
        :AddBuff(5277) -- Evasion
        :AddSpell( 1330, 000,"Crowd", F.UNIQUE) -- Garrote silence
        :AddSpell(  703, 000,"Default", F.TICKS) -- Garrote
        :AddSpell(  408, 000,"Crowd", F.UNIQUE) -- Kidney Shot
        -- Poisons
        :AddSpell(200803, 000, "Default")
        :AddSpell(30981, 000,"Crowd") -- Crippling Poison
        --:AddSpell( 5760, 000,"Crowd") -- Mind-numbing Poison
        :AddSpell( 8679, 000,"Crowd") -- Wound Poison
        --:AddSpell(108215,000,"Crowd") -- Paralytic Poison
        --:AddSpell(113953,000,"Crowd") -- Paralysis
        :AddSpell(108211,000,"Default") -- Leeching Poison
        :AddSpell( 2818, 000,"Default", F.TICKS) -- Deadly Poison
        :AddSpell( 1943, 000,"Default", F.TICKS):SetTickSpeed(2) -- Rupture
        :AddBuff(36554) -- Shadow Step
        :AddSpell(79140, 020,"Crowd", F.UNIQUE) -- Vendetta

        -- Assassination Talents
        :AddBuff(193640) -- Elaborate Planning
        :AddSpell(16511,  20,"Default", F.TICKS) -- Hemorrhage
        :AddSpell(154904, 000, "Default", F.TICKS) -- Internal Bleeding

        -----------------------------------------------  

        -- Subtlety Spells
        :AddSpell(195452, 000, "Default", F.TICKS):SetTickSpeed(2) -- Nightblade
        :AddDebuff(206760) -- Nightblade Slow
        :AddBuff(121471) -- Shadow Blades
        :AddBuff(185313) -- Shadow Dance
        :AddBuff(212283) -- Symbol of Death


        -- Subtlety Talents
        :AddBuff(31223) -- Master of Subtlety
        :AddBuff(108208) -- Subterfuge
        :AddDebuff(196951, "Crowd") -- Strike from the Shadows
        :AddBuff(206237):SetTickSpeed(3) -- Enveloping Shadows
        -----------------------------------------------  

        :AddMeleeBuffs()

        local sap = FW:SpellName(6770);
        ST:RegisterOnTimerBreak(function(unit,mark,spell)
            if spell == sap then
                if mark~=0 then unit=FW.RaidIcons[mark]..unit;end
                CA:CastShow("SapBreak",unit);
            end
        end);
        ST:RegisterOnTimerFade(sap,"SapFade");		
    end
    if CD then
        -- Poisons
        CD:AddCooldownBuff(30981) -- Crippling Poison
        :AddCooldownBuff( 5761) -- Mind-numbing Poison
        :AddCooldownBuff( 8679) -- Wound Poison
        :AddCooldownBuff( 2818) -- Deadly Poison
        :AddCooldownBuff(108215) -- Paralytic Poison
        :AddCooldownBuff(108211) -- Leeching Poison

        :AddMeleePowerupCooldowns()
    end

    if ST then
        FW:SetMainCategory(FWL.RAID_MESSAGES):SetSubCategory(FWL.BREAK_FADE,FW.ICON.SPECIFIC,2)
        :AddOption("INF",FWL.BREAK_FADE_HINT1)
        :AddOption("MS2",FWL.SAP_BREAK,"","SapBreak")
        :AddOption("MS2",FWL.SAP_FADE,"","SapFade")
    end

    FW.Default.SapBreak = 	{[0]=0,">> Sap on %s Broke Early! <<"};
    FW.Default.SapFade = 	{[0]=0,">> Sap on %s Fading in 3 seconds! <<"};

end
