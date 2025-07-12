-- UI Library
local UI = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Constants
local EASING_STYLE = Enum.EasingStyle.Quint
local EASING_DIRECTION = Enum.EasingDirection.Out
local TRANSITION_TIME = 0.5
local DRAG_SPEED = 1

-- UI Assets
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UILibrary"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screenGui.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Loading Screen
local loadingFrame = Instance.new("Frame")
loadingFrame.Name = "LoadingFrame"
loadingFrame.Size = UDim2.new(0, 300, 0, 150)
loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
loadingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
loadingFrame.BorderSizePixel = 0
loadingFrame.ZIndex = 100
loadingFrame.Parent = screenGui

local loadingCorner = Instance.new("UICorner")
loadingCorner.CornerRadius = UDim.new(0, 6)
loadingCorner.Parent = loadingFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Title Here"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = loadingFrame

local status = Instance.new("TextLabel")
status.Name = "Status"
status.Size = UDim2.new(1, -20, 0, 20)
status.Position = UDim2.new(0, 10, 0, 50)
status.BackgroundTransparency = 1
status.Text = "UI Initialization [ Downloading ]"
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = loadingFrame

local progressBarBackground = Instance.new("Frame")
progressBarBackground.Name = "ProgressBarBackground"
progressBarBackground.Size = UDim2.new(1, -20, 0, 10)
progressBarBackground.Position = UDim2.new(0, 10, 0, 80)
progressBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
progressBarBackground.BorderSizePixel = 0
progressBarBackground.Parent = loadingFrame

local progressBar = Instance.new("Frame")
progressBar.Name = "ProgressBar"
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
progressBar.BorderSizePixel = 0
progressBar.Parent = progressBarBackground

local progressText = Instance.new("TextLabel")
progressText.Name = "ProgressText"
progressText.Size = UDim2.new(1, -20, 0, 20)
progressText.Position = UDim2.new(0, 10, 0, 100)
progressText.BackgroundTransparency = 1
progressText.Text = "0%"
progressText.TextColor3 = Color3.fromRGB(200, 200, 200)
progressText.Font = Enum.Font.Gotham
progressText.TextSize = 14
progressText.TextXAlignment = Enum.TextXAlignment.Right
progressText.Parent = loadingFrame

-- Main UI Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 400)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainFrameCorner = Instance.new("UICorner")
mainFrameCorner.CornerRadius = UDim.new(0, 6)
mainFrameCorner.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(0, 200, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Script Name"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 14
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.Parent = titleBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 1, 0)
minimizeButton.Position = UDim2.new(1, -60, 0, 0)
minimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 14
minimizeButton.Parent = titleBar

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 120, 1, -30)
sidebar.Position = UDim2.new(0, 0, 0, 30)
sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

local tabsContainer = Instance.new("ScrollingFrame")
tabsContainer.Name = "TabsContainer"
tabsContainer.Size = UDim2.new(1, 0, 1, -40)
tabsContainer.Position = UDim2.new(0, 0, 0, 0)
tabsContainer.BackgroundTransparency = 1
tabsContainer.BorderSizePixel = 0
tabsContainer.ScrollBarThickness = 4
tabsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
tabsContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
tabsContainer.Parent = sidebar

local settingsTabDivider = Instance.new("Frame")
settingsTabDivider.Name = "SettingsTabDivider"
settingsTabDivider.Size = UDim2.new(0.8, 0, 0, 1)
settingsTabDivider.Position = UDim2.new(0.1, 0, 1, -40)
settingsTabDivider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
settingsTabDivider.BorderSizePixel = 0
settingsTabDivider.Parent = sidebar

local settingsTab = Instance.new("TextButton")
settingsTab.Name = "SettingsTab"
settingsTab.Size = UDim2.new(1, 0, 0, 40)
settingsTab.Position = UDim2.new(0, 0, 1, -40)
settingsTab.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
settingsTab.BorderSizePixel = 0
settingsTab.Text = "Settings"
settingsTab.TextColor3 = Color3.fromRGB(200, 200, 200)
settingsTab.Font = Enum.Font.Gotham
settingsTab.TextSize = 14
settingsTab.Parent = sidebar

-- Main Content
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -120, 1, -30)
contentFrame.Position = UDim2.new(0, 120, 0, 30)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

local tabContentContainer = Instance.new("Frame")
tabContentContainer.Name = "TabContentContainer"
tabContentContainer.Size = UDim2.new(1, 0, 1, 0)
tabContentContainer.BackgroundTransparency = 1
tabContentContainer.Parent = contentFrame

-- UI Functions
local function tween(obj, props, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(duration or TRANSITION_TIME, easingStyle or EASING_STYLE, easingDirection or EASING_DIRECTION)
    local tween = TweenService:Create(obj, tweenInfo, props)
    tween:Play()
    return tween
end

local function createRippleEffect(button)
    local ripple = Instance.new("Frame")
    ripple.Name = "Ripple"
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.8
    ripple.ZIndex = 10
    ripple.Parent = button
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ripple
    
    tween(ripple, {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 1}, 0.5):Play()
    
    game:GetService("Debris"):AddItem(ripple, 0.5)
end

-- Loading Functions
function UI:SetLoadingProgress(percent)
    progressBar.Size = UDim2.new(percent / 100, 0, 1, 0)
    progressText.Text = math.floor(percent) .. "%"
end

function UI:CompleteLoading()
    local fadeTween = tween(loadingFrame, {BackgroundTransparency = 1}, 0.5)
    
    local moveTween = tween(loadingFrame, {
        Position = UDim2.new(0.5, -loadingFrame.AbsoluteSize.X/2, -1, 0)
    }, 0.5)
    
    moveTween.Completed:Connect(function()
        loadingFrame.Visible = false
        UI:ShowMainUI()
    end)
end

-- Main UI Functions
function UI:ShowMainUI()
    mainFrame.Visible = true
    mainFrame.Position = UDim2.new(0.5, -250, 1.5, -200)
    mainFrame.BackgroundTransparency = 1
    
    tween(mainFrame, {
        Position = UDim2.new(0.5, -250, 0.5, -200),
        BackgroundTransparency = 0
    })
end

function UI:HideMainUI(instant)
    if instant then
        mainFrame.Visible = false
    else
        tween(mainFrame, {
            Position = UDim2.new(0.5, -250, 1.5, -200),
            BackgroundTransparency = 1
        }).Completed:Connect(function()
            mainFrame.Visible = false
        end)
    end
end

-- Tab Management
local tabs = {}
local currentTab = nil

function UI:AddTab(name, icon)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name .. "Tab"
    tabButton.Size = UDim2.new(1, -10, 0, 40)
    tabButton.Position = UDim2.new(0, 5, 0, #tabs * 40)
    tabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    tabButton.BorderSizePixel = 0
    tabButton.Text = name
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 14
    tabButton.Parent = tabsContainer
    
    if icon then
        local iconImage = Instance.new("ImageLabel")
        iconImage.Name = "Icon"
        iconImage.Size = UDim2.new(0, 20, 0, 20)
        iconImage.Position = UDim2.new(0, 10, 0.5, -10)
        iconImage.BackgroundTransparency = 1
        iconImage.Image = icon
        iconImage.Parent = tabButton
        
        tabButton.TextXAlignment = Enum.TextXAlignment.Left
        tabButton.Text = "   " .. name
    end
    
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = name .. "Content"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.ScrollBarThickness = 4
    tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabContent.Parent = tabContentContainer
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Name = "Layout"
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Parent = tabContent
    
    local tab = {
        name = name,
        button = tabButton,
        content = tabContent
    }
    
    table.insert(tabs, tab)
    
    tabButton.MouseButton1Click:Connect(function()
        UI:SwitchTab(tab)
    end)
    
    if #tabs == 1 then
        UI:SwitchTab(tab)
    end
    
    return tab
end

function UI:SwitchTab(tab)
    if currentTab then
        currentTab.content.Visible = false
        tween(currentTab.button, {BackgroundColor3 = Color3.fromRGB(35, 35, 45)})
    end
    
    currentTab = tab
    tab.content.Visible = true
    tween(tab.button, {BackgroundColor3 = Color3.fromRGB(50, 50, 60)})
end

-- UI Elements
function UI:CreateSector(tab, name, side)
    local sector = Instance.new("Frame")
    sector.Name = name .. "Sector"
    sector.Size = UDim2.new(side == "right" and 0.48 or 0.48, 0, 0, 0)
    sector.Position = UDim2.new(side == "right" and 0.52 or 0, 0, 0, 0)
    sector.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    sector.BorderSizePixel = 0
    sector.AutomaticSize = Enum.AutomaticSize.Y
    sector.Parent = tab.content
    
    local sectorCorner = Instance.new("UICorner")
    sectorCorner.CornerRadius = UDim.new(0, 6)
    sectorCorner.Parent = sector
    
    local sectorTitle = Instance.new("TextLabel")
    sectorTitle.Name = "Title"
    sectorTitle.Size = UDim2.new(1, -20, 0, 30)
    sectorTitle.Position = UDim2.new(0, 10, 0, 0)
    sectorTitle.BackgroundTransparency = 1
    sectorTitle.Text = name
    sectorTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    sectorTitle.Font = Enum.Font.GothamBold
    sectorTitle.TextSize = 16
    sectorTitle.Parent = sector
    
    local sectorContent = Instance.new("Frame")
    sectorContent.Name = "Content"
    sectorContent.Size = UDim2.new(1, -10, 0, 0)
    sectorContent.Position = UDim2.new(0, 5, 0, 35)
    sectorContent.BackgroundTransparency = 1
    sectorContent.AutomaticSize = Enum.AutomaticSize.Y
    sectorContent.Parent = sector
    
    local sectorLayout = Instance.new("UIListLayout")
    sectorLayout.Name = "Layout"
    sectorLayout.Padding = UDim.new(0, 5)
    sectorLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sectorLayout.Parent = sectorContent
    
    return sectorContent
end

function UI:CreateButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Name = text .. "Button"
    button.Size = UDim2.new(1, 0, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = parent
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        createRippleEffect(button)
        if callback then
            callback()
        end
    end)
    
    return button
end

function UI:CreateToggle(parent, text, default, callback)
    local toggle = Instance.new("Frame")
    toggle.Name = text .. "Toggle"
    toggle.Size = UDim2.new(1, 0, 0, 30)
    toggle.BackgroundTransparency = 1
    toggle.Parent = parent
    
    local toggleText = Instance.new("TextLabel")
    toggleText.Name = "Text"
    toggleText.Size = UDim2.new(0.7, 0, 1, 0)
    toggleText.BackgroundTransparency = 1
    toggleText.Text = text
    toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleText.Font = Enum.Font.Gotham
    toggleText.TextSize = 14
    toggleText.TextXAlignment = Enum.TextXAlignment.Left
    toggleText.Parent = toggle
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "Toggle"
    toggleButton.Size = UDim2.new(0, 50, 0, 25)
    toggleButton.Position = UDim2.new(1, -50, 0.5, -12.5)
    toggleButton.BackgroundColor3 = default and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(70, 70, 80)
    toggleButton.Text = ""
    toggleButton.Parent = toggle
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = toggleButton
    
    local toggleSwitch = Instance.new("Frame")
    toggleSwitch.Name = "Switch"
    toggleSwitch.Size = UDim2.new(0, 21, 0, 21)
    toggleSwitch.Position = default and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
    toggleSwitch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleSwitch.Parent = toggleButton
    
    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(0, 12)
    switchCorner.Parent = toggleSwitch
    
    toggleButton.MouseButton1Click:Connect(function()
        local newValue = not (toggleButton.BackgroundColor3 == Color3.fromRGB(100, 150, 255))
        
        tween(toggleButton, {
            BackgroundColor3 = newValue and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(70, 70, 80)
        })
        
        tween(toggleSwitch, {
            Position = newValue and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
        })
        
        if callback then
            callback(newValue)
        end
    end)
    
    return {
        Set = function(value)
            tween(toggleButton, {
                BackgroundColor3 = value and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(70, 70, 80)
            })
            
            tween(toggleSwitch, {
                Position = value and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
            })
        end,
        Get = function()
            return toggleButton.BackgroundColor3 == Color3.fromRGB(100, 150, 255)
        end
    }
end

function UI:CreateDropdown(parent, text, options, default, callback, multiSelect)
    local dropdown = Instance.new("Frame")
    dropdown.Name = text .. "Dropdown"
    dropdown.Size = UDim2.new(1, 0, 0, 30)
    dropdown.BackgroundTransparency = 1
    dropdown.ClipsDescendants = true
    dropdown.Parent = parent
    
    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Name = "Button"
    dropdownButton.Size = UDim2.new(1, 0, 0, 30)
    dropdownButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    dropdownButton.Text = text .. ": " .. (multiSelect and "Select..." or options[default or 1])
    dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownButton.Font = Enum.Font.Gotham
    dropdownButton.TextSize = 14
    dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
    dropdownButton.Parent = dropdown
    
    local buttonPadding = Instance.new("UIPadding")
    buttonPadding.PaddingLeft = UDim.new(0, 10)
    buttonPadding.Parent = dropdownButton
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = dropdownButton
    
    local dropdownArrow = Instance.new("ImageLabel")
    dropdownArrow.Name = "Arrow"
    dropdownArrow.Size = UDim2.new(0, 15, 0, 15)
    dropdownArrow.Position = UDim2.new(1, -20, 0.5, -7.5)
    dropdownArrow.BackgroundTransparency = 1
    dropdownArrow.Image = "rbxassetid://6031090990"
    dropdownArrow.Parent = dropdownButton
    
    local dropdownOptions = Instance.new("Frame")
    dropdownOptions.Name = "Options"
    dropdownOptions.Size = UDim2.new(1, 0, 0, 0)
    dropdownOptions.Position = UDim2.new(0, 0, 0, 35)
    dropdownOptions.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    dropdownOptions.Visible = false
    dropdownOptions.Parent = dropdown
    
    local optionsCorner = Instance.new("UICorner")
    optionsCorner.CornerRadius = UDim.new(0, 4)
    optionsCorner.Parent = dropdownOptions
    
    local optionsLayout = Instance.new("UIListLayout")
    optionsLayout.Padding = UDim.new(0, 2)
    optionsLayout.Parent = dropdownOptions
    
    local selected = {}
    if multiSelect then
        selected = {}
    else
        selected[1] = options[default or 1]
    end
    
    local function updateText()
        if multiSelect then
            if #selected == 0 then
                dropdownButton.Text = text .. ": Select..."
            elseif #selected == 1 then
                dropdownButton.Text = text .. ": " .. selected[1]
            else
                dropdownButton.Text = text .. ": " .. #selected .. " selected"
            end
        else
            dropdownButton.Text = text .. ": " .. selected[1]
        end
    end
    
    local function createOption(option)
        local optionButton = Instance.new("TextButton")
        optionButton.Name = option
        optionButton.Size = UDim2.new(1, -10, 0, 25)
        optionButton.Position = UDim2.new(0, 5, 0, 0)
        optionButton.BackgroundColor3 = (not multiSelect and selected[1] == option) and Color3.fromRGB(70, 100, 150) or Color3.fromRGB(60, 60, 70)
        optionButton.Text = option
        optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        optionButton.Font = Enum.Font.Gotham
        optionButton.TextSize = 14
        optionButton.TextXAlignment = Enum.TextXAlignment.Left
        
        local optionPadding = Instance.new("UIPadding")
        optionPadding.PaddingLeft = UDim.new(0, 10)
        optionPadding.Parent = optionButton
        
        optionButton.MouseButton1Click:Connect(function()
            if multiSelect then
                local found = false
                for i, v in ipairs(selected) do
                    if v == option then
                        table.remove(selected, i)
                        found = true
                        break
                    end
                end
                
                if not found then
                    table.insert(selected, option)
                end
                
                optionButton.BackgroundColor3 = found and Color3.fromRGB(60, 60, 70) or Color3.fromRGB(70, 100, 150)
            else
                selected[1] = option
                dropdownOptions.Visible = false
                tween(dropdownArrow, {Rotation = 0})
                
                for _, child in ipairs(dropdownOptions:GetChildren()) do
                    if child:IsA("TextButton") then
                        child.BackgroundColor3 = child.Name == option and Color3.fromRGB(70, 100, 150) or Color3.fromRGB(60, 60, 70)
                    end
                end
            end
            
            updateText()
            
            if callback then
                if multiSelect then
                    callback(selected)
                else
                    callback(option)
                end
            end
        end)
        
        return optionButton
    end
    
    for _, option in ipairs(options) do
        local optionButton = createOption(option)
        optionButton.Parent = dropdownOptions
    end
    
    dropdownOptions.AutomaticSize = Enum.AutomaticSize.Y
    
    local isOpen = false
    
    dropdownButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        dropdownOptions.Visible = isOpen
        
        if isOpen then
            tween(dropdownArrow, {Rotation = 180})
        else
            tween(dropdownArrow, {Rotation = 0})
        end
    end)
    
    return {
        Set = function(value)
            if multiSelect then
                selected = {}
                for _, option in ipairs(options) do
                    for _, val in ipairs(value) do
                        if option == val then
                            table.insert(selected, option)
                            break
                        end
                    end
                end
                
                for _, child in ipairs(dropdownOptions:GetChildren()) do
                    if child:IsA("TextButton") then
                        local found = false
                        for _, val in ipairs(selected) do
                            if child.Name == val then
                                found = true
                                break
                            end
                        end
                        child.BackgroundColor3 = found and Color3.fromRGB(70, 100, 150) or Color3.fromRGB(60, 60, 70)
                    end
                end
            else
                selected[1] = value
                for _, child in ipairs(dropdownOptions:GetChildren()) do
                    if child:IsA("TextButton") then
                        child.BackgroundColor3 = child.Name == value and Color3.fromRGB(70, 100, 150) or Color3.fromRGB(60, 60, 70)
                    end
                end
            end
            
            updateText()
        end,
        Get = function()
            if multiSelect then
                return selected
            else
                return selected[1]
            end
        end
    }
end

function UI:CreateLabel(parent, text)
    local label = Instance.new("TextLabel")
    label.Name = text .. "Label"
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = parent
    
    return label
end

function UI:CreateSeparator(parent, text)
    local separator = Instance.new("Frame")
    separator.Name = text .. "Separator"
    separator.Size = UDim2.new(1, 0, 0, 20)
    separator.BackgroundTransparency = 1
    separator.Parent = parent
    
    local leftLine = Instance.new("Frame")
    leftLine.Name = "LeftLine"
    leftLine.Size = UDim2.new(0.5, -40, 0, 1)
    leftLine.Position = UDim2.new(0, 0, 0.5, 0)
    leftLine.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
    leftLine.BorderSizePixel = 0
    leftLine.Parent = separator
    
    local rightLine = Instance.new("Frame")
    rightLine.Name = "RightLine"
    rightLine.Size = UDim2.new(0.5, -40, 0, 1)
    rightLine.Position = UDim2.new(0.5, 40, 0.5, 0)
    rightLine.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
    rightLine.BorderSizePixel = 0
    rightLine.Parent = separator
    
    local separatorText = Instance.new("TextLabel")
    separatorText.Name = "Text"
    separatorText.Size = UDim2.new(0, 80, 1, 0)
    separatorText.Position = UDim2.new(0.5, -40, 0, 0)
    separatorText.BackgroundTransparency = 1
    separatorText.Text = text
    separatorText.TextColor3 = Color3.fromRGB(200, 200, 200)
    separatorText.Font = Enum.Font.Gotham
    separatorText.TextSize = 14
    separatorText.Parent = separator
    
    return separator
end

function UI:CreateTextBox(parent, text, placeholder, callback)
    local textBoxFrame = Instance.new("Frame")
    textBoxFrame.Name = text .. "TextBox"
    textBoxFrame.Size = UDim2.new(1, 0, 0, 30)
    textBoxFrame.BackgroundTransparency = 1
    textBoxFrame.Parent = parent
    
    local textBoxLabel = Instance.new("TextLabel")
    textBoxLabel.Name = "Label"
    textBoxLabel.Size = UDim2.new(0.4, 0, 1, 0)
    textBoxLabel.BackgroundTransparency = 1
    textBoxLabel.Text = text
    textBoxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBoxLabel.Font = Enum.Font.Gotham
    textBoxLabel.TextSize = 14
    textBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
    textBoxLabel.Parent = textBoxFrame
    
    local textBox = Instance.new("TextBox")
    textBox.Name = "Box"
    textBox.Size = UDim2.new(0.6, 0, 1, 0)
    textBox.Position = UDim2.new(0.4, 0, 0, 0)
    textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    textBox.Text = ""
    textBox.PlaceholderText = placeholder or ""
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 14
    textBox.Parent = textBoxFrame
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 4)
    boxCorner.Parent = textBox
    
    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and callback then
            callback(textBox.Text)
        end
    end)
    
    return {
        Set = function(value)
            textBox.Text = value
        end,
        Get = function()
            return textBox.Text
        end
    }
end

-- Draggable UI
local dragging = false
local dragInput, dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Close and Minimize Buttons
closeButton.MouseButton1Click:Connect(function()
    createRippleEffect(closeButton)
    
    local confirmation = Instance.new("Frame")
    confirmation.Size = UDim2.new(0, 300, 0, 150)
    confirmation.Position = UDim2.new(0.5, -150, 0.5, -75)
    confirmation.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    confirmation.Parent = screenGui
    
    local confirmationCorner = Instance.new("UICorner")
    confirmationCorner.CornerRadius = UDim.new(0, 6)
    confirmationCorner.Parent = confirmation
    
    local confirmationText = Instance.new("TextLabel")
    confirmationText.Size = UDim2.new(1, -20, 0, 60)
    confirmationText.Position = UDim2.new(0, 10, 0, 10)
    confirmationText.BackgroundTransparency = 1
    confirmationText.Text = "Are you sure you want to close the script?"
    confirmationText.TextColor3 = Color3.fromRGB(255, 255, 255)
    confirmationText.Font = Enum.Font.Gotham
    confirmationText.TextSize = 16
    confirmationText.TextWrapped = true
    confirmationText.Parent = confirmation
    
    local yesButton = Instance.new("TextButton")
    yesButton.Size = UDim2.new(0, 120, 0, 40)
    yesButton.Position = UDim2.new(0.5, -130, 1, -60)
    yesButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    yesButton.Text = "Yes"
    yesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    yesButton.Font = Enum.Font.Gotham
    yesButton.TextSize = 14
    yesButton.Parent = confirmation
    
    local yesCorner = Instance.new("UICorner")
    yesCorner.CornerRadius = UDim.new(0, 4)
    yesCorner.Parent = yesButton
    
    local noButton = Instance.new("TextButton")
    noButton.Size = UDim2.new(0, 120, 0, 40)
    noButton.Position = UDim2.new(0.5, 10, 1, -60)
    noButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    noButton.Text = "No"
    noButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    noButton.Font = Enum.Font.Gotham
    noButton.TextSize = 14
    noButton.Parent = confirmation
    
    local noCorner = Instance.new("UICorner")
    noCorner.CornerRadius = UDim.new(0, 4)
    noCorner.Parent = noButton
    
    yesButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    noButton.MouseButton1Click:Connect(function()
        confirmation:Destroy()
    end)
end)

minimizeButton.MouseButton1Click:Connect(function()
    createRippleEffect(minimizeButton)
    UI:HideMainUI(true)
end)

-- Right Ctrl Toggle
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
        if mainFrame.Visible then
            UI:HideMainUI()
        else
            UI:ShowMainUI()
        end
    end
end)

-- Initialize
UI:SetLoadingProgress(0)
for i = 1, 100 do
    task.wait(0.02)
    UI:SetLoadingProgress(i)
end
task.wait(0.5)
UI:CompleteLoading()

return UI
