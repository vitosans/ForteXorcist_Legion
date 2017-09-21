--ForteXorcist v1.980.8 by Xus 28-09-2012 for 5.0

if FW.CLASS == "DEATHKNIGHT" then
    local FW = FW;
    local FWL = FW.L;
    local DK = FW:ClassModule("DeathKnight");

    local ST = FW:Module("Timer");
    local CA = FW:Module("Casting");
    local CD = FW:Module("Cooldown");

    if ST then
        local F = ST.F;
        ST:SetDefaultHasted(0)

        -- Shared Spells
        :AddBuff(53766) -- Anti-Magic Shell
        :AddSpell(45524,   8,"Crowd") -- Chains of Ice
        :AddSpell(111673, 300,"Pet",  F.CHARM) -- Control Undead
        :AddSpell(56222,   3,"Crowd") -- Dark Command
        :AddBuff(58130) -- Icebound Fortitude
        :AddSpell(47528,   3, "Crowd") -- Mind Freeze
        :AddBuff(60068) -- Path of Frost
        :AddBuff(212552) -- Wraith Walk
        :AddBuff(53365) -- Unholy Strength
        :AddSpell(51714,  20,"Default") -- Razorice
        :AddBuff(178819) -- Dark Succor

        -- Frost Spells
        :AddSpellRemap(49184,55095) -- Icy Touch to Frost Fever
        :AddSpell(55095,  24,"Default", F.AOE+F.TICKS+F.REFRESH):SetTickSpeed(3) -- Frost Fever, refreshed by Howling Blast
        :AddBuff(51271) -- Pillar of Frost
        :AddSpell(196770, 8, "Default", F.AOE+F.TICKS+F.REFRESH):SetTickSpeed(1) -- Remorseless Winter
        :AddBuff(51124) -- Killing Machine (instant cast)
        :AddBuff(59052) -- Rime

        --Frost Talents
        :AddBuff(194878) -- Icy Talons
        :AddBuff(207127) -- Hungering Rune Weapon
        :AddDebuff(207161, "Crowd") -- Abomination's Might
        :AddSpell(207167, 4, "Crowd", F.AOE) -- Blinding Sleet
        :AddDebuff(207170, "Crowd") -- Winter is Coming
        :AddBuff(207256) -- Obliteration
        :AddBuff(152279) -- Breath of Sindragosa

        -- Blood Spells
        :AddSpell(221562,   5, "Crowd") -- Asphyxiate
        :AddSpellRemap(195292,55078) -- Death's Caress to Blood Plague
        :AddSpellRemap(50842,55078) -- Blood Boil to Blood Plague
        :AddSpell(55078,  24,"Default",  F.TICKS+F.REFRESH):SetTickSpeed(3) -- Blood Plague, refreshed by Blood Boil & Death's Caress
        :AddBuff(49028) -- Dancing Rune Weapon
        :AddSpell(43265,  10,"Default", F.AOE_DMG):SetTickSpeed(1) -- Death & Decay
        :AddSpell(206930, 8, "Crowd") -- Heart Strike Slow
        :AddSpellRemap(195182,195181) -- Marrowrend to Bone Shield
        :AddBuff(195181) -- Bone Shield
        :AddBuff(55233) -- Vampiric Blood
        :AddBuff(81136) -- Crimson Scourge
        :AddBuff(77535) -- Blood Shield

        --Blood Talents
        :AddChannel(206931,1,3) -- Blooddrinker

        :AddBuff(212744) -- Soulgorge

        :AddDebuff(206940) -- Mark of Blood
        :AddBuff(219809) -- Tombstone

        :AddBuff(194679) -- Rune Tap

        :AddBuff(194844) -- Bonestorm
        :AddDebuff(206977) -- Blood Mirror

        -- Unholy Spells
        :AddSpell(42650, 4, "Pet", F.SUMMON):AddExtraSpell(42651) -- Summon Army of the Dead
        :AddSpell(42651, 40, "Pet", F.SUMMON) -- Army of the Dead
        :AddSpell(63560, 20, "Pet", F.SUMMON) -- Dark Transformation
        :AddSpellRemap(85948, 194310) -- Festering Strike to Festering Wound
        :AddDebuff(194310) -- Festering Wound
        :AddSpellRemap(77575, 191587) -- Outbreak to Virulent Plague
        --:AddSpellRemap(77575, 196782) -- Outbreak to Outbreak Miasma
        --:AddSpell(196782, 6, "Default", F.AOE) -- Outbreak
        :AddSpell(191587, 21, "Default", F.AOE_DMG) -- Virulent Plague
        :AddSpell(49206,  40, "Pet",   F.SUMMON) -- Summon Gargoyle
        :AddBuff(51460) -- Runic Corruption
        :AddBuff(81340):SetStacks(0) -- Sudden Doom

        -- Unholy Talents
        :AddBuff(207289) -- Unholy Frenzy
        :AddBuff(207319) -- Corpse Shield
        :AddSpell(207349, 15, "Pet", F.SUMMON) -- Summon Valkyr
        :AddSpell(152280, 10, "Default", F.AOE_DMG) -- Defile
        :AddSpell(130736, 5, "Default", F.DEBUFF) -- Soulreaper

        -- Honor Talents
        :AddSpell(47476,   5,"Crowd") -- Strangulate


        :AddSpell(77606,   8,"Crowd") -- Dark Simulacrum
        :AddSpell(57532, 300,"Pet",   F.SUMMON) -- "Eye of Acherus"
        --:AddSpell(49194, 000,"Default", F.TICKS):SetTickSpeed(1) -- Unholy Blight

        --
        :AddBuff(55972) -- "Abominable Might"
        :AddBuff(50421) -- "Scent of Blood"
        :AddBuff(51271) -- Unbreakable Armor
        :AddBuff(49039) -- Lichborne
        :AddBuff(66803) -- Desolation
        :AddBuff(115994) -- Unholy Blight
        :AddBuff(119975) -- Conversion
        :AddBuff(96268) -- Death's Advance

        :AddMeleeBuffs()
        :AddCasterBuffs()

        FW:SetMainCategory(FWL.RAID_MESSAGES);

        FW:SetSubCategory("Self Damage Reduction",FW.ICON.SPECIFIC,2);
        FW:AddOption("MS2",ibf,	 "",	"IBFStart");
        FW.Default.IBFStart = {[0]=1,"+++ Icebound Fortitude (12 sec) +++"};

        FW:AddOption("MS2",vb,	"",	"VBStart");
        FW.Default.VBStart = {[0]=1,"+++ Vamparic Blood (10 sec) +++"};

        FW:AddOption("MS2",ams,	"",	"AMSStart");
        FW.Default.AMSStart = {[0]=1,"+++ Anti-Magic Shell (7 sec) +++"};

        FW:AddOption("MS2",lb,	"",	"LBStart");
        FW.Default.LBStart = {[0]=1,"+++ Lichborne (10 sec) +++"};

        FW:AddOption("MS2",drw,	"",	"DRWStart");
        FW.Default.DRWStart = {[0]=1,"+++ Dancing Rune Weapon (12 sec) +++"};

        FW:SetSubCategory("Other",FW.ICON.SPECIFIC,2);
        FW:AddOption("MS2",ra,	"",	"RAStart");
        FW.Default.RAStart = {[0]=1,">>> Raise Ally on %s <<<"};
    end
end
