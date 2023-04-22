-- Load libraries
local AceGUI = LibStub("AceGUI-3.0")

-- Addon variables
local playerName = UnitName("player")

local addonName = "AdventureGuide"

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

-- -- Minimap button
-- local miniMapButton = CreateFrame("Button", addonName .. "miniMapButton", Minimap)
-- miniMapButton:SetSize(32, 32)
-- miniMapButton:SetFrameStrata("MEDIUM")
-- miniMapButton:SetFrameLevel(0)
-- miniMapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 54 - (80 * cos(225)), (80 * sin(225)) - 54)
-- miniMapButton:SetNormalTexture("Interface/PLAYERFRAME/UI-PlayerFrame-Deathknight-SingleRune")
-- miniMapButton:SetScript("OnClick", function ()
--     if addonFrame:IsShown() then
--         addonFrame:Hide()
--     else
--         addonFrame:Show()
--     end
-- end)