-- Load libraries
local AceGUI = LibStub("AceGUI-3.0")

-- Addon variables
local playerName = UnitName("player")

-- Create a table to store dungeon and raid information
local dungeons = {
    {
        name = "Blackfathom Deeps",
        overview = "Once dedicated to the night elves' goddess Elune, Blackfathom Deeps was thought to have been destroyed during the Sundering, lost beneath the ocean. Millennia later, members of the Twilight's Hammer cult were drawn to the temple by whispers and foul dreams. After sacrificing untold numbers of innocents, the cult was rewarded with a new task: to protect one of the Old Gods' most cherished creatures, a pet that is still in need of nurturing before he can unleash his dark powers on the world.\n\nThis dungeon is recommended between (24 - 32)",
        bosses = {"Ghamoo-Ra",
                  "Lady Sarevess",
                  "Gelihast",
                  "Baron Aquanis",
                  "Twilight Lord Kelris",
                  "Old Serra'kis",
                  "Aku'mai"},
        bossInfo = {"Ghamoo-Ra\n\nWhen the Twilight's Hammer cult arrived, its followers roused and imprisoned one of the last peaceful creatures living in Elune's temple. The cult delighted in tormenting the giant turtle for years, flaying its mind and body until it succumbed to madness. Naming the beast Ghamoo-Ra, the cultists attempt to control its savagery in order to protect their lair.",
                    "Lady Sarevess\n\nNext boss information"},
    },
    {
        name = "Blackrock Depths",
        overview = "Text to go here",
        bosses = {"Boss 1"}
    }
}
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

        local bfdTexture = AceGUI:Create("Icon")
        bfdTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Media\\bfd.blp")
        bfdTexture:SetImageSize(140, 100)
        bfdTexture:SetText("Blackfathom Deeps")
        bfdTexture:SetRelativeWidth(1)
        bfdTexture:SetPoint("LEFT", container.frame, "LEFT", 0, -0)
        contentGroup:AddChild(bfdTexture)

        local bfdTexture = AceGUI:Create("Icon")
        bfdTexture:SetImage("Interface\\AddOns\\AdventureGuide\\Media\\brf.blp")
        bfdTexture:SetImageSize(140, 100)
        bfdTexture:SetText("Blackrock Depths")
        bfdTexture:SetRelativeWidth(1)
        bfdTexture:SetPoint("LEFT", container.frame, "LEFT", 0, -0)
        contentGroup:AddChild(bfdTexture)

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
