-- Load libraries
local AceGUI = LibStub("AceGUI-3.0")

local function DrawSuggestedContentTab(container)
    local scrollContainer = AceGUI:Create("SimpleGroup")
    scrollContainer:SetFullWidth(true)
    scrollContainer:SetFullHeight(true)
    scrollContainer:SetLayout("Fill")
    tabContainer:AddChild(scrollContainer)

    local scrollFrame = AceGUI:Create("ScrollFrame")
    scrollFrame:SetLayout("Flow")
    scrollContainer:AddChild(scrollFrame)
    
    local suggestedContentDescriptionTitle = AceGUI:Create("Label")
    suggestedContentDescriptionTitle:SetWidth(500)
    suggestedContentDescriptionTitle:SetText("Suggested Content")
    suggestedContentDescriptionTitle:SetFont("Fonts\\FRIZQT__.TTF", 25, nil)
    suggestedContentDescriptionTitle:SetColor(1, 1, 0)
    scrollFrame:AddChild(suggestedContentDescriptionTitle)

end


-- Create the main addon frame
local addonFrame = AceGUI:Create("Frame")
addonFrame:SetTitle("Adventure Guide")
addonFrame:SetWidth(900)
addonFrame:SetHeight(600)
addonFrame:SetLayout("Fill")
addonFrame:SetPoint("CENTER")
addonFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)

-- Create tabContainerGroup
tabContainer = AceGUI:Create("TabGroup")
local tabTable = {
    { value = "SuggestedContentTab", text = "Suggested Content" },
    { value = "DungeonsTab", text = "Dungeons" },
    { value = "RaidsTab", text = "Raids" },
}

tabContainer:SetTabs(tabTable)
tabContainer:SetFullWidth(true)
tabContainer:SetFullHeight(true)
tabContainer:SetLayout("Flow")
addonFrame:AddChild(tabContainer)

local function SelectGroup(container, event, group)
    container:ReleaseChildren()
    if group == "SuggestedContentTab" then
        DrawSuggestedContentTab(container)
    end
end

tabContainer:SetCallback("OnGroupSelected", SelectGroup)
tabContainer:SelectTab("SuggestedContentTab")

