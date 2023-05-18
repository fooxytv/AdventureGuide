-- Load libraries
local AceGUI = LibStub("AceGUI-3.0")

-- Addon variables
local addonName = "AdventureGuide"
local version = ...
local playerName = UnitName("player")
local playerRace = UnitRace("player")
local _, playerClass = UnitClass("player")
local classColor = RAID_CLASS_COLORS[playerClass] or {r = 1, g = 1, b = 1} -- default to white if not found
playerName = format("|cff%02x%02x%02x%s|r", classColor.r*255, classColor.g*255, classColor.b*255, playerName)
local playerFaction = UnitFactionGroup("player")

function GetFactionNum(playerFaction)
    if playerFaction == "Alliance" then
        return 1
    elseif playerFaction == "Horde" then
        return 0
    end
end

local expansions = {
    {
        name = "Classic",
    }
}

local classTable = {
    [1] = "WARRIOR",
    [2] = "PALADIN",
    [3] = "HUNTER",
    [4] = "ROGUE",
    [5] = "PRIEST",
    [6] = "SHAMAN",
    [7] = "MAGE",
    [8] = "WARLOCK",
    [9] = "DRUID",
}

local classRace = {
    [1] = "Human",
    [2] = "Dwarf",
    [3] = "Gnome",
    [4] = "Night Elf",
    [5] = "Orc",
    [6] = "Tauren",
    [7] = "Undead",
    [8] = "Troll",
}

function GetRaceId(playerRace)
    for raceId, name in pairs(classRace) do
        if name == playerRace then
            return raceId
        end
    end
end

function GetClassId(playerClass)
    for classId, name in pairs(classTable) do
        if name == playerClass then
            return classId
        end
    end
end

local dungeonTable = {
    [33] = "Shadowfang Keep",
    [34] = "The Stockade",
    [36] = "The Deadmines",
    [43] = "Wailing Caverns",
    [47] = "Razorfen Kraul",
    [48] = "Blackfathom Deep",
    [70] = "Uldaman",
    [90] = "Gnomeregan",
    [109] = "Sunken Temple",
    [129] = "Razorfen Downs",
    [189] = "The Scarlet Monastery",
    [389] = "Ragefire Chasm",
    [209] = "Zul'Farrak",
    [349] = "Maraudon",
    [230] = "Blackrock Depths",
    [229] = "Blackrock Spire",
    [429] = "Dire Maul",
    [289] = "Scholomance",
    [329] = "Stratholme"
}

local dungeonBossTable = {
    [33] = {
        "Rethilgore",
        "Fel Steeds/Shadow Charger",
        "Razorclaw the Butcher",
        "Baron Silverlaine",
        "Commander Springvale",
        "Odo the Blindwatcher",
        "Deathsworn Captain (Rare)",
        "Fenrus the Devourer",
        "Wolf Master Nandos",
        "Archmage Arugal"
    },
    [34] = {
        "Targorr the Dread",
        "Kam Deepfury",
        "Hamhock",
        "Bazil Thredd",
        "Dextren Ward",
        "Bruegal Ironknuckle (Rare)"
    },
    [36] = {
        "Rhahk'zor",
        "Miner Johnson (Rare)",
        "Sneed's Shredder",
        "Gilnid",
        "Mr. Smite",
        "Captain Greenskin",
        "Edwin Van Cleef",
        "Cookie (Bonus Boss)",
    },
    [43] = {
        "Kresh",
        "Lady Anacondra",
        "Lord Cobrahn",
        "Deviate Faerie Dragon (Rare)",
        "Lord Pythas",
        "Skum",
        "Lord Serpentis",
        "Verdan the Everliving",
        "The Naralex Event (Mutanus the Devourer",
    },
    [47] = {
        "Roogug",
        "Aggem Thorncurse",
        "Death Speaker Jargba",
        "Overlord Ramtusk",
        "Agathelos the Raging",
        "Blind Hunter (Rare)",
        "Earthcaller Halmgar",
        "Charlga Razorflank",
    },
    [48] = {
        [1] = "Ghamoo-Ra",
        [2] = "Lady Sarevess",
        [3] = "Gelihast",
        [4] = "Twilight Lord Kelris",
        [5] = "Event - Fire Of Aku'Mai",
        [6] = "Old Serra'Kis",
        [7] = "Aku'Mai",
    },
}

local encounterJournalDungeonOverview = {
    [48] = "|cFFFFA500|Hitem:21877::::::::120:256::::::|hDungeon Overview|h|r\n\nBlackfathom Deeps is located in Ashenvale in the Kalimdor. It is an ancient temple complex that lies beneath the waters of Blackfathom Bay. The dungeon is designed for players around level 20-30.\n\nThe storyline of Blackfathom Deeps revolves around the Twelight's Hammer, a cult dedicated to serving the Old Gods. The cult has taken control of the temple and seeks to summon a powerful minion of their dark masters. " ..playerName.. " you're tasked with infiltrating the temple and putting an end to the cult's plans.\n\nThe dungeon consists of several areas, including underwater sections and dry land.",
}

local encounterJournal = {
    [48] = {
        [1] = "|cFFFFA500|Hitem:21877::::::::120:256::::::|hGhamoo-Ra|h|r\n\nGhamoo-Ra is a level 25 elite turtle located in Blackfathom Deeps. He is the first boss of the dungeon.\n\n\n\n|cFFFFA500|Hitem:21877::::::::120:256::::::|hAbilities|h|r\n\nTrample\n\n\n\n|cFFFFA500|Hitem:21877::::::::120:256::::::|hEncounter Strategy|h|r\n\nGhamoo-Ra is a simple tank and spank with a catch - the boss has a tremendous amount of armour and takes significantly reduced damage. Every so often, he will cast his primary ability, so make sure to stay spread out. This is a simple encounter with very little explanation required.\n\n\n\n|cFFFFA500|Hitem:21877::::::::120:256::::::|hLoot|h|r\n\n|cff00ccff|Hitem:21877::::::::120:256::::::|h[Ghamoo-Ra's Bind]|h|r\n[Tortoise Armor].",
        [2] = "|cff00ccff|Hitem:21877::::::::120:256::::::|hEncounter Strategy|h|r\n\nSarevess patrols the area with 2 other Naga. Make sure to clear out the cave before pulling her and her 2 bodyguards. Make sure to Crowd Control at least one of the bodyguards before engaging her. Focus the add down, switch to Sarevess.\n\n",
    }
}

local suggestedContentData = {
    [0] = {
        [1] = {
            [4] = "|cFFFFA500|Hitem:21877::::::::120:256::::::|hQuest Campaign!|h|r\n\nTo start your levelling journey, speak to |cFFFFA500|Hitem:21877::::::::120:256::::::|hDeputy Wilem|h|r, accept the quest [!]Accept: The Start is Here!"
        },
    },
    [1] = {
        [1] = {
            [4] = string.format("|cFFFFA500|Hitem:21877::::::::120:256::::::|hQuest Campaign!|h|r\n\nTo start your levelling journey, speak to |cFF00FF00|Hitem:21877::::::::120:256::::::|hDeputy Wilem|h|r, accept the quest |cFFFFFF00|Hitem:21877::::::::120:256::::::|hA Threat Within|h|r\n\n")
        },
    },
}

local suggestDungeonContentData = {
    [0] = {
        [1] = {
            [4] = string.format("")
        }
    },
    [1] = {
        [1] = {
            [4] = string.format("|cFFFFA500|Hitem:21877::::::::120:256::::::|hDungeon Quests!|h|r\n\nYou are currently not higher enough level to accept any dungeon quests.\n\n")
        },
    }
}

local function InitAdventureGuideFrame()
    local adventureGuideFrame = AceGUI:Create("Frame")
    adventureGuideFrame:SetTitle(addonName)
    adventureGuideFrame:SetWidth(885)
    adventureGuideFrame:SetHeight(550)
    adventureGuideFrame:SetLayout("Fill")
    adventureGuideFrame:SetPoint("TOPLEFT", 50, -50)
    adventureGuideFrame:SetCallback("OnClose", function (widget) AceGUI:Release(widget) end)

    return adventureGuideFrame
end

-- adventureGuideFrame:SetWidth(1040)
-- adventureGuideFrame:SetHeight(640)

local function InitAdventureGuideFrameTabs(adventureGuideFrame)
    local adventureGuideFrameTab = AceGUI:Create("TabGroup")
    adventureGuideFrameTab:SetLayout("Flow")
    adventureGuideFrameTab:SetTabs(
        {{text = "Suggested Content", value = "tab1",},{text = "Dungeons",value = "tab2",},{text = "Raids",value = "tab3",},}
    )
    adventureGuideFrameTab:SetCallback("OnGroupSelected", function (adventureGuideFrameTabContainer, event, group)
        if group == "tab1" then
            adventureGuideFrameTabContainer:ReleaseChildren()

            local factionId = GetFactionNum(playerFaction)
            local classId = GetClassId(playerClass)
            local raceId = GetRaceId(playerRace)
            local suggestedContent = suggestedContentData[factionId][raceId][classId]
            local suggestDungeonContent = suggestDungeonContentData[factionId][raceId][classId]

--          -- Suggested Content header
            local label = AceGUI:Create("Heading")
            label:SetText("Suggested Content")
            label:SetWidth(1000)
            label:SetHeight(10)
            label:SetPoint("TOPLEFT", adventureGuideFrameTabContainer.frame, 100, -100)
            adventureGuideFrameTabContainer:AddChild(label)

            -- Create a container for expansion dropdown
            local dropdownContainer = AceGUI:Create("InlineGroup")
            dropdownContainer:SetLayout("List")
            dropdownContainer:SetFullWidth(true)
            adventureGuideFrameTabContainer:AddChild(dropdownContainer)

            -- Create dropdown box
            local expansionDropDown = AceGUI:Create("Dropdown")
            expansionDropDown:SetList({
                ["era"] = expansions[1].name
            })
            expansionDropDown:SetWidth(200)
            expansionDropDown:SetHeight(25)
            expansionDropDown:SetValue("")
            expansionDropDown:SetDisabled(true)
            expansionDropDown:SetPoint("CENTER", 0, 0)
            dropdownContainer:AddChild(expansionDropDown)

            local outerContentGroup = AceGUI:Create("InlineGroup") -- "InlineGroup" is also good
            outerContentGroup:SetFullWidth(true)
            -- outerContentGroup:SetRelativeWidth(0.5)
            outerContentGroup:SetFullHeight(true) -- probably?
            outerContentGroup:SetLayout("Fill") -- important!
            adventureGuideFrameTabContainer:AddChild(outerContentGroup)

            local outerScrollContainer = AceGUI:Create("ScrollFrame") -- "InlineGroup" is also good
            outerScrollContainer:SetFullWidth(true)
            outerScrollContainer:SetFullHeight(true) -- probably?
            outerScrollContainer:SetLayout("Flow") -- important!
            outerContentGroup:AddChild(outerScrollContainer)

            local leftContentGroup = AceGUI:Create("SimpleGroup") -- "InlineGroup" is also good
            leftContentGroup:SetWidth(490)
            leftContentGroup:SetRelativeWidth(0.5)
            leftContentGroup:SetHeight(335) -- probably?
            leftContentGroup:SetLayout("Fill") -- important!
            outerScrollContainer:AddChild(leftContentGroup)

            local suggestedJournalTextureLeft = leftContentGroup.frame:CreateTexture(nil, "BACKGROUND")
            suggestedJournalTextureLeft:SetAllPoints(leftContentGroup.frame)
            suggestedJournalTextureLeft:SetTexture("Interface\\AddOns\\AdventureGuide\\Textures\\ajbg.blp")

            -- local leftTextlabel = AceGUI:Create("Label")
            -- leftTextlabel:SetFont("Fonts\\FRIZQT__.TTF", 12, nil)
            -- leftTextlabel:SetText("")
            -- leftTextlabel:SetRelativeWidth(1)
            -- leftTextlabel:SetWidth(50)
            -- leftTextlabel:SetHeight(50)
            -- leftTextlabel:SetPoint("CENTER", leftContentGroup.frame, "CENTER", 50, -50)
            -- textContentGroup:AddChild(leftTextlabel)

            -- local leftButton = AceGUI:Create("Button")
            -- leftButton:SetText("Start Questing")
            -- leftButton:SetRelativeWidth(0.2)
            -- leftButton:SetWidth(130)
            -- leftButton:SetHeight(30)
            -- leftButton:SetPoint("CENTER", leftContentGroup.frame, "CENTER", 0, -100)
            -- leftContentGroup:AddChild(leftButton)

            -- leftButton:SetCallback("OnClick", function()
            --     local command = "/way 48.18, 42.97 Deputy Wilem"
            --     ChatFrame1EditBox:SetText(command)
            --     ChatEdit_SendText(ChatFrame1EditBox)
            -- end)

            local rightContentGroup = AceGUI:Create("SimpleGroup") -- "InlineGroup" is also good
            rightContentGroup:SetWidth(490)
            rightContentGroup:SetRelativeWidth(0.5)
            rightContentGroup:SetHeight(339) -- probably?
            rightContentGroup:SetLayout("Fill")
            outerScrollContainer:AddChild(rightContentGroup)

            local suggestedDungeonJournalTextureRight = rightContentGroup.frame:CreateTexture(nil, "BACKGROUND")
            suggestedDungeonJournalTextureRight:SetAllPoints(rightContentGroup.frame)
            suggestedDungeonJournalTextureRight:SetTexture("Interface\\AddOns\\AdventureGuide\\Textures\\ajbgbw.blp")

            -- local rightButton = AceGUI:Create("Button")
            -- rightButton:SetText("Start Dungeon Quests")
            -- rightButton:SetRelativeWidth(0.5)
            -- rightButton:SetWidth(150)
            -- rightButton:SetHeight(30)
            -- rightButton:SetPoint("CENTER", rightContentGroup.frame, "CENTER", 0, -100)
            -- rightButton:SetDisabled(true)
            -- rightContentGroup:AddChild(rightButton)

        elseif group == "tab2" then
            adventureGuideFrameTabContainer:ReleaseChildren()

--          -- Suggested Content header
            local label = AceGUI:Create("Heading")
            label:SetText("Dungeons")
            label:SetWidth(1000)
            label:SetHeight(10)
            label:SetPoint("TOPLEFT", adventureGuideFrameTabContainer.frame, 0, 0)
            adventureGuideFrameTabContainer:AddChild(label)

            -- Create a container for expansion dropdown
            local dropdownContainer = AceGUI:Create("InlineGroup")
            dropdownContainer:SetLayout("List")
            dropdownContainer:SetFullWidth(true)
            adventureGuideFrameTabContainer:AddChild(dropdownContainer)

            -- Create dropdown box
            local expansionDropDown = AceGUI:Create("Dropdown")
            expansionDropDown:SetList({
                ["era"] = expansions[1].name
            })
            expansionDropDown:SetWidth(200)
            expansionDropDown:SetHeight(25)
            expansionDropDown:SetValue("era")
            expansionDropDown:SetDisabled(true)
            expansionDropDown:SetPoint("CENTER", 0, 0)
            dropdownContainer:AddChild(expansionDropDown)

            local outerContentGroup = AceGUI:Create("InlineGroup") -- "InlineGroup" is also good
            outerContentGroup:SetFullWidth(true)
            outerContentGroup:SetFullHeight(true) -- probably?
            outerContentGroup:SetLayout("Fill") -- important!
            adventureGuideFrameTabContainer:AddChild(outerContentGroup)

            local scrollcontainer = AceGUI:Create("ScrollFrame") -- "InlineGroup" is also good
            scrollcontainer:SetFullWidth(true)
            scrollcontainer:SetFullHeight(true) -- probably?
            scrollcontainer:SetLayout("Flow") -- important!
            outerContentGroup:AddChild(scrollcontainer)

            -- local contentGroup = AceGUI:Create("InlineGroup") -- "InlineGroup" is also good
            -- contentGroup:SetWidth(270)
            -- contentGroup:SetHeight(150) -- probably?
            -- contentGroup:SetLayout("Flow") -- important!
            -- scrollcontainer:AddChild(contentGroup)

            local blackfathomDeepTexture = AceGUI:Create("Icon")
            blackfathomDeepTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\bfd.blp")
            blackfathomDeepTexture:SetImageSize(160, 80)
            blackfathomDeepTexture:SetRelativeWidth(0.2)
            blackfathomDeepTexture:SetLabel(dungeonTable[48])
            scrollcontainer:AddChild(blackfathomDeepTexture)
            blackfathomDeepTexture:SetCallback("OnClick", function ()
                adventureGuideFrameTabContainer:ReleaseChildren()

                local db = dungeonTable[48]

                local bfdLabel = AceGUI:Create("Heading")
                bfdLabel:SetText(db)
                bfdLabel:SetWidth(1000)
                bfdLabel:SetHeight(10)
                bfdLabel:SetPoint("TOPLEFT", adventureGuideFrameTabContainer.frame, 0, 0)
                adventureGuideFrameTabContainer:AddChild(label)

                -- Create a container for expansion dropdown
                local dropdownContainer = AceGUI:Create("InlineGroup")
                dropdownContainer:SetLayout("List")
                dropdownContainer:SetFullWidth(true)
                adventureGuideFrameTabContainer:AddChild(dropdownContainer)

                -- Create dropdown box
                local bossDropDown = AceGUI:Create("Dropdown")
                bossDropDown:SetList({
                    ["0"] = "_",
                    ["1"] = dungeonBossTable[48][1],
                    ["2"] = dungeonBossTable[48][2],
                    ["3"] = dungeonBossTable[48][3],
                    ["4"] = dungeonBossTable[48][4],
                    ["5"] = dungeonBossTable[48][5],
                    ["6"] = dungeonBossTable[48][6],
                    ["7"] = dungeonBossTable[48][7],
                })
                bossDropDown:SetWidth(200)
                bossDropDown:SetHeight(25)
                -- bossDropDown:SetValue("1")
                bossDropDown:SetText("")
                bossDropDown:SetDisabled(false)
                bossDropDown:SetPoint("CENTER", 0, 0)
                dropdownContainer:AddChild(expansionDropDown)

                local outerContentGroup = AceGUI:Create("InlineGroup") -- "InlineGroup" is also good
                outerContentGroup:SetFullWidth(true)
                outerContentGroup:SetFullHeight(true) -- probably?
                outerContentGroup:SetLayout("Fill") -- important!
                adventureGuideFrameTabContainer:AddChild(outerContentGroup)

                local bossInfoTextlabel = AceGUI:Create("Label")
                bossInfoTextlabel:SetFont("Fonts\\FRIZQT__.TTF", 12, nil)
                bossInfoTextlabel:SetText(encounterJournalDungeonOverview[48])
                bossInfoTextlabel:SetFullWidth(true)
                bossInfoTextlabel:SetFullHeight(true)
                scrollcontainer:AddChild(bossInfoTextlabel)
    
                local scrollcontainer = AceGUI:Create("ScrollFrame") -- "InlineGroup" is also good
                scrollcontainer:SetFullWidth(true)
                scrollcontainer:SetFullHeight(true) -- probably?
                scrollcontainer:SetLayout("Fill") -- important!
                outerContentGroup:AddChild(scrollcontainer)

                bossDropDown:SetCallback("OnValueChanged", function (self, event, value)

                    if value == "0" then

                        adventureGuideFrameTab:SelectTab("tab2")
                    elseif value == "1" then
                        scrollcontainer:ReleaseChildren()

                        local textlabel = AceGUI:Create("Label")
                        textlabel:SetFont("Fonts\\FRIZQT__.TTF", 12, nil)
                        textlabel:SetText(encounterJournal[48][1])
                        textlabel:SetFullWidth(true)
                        textlabel:SetFullHeight(true)
                        scrollcontainer:AddChild(textlabel)
                    elseif value == "2" then
                        scrollcontainer:ReleaseChildren()

                        local textlabel = AceGUI:Create("Label")
                        textlabel:SetFont("Fonts\\FRIZQT__.TTF", 12, nil)
                        textlabel:SetText(encounterJournal[48][2])
                        textlabel:SetFullWidth(true)
                        textlabel:SetFullHeight(true)
                        scrollcontainer:AddChild(textlabel)
                    end
                end)

            end)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\brd.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[230])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\dm.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[36])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\drm.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[429])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\gnome.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[90])
            dungeonTexture:SetRelativeWidth(0.2)
            dungeonTexture:SetPoint("TOPRIGHT", scrollcontainer.frame, "TOPRIGHT", 0, 0)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\brs.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[229])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\mara.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[349])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\rfc.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[389])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\rfd.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[129])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\rfk.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[47])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            -- local dungeonTexture = AceGUI:Create("Icon")
            -- dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\sh.blp")
            -- dungeonTexture:SetImageSize(160, 80)
            -- dungeonTexture:SetLabel(dungeonTable[0])
            -- dungeonTexture:SetRelativeWidth(0.2)
            -- scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\sm.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[189])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\scholo.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[289])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\sfk.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[33])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\strat.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[230])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\stocks.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[34])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\temple.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[109])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\uld.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[70])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\wc.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[43])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)

            local dungeonTexture = AceGUI:Create("Icon")
            dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\zf.blp")
            dungeonTexture:SetImageSize(160, 80)
            dungeonTexture:SetLabel(dungeonTable[209])
            dungeonTexture:SetRelativeWidth(0.2)
            scrollcontainer:AddChild(dungeonTexture)
            
        elseif group == "tab3" then
            adventureGuideFrameTabContainer:ReleaseChildren()

            -- Suggested Content header
            local label = AceGUI:Create("Heading")
            label:SetText("Raids")
            label:SetWidth(1000)
            label:SetHeight(10)
            label:SetPoint("TOPLEFT", adventureGuideFrameTabContainer.frame, 100, -100)
            adventureGuideFrameTabContainer:AddChild(label)

            -- Create a container for expansion dropdown
            local dropdownContainer = AceGUI:Create("InlineGroup")
            dropdownContainer:SetLayout("List")
            dropdownContainer:SetFullWidth(true)
            adventureGuideFrameTabContainer:AddChild(dropdownContainer)

            -- Create dropdown box
            local expansionDropDown = AceGUI:Create("Dropdown")
            expansionDropDown:SetList({
                ["era"] = expansions[1].name
            })
            expansionDropDown:SetWidth(200)
            expansionDropDown:SetHeight(25)
            expansionDropDown:SetValue("era")
            expansionDropDown:SetDisabled(true)
            expansionDropDown:SetPoint("CENTER", 0, 0)
            dropdownContainer:AddChild(expansionDropDown)

            local contentGroup = AceGUI:Create("InlineGroup") -- "InlineGroup" is also good
            contentGroup:SetFullWidth(true)
            contentGroup:SetFullHeight(true) -- probably?
            contentGroup:SetLayout("Fill") -- important!
            adventureGuideFrameTabContainer:AddChild(contentGroup)

            local scrollcontainer = AceGUI:Create("ScrollFrame") -- "InlineGroup" is also good
            scrollcontainer:SetFullWidth(true)
            scrollcontainer:SetFullHeight(true) -- probably?
            scrollcontainer:SetLayout("Fill") -- important!
            contentGroup:AddChild(scrollcontainer)
        end
        return adventureGuideFrameTabContainer
    end)
    adventureGuideFrameTab:SelectTab("tab1")
    adventureGuideFrame:AddChild(adventureGuideFrameTab)

    return adventureGuideFrameTab
end

SLASH_HELLO1 = "/advopen"

local adventureGuideFrame, adventureGuideFrameTab

function SlashCmdList.HELLO(msg, editbox)
    if adventureGuideFrame and adventureGuideFrameTab and adventureGuideFrame:IsShown() then
        adventureGuideFrame:Hide()
    else
        adventureGuideFrame = InitAdventureGuideFrame()
        adventureGuideFrameTab = InitAdventureGuideFrameTabs(adventureGuideFrame)
    end
end
