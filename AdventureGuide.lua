-- Load libraries
local AceGUI = LibStub("AceGUI-3.0")

-- Addon variables
local addonName = "AdventureGuide"

local playerName = UnitName("player")
local _, playerClass = UnitClass("player")
local classColor = RAID_CLASS_COLORS[playerClass] or {r = 1, g = 1, b = 1} -- default to white if not found
playerName = format("|cff%02x%02x%02x%s|r", classColor.r*255, classColor.g*255, classColor.b*255, playerName)



-- Create the main addon frame
local addonFrame = AceGUI:Create("Frame")
addonFrame:SetTitle("Adventure Guide")
addonFrame:SetWidth(1031)
addonFrame:SetHeight(661)
addonFrame:SetLayout("Fill")
addonFrame:SetPoint("CENTER")
addonFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)

-- Create the TabGroup
local tab =  AceGUI:Create("TabGroup")
tab:SetLayout("Flow")

-- Setup which tabs to show
tab:SetTabs({{text="Suggested Content", value="tab1"}, {text="Dungeons", value="tab2"}, {text="Raids", value="tab3"}})

-- Register callback
tab:SetCallback("OnGroupSelected", function(container, event, group)
    if group == "tab1" then
        -- Update content for Tab 1
        container:ReleaseChildren() -- Clear existing content

        -- Suggested Content header
        local label = AceGUI:Create("Label")
        label:SetFont("Fonts\\FRIZQT__.TTF", 25, nil)
        label:SetColor(1, 1, 0)
        label:SetText("\nSuggested Content\n")
        label:SetFullWidth(true)
        label:SetFullHeight(true)
        container:AddChild(label)

        -- Create an InlineGroup for Suggested Content
        local contentGroup = AceGUI:Create("InlineGroup")
        contentGroup:SetLayout("Flow")
        contentGroup:SetFullWidth(true)
        contentGroup:SetFullHeight(true)
        container:AddChild(contentGroup)

        local content = contentGroup.content:GetParent()
        content:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            title = true, tileSize = 16, edgeSize = 12,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        content:SetBackdropColor(0, 0, 0, 0.8)
        content:SetBackdropBorderColor(0, 0, 0, 1)

        local content = addonFrame.content:GetParent()
        content:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            title = true, tileSize = 16, edgeSize = 12,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        content:SetBackdropColor(0, 0, 0, 0.8)
        content:SetBackdropBorderColor(0, 0, 0, 1)

        -- Create a label for the suggested content description
        local descriptionLabel = AceGUI:Create("Label")
        descriptionLabel:SetFont("Fonts\\FRIZQT__.TTF", 12, nil)
        descriptionLabel:SetText("Welcome " .. playerName .. "!\n\nI hope you find this addon valuable as you embark on your journey in Azeroth, whether you're a seasoned veteran of the Classic Era or just starting out. In this section, you'll find options below to kickstart your leveling journey. Make sure to revisit this section as you progress through the game to receive suggestions for leveling zones that are appropriate for your level range, as well as information on dungeons and raids that are accessible to you.")
        descriptionLabel:SetRelativeWidth(1)
        contentGroup:AddChild(descriptionLabel)

        -- Add padding to the description label
        local paddingFrame = AceGUI:Create("Label")
        paddingFrame:SetWidth(1)
        paddingFrame:SetFullHeight(true)
        paddingFrame:SetUserData("marginLeft", 0)
        paddingFrame:SetUserData("marginTop", -10)
        contentGroup:AddChild(paddingFrame)

        -- Create a label for the suggested content
        local suggestedContentLabel = AceGUI:Create("Label")
        suggestedContentLabel:SetFont("Fonts\\FRIZQT__.TTF", 12, nil)
        suggestedContentLabel:SetText("\n  Suggested Content goes here..")
        suggestedContentLabel:SetPoint("TOPLEFT", -10, -10)
        suggestedContentLabel:SetFullWidth(true)
        suggestedContentLabel:SetRelativeWidth(1)
        suggestedContentLabel:SetHeight(40)
        container:AddChild(suggestedContentLabel)

        container:SetLayout("List")
    elseif group == "tab2" then
        -- Update content for Tab 2
        container:ReleaseChildren() -- Clear existing content
        local label = AceGUI:Create("Label")
        label:SetFont("Fonts\\FRIZQT__.TTF", 25, nil)
        label:SetColor(1, 1, 0)
        label:SetText("\n Dungeons")
        label:SetFullWidth(true)
        label:SetFullHeight(true)
        container:AddChild(label)

        local contentGroup = AceGUI:Create("InlineGroup")
        contentGroup:SetLayout("Flow")
        contentGroup:SetFullWidth(true)
        contentGroup:SetFullHeight(true)
        container:AddChild(contentGroup)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\bfd.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)
        dungeonTexture:SetCallback("OnClick", function()
            container:ReleaseChildren()

            local label = AceGUI:Create("Label")
            label:SetFont("Fonts\\FRIZQT__.TTF", 25, nil)
            label:SetColor(1, 1, 0)
            label:SetText("\n Blackfathom Deeps")
            label:SetFullWidth(true)
            label:SetFullHeight(true)
            container:AddChild(label)

            local outerGroup = AceGUI:Create("InlineGroup")
            -- outerGroup:SetRelativeWidth(1.0)
            outerGroup:SetFullHeight(true)
            outerGroup:SetFullWidth(true)
            outerGroup:SetLayout("Flow")
            container:AddChild(outerGroup)
            
            local leftBox = AceGUI:Create("InlineGroup")
            leftBox:SetWidth(400)
            leftBox:SetHeight(400)
            leftBox:SetLayout("Flow")
            leftBox.frame:SetPoint("TOPLEFT", outerGroup.frame, "TOPLEFT", 0, 0)
            leftBox.frame:SetPoint("BOTTOMLEFT", outerGroup.frame, "BOTTOMLEFT", 0, 0)
            outerGroup:AddChild(leftBox)

            local content = leftBox.content:GetParent()
            content:SetBackdrop({
                bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                title = true, tileSize = 16, edgeSize = 12,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            content:SetBackdropColor(0, 0, 0, 0.8)
            content:SetBackdropBorderColor(0, 0, 0, 1)

            local grButton = AceGUI:Create("Button")
            grButton:SetText("Ghamoo-Ra")
            grButton:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, 0)
            leftBox:AddChild(grButton)

            local lsButton = AceGUI:Create("Button")
            lsButton:SetText("Lady Sarevess")
            lsButton:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, 0)
            leftBox:AddChild(lsButton)

            local gelButton = AceGUI:Create("Button")
            gelButton:SetText("Gelihast")
            gelButton:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, 0)
            leftBox:AddChild(gelButton)

            local tlkButton = AceGUI:Create("Button")
            tlkButton:SetText("Twilight Lord Kelris")
            tlkButton:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, 0)
            leftBox:AddChild(tlkButton)

            local oskButton = AceGUI:Create("Button")
            oskButton:SetText("Old Serra'Kis")
            oskButton:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, 0)
            leftBox:AddChild(oskButton)

            local akButton = AceGUI:Create("Button")
            akButton:SetText("Aku'Mai")
            akButton:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, 0)
            leftBox:AddChild(akButton)

            local rightBox = AceGUI:Create("InlineGroup")
            rightBox:SetWidth(550)
            rightBox:SetHeight(215)
            rightBox:SetLayout("Flow")
            outerGroup:AddChild(rightBox)
            rightBox.frame:SetPoint("TOPRIGHT", outerGroup.frame, "TOPRIGHT", 0, 0)
            rightBox.frame:SetPoint("BOTTOMRIGHT", outerGroup.frame, "BOTTOMRIGHT", 0, 0)

            local content = rightBox.content:GetParent()
            content:SetBackdrop({
                bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                title = true, tileSize = 16, edgeSize = 12,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            content:SetBackdropColor(0, 0, 0, 0.8)
            content:SetBackdropBorderColor(0, 0, 0, 1)

            local bfdMap = AceGUI:Create("Icon")
            bfdMap:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\bfd-map.blp")
            bfdMap:SetImageSize(256, 128)
            bfdMap:SetRelativeWidth(1)
            bfdMap:SetPoint("CENTER", container.frame, "CENTER", 0, -10)
            rightBox:AddChild(bfdMap)

            local label = AceGUI:Create("Label")
            label:SetFont("Fonts\\FRIZQT__.TTF", 12, nil)
            label:SetText("\nBlackfathom Deeps, found in Ashenvale, is a dungeon suitable for levels 24-32. To enter, one must swim through an underwater entrance leading to a stair-lined shaft. The dungeon consists of a network of watery caverns that eventually lead to a temple dedicated to the hydra known as Aku'mai.")
            label:SetFullWidth(true)
            label:SetFullHeight(true)
            rightBox:AddChild(label)

            grButton:SetCallback("OnClick", function ()
                rightBox:ReleaseChildren()
                
                local bfdMap = AceGUI:Create("Icon")
                bfdMap:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\bfd-1.blp")
                bfdMap:SetImageSize(256, 128)
                bfdMap:SetRelativeWidth(1)
                bfdMap:SetPoint("CENTER", container.frame, "CENTER", 0, -10)
                rightBox:AddChild(bfdMap)

                local label = AceGUI:Create("Label")
                label:SetFont("Fonts\\FRIZQT__.TTF", 12, nil)
                label:SetText("\nGhamoo-Ra is a level 25 elite Turtle located in BFD. He is the first boss of the dungeon.\n\nGhamoo-ra is a simple tank and spank with a catch. The boss has a tremendous amount of armor and takes significantly reduced damage. Every so often, he will cast his primary ability, so make sure to stay spread out.")
                label:SetFullWidth(true)
                label:SetFullHeight(true)
                rightBox:AddChild(label)

            end)

            lsButton:SetCallback("OnClick", function ()
                rightBox:ReleaseChildren()

                local bfdMap = AceGUI:Create("Icon")
                bfdMap:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\bfd-2.blp")
                bfdMap:SetImageSize(256, 128)
                bfdMap:SetRelativeWidth(1)
                bfdMap:SetPoint("CENTER", container.frame, "CENTER", 0, -10)
                rightBox:AddChild(bfdMap)

                local label = AceGUI:Create("Label")
                label:SetFont("Fonts\\FRIZQT__.TTF", 12, nil)
                label:SetText("\nLady Sarevess is a level 25 Elite Naga located in the north west cave following Ghamoo-ra. She patrols her save with 2 other Naga.\n\nSarevess patrols the area with 2 other Naga. Make sure to clear out the cave before pulling her and her 2 bodyguards. Make sure to CC at least one of the bodyguards before engaging. Focus the add down, siwtch to Sarevess.")
                label:SetFullWidth(true)
                label:SetFullHeight(true)
                rightBox:AddChild(label)
            end)

            gelButton:SetCallback("OnClick", function ()
                rightBox:ReleaseChildren()

                local bfdMap = AceGUI:Create("Icon")
                bfdMap:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\bfd-3.blp")
                bfdMap:SetImageSize(256, 128)
                bfdMap:SetRelativeWidth(1)
                bfdMap:SetPoint("CENTER", container.frame, "CENTER", 0, -10)
                rightBox:AddChild(bfdMap)

                local label = AceGUI:Create("Label")
                label:SetFont("Fonts\\FRIZQT__.TTF", 12, nil)
                label:SetText("\nGelihast is a level 26 Murlock located in a cave in BFD. He is an optional boss.\n\nGelihast is a straight forward encounter with a small twist - his room is packed with Murlocs. While the fight with Geli requires no explaination, you must be very careful when pulling the adds around the room prior to pulling the boss. Gelihast has a nasty net ability which can leave your tank in an awkward position to subsequently pull additional mobs, so it is crucial that you clear his room first before you pull him. Once he's dead, click on the latar behind him for a small buff.")
                label:SetFullWidth(true)
                label:SetFullHeight(true)
                rightBox:AddChild(label)
            end)

            tlkButton:SetCallback("OnClick", function ()
                rightBox:ReleaseChildren()

                local bfdMap = AceGUI:Create("Icon")
                bfdMap:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\bfd-4.blp")
                bfdMap:SetImageSize(256, 128)
                bfdMap:SetRelativeWidth(1)
                bfdMap:SetPoint("CENTER", container.frame, "CENTER", 0, -10)
                rightBox:AddChild(bfdMap)

                local label = AceGUI:Create("Label")
                label:SetFont("Fonts\\FRIZQT__.TTF", 12, nil)
                label:SetText("\nTwilight Lord Kelris is a level 27 Elite Orc located in the pen-ultimate room of BFD.\n\nKelris is not a paricular dangerous boss, although his sleep ability may catch your healer off guard. Make sure to keep the tank topped off in the event the healer is slept, and have all hybrid classes heal the tank if such an event happens.\n\nEvent - Fire of Aku'Mai\n\nThe Fire of Aku'Mai event is a small event after lord Kelris that is required to open the door to the final boss of BFD, Aku'Mai. At the base of the Azshara statue where Kelris channels his magic, there are four braziers positioned in each corner of the statue's pedestal. Once Kelris is dead and the room is clear, have your tank click on ONE brazier, activating a single wave of the event. Each wave spawns a series of mobs that need to be killed. The first wave, the turtle wave, is the most difficult. The turtles do a remendous amount of damage and require an offtank to pick one of them up, otherwise your tank will die. Pet classes and rogue evasion tanks are very useful here. After a wave is complete, make sure to top off your group in health and mana before clicking the next brazier. All 4 braziers and subsequently all 4 waves must be conquered before the door to Aku'Mai's lair opens.")
                label:SetFullWidth(true)
                label:SetFullHeight(true)
                rightBox:AddChild(label)
            end)

            oskButton:SetCallback("OnClick", function ()
                rightBox:ReleaseChildren()

                local bfdMap = AceGUI:Create("Icon")
                bfdMap:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\bfd-5.blp")
                bfdMap:SetImageSize(256, 128)
                bfdMap:SetRelativeWidth(1)
                bfdMap:SetPoint("CENTER", container.frame, "CENTER", 0, -10)
                rightBox:AddChild(bfdMap)

                local label = AceGUI:Create("Label")
                label:SetFont("Fonts\\FRIZQT__.TTF", 12, nil)
                label:SetText("\nOld Serra'kis is a level 26 Elite Loch Ness monster located near the end of BFD.\n\nSerra'kis is an optional loot pinata with no real abilites. The only thing you should be mindful of is your breath meter while under water.")
                label:SetFullWidth(true)
                label:SetFullHeight(true)
                rightBox:AddChild(label)
            end)

            akButton:SetCallback("OnClick", function ()
                rightBox:ReleaseChildren()

                local bfdMap = AceGUI:Create("Icon")
                bfdMap:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\bfd-6.blp")
                bfdMap:SetImageSize(256, 128)
                bfdMap:SetRelativeWidth(1)
                bfdMap:SetPoint("CENTER", container.frame, "CENTER", 0, -10)
                rightBox:AddChild(bfdMap)

                local label = AceGUI:Create("Label")
                label:SetFont("Fonts\\FRIZQT__.TTF", 12, nil)
                label:SetText("\nAku'Mai is the level 28 Elite hydra located at the end of BFD.\n\nAku'Mai is a tank and spank with massive single target damage due to his frenzy ability. Make sure to stay away from his poison cloud so the healer can focus heals on the tank. Hybrid classes should offer healing assistance here if possible, and the tank should use a health pot if he has one. Overall, this is a very simple fight.")
                label:SetFullWidth(true)
                label:SetFullHeight(true)
                rightBox:AddChild(label)
            end)
            
            local backButton = AceGUI:Create("Button")
            backButton:SetText("Back")
            backButton:SetRelativeWidth(0.1)
            backButton:SetPoint("BOTTOMLEFT", container.frame, "BOTTOMLEFT", -100, 0)
            backButton:SetCallback("OnClick", function ()
                container:ReleaseChildren()
                tab:SelectTab("tab2")
            end)
            container:AddChild(backButton)

            local fillingGroup = AceGUI:Create("Button")
            fillingGroup:SetText("Back")
            fillingGroup:SetHeight(190)
            fillingGroup.frame:SetAlpha(0.0)
            fillingGroup:SetFullWidth(true)
            outerGroup:AddChild(fillingGroup)
            fillingGroup:SetPoint("BOTTOMLEFT", container.frame, "BOTTOMLEFT", -100, 0)
        end)
        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\brd.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\dm.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\drm.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\gnome.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\lbrs.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\mara.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\rfc.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\rfd.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\rfk.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\sh.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\sm.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\scholo.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\sfk.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\strat.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\stocks.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\temple.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\uld.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\wc.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local dungeonTexture = AceGUI:Create("Icon")
        dungeonTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Textures\\zf.blp")
        dungeonTexture:SetImageSize(172, 94)
        dungeonTexture:SetRelativeWidth(0.2)
        dungeonTexture:SetPoint("TOPLEFT", container.frame, "TOPLEFT", 0, -10)
        contentGroup:AddChild(dungeonTexture)

        local paddingFrame = AceGUI:Create("Label")
        paddingFrame:SetWidth(1)
        paddingFrame:SetFullHeight(true)
        paddingFrame:SetUserData("marginLeft", 0)
        paddingFrame:SetUserData("marginTop", 0)
        contentGroup:AddChild(paddingFrame)
    elseif group == "tab3" then
        -- Update content for Tab 3
        container:ReleaseChildren() -- Clear existing content
        local label = AceGUI:Create("Label")
        label:SetFont("Fonts\\FRIZQT__.TTF", 20, nil)
        label:SetColor(1, 1, 0)
        label:SetText("Raids")
        label:SetFullWidth(true)
        label:SetFullHeight(true)
        container:AddChild(label)
    end
end)

-- Set initial Tab (this will fire the OnGroupSelected callback)
tab:SelectTab("tab1")

-- Add the tab group to the main addon frame
addonFrame:AddChild(tab)

-- Show the main addon frame
addonFrame:Show()

-- Minimap button
local miniMapButton = CreateFrame("Button", addonName .. "miniMapButton", Minimap)
miniMapButton:SetSize(32, 32)
miniMapButton:SetFrameStrata("MEDIUM")
miniMapButton:SetFrameLevel(0)
miniMapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 54 - (80 * cos(225)), (80 * sin(225)) - 54)
miniMapButton:SetNormalTexture("Interface/PLAYERFRAME/UI-PlayerFrame-Deathknight-SingleRune")
miniMapButton:SetScript("OnClick", function ()
    if addonFrame:IsShown() then
        addonFrame:Hide()
    end
end)