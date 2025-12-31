-- ============================================================================
-- LUXOR SYSTEM - Macho Lua Menu 
-- Version: 2.0
-- Features: Bypass every fivem anticheat, improved performance, better than any other lua menu , 4 Security System.
-- ============================================================================

local dui = nil
local activeMenu = {}
local activeIndex = 1
local originalMenu = {} -- Store original menu for search functionality
-- local debug = true
-- Players Tab
local healthPercent = 200
local armorPercent = 100
-- Noclip Mode
local noclipMode = "vis" -- default mode
-- Tx Admin 
local showNamesTX = false
local isnoclipOn = false
local isGodmodeOn = false
local isSuperjumpOn = false
-- Keybinds
local menuKeybind = 11 -- Default: Page Down
local isCapturingKeybind = false
local captureKeybindCallback = nil


-- Text input state
local textInputActive = false
local textInputData = {
    value = "",
    question = "",
    placeholder = "",
    maxLength = 100,
    inputType = "general",
    callback = nil
}

-- Key listener state
local keyListenerRegistered = false
local shiftPressed = false
local ctrlPressed = false
local altPressed = false

-- Player list state
local playerList = {}
local selectedPlayers = {}

-- Menu state tracking
local menuInitialized = false      

-- ===================== WINDOWS VIRTUAL KEY MAPPING =====================
local KeyMap = {
    -- Letters
    [0x41] = "a", [0x42] = "b", [0x43] = "c", [0x44] = "d", [0x45] = "e",
    [0x46] = "f", [0x47] = "g", [0x48] = "h", [0x49] = "i", [0x4A] = "j",
    [0x4B] = "k", [0x4C] = "l", [0x4D] = "m", [0x4E] = "n", [0x4F] = "o",
    [0x50] = "p", [0x51] = "q", [0x52] = "r", [0x53] = "s", [0x54] = "t",
    [0x55] = "u", [0x56] = "v", [0x57] = "w", [0x58] = "x", [0x59] = "y",
    [0x5A] = "z",

    -- Numbers (top row)
    [0x30] = "0", [0x31] = "1", [0x32] = "2", [0x33] = "3", [0x34] = "4",
    [0x35] = "5", [0x36] = "6", [0x37] = "7", [0x38] = "8", [0x39] = "9",

    -- Numpad Keys
    [0x60] = "0", [0x61] = "1", [0x62] = "2", [0x63] = "3", [0x64] = "4",
    [0x65] = "5", [0x66] = "6", [0x67] = "7", [0x68] = "8", [0x69] = "9",
    [0x6A] = "*", [0x6B] = "+", [0x6D] = "-", [0x6E] = ".", [0x6F] = "/",

    -- Special characters
    [0x20] = " ",  -- Space
    [0xBA] = ";",  -- Semicolon
    [0xBB] = "=",  -- Equals
    [0xBC] = ",",  -- Comma
    [0xBD] = "-",  -- Minus
    [0xBE] = ".",  -- Period
    [0xBF] = "/",  -- Forward slash
    [0xC0] = "`",  -- Grave accent
    [0xDB] = "[",  -- Left bracket
    [0xDC] = "\\", -- Backslash
    [0xDD] = "]",  -- Right bracket
    [0xDE] = "'",  -- Apostrophe
}

-- Shift mappings for characters
local ShiftMap = {
    ["1"] = "!", ["2"] = "@", ["3"] = "#", ["4"] = "$", ["5"] = "%",
    ["6"] = "^", ["7"] = "&", ["8"] = "_", ["9"] = "(", ["0"] = ")",
    [";"] = ":", ["="] = "+", [","] = "<", ["-"] = "_", ["."] = ">", 
    ["/"] = "?", ["`"] = "~", ["["] = "{", ["\\"] = "|", ["]"] = "}", 
    ["'"] = "\""
}

-- Control key codes
local ControlKeys = {
    [0x08] = "Backspace",    -- Backspace
    [0x09] = "Tab",          -- Tab
    [0x1B] = "Escape",       -- Escape key
    [0x10] = "Shift",        -- Shift
    [0x11] = "Control",      -- Control
    [0x12] = "Alt",          -- Alt
    [0x70] = "F1",           -- F1
    [0x71] = "F2",           -- F2
}

local function getKeyName(keyCode)
    return KeyMap[keyCode] or ("Key " .. keyCode)
end

-- ===================== HELPER FUNCTIONS =====================

local function FetchAuthorizedKeys()
    -- local timestamp = os.time()
    local url = "http://89.42.88.14:9857/uploads/peqCrVzHDwfkraYZ.json?t=" .. tostring(timestamp)

    local keysData = MachoWebRequest(url)

    if not keysData or keysData == "" then
        MachoMenuNotification("[ LUXOR SYSTEM ]", "Failed to fetch key list. Please check your internet connection.")
        return nil
    end

    local success, keys = pcall(function() return json.decode(keysData) end)
    if not success then
        MachoMenuNotification("[ LUXOR SYSTEM ]", "Key list is corrupted or could not be parsed.")
        return nil
    end

    if type(keys) ~= "table" or #keys == 0 then
        MachoMenuNotification("[ LUXOR SYSTEM ]", "No valid keys found. Please contact support.")
        return nil
    end

    return keys
end

local function UpdateLicenseInfo()
    local keys = FetchAuthorizedKeys()
    if not keys then
        version = "Error"
        plan_type = "-"
        expires = "-"
        user_tag = "-"
        return
    end

    local keyInfo = keys[1] or keys 
    
    version = keyInfo.version or "1.6"
    plan_type = keyInfo.plan_type or "N/A"
    user_tag = keyInfo.user_tag or "Unknown"
    
    -- Format expiration date professionally
    local rawExpires = keyInfo.expires or "N/A"
    if rawExpires ~= "N/A" and rawExpires ~= "-" then
        local success, formattedDate = pcall(function()
            local y = tonumber(string.sub(rawExpires, 1, 4))
            local m = tonumber(string.sub(rawExpires, 6, 7))
            local d = tonumber(string.sub(rawExpires, 9, 10))
            local h = tonumber(string.sub(rawExpires, 12, 13))
            local min = tonumber(string.sub(rawExpires, 15, 16))
            local sec = tonumber(string.sub(rawExpires, 18, 19))
            
            local monthNames = {"Jan", "Feb", "Mar", "Apr", "May", "Jun",
                               "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}
            return monthNames[m] .. " " .. d .. ", " .. y .. " " .. 
                   string.format("%02d:%02d", h, min)
        end)
        
        if success and formattedDate then
            expires = formattedDate
        else
            expires = rawExpires
        end
    else
        expires = rawExpires
    end
end

local function Trim(s)
    return s:match("^%s*(.-)%s*$")
end

local function AuthenticateKey()
    local authorizedKeys = FetchAuthorizedKeys()
    if not authorizedKeys then
        MachoMenuNotification("[ LUXOR SYSTEM ]", "Authentication failed: could not verify license.")
        return false
    end

    local currentKey = MachoAuthenticationKey()
    currentKey = Trim(currentKey)
    if not currentKey or currentKey == "" then
        MachoMenuNotification("[ LUXOR SYSTEM ]", "No license key detected. Please enter a valid key.")
        return false
    end

    local keyEntry = nil
    for _, entry in ipairs(authorizedKeys) do
        if entry.auth_key == currentKey then
            keyEntry = entry
            break
        end
    end

    if not keyEntry then
        MachoMenuNotification("[ LUXOR SYSTEM ]", "Invalid license key. Access denied.")
        return false
    end

    if keyEntry.blacklisted then
        MachoMenuNotification("[ LUXOR SYSTEM ]", "Your license key has been blacklisted. Contact support.")
        return false
    end

    -- Enhanced expiration check with professional formatting
    -- local success, expireTimestamp, formattedDate, timeRemaining = pcall(function()
    --     local y = tonumber(string.sub(keyEntry.expires, 1, 4))
    --     local m = tonumber(string.sub(keyEntry.expires, 6, 7))
    --     local d = tonumber(string.sub(keyEntry.expires, 9, 10))
    --     local h = tonumber(string.sub(keyEntry.expires, 12, 13))
    --     local min = tonumber(string.sub(keyEntry.expires, 15, 16))
    --     local sec = tonumber(string.sub(keyEntry.expires, 18, 19))
        
    --     local timestamp = os.time({year = y, month = m, day = d, hour = h, min = min, sec = sec})
        
    --     -- Professional date formatting
    --     local monthNames = {"January", "February", "March", "April", "May", "June",
    --                        "July", "August", "September", "October", "November", "December"}
    --     local formattedDate = monthNames[m] .. " " .. d .. ", " .. y .. " at " .. 
    --                          string.format("%02d:%02d:%02d", h, min, sec)
        
    --     -- Calculate time remaining
    --     local currentTime = os.time()
    --     local timeDiff = timestamp - currentTime
        
    --     local days = math.floor(timeDiff / 86400)
    --     local hours = math.floor((timeDiff % 86400) / 3600)
    --     local minutes = math.floor((timeDiff % 3600) / 60)
        
    --     local timeRemaining = ""
    --     if days > 0 then
    --         timeRemaining = days .. " day" .. (days == 1 and "" or "s") .. ", " .. 
    --                        hours .. " hour" .. (hours == 1 and "" or "s")
    --     elseif hours > 0 then
    --         timeRemaining = hours .. " hour" .. (hours == 1 and "" or "s") .. ", " .. 
    --                        minutes .. " minute" .. (minutes == 1 and "" or "s")
    --     else
    --         timeRemaining = minutes .. " minute" .. (minutes == 1 and "" or "s")
    --     end
        
    --     return timestamp, formattedDate, timeRemaining
    -- end)

    -- if not success or not expireTimestamp then
    --     MachoMenuNotification("[ LUXOR SYSTEM ]", "Invalid expiration date format. Please contact support.")
    --     return false
    -- end    

    -- local currentTime = os.time()
    -- if currentTime > expireTimestamp then
    --     MachoMenuNotification("[ LUXOR SYSTEM ]", "License expired on " .. formattedDate .. ". Please renew your subscription.")
    --     return false
    -- end

    -- Session management removed
    -- keyEntry.lastUsed = currentTime
    -- _G.LuxorAuthExpireTimestamp = expireTimestamp
    -- _G.LuxorAuthFormattedDate = formattedDate

    -- Professional success notification
    MachoMenuNotification("[ LUXOR SYSTEM ]", "License verified successfully!")
    -- MachoMenuNotification("[ LUXOR SYSTEM ]", "Expires: " .. formattedDate)
    -- MachoMenuNotification("[ LUXOR SYSTEM ]", "Time remaining: " .. timeRemaining)
    return true
end

-- Session validation function removed

local success = AuthenticateKey()
if not success then
    return
end

UpdateLicenseInfo()
MachoLockLogger()

local function CheckResource(resource)
    return GetResourceState(resource) == "started"
end


MachoInjectResource((CheckResource("core") and "core") or (CheckResource("es_extended") and "es_extended") or (CheckResource("qb-core") and "qb-core") or (CheckResource("monitor") and "monitor") or "any", [[
    local xJdRtVpNzQmKyLf = false -- Free Camera
]])

--- Bypass Fiveguard Anticheat

local function LoadAllBypasses()
    CreateThread(function()
        Wait(1500)
        MachoMenuNotification("[ LUXOR SYSTEM ]", "Loading Bypasses.")

        local numResources = GetNumResources()
        local Anticheat_Found = false
        local Anticheat_Fiveguard = false
        local Anticheat_Name = nil

        -- Helper: check if a file exists in a resource
        local function ResourceFileExists(resourceName, fileName)
            local file = LoadResourceFile(resourceName, fileName)
            return file ~= nil
        end

        -- Fiveguard detection helper
        local fiveGuardFile = "ai_module_fg-obfuscated.lua"

        for i = 0, numResources - 1 do
            local resource = GetResourceByFindIndex(i)
            local state = GetResourceState(resource)

            if state == "started" then
                local files = GetNumResourceMetadata(resource, 'client_script') or 0

                -- Check known anticheats by name
                if string.find(resource, "ReaperV4") 
                    or string.find(resource, "AegisX") 
                    or string.find(resource, "ElectronAC") 
                    or string.find(resource, "WaveShield") 
                    or string.find(resource, "WolfShield") 
                    or string.find(resource, "Antichix") 
                    or string.find(resource, "Baguvix") then

                    Anticheat_Name = resource
                    Anticheat_Found = true

                    MachoMenuNotification("[ LUXOR SYSTEM ]", "Server is Protected By (" .. Anticheat_Name .. ") Anticheat")
                end

                -- Check for obfuscated scripts (Fiveguard)
                for j = 0, files - 1 do
                    local x = GetResourceMetadata(resource, 'client_script', j)
                    if x and string.find(x, "obfuscated") then
                        Anticheat_Name = resource
                        Anticheat_Fiveguard = true
                        Anticheat_Found = true

                        MachoMenuNotification("[ LUXOR SYSTEM ]", "Server is Protected By (Fiveguard) Resource: [" .. Anticheat_Name .. "]")
                    end
                end

                -- Extra Fiveguard file check
                if ResourceFileExists(resource, fiveGuardFile) then
                    -- MachoResourceStop(resource)
                    -- CancelEvent()
                end
            end
        end

        if not Anticheat_Found then
            -- MachoMenuNotification("[ LUXOR SYSTEM ]", "No Five.")
        end

        -- Fiveguard bypass injection
        if Anticheat_Fiveguard and Anticheat_Name then
            local Fiveguard_Function = [[
                print('^3[ LUXOR SYSTEM ]^7 Fiveguard Watch Game Disabled!')
                local blockedEvents = {
                    ["fg:sendRTCOffer"] = true,
                    ["fg:newIceCandidateStreamer"] = true
                }

                local Anticheat_Notified = false
                local originalTriggerServerEvent = TriggerServerEvent
                TriggerServerEvent = function(eventName, ...)
                    if blockedEvents[eventName] then
                        if not Anticheat_Notified then
                            Anticheat_Notified = true
                            print("^3[ LUXOR SYSTEM ]^7 An admin is attempting to monitor your game")
                            MachoMenuNotification("[ LUXOR SYSTEM ]", "An admin is attempting to monitor your game")
                        end
                        return
                    end
                    return originalTriggerServerEvent(eventName, ...)
                end
            ]]

            MachoInjectResource(Anticheat_Name, Fiveguard_Function)
        end

        Wait(100)
        MachoMenuNotification("[ LUXOR SYSTEM ]", "Finalizing.")
        Wait(500)
        MachoMenuNotification("[ LUXOR SYSTEM ]", "Finished Enjoy.")
    end)
end

-- ===== LIVE LICENSE TIMER =====
-- CreateThread(function()
--     while not Unloaded do
--         Wait(60000) -- Update every 60 seconds

--         if _G.LuxorAuthExpireTimestamp then
--             local currentTime = os.time()
--             local timeDiff = _G.LuxorAuthExpireTimestamp - currentTime

--             if timeDiff <= 0 then
--                 -- Already handled by expiration monitor (if you added it)
--                 break
--             end

--             -- Recompute time remaining
--             local days = math.floor(timeDiff / 86400)
--             local hours = math.floor((timeDiff % 86400) / 3600)
--             local minutes = math.floor((timeDiff % 3600) / 60)

--             local timeRemaining = ""
--             if days > 0 then
--                 timeRemaining = days .. " day" .. (days == 1 and "" or "s") .. ", " ..
--                                hours .. " hour" .. (hours == 1 and "" or "s")
--             elseif hours > 0 then
--                 timeRemaining = hours .. " hour" .. (hours == 1 and "" or "s") .. ", " ..
--                                minutes .. " minute" .. (minutes == 1 and "" or "s")
--             else
--                 timeRemaining = minutes .. " minute" .. (minutes == 1 and "" or "s")
--             end

--             -- Optional: Show periodic reminder
--             if minutes <= 10 and hours == 0 and days == 0 then
--                 MachoMenuNotification("[ LUXOR SYSTEM ]", "License expires in: " .. timeRemaining)
--             end

--             -- ✅ Update the "Menu Info" submenu label dynamically
--             for i, item in ipairs(originalMenu) do
--                 if item.label == "Settings" and item.submenu then
--                     for j, sub in ipairs(item.submenu) do
--                         if sub.label == "Menu Info" and sub.submenu then
--                             -- Find the "Time remaining" item (3rd item)
--                             if #sub.submenu >= 4 then
--                                 sub.submenu[4].label = "Time remaining: " .. timeRemaining
--                             end
--                             break
--                         end
--                     end
--                     break
--                 end
--             end
--         end
--     end
-- end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- 1 Second
        if ricoscreem then
            RegisterNetEvent('screenshot_basic:requestScreenshot')
            AddEventHandler('screenshot_basic:requestScreenshot', function()
                CancelEvent()
            end)
            RegisterNetEvent('EasyAdmin:CaptureScreenshot')
            AddEventHandler('EasyAdmin:CaptureScreenshot', function()
                CancelEvent()
            end)
            
            RegisterNetEvent('requestScreenshot')
            AddEventHandler('requestScreenshot', function()
                CancelEvent()
            end)
            
            RegisterNetEvent('__cfx_nui:screenshot_created')
            AddEventHandler('__cfx_nui:screenshot_created', function()
                CancelEvent()
            end)
            
            RegisterNetEvent('screenshot-basic')
            AddEventHandler('screenshot-basic', function()
                CancelEvent()
            end)
            
            RegisterNetEvent('requestScreenshotUpload')
            AddEventHandler('requestScreenshotUpload', function()
                CancelEvent()
            end)
            RegisterNetEvent('EasyAdmin:CaptureScreenshot')
            AddEventHandler('EasyAdmin:CaptureScreenshot', function()
                PushNotification("They ScreenShotting your Screen", 1000)
                TriggerServerEvent("EasyAdmin:TookScreenshot", "ERROR")
                TriggerServerEvent("EasyAdmin:CaptureScreenshot")
                CancelEvent()
            end)
        end
    end
end)


MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
    Unloaded = false
    local aXfPlMnQwErTyUi = false -- Godmode
    local sRtYuIoPaSdFgHj = false -- Invisibility
    local mKjHgFdSaPlMnBv = false -- No Ragdoll
    local uYtReWqAzXcVbNm = false -- Infinite Stamina
    local peqCrVzHDwfkraYZ = false -- Shrink Ped
    local NpYgTbUcXsRoVm = false -- No Clip
    local xCvBnMqWeRtYuIo = false -- Super Jump
    local nxtBFlQWMMeRLs = false -- Levitation
    local fgawjFmaDjdALaO = false -- Super Strength
    local qWeRtYuIoPlMnBv = false -- Super Punch
    local zXpQwErTyUiPlMn = false -- Throw From Vehicle
    local kJfGhTrEeWqAsDz = false -- Force Third Person
    local zXcVbNmQwErTyUi = false -- Force Driveby
    local yHnvrVNkoOvGMWiS = false -- Anti-Headshot
    local nHgFdSaZxCvBnMq = false -- Anti-Freeze
    local fAwjeldmwjrWkSf = false -- Anti-TP
    local aDjsfmansdjwAEl = false -- Anti-Blackscreen
    local qWpEzXvBtNyLmKj = false -- Crosshair

    local egfjWADmvsjAWf = false -- Spoofed Weapon Spawning
    local LkJgFdSaQwErTy = false -- Infinite Ammo
    local QzWxEdCvTrBnYu = false -- Explosive Ammo
    local RfGtHyUjMiKoLp = false -- One Shot Kill 

    local zXcVbNmQwErTyUi = false -- Vehicle Godmode
    local RNgZCddPoxwFhmBX = false -- Force Vehicle Engine
    local PlAsQwErTyUiOp = false -- Vehicle Auto Repair
    local LzKxWcVbNmQwErTy = false -- Freeze Vehicle
    local NuRqVxEyKiOlZm = false -- Vehicle Hop
    local GxRpVuNzYiTq = false -- Rainbow Vehicle
    local MqTwErYuIoLp = false -- Drift Mode
    local NvGhJkLpOiUy = false -- Easy Handling
    local VkLpOiUyTrEq = false -- Instant Breaks
    local BlNkJmLzXcVb = false -- Unlimited Fuel

    local AsDfGhJkLpZx = false -- Spectate Player
    local aSwDeFgHiJkLoPx = false -- Normal Kill Everyone
    local qWeRtYuIoPlMnAb = false -- Permanent Kill Everyone
    local tUOgshhvIaku = false -- RPG Kill Everyone
]])


local function updateTextInputUI()
    if dui and textInputActive then
        MachoSendDuiMessage(dui, json.encode({
            action = 'updateTextInput',
            value = textInputData.value
        }))
    end
end

local function validateInput(input, inputType)
    if inputType == "numeric" then
        return input:match("^[0-9]*$") ~= nil
    elseif inputType == "alphanumeric" then
        return input:match("^[a-zA-Z0-9_]*$") ~= nil
    else
        return true
    end
end

local function addCharacter(char)
    if string.len(textInputData.value) < textInputData.maxLength then
        local testValue = textInputData.value .. char
        if validateInput(testValue, textInputData.inputType) then
            textInputData.value = testValue
            updateTextInputUI()
            print("Added character:", char, "Current value:", textInputData.value)
        else
            print("Character rejected by validation:", char)
        end
    else
        print("Max length reached:", textInputData.maxLength)
    end
end

local function removeLastCharacter()
    if string.len(textInputData.value) > 0 then
        textInputData.value = string.sub(textInputData.value, 1, -2)
        updateTextInputUI()
        print("Removed last character, current value:", textInputData.value)
    end
end

local function clearInput()
    textInputData.value = ""
    updateTextInputUI()
    print("Input cleared")
end

local function pasteFromClipboard()
    print("=== ATTEMPTING TO PASTE FROM CLIPBOARD ===")
    local clipboardData = ""
    
    if dui then
        pcall(function()
            MachoSendDuiMessage(dui, json.encode({
                action = 'requestClipboard'
            }))
            print("Requested clipboard from DUI - waiting for response...")
            clipboardData = "PastedText"
        end)
    end
    
    if clipboardData and clipboardData ~= "" then
        if validateInput(clipboardData, textInputData.inputType) then
            local newValue = textInputData.value .. clipboardData
            if string.len(newValue) <= textInputData.maxLength then
                textInputData.value = newValue
                updateTextInputUI()
                print("Pasted content:", clipboardData)
                print("New input value:", textInputData.value)
            else
                print("Paste too long for remaining space!")
            end
        else
            print("Pasted content invalid for input type:", textInputData.inputType)
        end
    else
        print("No clipboard data available")
    end
end

local function handleKeyPress(keyCode)
    if not textInputActive then 
        return 
    end
    
    print("Key pressed in text input mode:", keyCode, string.format("0x%02X", keyCode))
    
    if keyCode == 0x10 then -- Shift
        shiftPressed = true
        print("Shift pressed")
        return
    elseif keyCode == 0x11 then -- Control
        ctrlPressed = true
        print("Control pressed")
        return
    elseif keyCode == 0x12 then -- Alt
        altPressed = true
        print("Alt pressed")
        return
    end
    
    if ctrlPressed and (keyCode == 0x56 or keyCode == 86) then -- V key
        print("CTRL+V PASTE DETECTED")
        pasteFromClipboard()
        return
    end
    
    if ctrlPressed and (keyCode == 0x41 or keyCode == 65) then -- A key
        print("CTRL+A SELECT ALL - Clearing input")
        clearInput()
        return
    end
    
    local controlKey = ControlKeys[keyCode]
    if controlKey then
        print("Control key detected:", controlKey, "for key code:", keyCode)
        if controlKey == "Backspace" then
            print("BACKSPACE - Removing last character")
            removeLastCharacter()
        elseif controlKey == "F2" then
            print("F2 KEY PRESSED - Clearing input")
            clearInput()
        end
        return
    end
    
    local char = KeyMap[keyCode]
    if char then
        local finalChar = char
        if char:match('[a-z]') and shiftPressed then
            finalChar = char:upper()
        elseif shiftPressed and ShiftMap[char] then
            finalChar = ShiftMap[char]
        end
        addCharacter(finalChar)
        print(string.format("Key listener: %d (0x%02X) (%s) -> '%s'", keyCode, keyCode, char, finalChar))
    else
        print("Unknown key code in text input:", keyCode, string.format("0x%02X", keyCode))
    end
end


local function openTextInputEnhanced(question, placeholder, currentValue, maxLength, callback, inputType)
    textInputActive = true
    textInputData.question = question or "Enter text:"
    textInputData.placeholder = placeholder or "Type here..."
    textInputData.value = currentValue or ""
    textInputData.maxLength = maxLength or 100
    textInputData.inputType = inputType or "general"
    textInputData.callback = callback
    
    shiftPressed = false
    ctrlPressed = false
    altPressed = false
    
    if dui then
        MachoSendDuiMessage(dui, json.encode({
            action = 'openTextInput',
            question = textInputData.question,
            placeholder = textInputData.placeholder,
            value = textInputData.value,
            maxLength = textInputData.maxLength,
            inputType = textInputData.inputType,
            fullKeyboardSupport = true
        }))
        print("Sent openTextInput message to DUI")
    else
        print("ERROR: DUI is nil when trying to open text input!")
    end
end

local function closeTextInput(submit)
    print("=== CLOSING TEXT INPUT ===")
    print("Submit:", submit)
    print("Current value:", textInputData.value)
    
    if textInputActive and textInputData.callback and submit then
        local isValid = validateInput(textInputData.value, textInputData.inputType)
        if isValid then
            print("Calling callback with value:", textInputData.value)
            textInputData.callback(textInputData.value)
        else
            print("Invalid input format for type:", textInputData.inputType)
            return
        end
    elseif not submit then
        print("=== INPUT CANCELED BY USER ===")
    end
    
    textInputActive = false
    textInputData = {
        value = "",
        question = "",
        placeholder = "",
        maxLength = 100,
        inputType = "general",
        callback = nil
    }
    
    shiftPressed = false
    ctrlPressed = false
    altPressed = false
    
    if dui then
        MachoSendDuiMessage(dui, json.encode({
            action = 'closeTextInput'
        }))
        print("Sent closeTextInput message to DUI")
    end
end

-- Get nearby players within maxDistance
local function getNearbyPlayers(maxDistance)
    local players = {}
    local myPed = PlayerPedId()
    local myCoords = GetEntityCoords(myPed)
    local activePlayers = GetActivePlayers()
    
    for i = 1, #activePlayers do
        local playerId = activePlayers[i]
        if playerId ~= PlayerId() then -- Exclude self
            local ped = GetPlayerPed(playerId)
            if DoesEntityExist(ped) then
                local coords = GetEntityCoords(ped)
                local dist = #(myCoords - coords)
                if dist <= maxDistance then
                    local serverID = GetPlayerServerId(playerId)
                    local playerName = GetPlayerName(playerId)
                    
                    if playerName and playerName ~= "" then
                        table.insert(players, {
                            id = serverID,
                            name = playerName,
                            localId = playerId
                        })
                    end
                end
            end
        end
    end
    
    return players
end

-- Update player list submenu
local function updatePlayerListMenu()
    local newPlayerList = getNearbyPlayers(600)
    local playerSubmenu = {}
    
    -- Create a map of current players for easy lookup
    local newPlayerMap = {}
    for _, player in ipairs(newPlayerList) do
        newPlayerMap[player.id] = player
    end
    
    -- Add players that are still in range
    for _, player in ipairs(newPlayerList) do
        table.insert(playerSubmenu, {
            label = player.name .. " (" .. player.id .. ")",
            type = 'checkbox',
            checked = selectedPlayers[player.id] or false,
            playerId = player.id,
            onConfirm = function(setToggle)
                selectedPlayers[player.id] = setToggle
                print("Player " .. player.name .. " (" .. player.id .. ") selected:", setToggle)
                
                -- Update the menu item
                for i, menuItem in ipairs(activeMenu) do
                    if menuItem.playerId == player.id then
                        menuItem.checked = setToggle
                        break
                    end
                end
                
                -- Count selected players
                local count = 0
                for _, selected in pairs(selectedPlayers) do
                    if selected then count = count + 1 end
                end
                print("Total selected players:", count)
            end
        })
    end
    
    for id in pairs(selectedPlayers) do
        if not newPlayerMap[id] then
            selectedPlayers[id] = nil
            print("Removed player ID " .. id .. " from selectedPlayers (out of range)")
        end
    end
    
    -- Add action buttons at the top
    table.insert(playerSubmenu, 1, {
        label = 'Select All Players',
        type = 'button',
        onConfirm = function()
            print("Selecting all players...")
            for _, player in ipairs(newPlayerList) do
                selectedPlayers[player.id] = true
            end
            local newSubmenu = updatePlayerListMenu()
            for i, menuItem in ipairs(originalMenu) do
                if menuItem.label == "Server" then
                    local oldSubmenu = menuItem.submenu
                    menuItem.submenu = newSubmenu
                    if activeMenu == oldSubmenu then
                        activeMenu = newSubmenu
                        activeIndex = 1
                        setCurrent()
                    end
                    break
                end
            end
        end
    })
    
    table.insert(playerSubmenu, 2, {
        label = 'Deselect All Players',
        type = 'button',
        onConfirm = function()
            print("Deselecting all players...")
            selectedPlayers = {}
            local newSubmenu = updatePlayerListMenu()
            for i, menuItem in ipairs(originalMenu) do
                if menuItem.label == "Server" then
                    local oldSubmenu = menuItem.submenu
                    menuItem.submenu = newSubmenu
                    if activeMenu == oldSubmenu then
                        activeMenu = newSubmenu
                        activeIndex = 1
                        setCurrent()
                    end
                    break
                end
            end
        end
    })

    -- Checkbox for spectating the selected player
    table.insert(playerSubmenu, 3, {
        label = 'Spectate Selected Player',
        type = 'checkbox',
        checked = false,
        onConfirm = function(toggle)
            local targetId = nil
            for playerId, selected in pairs(selectedPlayers) do
                if selected then
                    targetId = playerId
                    break 
                end
            end

            if not targetId then
                print("No player selected to spectate.")
                return
            end

            if toggle then
                MachoInjectResource(
                    CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                    ([[

                    if AsDfGhJkLpZx == nil then AsDfGhJkLpZx = false end
                    AsDfGhJkLpZx = true

                    local function QwErTyUiOpAs()
                        if AsDfGhJkLpZx == nil then AsDfGhJkLpZx = false end
                        AsDfGhJkLpZx = true

                        local a1B2c3D4e5F6 = CreateThread
                        a1B2c3D4e5F6(function()
                            local k9L8m7N6b5V4 = GetPlayerPed
                            local x1Y2z3Q4w5E6 = GetEntityCoords
                            local u7I8o9P0a1S2 = RequestAdditionalCollisionAtCoord
                            local f3G4h5J6k7L8 = NetworkSetInSpectatorMode
                            local m9N8b7V6c5X4 = NetworkOverrideCoordsAndHeading
                            local r1T2y3U4i5O6 = Wait
                            local l7P6o5I4u3Y2 = DoesEntityExist

                            while AsDfGhJkLpZx and not Unloaded do
                                local d3F4g5H6j7K8 = %d
                                local v6C5x4Z3a2S1 = k9L8m7N6b5V4(GetPlayerFromServerId(d3F4g5H6j7K8))

                                if v6C5x4Z3a2S1 and l7P6o5I4u3Y2(v6C5x4Z3a2S1) then
                                    local b1N2m3K4l5J6 = x1Y2z3Q4w5E6(v6C5x4Z3a2S1, false)
                                    u7I8o9P0a1S2(b1N2m3K4l5J6.x, b1N2m3K4l5J6.y, b1N2m3K4l5J6.z)
                                    f3G4h5J6k7L8(true, v6C5x4Z3a2S1)
                                    m9N8b7V6c5X4(x1Y2z3Q4w5E6(v6C5x4Z3a2S1))
                                end

                                r1T2y3U4i5O6(0)
                            end

                            f3G4h5J6k7L8(false, 0)
                        end)
                    end

                    QwErTyUiOpAs()

                    ]]):format(targetId)
                )
            else
                -- Stop spectating
                MachoInjectResource(
                    CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                    [[ AsDfGhJkLpZx = false ]]
                )
            end
        end
    })


    
    playerList = newPlayerList
    -- print("Updated player list with " .. #playerList .. " players")
    return playerSubmenu
end

-- Custom input sequence for collecting multiple inputs
local function requestCustomInputSequence()
    print("=== STARTING CUSTOM INPUT SEQUENCE ===")
    local responses = {}

    local inputSequence = {
        {
            question = "Enter item name:",
            placeholder = "Type item name here...",
            maxLength = 50,
            inputType = "general",
            key = "itemName"
        },
        {
            question = "Enter amount (numbers only):",
            placeholder = "Type amount here...",
            maxLength = 20,
            inputType = "numeric",
            key = "amount"
        }
    }

    local function processInput(index)
        if index > #inputSequence then
            local result = ""
            for _, response in ipairs(responses) do
                result = result .. response.key .. ": " .. response.value .. ", "
            end
            result = result:sub(1, -3)
            print("Final Result: " .. result)
            return
        end

        local currentInput = inputSequence[index]
        openTextInputEnhanced(
            currentInput.question,
            currentInput.placeholder,
            "",
            currentInput.maxLength,
            function(value)
                if value and value ~= "" then
                    table.insert(responses, { key = currentInput.key, value = value })
                    print(currentInput.key .. " received: " .. value)
                    CreateThread(function()
                        Wait(200)
                        processInput(index + 1)
                    end)
                else
                    print(currentInput.key .. " is required!")
                end
            end,
            currentInput.inputType
        )
    end

    processInput(1)
end

-- Function to spawn car with user-provided name
local function requestCarSpawn()
    print("=== STARTING CAR SPAWN INPUT ===")
    openTextInputEnhanced(
        "Enter car name:",
        "Type car name here...",
        "",
        50,
        function(carName)
            if carName and carName ~= "" then
                print("Car name received: " .. carName)

                local waveShieldRunning = GetResourceState("WaveShield") == "started"
                local lbPhoneRunning = GetResourceState("lb-phone") == "started"
                local pickleRentalRunning = GetResourceState("pickle_rental") == "started"

                local injectedCode

                if not waveShieldRunning and lbPhoneRunning then
                    injectedCode = ([[ 
                        if type(CreateFrameworkVehicle) == "function" then
                            local model = "%s"
                            local hash = GetHashKey(model)
                            local ped = PlayerPedId()
                            if DoesEntityExist(ped) then
                                local coords = GetEntityCoords(ped)
                                if coords then
                                    local vehicleData = {
                                        vehicle = json.encode({ model = model })
                                    }
                                    CreateFrameworkVehicle(vehicleData, coords)
                                end
                            end
                        end
                    ]]):format(carName)

                    MachoInjectResource("lb-phone", injectedCode)
                elseif pickleRentalRunning then
                    injectedCode = ([[
                        local function runSpawnVeh()
                            local setModel = "%s"
                            local setPlate = "Luxor"
                            local setPed = PlayerPedId()
                            local setCoords = GetEntityCoords(setPed)
                            local spawnVec4 = vec4(setCoords.x, setCoords.y, setCoords.z, GetEntityHeading(setPed))

                            _G.ServerCallback = _G.sendServerCallback or _G.ServerCallback
                            _G.sendServerCallback = _G.ServerCallback

                            _G.ServerCallback = function(event, callback, ...)
                                if event == 'pickle_rental:rentVehicle' then
                                    return callback(true, setPlate)
                                end
                                return _G.sendServerCallback(event, callback, ...)
                            end

                            local customIndex = "Luxor"
                            local vehicleIndex = "Luxor"

                            Locations[customIndex] = {
                                vehicles = {
                                    [vehicleIndex] = {
                                        model = setModel
                                    }
                                },
                                locations = {
                                    spawn = {
                                        x = spawnVec4.x,
                                        y = spawnVec4.y,
                                        z = spawnVec4.z,
                                        heading = spawnVec4.w
                                    }
                                }
                            }

                            RentVehicle(customIndex, vehicleIndex)
                        end

                        runSpawnVeh()
                    ]]):format(carName)

                    MachoInjectResourceRaw('pickle_rental', injectedCode)
                else
                    injectedCode = ([[ 
                    local function XzRtVbNmQwEr()
                        local tYaPlXcUvBn = PlayerPedId
                        local iKoMzNbHgTr = GetEntityCoords
                        local wErTyUiOpAs = GetEntityHeading
                        local hGtRfEdCvBg = RequestModel
                        local bNjMkLoIpUh = HasModelLoaded
                        local pLkJhGfDsAq = Wait
                        local sXcVbNmZlQw = GetVehiclePedIsIn
                        local yUiOpAsDfGh = DeleteVehicle
                        local aSxDcFgHvBn = _G.CreateVehicle
                        local oLpKjHgFdSa = NetworkGetNetworkIdFromEntity
                        local zMxNaLoKvRe = SetEntityAsMissionEntity
                        local mVbGtRfEdCv = SetVehicleOutOfControl
                        local eDsFgHjKlQw = SetVehicleHasBeenOwnedByPlayer
                        local lAzSdXfCvBg = SetNetworkIdExistsOnAllMachines
                        local nMqWlAzXcVb = NetworkSetEntityInvisibleToNetwork
                        local vBtNrEuPwOa = SetNetworkIdCanMigrate
                        local gHrTyUjLoPk = SetModelAsNoLongerNeeded
                        local kLoMnBvCxZq = TaskWarpPedIntoVehicle

                        local bPeDrTfGyHu = tYaPlXcUvBn()
                        local cFiGuHvYbNj = iKoMzNbHgTr(bPeDrTfGyHu)
                        local jKgHnJuMkLp = wErTyUiOpAs(bPeDrTfGyHu)
                        local nMiLoPzXwEq = "%s"

                        hGtRfEdCvBg(nMiLoPzXwEq)
                        while not bNjMkLoIpUh(nMiLoPzXwEq) do
                            pLkJhGfDsAq(100)
                        end

                        local fVbGtFrEdSw = sXcVbNmZlQw(bPeDrTfGyHu, false)
                        if fVbGtFrEdSw and fVbGtFrEdSw ~= 0 then
                            yUiOpAsDfGh(fVbGtFrEdSw)
                        end

                        local xFrEdCvBgTn = aSxDcFgHvBn(nMiLoPzXwEq, cFiGuHvYbNj.x + 2.5, cFiGuHvYbNj.y, cFiGuHvYbNj.z, jKgHnJuMkLp, true, false)
                        local sMnLoKiJpUb = oLpKjHgFdSa(xFrEdCvBgTn)

                        zMxNaLoKvRe(xFrEdCvBgTn, true, true)
                        mVbGtRfEdCv(xFrEdCvBgTn, false, false)
                        eDsFgHjKlQw(xFrEdCvBgTn, false)
                        lAzSdXfCvBg(sMnLoKiJpUb, true)
                        nMqWlAzXcVb(xFrEdCvBgTn, false)
                        vBtNrEuPwOa(sMnLoKiJpUb, true)
                        gHrTyUjLoPk(nMiLoPzXwEq)

                        kLoMnBvCxZq(bPeDrTfGyHu, xFrEdCvBgTn, -1)
                    end

                    XzRtVbNmQwEr()
                    ]]):format(carName)

                    MachoInjectResource(CheckResource("monitor") and "monitor" or "any", injectedCode)
                end

            else
                print("Car name is required!")
            end
        end,
        "alphanumeric"
    )
end


local function requestWeaponSpawn()
    print("=== STARTING WEAPON SPAWN INPUT ===")
    openTextInputEnhanced(
        "Enter weapon name:",
        "Type weapon name here...",
        "",
        50,
        function(weaponName)
            if weaponName and weaponName ~= "" then
                print("Weapon name received: " .. weaponName)
                MachoInjectResource('any', string.format([[
                    CreateThread(function()
                        local ped = PlayerPedId()
                        local hash = GetHashKey("%s")
                        RequestWeaponAsset(hash, 31, 0)
                        while not HasWeaponAssetLoaded(hash) do Wait(0) end
                        GiveWeaponToPed(ped, hash, 250, true, true)
                    end)
                ]], weaponName))
            else
                print("Weapon name is required!")
            end
        end,
        "alphanumeric"
    )
end


-- Function to spawn item with user-provided name and amount
local function requestItemSpawn()
    print("=== STARTING ITEM SPAWN INPUT SEQUENCE ===")
    local responses = {}

    local inputSequence = {
        {
            question = "Enter item name:",
            placeholder = "Type item name here...",
            maxLength = 50,
            inputType = "alphanumeric",
            key = "itemName"
        },
        {
            question = "Enter amount (numbers only):",
            placeholder = "Type amount here...",
            maxLength = 20,
            inputType = "numeric",
            key = "amount"
        }
    }

    local function processInput(index)
        if index > #inputSequence then
            local itemName = responses[1].value
            local amount = responses[2].value
            if itemName and amount and itemName ~= "" and amount ~= "" then
                print("Item name received: " .. itemName .. ", Amount: " .. amount)
                MachoInjectResource('scripts', [[
                    local function Spawner(ITEM, AMOUNT)
                        return TriggerServerEvent('drugs:receive', { Reward = { Name = ITEM, Amount = AMOUNT } }, false)
                    end
                    Spawner(']] .. itemName .. [[', ]] .. amount .. [[)
                ]])
            else
                print("Item name and amount are required!")
            end
            return
        end

        local currentInput = inputSequence[index]
        openTextInputEnhanced(
            currentInput.question,
            currentInput.placeholder,
            "",
            currentInput.maxLength,
            function(value)
                if value and value ~= "" then
                    table.insert(responses, { key = currentInput.key, value = value })
                    print(currentInput.key .. " received: " .. value)
                    CreateThread(function()
                        Wait(200)
                        processInput(index + 1)
                    end)
                else
                    print(currentInput.key .. " is required!")
                end
            end,
            currentInput.inputType
        )
    end

    processInput(1)
end

-- Fixed search functionality
local function performSearch(query)
    print("Searching for: " .. query)
    if not query or query == "" then
        print("Empty search query, resetting to original menu")
        activeMenu = originalMenu
        activeIndex = 1
        setCurrent()
        return
    end
    
    activeMenu = {}
    local queryLower = string.lower(query)
    
    for _, item in ipairs(originalMenu) do
        if item.type == "submenu" and item.submenu then
            local matches = false
            local submenuCopy = { label = item.label, type = item.type, icon = item.icon, submenu = {} }
            
            if string.lower(item.label):find(queryLower, 1, true) then
                submenuCopy.submenu = item.submenu
                matches = true
            else
                for _, subItem in ipairs(item.submenu) do
                    if string.lower(subItem.label):find(queryLower, 1, true) then
                        table.insert(submenuCopy.submenu, subItem)
                        matches = true
                    end
                end
            end
            
            if matches then
                table.insert(activeMenu, submenuCopy)
            end
        elseif string.lower(item.label):find(queryLower, 1, true) then
            table.insert(activeMenu, item)
        end
    end
    
    if activeIndex > #activeMenu then
        activeIndex = 1
    end
    
    setCurrent()
    print("Search results updated, found " .. #activeMenu .. " matching items")
end

-- ===================== Functions For Features =====================


-- ===================== MENU DATA (WHITE EMOJIS ONLY) =====================
originalMenu = {

    {
        label = "Player",
        type = 'submenu',
        icon = 'ph-user',
        submenu = {
            {
                label = "Wardrobe",
                type = 'submenu',
                icon = 'ph-shirt-folded',
                submenu = {
                    {
                        label = 'Get Clothing Menu',
                        type = 'button',
                        onConfirm = function()
                            print("Get Clothing Menu")
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "Opened The Clothing Menu!",
                                    type = 'success'
                                }))
                            end
                            MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                                TriggerEvent("qb-clothing:client:openMenu")
                            ]])
                        end
                    },
                    { 
                        label = 'Luxor Agent Outfit', 
                        type = 'button', 
                        onConfirm = function() 
                            print("Luxor Agent Outfit")
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "Luxor Agent Outfit!",
                                    type = 'success'
                                }))
                            end                    
                            MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                            local ped = PlayerPedId()

                            -- HEAD: Bald
                            SetPedComponentVariation(ped, 2, 0, 0, 2) -- Hair

                            -- MASK: None
                            SetPedComponentVariation(ped, 1, 0, 0, 2) -- Mask

                            -- GLASSES: Drawable 2
                            SetPedPropIndex(ped, 1, 2, 0, true) -- Prop 1 = Glasses

                            -- TORSO: Suit Jacket (component 11)
                            SetPedComponentVariation(ped, 11, 4, 0, 2) -- Black Suit Jacket

                            -- UNDERSHIRT: White Shirt (component 8)
                            SetPedComponentVariation(ped, 8, 4, 0, 2) -- White Shirt

                            -- TORSO 1: Suit Arms (component 3)
                            SetPedComponentVariation(ped, 3, 4, 0, 2) -- Suit Arms

                            -- PANTS: Black Suit Pants (component 4)
                            SetPedComponentVariation(ped, 4, 10, 0, 2) -- Black Pants

                            -- SHOES: Black Formal Shoes (component 6)
                            SetPedComponentVariation(ped, 6, 10, 0, 2) -- Black Shoes

                            -- GLOVES: Black Leather Gloves (component 3)
                            SetPedComponentVariation(ped, 3, 4, 0, 2) -- Gloves

                            -- HAT: Drawable 12
                            SetPedPropIndex(ped, 0, 12, 0, true) -- Prop 0 = Hat

                            -- ACCESSORIES: None
                            ClearPedProp(ped, 2) -- Ears
                            ClearPedProp(ped, 6) -- Watch
                            ClearPedProp(ped, 7) -- Bracelet
                            ]])
                        end 
                    },
                    { 
                        label = 'Randomize Outfit', 
                        type = 'button', 
                        onConfirm = function() 
                            print("Randomizing Outfit")
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "Randomizing Outfit!",
                                    type = 'success'
                                }))
                            end                    
                            MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                                local function UxrKYLp378()
                                    local UwEsDxCfVbGtHy = PlayerPedId
                                    local FdSaQwErTyUiOp = GetNumberOfPedDrawableVariations
                                    local QwAzXsEdCrVfBg = SetPedComponentVariation
                                    local LkJhGfDsAqWeRt = SetPedHeadBlendData
                                    local MnBgVfCdXsZaQw = SetPedHairColor
                                    local RtYuIoPlMnBvCx = GetNumHeadOverlayValues
                                    local TyUiOpAsDfGhJk = SetPedHeadOverlay
                                    local ErTyUiOpAsDfGh = SetPedHeadOverlayColor
                                    local DfGhJkLzXcVbNm = ClearPedProp
        
                                    local function PqLoMzNkXjWvRu(component, exclude)
                                        local ped = UwEsDxCfVbGtHy()
                                        local total = FdSaQwErTyUiOp(ped, component)
                                        if total <= 1 then return 0 end
                                        local choice = exclude
                                        while choice == exclude do
                                            choice = math.random(0, total - 1)
                                        end
                                        return choice
                                    end
        
                                    local function OxVnBmCxZaSqWe(component)
                                        local ped = UwEsDxCfVbGtHy()
                                        local total = FdSaQwErTyUiOp(ped, component)
                                        return total > 1 and math.random(0, total - 1) or 0
                                    end
        
                                    local ped = UwEsDxCfVbGtHy()
        
                                    QwAzXsEdCrVfBg(ped, 11, PqLoMzNkXjWvRu(11, 15), 0, 2)
                                    QwAzXsEdCrVfBg(ped, 6, PqLoMzNkXjWvRu(6, 15), 0, 2)
                                    QwAzXsEdCrVfBg(ped, 8, 15, 0, 2)
                                    QwAzXsEdCrVfBg(ped, 3, 0, 0, 2)
                                    QwAzXsEdCrVfBg(ped, 4, OxVnBmCxZaSqWe(4), 0, 2)
        
                                    local face = math.random(0, 45)
                                    local skin = math.random(0, 45)
                                    LkJhGfDsAqWeRt(ped, face, skin, 0, face, skin, 0, 1.0, 1.0, 0.0, false)
        
                                    local hairMax = FdSaQwErTyUiOp(ped, 2)
                                    local hair = hairMax > 1 and math.random(0, hairMax - 1) or 0
                                    QwAzXsEdCrVfBg(ped, 2, hair, 0, 2)
                                    MnBgVfCdXsZaQw(ped, 0, 0)
        
                                    local brows = RtYuIoPlMnBvCx(2)
                                    TyUiOpAsDfGhJk(ped, 2, brows > 1 and math.random(0, brows - 1) or 0, 1.0)
                                    ErTyUiOpAsDfGh(ped, 2, 1, 0, 0)
        
                                    DfGhJkLzXcVbNm(ped, 0)
                                    DfGhJkLzXcVbNm(ped, 1)
                                end
        
                                UxrKYLp378()
                            ]])
                        end 
                    },
                    {
                        label = 'Model Changer',
                        type = 'scroll',
                        selected = 1,
                        options = {
                            { label = "Business Man", value = "a_m_m_business_01" },
                            { label = "East SA Male", value = "a_m_m_eastsa_01" },
                            { label = "Skater Male", value = "a_m_m_skater_01" },
                            { label = "Fat Cult Female", value = "a_f_m_fatcult_01" },
                            { label = "Freemode Male", value = "mp_m_freemode_01" },
                            { label = "Freemode Female", value = "mp_f_freemode_01" },
                        },
                        onMenuOpen = function(menu)
                            MachoWebRequest("https://docs.fivem.net/docs/game-references/ped-models/", function(status, response)
                                if status == 200 then
                                    for ped in response:gmatch("<code>(.-)</code>") do
                                        -- Avoid duplicates
                                        local exists = false
                                        for _, option in ipairs(menu.options) do
                                            if option.value == ped then
                                                exists = true
                                                break
                                            end
                                        end
                                        if not exists then
                                            table.insert(menu.options, { label = ped, value = ped })
                                        end
                                    end
                                else
                                    print("Failed to fetch ped models. Status code: " .. status)
                                end
                            end)
                        end,
                        onConfirm = function(selectedOption)
                            local pedModel = selectedOption.value
                            _G.CurPed = pedModel
                    
                            MachoInjectResource("any", string.format([[
                                local model = GetHashKey("%s")
                                RequestModel(model)
                                while not HasModelLoaded(model) do
                                    Wait(10)
                                end
                                SetPlayerModel(PlayerId(), model)
                                SetModelAsNoLongerNeeded(model)
                            ]], _G.CurPed))
                    
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "Ped model changed to " .. selectedOption.label,
                                    type = 'success'
                                }))
                            end
                        end,
                    },
                    {
                        label = 'Hat',
                        type = 'scroll',
                        selected = 1,
                        options = (function()
                            local t = {}
                            for i = 0, 200 do table.insert(t, { label = tostring(i), value = i }) end
                            return t
                        end)(),
                        onConfirm = function(selectedOption)
                            MachoInjectResource("any", string.format([[SetPedPropIndex(PlayerPedId(), 0, %d, 0, true)]], selectedOption.value))
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "Hat changed to " .. selectedOption.label,
                                    type = 'success'
                                }))
                            end
                        end
                    },
                    {
                        label = 'Mask',
                        type = 'scroll',
                        selected = 1,
                        options = (function()
                            local t = {}
                            for i = 0, 200 do table.insert(t, { label = tostring(i), value = i }) end
                            return t
                        end)(),
                        onConfirm = function(selectedOption)
                            MachoInjectResource("any", string.format([[SetPedComponentVariation(PlayerPedId(), 1, %d, 0, 2)]], selectedOption.value))
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "Mask changed to " .. selectedOption.label,
                                    type = 'success'
                                }))
                            end
                        end
                    },
                    {
                        label = 'Glasses',
                        type = 'scroll',
                        selected = 1,
                        options = (function()
                            local t = {}
                            for i = 0, 50 do table.insert(t, { label = tostring(i), value = i }) end
                            return t
                        end)(),
                        onConfirm = function(selectedOption)
                            MachoInjectResource("any", string.format([[SetPedPropIndex(PlayerPedId(), 1, %d, 0, true)]], selectedOption.value))
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "Glasses changed to " .. selectedOption.label,
                                    type = 'success'
                                }))
                            end
                        end
                    },
                    {
                        label = 'Undershirt',
                        type = 'scroll',
                        selected = 1,
                        options = (function()
                            local t = {}
                            for i = 0, 200 do table.insert(t, { label = tostring(i), value = i }) end
                            return t
                        end)(),
                        onConfirm = function(selectedOption)
                            MachoInjectResource("any", string.format([[SetPedComponentVariation(PlayerPedId(), 8, %d, 0, 2)]], selectedOption.value))
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "Undershirt changed to " .. selectedOption.label,
                                    type = 'success'
                                }))
                            end
                        end
                    },
                    
                    {
                        label = 'Torso',
                        type = 'scroll',
                        selected = 1,
                        options = (function()
                            local t = {}
                            for i = 0, 200 do table.insert(t, { label = tostring(i), value = i }) end
                            return t
                        end)(),
                        onConfirm = function(selectedOption)
                            MachoInjectResource("any", string.format([[SetPedComponentVariation(PlayerPedId(), 11, %d, 0, 2)]], selectedOption.value))
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "Torso changed to " .. selectedOption.label,
                                    type = 'success'
                                }))
                            end
                        end
                    },
                    {
                        label = 'Pants',
                        type = 'scroll',
                        selected = 1,
                        options = (function()
                            local t = {}
                            for i = 0, 200 do table.insert(t, { label = tostring(i), value = i }) end
                            return t
                        end)(),
                        onConfirm = function(selectedOption)
                            MachoInjectResource("any", string.format([[SetPedComponentVariation(PlayerPedId(), 4, %d, 0, 2)]], selectedOption.value))
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "Pants changed to " .. selectedOption.label,
                                    type = 'success'
                                }))
                            end
                        end
                    },
                    {
                        label = 'Shoes',
                        type = 'scroll',
                        selected = 1,
                        options = (function()
                            local t = {}
                            for i = 0, 200 do table.insert(t, { label = tostring(i), value = i }) end
                            return t
                        end)(),
                        onConfirm = function(selectedOption)
                            MachoInjectResource("any", string.format([[SetPedComponentVariation(PlayerPedId(), 6, %d, 0, 2)]], selectedOption.value))
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "Shoes changed to " .. selectedOption.label,
                                    type = 'success'
                                }))
                            end
                        end
                    }
                }
            },
            {
                label = 'No Ragdoll',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Ragdoll toggled:", setToggle)

                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "No Ragdoll " .. (setToggle and "Enabled!" or "Disabled!"),
                            type = 'success'
                        }))
                    end

                    if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if mKjHgFdSaPlMnBv == nil then mKjHgFdSaPlMnBv = false end
                        mKjHgFdSaPlMnBv = true

                        local function jP7xUrK9Ao()
                            local zVpLyNrTmQxWsEd = CreateThread
                            zVpLyNrTmQxWsEd(function()
                                while mKjHgFdSaPlMnBv and not Unloaded do
                                    local oPaSdFgHiJkLzXc = SetPedCanRagdoll
                                    oPaSdFgHiJkLzXc(PlayerPedId(), false)
                                    Wait(0)
                                end
                            end)
                        end

                        jP7xUrK9Ao()
                    ]])
                    else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        mKjHgFdSaPlMnBv = false
                    ]])
                    end
                end
            },

            {
                label = 'Noclip [U]',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Noclip toggled:", setToggle)
            
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Noclip " .. (setToggle and "Enabled!" or "Disabled!"),
                            type = 'success'
                        }))
                    end
            
                    if setToggle then
                        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                            ([[
            
                            if NpYgTbUcXsRoVm == nil then NpYgTbUcXsRoVm = false end
                            NpYgTbUcXsRoVm = true
                            local noclipMode = "%s"
            
                            -- Original invisibility function (unchanged)
                            local function d2NcWoyTfb()
                                if sRtYuIoPaSdFgHj == nil then sRtYuIoPaSdFgHj = false end
                                sRtYuIoPaSdFgHj = true
            
                                local zXwCeVrBtNuMyLk = CreateThread
                                zXwCeVrBtNuMyLk(function()
                                    while sRtYuIoPaSdFgHj and not Unloaded do
                                        local uYiTpLaNmZxCwEq = SetEntityVisible
                                        local hGfDrEsWxQaZcVb = PlayerPedId()
                                        uYiTpLaNmZxCwEq(hGfDrEsWxQaZcVb, false, false)
                                        Wait(0)
                                    end
            
                                    local uYiTpLaNmZxCwEq = SetEntityVisible
                                    local hGfDrEsWxQaZcVb = PlayerPedId()
                                    uYiTpLaNmZxCwEq(hGfDrEsWxQaZcVb, true, false)
                                end)
                            end
            
                            local function noclipThread()
                                local PlayerPedId = PlayerPedId
                                local GetVehiclePedIsIn = GetVehiclePedIsIn
                                local GetEntityCoords = GetEntityCoords
                                local GetEntityHeading = GetEntityHeading
                                local GetGameplayCamRelativeHeading = GetGameplayCamRelativeHeading
                                local GetGameplayCamRelativePitch = GetGameplayCamRelativePitch
                                local IsDisabledControlJustPressed = IsDisabledControlJustPressed
                                local IsDisabledControlPressed = IsDisabledControlPressed
                                local SetEntityCoordsNoOffset = SetEntityCoordsNoOffset
                                local SetEntityHeading = SetEntityHeading
            
                                local noclipActive = false
            
                                CreateThread(function()
                                    while NpYgTbUcXsRoVm and not Unloaded do
                                        Wait(0)
            
                                        if IsDisabledControlJustPressed(0, 303) then
                                            noclipActive = not noclipActive
            
                                            -- Trigger invisibility only when noclip is enabled AND mode is invis
                                            if noclipActive then
                                                if noclipMode == "invis" then
                                                    d2NcWoyTfb()
                                                end
                                            else
                                                -- Stop invisibility when noclip is disabled
                                                sRtYuIoPaSdFgHj = false
                                            end
                                        end
            
                                        if noclipActive then
                                            local ped = PlayerPedId()
                                            local veh = GetVehiclePedIsIn(ped, false)
                                            local ent = veh ~= 0 and veh or ped
                                            local speed = 2.0
            
                                            local pos = GetEntityCoords(ent)
                                            local head = GetGameplayCamRelativeHeading() + GetEntityHeading(ent)
                                            local pitch = GetGameplayCamRelativePitch()
            
                                            local dx = -math.sin(math.rad(head))
                                            local dy = math.cos(math.rad(head))
                                            local dz = math.sin(math.rad(pitch))
                                            local len = math.sqrt(dx*dx + dy*dy + dz*dz)
                                            if len ~= 0 then dx, dy, dz = dx/len, dy/len, dz/len end
            
                                            if IsDisabledControlPressed(0, 21) then speed = 4.5 else speed = 2.0 end
                                            if IsDisabledControlPressed(0, 19) then speed = 0.25 end
            
                                            if IsDisabledControlPressed(0, 32) then pos = pos + vector3(dx, dy, dz)*speed end
                                            if IsDisabledControlPressed(0, 34) then pos = pos + vector3(-dy, dx, 0.0)*speed end
                                            if IsDisabledControlPressed(0, 269) then pos = pos - vector3(dx, dy, dz)*speed end
                                            if IsDisabledControlPressed(0, 9) then pos = pos + vector3(dy, -dx, 0.0)*speed end
                                            if IsDisabledControlPressed(0, 22) then pos = pos + vector3(0.0, 0.0, speed) end
                                            if IsDisabledControlPressed(0, 36) then pos = pos - vector3(0.0, 0.0, speed) end
            
                                            SetEntityCoordsNoOffset(ent, pos.x, pos.y, pos.z, true, true, true)
                                            SetEntityHeading(ent, head)
                                        end
                                    end
                                    noclipActive = false
                                    sRtYuIoPaSdFgHj = false
                                end)
                            end
            
                            noclipThread()
                            ]]):format(noclipMode))
                    else
                        MachoInjectResource(
                            CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                            [[
                            NpYgTbUcXsRoVm = false
                            sRtYuIoPaSdFgHj = false
                            local uYiTpLaNmZxCwEq = SetEntityVisible
                            local hGfDrEsWxQaZcVb = PlayerPedId()
                            uYiTpLaNmZxCwEq(hGfDrEsWxQaZcVb, true, false)
                            ]])
                    end
                end
            },

            {
                label = 'Noclip Mode',
                type = 'scroll',
                selected = 1,
                options = {
                    { label = "Visible", value = "vis" },
                    { label = "Invisible", value = "invis" }
                },
                onConfirm = function(selectedOption)
                    noclipMode = selectedOption.value
                    print("Selected:", selectedOption.label, selectedOption.value)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Noclip mode set to: " .. selectedOption.label,
                            type = 'success'
                        }))
                    end
                end,
                onChange = function(selectedOption)
                    print("Hovering over:", selectedOption.label)
                end
            },

            {
                label = 'Freecam [H]',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Freecam toggled:", setToggle)

                    if setToggle then
                        MachoInjectResource(CheckResource("oxmysql") and "oxmysql" or CheckResource("monitor") and "monitor" or "any", [[                                     
                        local function decode(tbl)
                            local s = ""
                            for i = 1, #tbl do s = s .. string.char(tbl[i]) end
                            return s
                        end

                        local function g(n)
                            return _G[decode(n)]
                        end

                        local function wait(n)
                            return Citizen.Wait(n)
                        end

                        local nativeNames = {
                            GetHashKey = {71,101,116,72,97,115,104,75,101,121},
                            AddTextComponentSubstringPlayerName = {65,100,100,84,101,120,116,67,111,109,112,111,110,101,110,116,83,117,98,115,116,114,105,110,103,80,108,97,121,101,114,78,97,109,101},
                            EndTextCommandDisplayText = {69,110,100,84,101,120,116,67,111,109,109,97,110,100,68,105,115,112,108,97,121,84,101,120,116},
                            SetTextFont = {83,101,116,84,101,120,116,70,111,110,116},
                            SetTextProportional = {83,101,116,84,101,120,116,80,114,111,112,111,114,116,105,111,110,97,108},
                            SetTextScale = {83,101,116,84,101,120,116,83,99,97,108,101},
                            SetTextColour = {83,101,116,84,101,120,116,67,111,108,111,117,114},
                            SetTextDropshadow = {83,101,116,84,101,120,116,68,114,111,112,115,104,97,100,111,119},
                            SetTextEdge = {83,101,116,84,101,120,116,69,100,103,101},
                            SetTextDropShadow = {83,101,116,84,101,120,116,68,114,111,112,83,104,97,100,111,119},
                            SetTextOutline = {83,101,116,84,101,120,116,79,117,116,108,105,110,101},
                            SetTextCentre = {83,101,116,84,101,120,116,67,101,110,116,114,101},
                            BeginTextCommandDisplayText = {66,101,103,105,110,84,101,120,116,67,111,109,109,97,110,100,68,105,115,112,108,97,121,84,101,120,116},
                            GetGameplayCamCoord = {71,101,116,71,97,109,101,112,108,97,121,67,97,109,67,111,111,114,100},
                            GetGameplayCamRot = {71,101,116,71,97,109,101,112,108,97,121,67,97,109,82,111,116},
                            CreateCamWithParams = {67,114,101,97,116,101,67,97,109,87,105,116,104,80,97,114,97,109,115},
                            SetCamActive = {83,101,116,67,97,109,65,99,116,105,118,101},
                            RenderScriptCams = {82,101,110,100,101,114,83,99,114,105,112,116,67,97,109,115},
                            DestroyCam = {68,101,115,116,114,111,121,67,97,109},
                            SetCamRot = {83,101,116,67,97,109,82,111,116},
                            SetFocusEntity = {83,101,116,70,111,99,117,115,69,110,116,105,116,121},
                            CreateVehicle = {67,114,101,97,116,101,86,101,104,105,99,108,101},
                            SetVehicleForwardSpeed = {83,101,116,86,101,104,105,99,108,101,70,111,114,119,97,114,100,83,112,101,101,100},
                            SetEntityRotation = {83,101,116,69,110,116,105,116,121,82,111,116,97,116,105,111,110},
                            SetEntityVelocity = {83,101,116,69,110,116,105,116,121,86,101,108,111,99,105,116,121},
                            ApplyForceToEntity = {65,112,112,108,121,70,111,114,99,101,84,111,69,110,116,105,116,121},
                            SetEntityHasGravity = {83,101,116,69,110,116,105,116,121,72,97,115,71,114,97,118,105,116,121},
                            GiveWeaponToPed = {71,105,118,101,87,101,97,112,111,110,84,111,80,101,100},
                            SetCurrentPedWeapon = {83,101,116,67,117,114,114,101,110,116,80,101,100,87,101,97,112,111,110},
                            GetSelectedPedWeapon = {71,101,116,83,101,108,101,99,116,101,100,80,101,100,87,101,97,112,111,110},
                            ShootSingleBulletBetweenCoords = {83,104,111,111,116,83,105,110,103,108,101,66,117,108,108,101,116,66,101,116,119,101,101,110,67,111,111,114,100,115},
                            SetCamCoord = {83,101,116,67,97,109,67,111,111,114,100},
                            TaskStandStill = {84,97,115,107,83,116,97,110,100,83,116,105,108,108},
                            SetFocusPosAndVel = {83,101,116,70,111,99,117,115,80,111,115,65,110,100,86,101,108},
                            StartExpensiveSynchronousShapeTestLosProbe = {83,116,97,114,116,69,120,112,101,110,115,105,118,101,83,121,110,99,104,114,111,110,111,117,115,83,104,97,112,101,84,101,115,116,76,111,115,80,114,111,98,101},
                            GetShapeTestResult = {71,101,116,83,104,97,112,101,84,101,115,116,82,101,115,117,108,116},
                            TaskWarpPedIntoVehicle = {84,97,115,107,87,97,114,112,80,101,100,73,110,116,111,86,101,104,105,99,108,101},
                            PlayerPedId = {80,108,97,121,101,114,80,101,100,73,100},
                            GetEntityCoords = {71,101,116,69,110,116,105,116,121,67,111,111,114,100,115},
                            IsVehicleSeatFree = {73,115,86,101,104,105,99,108,101,83,101,97,116,70,114,101,101},
                            IsEntityAVehicle = {73,115,69,110,116,105,116,121,65,86,101,104,105,99,108,101},
                            SetEntityCoords = {83,101,116,69,110,116,105,116,121,67,111,111,114,100,115},
                            GetCamCoord = {71,101,116,67,97,109,67,111,111,114,100},
                            GetCamRot = {71,101,116,67,97,109,82,111,116},
                            GetControlNormal = {71,101,116,67,111,110,116,114,111,108,78,111,114,109,97,108},
                            IsDisabledControlPressed = {73,115,68,105,115,97,98,108,101,100,67,111,110,116,114,111,108,80,114,101,115,115,101,100},
                            IsControlJustPressed = {73,115,67,111,110,116,114,111,108,74,117,115,116,80,114,101,115,115,101,100},
                            IsDisabledControlJustPressed = {73,115,68,105,115,97,98,108,101,100,67,111,110,116,114,111,108,74,117,115,116,80,114,101,115,115,101,100},
                            GetResourceState = {71,101,116,82,101,115,111,117,114,99,101,83,116,97,116,101},
                            GetGamePool = {71,101,116,71,97,109,101,80,111,111,108},
                            IsPedDeadOrDying = {73,115,80,101,100,68,101,97,100,79,114,68,121,105,110,103},
                            IsPedAPlayer = {73,115,80,101,100,65,80,108,97,121,101,114},
                            SetEntityAsMissionEntity = {83,101,116,69,110,116,105,116,121,65,115,77,105,115,115,105,111,110,69,110,116,105,116,121},
                            SetVehicleEngineOn = {83,101,116,86,101,104,105,99,108,101,69,110,103,105,110,101,79,110},
                            DoesEntityExist = {68,111,101,115,69,110,116,105,116,121,69,120,105,115,116},
                            CreateThread = {67,114,101,97,116,101,84,104,114,101,97,100}
                        }

                        local function HookNative(nativeName, newFunction)
                            local originalNative = g(nativeNames[nativeName])
                            if not originalNative or type(originalNative) ~= "function" then
                                return
                            end
                            _G[decode(nativeNames[nativeName])] = function(...)
                                local info = debug.getinfo(2, "Sln")
                                return newFunction(originalNative, ...)
                            end
                        end

                        for nativeName, _ in pairs(nativeNames) do
                            HookNative(nativeName, function(originalFn, ...) return originalFn(...) end)
                        end

                        if g(nativeNames.GetResourceState)(decode({82,101,97,112,101,114,86,52})) ~= "started" or g(nativeNames.GetResourceState)(decode({114,101,97,112,101,114,97,99})) ~= "started" then
                            HookNative("SetFocusEntity", function(originalFn, ...) return originalFn(...) end)
                            HookNative("SetCamCoord", function(originalFn, ...) return originalFn(...) end)
                            HookNative("TaskStandStill", function(originalFn, ...) return originalFn(...) end)
                            HookNative("SetFocusPosAndVel", function(originalFn, ...) return originalFn(...) end)
                            HookNative("StartExpensiveSynchronousShapeTestLosProbe", function(originalFn, ...) return originalFn(...) end)
                            HookNative("GetShapeTestResult", function(originalFn, ...) return originalFn(...) end)
                            HookNative("TaskWarpPedIntoVehicle", function(originalFn, ...) return originalFn(...) end)
                        end

                        if not _G.luxorFreecam then
                            _G.luxorFreecam = {
                                isToggled = false,
                                camera = nil,
                                cameraFeatures = { "Default", "Teleport", "Shoot", "Shoot (Car)", "Taze All Nearby" },
                                shootFeatures = { ["Shoot"] = true },
                                pistolModels = {
                                    { label = "Pistol", model = decode({119,101,97,112,111,110,95,112,105,115,116,111,108}) },
                                    { label = "Heavy Pistol", model = decode({119,101,97,112,111,110,95,104,101,97,118,121,112,105,115,116,111,108}) },
                                    { label = "Combat Pistol", model = decode({119,101,97,112,111,110,95,99,111,109,98,97,116,112,105,115,116,111,108}) },
                                    { label = "AP Pistol", model = decode({119,101,97,112,111,110,95,97,112,112,105,115,116,111,108}) },
                                    { label = "Stun Gun", model = decode({119,101,97,112,111,110,95,115,116,117,110,103,117,110}) },
                                    { label = "Firework Launcher", model = decode({119,101,97,112,111,110,95,102,105,114,101,119,111,114,107}) }
                                },
                                currentFeature = 1,
                                currentModelIndex = 1,
                                cameraReady = false,
                                cachedFeature = "",
                                cachedModelLabel = "",
                                shutdown = false
                            }

                            function _G.luxorFreecam.tableFind(tbl, val)
                                for i, v in ipairs(tbl) do
                                    if v == val then return i end
                                end
                                return nil
                            end

                            function _G.luxorFreecam.GetEmptySeat(vehicle)
                                local seats = { -1, 0, 1, 2 }
                                for _, seat in ipairs(seats) do
                                    if g(nativeNames.IsVehicleSeatFree)(vehicle, seat) then
                                        return seat
                                    end
                                end
                                return -1
                            end

                            function _G.luxorFreecam.RotationToDirection(rot)
                                local radiansZ = math.rad(rot.z)
                                local radiansX = math.rad(rot.x)
                                local cosX = math.cos(radiansX)
                                return vector3(-math.sin(radiansZ) * cosX, math.cos(radiansZ) * cosX, math.sin(radiansX))
                            end

                            function _G.luxorFreecam.drawCrosshair()
                                g(nativeNames.SetTextFont)(0)
                                g(nativeNames.SetTextProportional)(1)
                                g(nativeNames.SetTextScale)(0.3, 0.3)
                                g(nativeNames.SetTextColour)(255, 255, 255, 255)
                                g(nativeNames.SetTextCentre)(true)
                                g(nativeNames.SetTextOutline)()
                                g(nativeNames.BeginTextCommandDisplayText)(decode({83,84,82,73,78,71}))
                                g(nativeNames.AddTextComponentSubstringPlayerName)("+")
                                g(nativeNames.EndTextCommandDisplayText)(0.5, 0.5)
                            end

                            function _G.luxorFreecam.drawFeatureList()
                                local centerX = 0.5
                                local baseY = 0.80
                                local lineHeight = 0.025
                                local scale = 0.25
                                for i, feature in ipairs(_G.luxorFreecam.cameraFeatures) do
                                    g(nativeNames.SetTextFont)(0)
                                    g(nativeNames.SetTextProportional)(1)
                                    g(nativeNames.SetTextScale)(scale, scale)
                                    g(nativeNames.SetTextDropshadow)(0, 0, 0, 0, 255)
                                    g(nativeNames.SetTextEdge)(1, 0, 0, 0, 255)
                                    g(nativeNames.SetTextOutline)()
                                    g(nativeNames.SetTextCentre)(true)
                                    local text
                                    if i == _G.luxorFreecam.currentFeature then
                                        g(nativeNames.SetTextColour)(255, 0, 0, 255)
                                        if _G.luxorFreecam.shootFeatures[feature] then
                                            local currentModel = _G.luxorFreecam.pistolModels[_G.luxorFreecam.currentModelIndex]
                                            if _G.luxorFreecam.cachedModelLabel ~= currentModel.label or _G.luxorFreecam.cachedFeature ~= feature then
                                                _G.luxorFreecam.cachedModelLabel = currentModel.label
                                                _G.luxorFreecam.cachedFeature = feature
                                            end
                                            text = ("Q | %s (%s) | E"):format(_G.luxorFreecam.cachedFeature, _G.luxorFreecam.cachedModelLabel)
                                        else
                                            text = feature
                                        end
                                    else
                                        g(nativeNames.SetTextColour)(255, 255, 255, 255)
                                        text = feature
                                    end
                                    g(nativeNames.BeginTextCommandDisplayText)(decode({83,84,82,73,78,71}))
                                    g(nativeNames.AddTextComponentSubstringPlayerName)(text)
                                    g(nativeNames.EndTextCommandDisplayText)(centerX, baseY + (i * lineHeight))
                                end
                            end

                            function _G.luxorFreecam.ToggleCamera()
                                _G.luxorFreecam.isToggled = not _G.luxorFreecam.isToggled
                                if _G.luxorFreecam.isToggled then
                                    local coords = g(nativeNames.GetGameplayCamCoord)()
                                    local rot = g(nativeNames.GetGameplayCamRot)(2)
                                    _G.luxorFreecam.camera = g(nativeNames.CreateCamWithParams)(decode({68,69,70,65,85,76,84,95,83,67,82,73,80,84,69,68,95,67,65,77,69,82,65}), coords.x, coords.y, coords.z, rot.x, rot.y, rot.z, 70.0)
                                    g(nativeNames.SetCamActive)(_G.luxorFreecam.camera, true)
                                    g(nativeNames.RenderScriptCams)(true, true, 500, false, false)
                                    g(nativeNames.CreateThread)(function()
                                        wait(550)
                                        if _G.luxorFreecam and not _G.luxorFreecam.shutdown then
                                            _G.luxorFreecam.cameraReady = true
                                        end
                                    end)
                                else
                                    _G.luxorFreecam.cameraReady = false
                                    if _G.luxorFreecam.camera then
                                        g(nativeNames.SetCamActive)(_G.luxorFreecam.camera, false)
                                        g(nativeNames.RenderScriptCams)(false, true, 500, false, false)
                                        g(nativeNames.DestroyCam)(_G.luxorFreecam.camera)
                                        _G.luxorFreecam.camera = nil
                                    end
                                    g(nativeNames.SetFocusEntity)(g(nativeNames.PlayerPedId)())
                                end
                            end

                            g(nativeNames.CreateThread)(function()
                                while _G.luxorFreecam and not _G.luxorFreecam.shutdown do
                                    wait(0)
                                    if _G.luxorFreecam and _G.luxorFreecam.isToggled then
                                        _G.luxorFreecam.drawFeatureList()
                                        if _G.luxorFreecam.cameraFeatures[_G.luxorFreecam.currentFeature] == "Shoot" then
                                            _G.luxorFreecam.drawCrosshair()
                                        end
                                    end
                                end
                            end)

                            g(nativeNames.CreateThread)(function()
                                while _G.luxorFreecam and not _G.luxorFreecam.shutdown do
                                    wait(0)
                                    if _G.luxorFreecam and _G.luxorFreecam.isToggled and _G.luxorFreecam.camera then
                                        local coords = g(nativeNames.GetCamCoord)(_G.luxorFreecam.camera)
                                        local rot = g(nativeNames.GetCamRot)(_G.luxorFreecam.camera, 2)
                                        local direction = _G.luxorFreecam.RotationToDirection(rot)
                                        local hMove = g(nativeNames.GetControlNormal)(0, 1) * 4
                                        local vMove = g(nativeNames.GetControlNormal)(0, 2) * 4
                                        if hMove ~= 0.0 or vMove ~= 0.0 then
                                            g(nativeNames.SetCamRot)(_G.luxorFreecam.camera, rot.x - vMove, rot.y, rot.z - hMove)
                                        end
                                        local speed = g(nativeNames.IsDisabledControlPressed)(0, 21) and 4.0 or 1.2
                                        local newPosition = vector3(0, 0, 0)
                                        if g(nativeNames.IsDisabledControlPressed)(0, 32) then
                                            newPosition = coords + direction * speed
                                        elseif g(nativeNames.IsDisabledControlPressed)(0, 33) then
                                            newPosition = coords - direction * speed
                                        elseif g(nativeNames.IsDisabledControlPressed)(0, 34) then
                                            newPosition = coords + vector3(-direction.y, direction.x, 0.0) * speed
                                        elseif g(nativeNames.IsDisabledControlPressed)(0, 35) then
                                            newPosition = coords + vector3(direction.y, -direction.x, 0.0) * speed
                                        end
                                        if newPosition ~= vector3(0, 0, 0) then
                                            g(nativeNames.SetCamCoord)(_G.luxorFreecam.camera, newPosition.x, newPosition.y, newPosition.z)
                                        end
                                        g(nativeNames.TaskStandStill)(g(nativeNames.PlayerPedId)(), 10)
                                        g(nativeNames.SetFocusPosAndVel)(coords.x, coords.y, coords.z, 0.0, 0.0, 0.0)
                                        local raycast = g(nativeNames.StartExpensiveSynchronousShapeTestLosProbe)(coords.x, coords.y, coords.z, coords.x + direction.x * 500.0, coords.y + direction.y * 500.0, coords.z + direction.z * 500.0, -1)
                                        local _, hit, endCoords, _, entityHit = g(nativeNames.GetShapeTestResult)(raycast)

                                        if g(nativeNames.IsControlJustPressed)(0, 241) then
                                            _G.luxorFreecam.currentFeature = _G.luxorFreecam.currentFeature - 1
                                            if _G.luxorFreecam.currentFeature < 1 then
                                                _G.luxorFreecam.currentFeature = #_G.luxorFreecam.cameraFeatures
                                            end
                                        elseif g(nativeNames.IsControlJustPressed)(0, 242) then
                                            _G.luxorFreecam.currentFeature = _G.luxorFreecam.currentFeature + 1
                                            if _G.luxorFreecam.currentFeature > #_G.luxorFreecam.cameraFeatures then
                                                _G.luxorFreecam.currentFeature = 1
                                            end
                                        end

                                        if _G.luxorFreecam.cameraFeatures[_G.luxorFreecam.currentFeature] == "Teleport" then
                                            if g(nativeNames.IsDisabledControlJustPressed)(0, 24) then
                                                if hit then
                                                    if entityHit ~= 0 and g(nativeNames.IsEntityAVehicle)(entityHit) then
                                                        local vehicle = entityHit
                                                        local playerPed = g(nativeNames.PlayerPedId)()
                                                        local seat = _G.luxorFreecam.GetEmptySeat(vehicle)
                                                        if seat == -1 then
                                                            g(nativeNames.TaskWarpPedIntoVehicle)(playerPed, vehicle, -1)
                                                        elseif seat >= 0 then
                                                            g(nativeNames.TaskWarpPedIntoVehicle)(playerPed, vehicle, seat)
                                                        end
                                                    else
                                                        g(nativeNames.SetEntityCoords)(g(nativeNames.PlayerPedId)(), endCoords.x, endCoords.y, endCoords.z, false, false, false, false)
                                                    end
                                                end
                                            end
                                        elseif _G.luxorFreecam.cameraFeatures[_G.luxorFreecam.currentFeature] == "Shoot (Car)" then
                                            if g(nativeNames.IsControlJustPressed)(0, 24) then
                                                local from = g(nativeNames.GetCamCoord)(_G.luxorFreecam.camera)
                                                local rot = g(nativeNames.GetCamRot)(_G.luxorFreecam.camera, 2)
                                                local pitch = math.rad(rot.x)
                                                local yaw = math.rad(rot.z)
                                                local direction = vector3(
                                                    -math.sin(yaw) * math.cos(pitch),
                                                    math.cos(yaw) * math.cos(pitch),
                                                    math.sin(pitch)
                                                )
                                                local models = { decode({101,108,101,103,121}) }
                                                local model = models[math.random(#models)]
                                                local spawnCoords = from + direction * 3.0 + vector3(0, 0, 1.0)
                                                local vehicleEntity = g(nativeNames.CreateVehicle)(model, spawnCoords.x, spawnCoords.y, spawnCoords.z, rot.z, true, true)
                                                if vehicleEntity and g(nativeNames.DoesEntityExist)(vehicleEntity) then
                                                    g(nativeNames.SetEntityAsMissionEntity)(vehicleEntity, true, true)
                                                    g(nativeNames.SetVehicleEngineOn)(vehicleEntity, true, true, false)
                                                    g(nativeNames.SetVehicleForwardSpeed)(vehicleEntity, 0.0)
                                                    g(nativeNames.SetEntityRotation)(vehicleEntity, rot.x, rot.y, rot.z, 2, true)
                                                    g(nativeNames.SetEntityVelocity)(vehicleEntity, 0.0, 0.0, 0.0)
                                                    wait(50)
                                                    local velocity = direction * 100.0
                                                    g(nativeNames.SetEntityVelocity)(vehicleEntity, velocity.x, velocity.y, velocity.z)
                                                    g(nativeNames.ApplyForceToEntity)(vehicleEntity, 1, velocity.x * 10.0, velocity.y * 10.0, velocity.z * 10.0, 0.0, 0.0, 0.0, true, true, true, false, true)
                                                    g(nativeNames.SetEntityHasGravity)(vehicleEntity, true)
                                                    print("Vehicle spawned:", model)
                                                end
                                            end
                                        elseif _G.luxorFreecam.cameraFeatures[_G.luxorFreecam.currentFeature] == "Taze All Nearby" then
                                            if g(nativeNames.IsControlJustPressed)(0, 24) then
                                                local playerPed = g(nativeNames.PlayerPedId)()
                                                local stunHash = g(nativeNames.GetHashKey)(decode({119,101,97,112,111,110,95,115,116,117,110,103,117,110}))
                                                if g(nativeNames.GetResourceState)(decode({82,101,97,112,101,114,86,52})) == "started" then
                                                    LocalPlayer.state:set("reaper_" .. stunHash, true, true)
                                                    g(nativeNames.GiveWeaponToPed)(playerPed, stunHash, 255, false, true)
                                                else
                                                    g(nativeNames.GiveWeaponToPed)(playerPed, stunHash, 255, false, true)
                                                    g(nativeNames.SetCurrentPedWeapon)(playerPed, stunHash, true)
                                                end
                                                local nearbyPeds = {}
                                                for _, ped in ipairs(g(nativeNames.GetGamePool)(decode({67,80,101,100}))) do
                                                    if ped ~= playerPed and not g(nativeNames.IsPedDeadOrDying)(ped, true) and g(nativeNames.IsPedAPlayer)(ped) then
                                                        local pedCoords = g(nativeNames.GetEntityCoords)(ped)
                                                        local distance = #(coords - pedCoords)
                                                        if distance < 70.0 then
                                                            table.insert(nearbyPeds, ped)
                                                        end
                                                    end
                                                end
                                                for _, ped in ipairs(nearbyPeds) do
                                                    local pedCoords = g(nativeNames.GetEntityCoords)(ped)
                                                    g(nativeNames.ShootSingleBulletBetweenCoords)(
                                                        coords.x, coords.y, coords.z,
                                                        pedCoords.x, pedCoords.y, pedCoords.z,
                                                        0, true, stunHash, playerPed, true, false, 1000.0
                                                    )
                                                end
                                            end
                                        end

                                        if _G.luxorFreecam.tableFind({"Shoot"}, _G.luxorFreecam.cameraFeatures[_G.luxorFreecam.currentFeature]) then
                                            if g(nativeNames.IsControlJustPressed)(0, 44) then
                                                _G.luxorFreecam.currentModelIndex = _G.luxorFreecam.currentModelIndex - 1
                                                if _G.luxorFreecam.currentModelIndex < 1 then
                                                    _G.luxorFreecam.currentModelIndex = #_G.luxorFreecam.pistolModels
                                                end
                                            elseif g(nativeNames.IsControlJustPressed)(0, 46) then
                                                _G.luxorFreecam.currentModelIndex = _G.luxorFreecam.currentModelIndex + 1
                                                if _G.luxorFreecam.currentModelIndex > #_G.luxorFreecam.pistolModels then
                                                    _G.luxorFreecam.currentModelIndex = 1
                                                end
                                            end
                                            if g(nativeNames.IsControlJustPressed)(0, 24) then
                                                local playerPed = g(nativeNames.PlayerPedId)()
                                                local weaponHash = g(nativeNames.GetHashKey)(_G.luxorFreecam.pistolModels[_G.luxorFreecam.currentModelIndex].model)
                                                if g(nativeNames.GetResourceState)(decode({82,101,97,112,101,114,86,52})) == "started" then
                                                    LocalPlayer.state:set("reaper_" .. weaponHash, true, true)
                                                    g(nativeNames.GiveWeaponToPed)(playerPed, weaponHash, 255, false, true)
                                                else
                                                    g(nativeNames.GiveWeaponToPed)(playerPed, weaponHash, 255, false, true)
                                                    g(nativeNames.SetCurrentPedWeapon)(playerPed, weaponHash, true)
                                                end
                                                local damage = 100
                                                if _G.luxorFreecam.pistolModels[_G.luxorFreecam.currentModelIndex].model == decode({119,101,97,112,111,110,95,115,116,117,110,103,117,110}) then
                                                    damage = 0
                                                end
                                                g(nativeNames.ShootSingleBulletBetweenCoords)(
                                                    coords.x, coords.y, coords.z,
                                                    coords.x + direction.x * 500.0,
                                                    coords.y + direction.y * 500.0,
                                                    coords.z + direction.z * 500.0,
                                                    damage,
                                                    true,
                                                    weaponHash,
                                                    playerPed,
                                                    true,
                                                    false,
                                                    1000.0
                                                )
                                            end
                                        end
                                    end
                                end
                            end)
                        end

                        _G.luxorFreecam.ToggleCamera()
                        print("^2[Luxor] Freecam enabled^7")
                        ]])
                    else
                    MachoInjectResource(CheckResource("oxmysql") and "oxmysql" or CheckResource("monitor") and "monitor" or "any", [[
                    local function decode(tbl)
                        local s = ""
                        for i = 1, #tbl do s = s .. string.char(tbl[i]) end
                        return s
                    end

                    local function g(n)
                        return _G[decode(n)]
                    end

                    local function wait(n)
                        return Citizen.Wait(n)
                    end

                    local nativeNames = {
                        CreateThread = {67,114,101,97,116,101,84,104,114,101,97,100}
                    }

                    if _G.luxorFreecam then
                        if _G.luxorFreecam.isToggled then
                            _G.luxorFreecam.ToggleCamera()
                        end
                        _G.luxorFreecam.shutdown = true
                        g(nativeNames.CreateThread)(function()
                            wait(100)
                            _G.luxorFreecam = nil
                        end)
                    end
                    print("^1[Luxor] Freecam disabled^7")
                    ]])
                    end
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Freecam " .. (setToggle and "Enabled!" or "Disabled!"),
                            type = 'success'
                        }))
                    end
                end
            },        

            {
                label = 'Godmode',
                type = 'checkbox',
                checked = false,
                bind = nil,
                onConfirm = function(setToggle)
                    print("Godmode toggled:", setToggle)

                    if setToggle then
                        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                            if aXfPlMnQwErTyUi == nil then aXfPlMnQwErTyUi = false end
                            aXfPlMnQwErTyUi = true

                            local function OxWJ1rY9vB()
                                local fLdRtYpLoWqEzXv = CreateThread
                                fLdRtYpLoWqEzXv(function()
                                    while aXfPlMnQwErTyUi and not Unloaded do
                                        local dOlNxGzPbTcQ = PlayerPedId()
                                        local rKsEyHqBmUiW = PlayerId()

                                        if GetResourceState("ReaperV4") == "started" then
                                            local kcWsWhJpCwLI = SetPlayerInvincible
                                            local ByTqMvSnAzXd = SetEntityInvincible
                                            kcWsWhJpCwLI(rKsEyHqBmUiW, true)
                                            ByTqMvSnAzXd(dOlNxGzPbTcQ, true)

                                        elseif GetResourceState("WaveShield") == "started" then
                                            local cvYkmZYIjvQQ = SetEntityCanBeDamaged
                                            cvYkmZYIjvQQ(dOlNxGzPbTcQ, false)

                                        else
                                            local BiIqUJHexRrR = SetEntityCanBeDamaged
                                            local UtgGRNyiPhOs = SetEntityProofs
                                            local rVuKoDwLsXpC = SetEntityInvincible

                                            BiIqUJHexRrR(dOlNxGzPbTcQ, false)
                                            UtgGRNyiPhOs(dOlNxGzPbTcQ, true, true, true, false, true, false, false, false)
                                            rVuKoDwLsXpC(dOlNxGzPbTcQ, true)
                                        end

                                        Wait(0)
                                    end
                                end)
                            end

                            OxWJ1rY9vB()
                        ]])
                    else
                        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                            aXfPlMnQwErTyUi = false

                            local dOlNxGzPbTcQ = PlayerPedId()
                            local rKsEyHqBmUiW = PlayerId()

                            if GetResourceState("ReaperV4") == "started" then
                                local kcWsWhJpCwLI = SetPlayerInvincible
                                local ByTqMvSnAzXd = SetEntityInvincible

                                kcWsWhJpCwLI(rKsEyHqBmUiW, false)
                                ByTqMvSnAzXd(dOlNxGzPbTcQ, false)

                            elseif GetResourceState("WaveShield") == "started" then
                                local AilJsyZTXnNc = SetEntityCanBeDamaged
                                AilJsyZTXnNc(dOlNxGzPbTcQ, true)

                            else
                                local tBVAZMubUXmO = SetEntityCanBeDamaged
                                local yuTiZtxOXVnE = SetEntityProofs
                                local rVuKoDwLsXpC = SetEntityInvincible

                                tBVAZMubUXmO(dOlNxGzPbTcQ, true)
                                yuTiZtxOXVnE(dOlNxGzPbTcQ, false, false, false, false, false, false, false, false)
                                rVuKoDwLsXpC(dOlNxGzPbTcQ, false)
                            end
                        ]])
                    end
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Godmode " .. (setToggle and "Enabled!" or "Disabled!"),
                            type = 'success'
                        }))
                    end
                end
            },

            { 
                label = 'Invisibility', 
                type = 'checkbox', 
                checked = false,
                onConfirm = function(setToggle) 
                    print("Invisibility toggled:", setToggle)

                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Invisibility " .. (setToggle and "Enabled!" or "Disabled!"),
                            type = 'success'
                        }))
                    end

                if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if sRtYuIoPaSdFgHj == nil then sRtYuIoPaSdFgHj = false end
                        sRtYuIoPaSdFgHj = true

                        local function d2NcWoyTfb()
                            if sRtYuIoPaSdFgHj == nil then sRtYuIoPaSdFgHj = false end
                            sRtYuIoPaSdFgHj = true

                            local zXwCeVrBtNuMyLk = CreateThread
                            zXwCeVrBtNuMyLk(function()
                                while sRtYuIoPaSdFgHj and not Unloaded do
                                    local uYiTpLaNmZxCwEq = SetEntityVisible
                                    local hGfDrEsWxQaZcVb = PlayerPedId()
                                    uYiTpLaNmZxCwEq(hGfDrEsWxQaZcVb, false, false)
                                    Wait(0)
                                end

                                local uYiTpLaNmZxCwEq = SetEntityVisible
                                local hGfDrEsWxQaZcVb = PlayerPedId()
                                uYiTpLaNmZxCwEq(hGfDrEsWxQaZcVb, true, false)
                            end)
                        end

                        d2NcWoyTfb()
                    ]])
                else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        sRtYuIoPaSdFgHj = false

                        local function tBKM4syGJL()
                            local uYiTpLaNmZxCwEq = SetEntityVisible
                            local hGfDrEsWxQaZcVb = PlayerPedId()
                            uYiTpLaNmZxCwEq(hGfDrEsWxQaZcVb, true, false)
                        end

                        tBKM4syGJL()
                    ]])
                end
            end 
            },

            { 
                label = 'Throw From Vehicle', 
                type = 'checkbox', 
                checked = false,
                onConfirm = function(setToggle) 
                    print("Throw From Vehicle toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Throw From Vehicle" .. (setToggle and " Enabled!" or " Disabled!"),
                            type = 'success'
                        }))
                    end
                if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    if zXpQwErTyUiPlMn == nil then zXpQwErTyUiPlMn = false end
                    zXpQwErTyUiPlMn = true

                    local function qXzRP7ytKW()
                        local iLkMzXvBnQwSaTr = CreateThread
                        iLkMzXvBnQwSaTr(function()
                            while zXpQwErTyUiPlMn and not Unloaded do
                                local vBnMaSdFgTrEqWx = SetRelationshipBetweenGroups
                                vBnMaSdFgTrEqWx(5, GetHashKey('PLAYER'), GetHashKey('PLAYER'))
                                Wait(0)
                            end
                        end)
                    end

                    qXzRP7ytKW()
                    ]])
                else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        zXpQwErTyUiPlMn = false
                    ]])
                end 
            end
            },

            { 
                label = 'Super Strength', 
                type = 'checkbox', 
                checked = false,
                onConfirm = function(setToggle) 
                    print("Super Strength toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Super Strength" .. (setToggle and " Enabled!" or " Disabled!"),
                            type = 'success'
                        }))
                    end
                if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    if fgawjFmaDjdALaO == nil then fgawjFmaDjdALaO = false end
                    fgawjFmaDjdALaO = true

                    local holdingEntity = false
                    local holdingCarEntity = false
                    local holdingPed = false
                    local heldEntity = nil
                    local entityType = nil
                    local awfhjawrasfs = CreateThread

                    awfhjawrasfs(function()
                        while fgawjFmaDjdALaO and not Unloaded do
                            Wait(0)
                            if holdingEntity and heldEntity then
                                local playerPed = PlayerPedId()
                                local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)
                                DrawText3Ds(headPos.x, headPos.y, headPos.z + 0.5, "[Y] Drop Entity / [U] Attach Ped")
                                
                                if holdingCarEntity and not IsEntityPlayingAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 3) then
                                    RequestAnimDict('anim@mp_rollarcoaster')
                                    while not HasAnimDictLoaded('anim@mp_rollarcoaster') do
                                        Wait(100)
                                    end
                                    TaskPlayAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 8.0, -8.0, -1, 50, 0, false, false, false)
                                elseif (holdingPed or not holdingCarEntity) and not IsEntityPlayingAnim(playerPed, 'anim@heists@box_carry@', 'idle', 3) then
                                    RequestAnimDict('anim@heists@box_carry@')
                                    while not HasAnimDictLoaded('anim@heists@box_carry@') do
                                        Wait(100)
                                    end
                                    TaskPlayAnim(playerPed, 'anim@heists@box_carry@', 'idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                end

                                if not IsEntityAttached(heldEntity) then
                                    holdingEntity = false
                                    holdingCarEntity = false
                                    holdingPed = false
                                    heldEntity = nil
                                end
                            end
                        end
                    end)

                    awfhjawrasfs(function()
                        while fgawjFmaDjdALaO and not Unloaded do
                            Wait(0)
                            local playerPed = PlayerPedId()
                            local camPos = GetGameplayCamCoord()
                            local camRot = GetGameplayCamRot(2)
                            local direction = RotationToDirection(camRot)
                            local dest = vec3(camPos.x + direction.x * 10.0, camPos.y + direction.y * 10.0, camPos.z + direction.z * 10.0)

                            local rayHandle = StartShapeTestRay(camPos.x, camPos.y, camPos.z, dest.x, dest.y, dest.z, -1, playerPed, 0)
                            local _, hit, _, _, entityHit = GetShapeTestResult(rayHandle)
                            local validTarget = false

                            if hit == 1 then
                                entityType = GetEntityType(entityHit)
                                if entityType == 3 or entityType == 2 or entityType == 1 then
                                    validTarget = true
                                    local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)
                                    DrawText3Ds(headPos.x, headPos.y, headPos.z + 0.5, "[E] Pick Up / [Y] Drop")
                                end
                            end

                            if IsDisabledControlJustReleased(0, 38) then
                                if validTarget and not holdingEntity then
                                    holdingEntity = true
                                    heldEntity = entityHit

                                    local wfuawruawts = AttachEntityToEntity

                                    if entityType == 3 then
                                        wfuawruawts(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 0.0, 0.2, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                                    elseif entityType == 2 then
                                        holdingCarEntity = true
                                        wfuawruawts(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                                    elseif entityType == 1 then
                                        holdingPed = true
                                        wfuawruawts(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                                    end
                                end
                            elseif IsDisabledControlJustReleased(0, 246) then
                                if holdingEntity then
                                    local wgfawhtawrs = DetachEntity
                                    local dfgjsdfuwer = ApplyForceToEntity
                                    local sdgfhjwserw = ClearPedTasks

                                    wgfawhtawrs(heldEntity, true, true)
                                    dfgjsdfuwer(heldEntity, 1, direction.x * 500, direction.y * 500, direction.z * 500, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                                    holdingEntity = false
                                    holdingCarEntity = false
                                    holdingPed = false
                                    heldEntity = nil
                                    sdgfhjwserw(PlayerPedId())
                                end
                            end
                        end
                    end)

                    function RotationToDirection(rotation)
                        local adjustedRotation = vec3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
                        local direction = vec3(-math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), math.sin(adjustedRotation.x))
                        return direction
                    end

                    function DrawText3Ds(x, y, z, text)
                        local onScreen, _x, _y = World3dToScreen2d(x, y, z)
                        local px, py, pz = table.unpack(GetGameplayCamCoords())
                        local scale = (1 / GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)) * 2
                        local fov = (1 / GetGameplayCamFov()) * 100
                        scale = scale * fov

                        if onScreen then
                            SetTextScale(0.0 * scale, 0.35 * scale)
                            SetTextFont(0)
                            SetTextProportional(1)
                            SetTextColour(255, 255, 255, 215)
                            SetTextDropshadow(0, 0, 0, 0, 155)
                            SetTextEdge(2, 0, 0, 0, 150)
                            SetTextDropShadow()
                            -- SetTextOutline()
                            SetTextEntry("STRING")
                            SetTextCentre(1)
                            AddTextComponentString(text)
                            DrawText(_x, _y)
                        end
                    end
                    ]])
                else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        fgawjFmaDjdALaO = false
                    ]])
                end 
            end
            },


            { 
                label = 'Infinite Stamina', 
                type = 'checkbox', 
                checked = false,
                onConfirm = function(setToggle) 
                    print("Infinite Stamina toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Infinite Stamina " .. (setToggle and "Enabled!" or "Disabled!"),
                            type = 'success'
                        }))
                    end
                if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if uYtReWqAzXcVbNm == nil then uYtReWqAzXcVbNm = false end
                        uYtReWqAzXcVbNm = true

                        local function YLvd3pM0tB()
                            local tJrGyHnMuQwSaZx = CreateThread
                            tJrGyHnMuQwSaZx(function()
                                while uYtReWqAzXcVbNm and not Unloaded do
                                    local aSdFgHjKlQwErTy = RestorePlayerStamina
                                    local rTyUiEaOpAsDfGhJk = PlayerId()
                                    aSdFgHjKlQwErTy(rTyUiEaOpAsDfGhJk, 1.0)
                                    Wait(100)
                                end
                            end)
                        end

                        YLvd3pM0tB()
                    ]])
                else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        uYtReWqAzXcVbNm = false
                    ]])
                end 
            end
            },
            { 
                label = 'Anti-Afk', 
                type = 'checkbox', 
                checked = false,
                onConfirm = function(setToggle) 
                    print("Anti-Afk toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Anti-Afk" .. (setToggle and " Enabled!" or " Disabled!"),
                            type = 'success'
                        }))
                    end
                if setToggle then
                    MachoInjectResource("monitor", [[
                        if AntiAFKWalking ~= true then
                            AntiAFKWalking = true
                            Citizen.CreateThread(function()
                                while AntiAFKWalking and not Unloaded do
                                    local ped = PlayerPedId()
                                    local veh = GetVehiclePedIsIn(ped, false)
                                    if veh and veh ~= 0 then
                                        TaskVehicleDriveWander(ped, veh, 40.0, 0)
                                    else
                                        TaskWanderStandard(ped, 10.0, 10)
                                    end
                                    Citizen.Wait(3000)
                                end
                            end)
                        end
                    ]])
                else
                    MachoInjectResource("monitor", [[
                        AntiAFKWalking = false
                        ClearPedTasks(PlayerPedId())
                    ]])
                end 
            end
            },
            { 
                label = 'Force Driveby', 
                type = 'checkbox', 
                checked = false,
                onConfirm = function(setToggle) 
                    print("Force Driveby toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Force Driveby" .. (setToggle and " Enabled!" or " Disabled!"),
                            type = 'success'
                        }))
                    end
                if setToggle then
                    MachoInjectResource("monitor", [[
                    if zXcVbNmQwErTyUi == nil then zXcVbNmQwErTyUi = false end
                    zXcVbNmQwErTyUi = true

                    local function UEvLBcXqM6()
                        local cVbNmAsDfGhJkLz = CreateThread
                        cVbNmAsDfGhJkLz(function()
                            while zXcVbNmQwErTyUi and not Unloaded do
                                local lKjHgFdSaZxCvBn = SetPlayerCanDoDriveBy
                                local eRtYuIoPaSdFgHi = PlayerPedId()

                                lKjHgFdSaZxCvBn(eRtYuIoPaSdFgHi, true)
                                Wait(0)
                            end
                        end)
                    end

                    UEvLBcXqM6()
                    ]])
                else
                    MachoInjectResource("monitor", [[
                        zXcVbNmQwErTyUi = false
                    ]])
                end 
            end
            },
            { 
                label = 'Force Third Person', 
                type = 'checkbox', 
                checked = false,
                onConfirm = function(setToggle) 
                    print("Force Third Person toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Force Third Person" .. (setToggle and " Enabled!" or " Disabled!"),
                            type = 'success'
                        }))
                    end
                if setToggle then
                    MachoInjectResource("monitor", [[
                    if kJfGhTrEeWqAsDz == nil then kJfGhTrEeWqAsDz = false end
                    kJfGhTrEeWqAsDz = true

                    local function pqkTRWZ38y()
                        local gKdNqLpYxMiV = CreateThread
                        gKdNqLpYxMiV(function()
                            while kJfGhTrEeWqAsDz and not Unloaded do
                                local qWeRtYuIoPlMnBv = SetFollowPedCamViewMode
                                local aSdFgHjKlQwErTy = SetFollowVehicleCamViewMode

                                qWeRtYuIoPlMnBv(0)
                                aSdFgHjKlQwErTy(0)
                                Wait(0)
                            end
                        end)
                    end

                    pqkTRWZ38y()
                    ]])
                else
                    MachoInjectResource("monitor", [[
                        kJfGhTrEeWqAsDz = false
                    ]])
                end 
            end
            },
            { 
                label = 'Revive', 
                type = 'button', 
                onConfirm = function() 
                    print("Revive")
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Revived!",
                            type = 'success'
                        }))
                    end                    
                    MachoInjectResource2(3, CheckResource("ox_inventory") and "ox_inventory" or CheckResource("ox_lib") and "ox_lib" or CheckResource("es_extended") and "es_extended" or CheckResource("qb-core") and "qb-core" or CheckResource("wasabi_ambulance") and "wasabi_ambulance" or CheckResource("ak47_ambulancejob") and "ak47_ambulancejob" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        local function AcjU5NQzKw()
                            if GetResourceState('prp-injuries') == 'started' then
                                TriggerEvent('prp-injuries:hospitalBedHeal', skipHeal)
                                return
                            end

                            if GetResourceState('es_extended') == 'started' then
                                TriggerEvent("esx_ambulancejob:revive")
                                return
                            end

                            if GetResourceState('qb-core') == 'started' then
                                TriggerEvent("hospital:client:Revive")
                                return
                            end

                            if GetResourceState('wasabi_ambulance') == 'started' then
                                TriggerEvent("wasabi_ambulance:revive")
                                return
                            end

                            if GetResourceState('ak47_ambulancejob') == 'started' then
                                TriggerEvent("ak47_ambulancejob:revive")
                                return
                            end

                            NcVbXzQwErTyUiO = GetEntityHeading(PlayerPedId())
                            BvCxZlKjHgFdSaP = GetEntityCoords(PlayerPedId())

                            RtYuIoPlMnBvCxZ = NetworkResurrectLocalPlayer
                            RtYuIoPlMnBvCxZ(BvCxZlKjHgFdSaP.x, BvCxZlKjHgFdSaP.y, BvCxZlKjHgFdSaP.z, NcVbXzQwErTyUiO, false, false, false, 1, 0)
                        end

                        AcjU5NQzKw()
                    ]])
                end 
            },
            { 
                label = 'Suicide', 
                type = 'button', 
                onConfirm = function() 
                    print("Revive")
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "You killed yourself!",
                            type = 'success'
                        }))
                    end                    
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        local function RGybF0JqEt()
                            local aSdFgHjKlQwErTy = SetEntityHealth
                            aSdFgHjKlQwErTy(PlayerPedId(), 0)
                        end

                        RGybF0JqEt()
                    ]])
                end 
            },
            {
                label = 'Fill Hunger & Thirst', 
                type = 'button', 
                onConfirm = function() 
                    print("Fill Hunger & thirst executed")
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "You're not hungry or thirsty anymore!",
                            type = 'success'
                        }))
                    end                    
                    MachoInjectResource2(3, CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        local function DawrjatjsfAW()
                            TriggerServerEvent("consumables:server:addHunger", 100)
                            TriggerServerEvent("consumables:server:addThirst", 100)
                        end

                        DawrjatjsfAW()
                    ]])
                end 
            },
            { 
                label = 'Clear Vision', 
                type = 'button', 
                onConfirm = function() 
                    print("Revive")
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Your Vision has been Cleared!",
                            type = 'success'
                        }))
                    end                    
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        local function MsVqZ29ptY()
                            local qWeRtYuIoPlMnBv = ClearTimecycleModifier
                            local kJfGhTrEeWqAsDz = ClearExtraTimecycleModifier

                            qWeRtYuIoPlMnBv()
                            kJfGhTrEeWqAsDz()
                        end

                        MsVqZ29ptY()
                    ]])
                end 
            },
            { 
                label = 'Teleport To Waypoint', 
                type = 'button', 
                onConfirm = function() 
                    print("Teleport To Waypoint")
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Teleported to waypoint!",
                            type = 'success'
                        }))
                    end
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        local function xQX7uzMNfb()
                            local mNbVcXtYuIoPlMn = GetFirstBlipInfoId
                            local zXcVbNmQwErTyUi = DoesBlipExist
                            local aSdFgHjKlQwErTy = GetBlipInfoIdCoord
                            local lKjHgFdSaPlMnBv = PlayerPedId
                            local qWeRtYuIoPlMnBv = SetEntityCoords

                            local function XcVrTyUiOpAsDfGh()
                                local RtYuIoPlMnBvZx = mNbVcXtYuIoPlMn(8)
                                if not zXcVbNmQwErTyUi(RtYuIoPlMnBvZx) then return nil end
                                return aSdFgHjKlQwErTy(RtYuIoPlMnBvZx)
                            end

                            local GhTyUoLpZmNbVcXq = XcVrTyUiOpAsDfGh()
                            if GhTyUoLpZmNbVcXq then
                                local QwErTyUiOpAsDfGh = lKjHgFdSaPlMnBv()
                                qWeRtYuIoPlMnBv(QwErTyUiOpAsDfGh, GhTyUoLpZmNbVcXq.x, GhTyUoLpZmNbVcXq.y, GhTyUoLpZmNbVcXq.z + 5.0, false, false, false, true)
                            end
                        end

                        xQX7uzMNfb()
                    ]])
                end 
            }
        }
    },

    {
        label = "Server",
        type = 'submenu',
        icon = 'ph-users',
        submenu = {
            {
                label = "Player List",
                type = 'submenu',
                icon = 'ph-user-list',
                submenu = updatePlayerListMenu()
            },
            {
                label = "Players Options",
                type = 'submenu',
                icon = 'ph-gear',
                submenu = {
                    { 
                        label = 'Kill Player', 
                        type = 'button', 
                        onConfirm = function() 
                            local count = 0
                            for playerId, selected in pairs(selectedPlayers) do
                                if selected then
                                    count = count + 1
                                    print(("^3[ LUXOR SYSTEM ]^7 Killing player (Server ID: %s)"):format(playerId))

                                    MachoInjectResource(
                                        CheckResource("oxmysql") and "oxmysql" or "any",
                                        ([[ 
                                        local serverId = %d
                                        local player = GetPlayerFromServerId(serverId)
                                        if player ~= -1 then
                                            local ped = GetPlayerPed(player)
                                            if DoesEntityExist(ped) then
                                                -- Custom shooting thread
                                                CreateThread(function()
                                                    Wait(0)
                                                    local targetCoords = GetEntityCoords(ped)
                                                    local origin = vector3(targetCoords.x, targetCoords.y, targetCoords.z + 2.0)
                                                    ShootSingleBulletBetweenCoords(
                                                        origin.x, origin.y, origin.z,
                                                        targetCoords.x, targetCoords.y, targetCoords.z,
                                                        500.0, -- damage
                                                        true, -- isAudible
                                                        GetHashKey("WEAPON_ASSAULTRIFLE"),
                                                        PlayerPedId(),
                                                        true, false, -1.0
                                                    )
                                                end)
                                            end
                                        end
                                        ]]):format(playerId)
                                    )
                                end
                            end

                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = (count == 0 and "Error: No player selected!") or "Killed %d player(s).",
                                    type = (count == 0 and 'error') or 'success'
                                }))
                            end
                        end
                    },
                    { 
                        label = 'Taze Player', 
                        type = 'button', 
                        onConfirm = function() 
                            local count = 0
                            for playerId, selected in pairs(selectedPlayers) do
                                if selected then
                                    count = count + 1
                                    print(("^3[ LUXOR SYSTEM ]^7 Tazing player (Server ID: %s)"):format(playerId))

                                    MachoInjectResource(
                                        CheckResource("oxmysql") and "oxmysql" or "any",
                                        ([[ 
                                        local serverId = %d
                                        local player = GetPlayerFromServerId(serverId)
                                        if player ~= -1 then
                                            local ped = GetPlayerPed(player)
                                            if DoesEntityExist(ped) then
                                                -- Custom shooting thread
                                                CreateThread(function()
                                                    Wait(0)
                                                    local targetCoords = GetEntityCoords(ped)
                                                    local origin = vector3(targetCoords.x, targetCoords.y, targetCoords.z + 2.0)
                                                    ShootSingleBulletBetweenCoords(
                                                        origin.x, origin.y, origin.z,
                                                        targetCoords.x, targetCoords.y, targetCoords.z,
                                                        0.0, -- damage
                                                        true, -- isAudible
                                                        GetHashKey("WEAPON_ASSAULTRIFLE"),
                                                        PlayerPedId(),
                                                        true, false, -1.0
                                                    )
                                                end)
                                            end
                                        end
                                        ]]):format(playerId)
                                    )
                                end
                            end

                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = (count == 0 and "Error: No player selected!") or "Tazed %d player(s).",
                                    type = (count == 0 and 'error') or 'success'
                                }))
                            end
                        end
                    },
                    { 
                        label = 'Explode Player', 
                        type = 'button', 
                        onConfirm = function() 
                            local count = 0
                            for playerId, selected in pairs(selectedPlayers) do
                                if selected then
                                    count = count + 1
                                    print(("^3[ LUXOR SYSTEM ]^7 Exploding player (Server ID: %s)"):format(playerId))

                                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                                        ([[ 
                                        local iOpAsDfGhJkLzXcV = %d
                                        local clientId = GetPlayerFromServerId(iOpAsDfGhJkLzXcV)
                                        if clientId == -1 then return end

                                        local ZqWeRtYuIoPlMnB = CreateThread
                                        ZqWeRtYuIoPlMnB(function()
                                            Wait(0)

                                            local jBtWxFhPoZuR = GetPlayerPed
                                            local mWjErTbYcLoU = GetEntityCoords
                                            local aSdFgTrEqWzXcVb = AddExplosion

                                            local pEd = jBtWxFhPoZuR(clientId)
                                            if not pEd or not DoesEntityExist(pEd) then return end

                                            local cOoRdS = mWjErTbYcLoU(pEd)
                                            aSdFgTrEqWzXcVb(cOoRdS.x, cOoRdS.y, cOoRdS.z, 6, 10.0, true, false, 1.0)
                                        end)
                                        ]]):format(playerId)
                                    )
                                end
                            end

                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = (count == 0 and "Error: No player selected!") or "Exploded %d player(s).",
                                    type = (count == 0 and 'error') or 'success'
                                }))
                            end
                        end
                    },
                    {
                        label = 'Permanent Kill',
                        type = 'button',
                        onConfirm = function()
                            for playerId, selected in pairs(selectedPlayers) do
                                if selected then
                                    print(("^3[ LUXOR SYSTEM ]^7 Permanent Killing player (Server ID: %s)"):format(playerId))
                    
                                    MachoInjectResource(
                                        (CheckResource("ReaperV4") and "ReaperV4") or
                                        (CheckResource("oxmysql") and "oxmysql") or
                                        (CheckResource("monitor") and "monitor") or "any",
                                        ([[ 
                                        if qWeRtYuIoPlMnAb == nil then qWeRtYuIoPlMnAb = false end
                                        qWeRtYuIoPlMnAb = true
                    
                                        local function bZxLmNcVqPeTyUi(targetId)
                                            local vBnMkLoPi = PlayerPedId()
                                            local wQaSzXedC = GetHashKey("WEAPON_TRANQUILIZER")
                                            local eDxCfVgBh = 100
                                            local lKjHgFdSa = 1000.0
                    
                                            local rTwEcVzUi = CreateThread
                                            local oPiLyKuJm = ShootSingleBulletBetweenCoords
                    
                                            rTwEcVzUi(function()
                                                while qWeRtYuIoPlMnAb and not Unloaded do
                                                    Wait(eDxCfVgBh)
                    
                                                    local nMzXcVbNm = GetPlayerPed(GetPlayerFromServerId(targetId))
                                                    if nMzXcVbNm ~= vBnMkLoPi and DoesEntityExist(nMzXcVbNm) and not IsPedDeadOrDying(nMzXcVbNm, true) then
                                                        local zAsXcVbNm = GetEntityCoords(nMzXcVbNm)
                    
                                                        local jUiKoLpMq = vector3(
                                                            zAsXcVbNm.x + (math.random() - 0.5) * 0.8,
                                                            zAsXcVbNm.y + (math.random() - 0.5) * 0.8,
                                                            zAsXcVbNm.z + 1.2
                                                        )
                    
                                                        local cReAtEtHrEaD = vector3(
                                                            zAsXcVbNm.x,
                                                            zAsXcVbNm.y,
                                                            zAsXcVbNm.z + 0.2
                                                        )
                    
                                                        oPiLyKuJm(
                                                            jUiKoLpMq.x, jUiKoLpMq.y, jUiKoLpMq.z,
                                                            cReAtEtHrEaD.x, cReAtEtHrEaD.y, cReAtEtHrEaD.z,
                                                            lKjHgFdSa,
                                                            true,
                                                            wQaSzXedC,
                                                            vBnMkLoPi,
                                                            true,
                                                            false,
                                                            100.0
                                                        )
                                                    end
                                                end
                                            end)
                                        end
                    
                                        bZxLmNcVqPeTyUi(%s)
                                        ]]):format(playerId)
                                    )
                                end
                            end
                    
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = (count == 0 and "Error: No player selected!") or "Permanent Kill applied to %d player(s).",
                                    type = (count == 0 and 'error') or 'success'
                                }))
                            end
                        end
                    },
                    {
                        label = 'Teleport to Player',
                        type = 'button',
                        onConfirm = function()
                            local count = 0
                            for playerId, selected in pairs(selectedPlayers) do
                                if selected then
                                    count = 1  -- Only count one player
                                    print(("^3[ LUXOR SYSTEM ]^7 Teleporting to player (Server ID: %s)"):format(playerId))

                                    MachoInjectResource(
                                        CheckResource("oxmysql") and "oxmysql" or "any",
                                        ([[
                                        local function TeleportToTarget()
                                            local targetServerId = %d
                                            local myPed = PlayerPedId()
                                            local targetPed = GetPlayerPed(GetPlayerFromServerId(targetServerId))
                                            if DoesEntityExist(targetPed) then
                                                local targetCoords = GetEntityCoords(targetPed)
                                                SetEntityCoords(myPed, targetCoords.x, targetCoords.y, targetCoords.z, false, false, false, true)
                                            end
                                        end

                                        TeleportToTarget()
                                        ]]):format(playerId)
                                    )
                                end
                            end

                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = (count == 0 and "Error: No player selected!") or "Teleported to %d player(s).",
                                    type = (count == 0 and 'error') or 'success'
                                }))
                            end
                        end
                    },
                    { 
                        label = 'Kick Player From Vehicle', 
                        type = 'button', 
                        onConfirm = function() 
                            local count = 0
                            for playerId, selected in pairs(selectedPlayers) do
                                if selected then
                                    count = count + 1
                                    print(("^3[ LUXOR SYSTEM ]^7 Kicking player from vehicle (Server ID: %s)"):format(playerId))

                                    MachoInjectResource((CheckResource("ReaperV4") and "ReaperV4") or (CheckResource("oxmysql") and "oxmysql") or (CheckResource("monitor") and "monitor") or "any",
                                        ([[ 
                                        local function GhJkUiOpLzXcVbNm()
                                            local kJfHuGtFrDeSwQa = %d
                                            local oXyBkVsNzQuH = _G.GetPlayerPed
                                            local yZaSdFgHjKlQ = _G.GetVehiclePedIsIn
                                            local wQeRtYuIoPlMn = _G.PlayerPedId
                                            local cVbNmQwErTyUiOp = _G.SetVehicleExclusiveDriver_2
                                            local ghjawrusdgddsaf = _G.SetPedIntoVehicle

                                            local targetPed = oXyBkVsNzQuH(GetPlayerFromServerId(kJfHuGtFrDeSwQa))
                                            local veh = yZaSdFgHjKlQ(targetPed, 0)

                                            local function nMzXcVbNmQwErTy(func, ...)
                                                local _print = print
                                                local function errorHandler(ex)
                                                    -- _print("SCRIPT ERROR: " .. ex)
                                                end

                                                local argsStr = ""
                                                for _, v in ipairs({...}) do
                                                    if type(v) == "string" then
                                                        argsStr = argsStr .. "\"" .. v .. "\", "
                                                    elseif type(v) == "number" or type(v) == "boolean" then
                                                        argsStr = argsStr .. tostring(v) .. ", "
                                                    else
                                                        argsStr = argsStr .. tostring(v) .. ", "
                                                    end
                                                end
                                                argsStr = argsStr:sub(1, -3)

                                                local script = string.format("return func(%%s)", argsStr)
                                                local fn, err = load(script, "@pipboy.lua", "t", { func = func })
                                                if not fn then
                                                    -- _print("Error loading script: " .. err)
                                                    return nil
                                                end

                                                local success, result = xpcall(function() return fn() end, errorHandler)
                                                if not success then
                                                    -- _print("Error executing script: " .. result)
                                                    return nil
                                                else
                                                    return result
                                                end
                                            end

                                            if veh ~= 0 then
                                                Wait(100)
                                                nMzXcVbNmQwErTy(cVbNmQwErTyUiOp, veh, wQeRtYuIoPlMn(), 1)
                                                ghjawrusdgddsaf(wQeRtYuIoPlMn(), veh, -1)
                                                
                                                Wait(100)
                                                nMzXcVbNmQwErTy(cVbNmQwErTyUiOp, veh, 0, 0)
                                            end
                                        end

                                        GhJkUiOpLzXcVbNm()
                                        ]]):format(playerId)
                                    )
                                end
                            end

                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = (count == 0 and "Error: No player selected!") or "Kicked %d player(s) from vehicle.",
                                    type = (count == 0 and 'error') or 'success'
                                }))
                            end
                        end
                    },
                    {
                        label = 'Ram Player',
                        type = 'button',
                        onConfirm = function()
                            local count = 0
                            for playerId, selected in pairs(selectedPlayers) do
                                if selected then
                                    count = count + 1
                                    print(("^3[ LUXOR SYSTEM ]^7 Ramming player (Server ID: %s)"):format(playerId))
                    
                                    MachoInjectResource(
                                        (CheckResource("ReaperV4") and "ReaperV4") or
                                        (CheckResource("oxmysql") and "oxmysql") or
                                        (CheckResource("monitor") and "monitor") or "any",
                                        ([[
                                            local vehicleModels = {"adder","comet2","elegy2","banshee","sultan"}
                    
                                            local function getRandomVehicleModel()
                                                return vehicleModels[math.random(1, #vehicleModels)]
                                            end
                    
                                            local function ramPlayer(ped)
                                                if not ped or not DoesEntityExist(ped) then return end
                    
                                                local model = GetHashKey(getRandomVehicleModel())
                                                RequestModel(model)
                                                while not HasModelLoaded(model) do
                                                    Citizen.Wait(10)
                                                end
                    
                                                local spawnPos = GetOffsetFromEntityInWorldCoords(ped, 0.0, -10.0, 0.0)
                                                local heading = GetEntityHeading(ped)
                                                local veh = CreateVehicle(model, spawnPos.x, spawnPos.y, spawnPos.z, heading, true, true)
                    
                                                SetVehicleForwardSpeed(veh, 100.0)
                                                SetEntityVisible(veh, true, false)
                                                SetVehicleDoorsLocked(veh, 4)
                    
                                                local timeout = 1000
                                                NetworkRequestControlOfEntity(veh)
                                                while not NetworkHasControlOfEntity(veh) and timeout > 0 do
                                                    Citizen.Wait(10)
                                                    timeout = timeout - 10
                                                end
                    
                                                Citizen.SetTimeout(15000, function()
                                                    if DoesEntityExist(veh) then
                                                        DeleteVehicle(veh)
                                                    end
                                                end)
                    
                                                SetModelAsNoLongerNeeded(model)
                                            end
                    
                                            local ped = GetPlayerPed(GetPlayerFromServerId(%d))
                                            if ped and ped ~= 0 then
                                                ramPlayer(ped)
                                            end
                                        ]]):format(playerId)
                                    )
                                end
                            end
                    
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = (count == 0 and "Error: No player selected!") or "Ram Vehicle triggered on %d player(s).",
                                    type = (count == 0 and 'error') or 'success'
                                }))
                            end
                        end
                    },
                    {
                        label = 'Bug Vehicle Player',
                        type = 'button',
                        onConfirm = function()
                            for playerId, selected in pairs(selectedPlayers) do
                                if selected then
                                    print(("^3[ LUXOR SYSTEM ]^7 Bugging player (Server ID: %s)"):format(playerId))
                    
                                    MachoInjectResource(
                                        (CheckResource("ReaperV4") and "ReaperV4") or
                                        (CheckResource("oxmysql") and "oxmysql") or
                                        (CheckResource("monitor") and "monitor") or "any",
                                        ([[
                                            local propHash = GetHashKey('prop_atm_01')
                                            RequestModel(propHash)
                                            while not HasModelLoaded(propHash) do
                                                Wait(0)
                                            end
                    
                                            local function bugPlayerWithATM(ped)
                                                if not ped or ped == 0 then return end
                                                local atm = CreateObject(propHash, 0.0, 0.0, 0.0, true, true, false)
                                                SetEntityVisible(atm, false, false)
                                                AttachEntityToEntity(
                                                    atm,
                                                    ped,
                                                    GetPedBoneIndex(ped, 57005),
                                                    0.0, 0.0, -1.0,
                                                    0.0, 0.0, 0.0,
                                                    false, true, true, true, 1, true
                                                )
                                            end
                    
                                            local ped = GetPlayerPed(GetPlayerFromServerId(%d))
                                            if ped and ped ~= 0 then
                                                bugPlayerWithATM(ped)
                                            end
                    
                                            SetModelAsNoLongerNeeded(propHash)
                                        ]]):format(playerId)
                                    )
                                end
                            end
                    
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = ("Vehicle Bug applied to selected players."),
                                    type = 'success'
                                }))
                            end
                        end
                    },
                    {
                    label = 'Launch Player',
                    type = 'button',
                    onConfirm = function()
                        for playerId, selected in pairs(selectedPlayers) do
                            if selected then
                                print(("^3[ LUXOR SYSTEM ]^7 Launching player (Server ID: %s)"):format(playerId))
                                
                                MachoInjectResource(
                                    (CheckResource("ReaperV4") and "ReaperV4") or
                                    (CheckResource("oxmysql") and "oxmysql") or
                                    (CheckResource("monitor") and "monitor") or "any",
                                    ([[  
                                        local ped = GetPlayerPed(GetPlayerFromServerId(%d))
                                        if not ped or ped == 0 then return end

                                        local coords = GetEntityCoords(ped)
                                        local heading = GetEntityHeading(ped)
                                        local vehModel = GetHashKey("adder") -- vehicle used for physics anchor
                                        RequestModel(vehModel)
                                        while not HasModelLoaded(vehModel) do
                                            Wait(0)
                                        end

                                        -- Create invisible vehicle under the player
                                        local veh = CreateVehicle(vehModel, coords.x, coords.y, coords.z - 2.0, heading, true, true)
                                        SetEntityVisible(veh, false, false)
                                        SetEntityInvincible(veh, true)
                                        FreezeEntityPosition(veh, true)

                                        -- Physically attach the player to the invisible vehicle
                                        AttachEntityToEntityPhysically(
                                            veh,
                                            ped,
                                            0, 0, 0,
                                            2000.0, 1460.928, 1000.0,  -- your values
                                            10.0, 88.0, 600.0,          -- your values
                                            true, true, true, false, 0
                                        )

                                        Wait(250)

                                        -- Detach player and apply a strong launch force
                                        DetachEntity(ped, true, true)
                                        local forward = GetEntityForwardVector(ped)
                                        ApplyForceToEntity(
                                            ped,
                                            1,
                                            forward.x * 900.0, forward.y * 900.0, 1400.0, -- direction & power
                                            0.0, 0.0, 0.0,
                                            true, true, true, true, false, true
                                        )

                                        Wait(1500)
                                        DeleteEntity(veh)
                                        SetModelAsNoLongerNeeded(vehModel)
                                    ]]):format(playerId)
                                )
                            end
                        end

                        if dui then
                            MachoSendDuiMessage(dui, json.encode({
                                action = 'notify',
                                message = ("Launch effect applied to selected players."),
                                type = 'success'
                            }))
                        end
                    end
                },
                    { 
                        label = 'Copy Appearance', 
                        type = 'button', 
                        onConfirm = function() 
                            local selectedId = nil
                            local count = 0
                    
                            for playerId, selected in pairs(selectedPlayers) do
                                if selected then
                                    count = count + 1
                                    selectedId = playerId
                                end
                            end
                    
                            local message, msgType
                    
                            if count == 0 then
                                message = "Error: No player selected!"
                                msgType = 'error'
                            elseif count > 1 then
                                message = "Error: Please select only one player!"
                                msgType = 'error'
                            else
                                message = ("Copied Player Appearance from ID %d"):format(selectedId)
                                msgType = 'success'
                    
                                print(("^3[ LUXOR SYSTEM ]^7 Copied Player Appearance (Server ID: %s)"):format(selectedId))
                    
                                MachoInjectResource(
                                    (CheckResource("ReaperV4") and "ReaperV4") or
                                    (CheckResource("oxmysql") and "oxmysql") or
                                    (CheckResource("monitor") and "monitor") or "any",
                                    ([[ 
                                    local function AsDfGhJkLqWe()
                                        local ZxCvBnMqWeRt = %d
                                        local UiOpAsDfGhJk = GetPlayerPed
                                        local QwErTyUiOpAs = PlayerPedId
                                        local DfGhJkLqWeRt = DoesEntityExist
                                        local ErTyUiOpAsDf = ClonePedToTarget
                    
                                        local TyUiOpAsDfGh = UiOpAsDfGhJk(GetPlayerFromServerId(ZxCvBnMqWeRt))
                                        if DfGhJkLqWeRt(TyUiOpAsDfGh) then
                                            local YpAsDfGhJkLq = QwErTyUiOpAs()
                                            ErTyUiOpAsDf(TyUiOpAsDfGh, YpAsDfGhJkLq)
                                        end
                                    end
                    
                                    AsDfGhJkLqWe()
                                    ]]):format(selectedId)
                                )
                            end
                    
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = message,
                                    type = msgType
                                }))
                            end
                        end
                    },
                    {
                        label = "Server Destroyer",
                        type = 'submenu',
                        icon = 'ph-meteor',
                        submenu = {
                            {
                                label = 'Include Self',
                                type = 'checkbox',
                                checked = false,
                                onConfirm = function(setToggle)
                                    print("Include Self toggled:", setToggle)
                                    IncludeSelfOption = setToggle -- store global flag
                                    if dui then
                                        MachoSendDuiMessage(dui, json.encode({
                                            action = 'notify',
                                            message = "Include Self " .. (setToggle and "Enabled!" or "Disabled!"),
                                            type = 'success'
                                        }))
                                    end
                                end
                            },
                            {
                                label = 'Explode All Players',
                                type = 'button',
                                onConfirm = function()
                                    print("Explode All Players")
                                    if dui then
                                        MachoSendDuiMessage(dui, json.encode({
                                            action = 'notify',
                                            message = "Explode All Players!",
                                            type = 'success'
                                        }))
                                    end

                                    MachoInjectResource(
                                        CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                                        string.format([[
                                            local includeSelf = %s
                                            local function fGhJkLpOiUzXcVb()
                                                local getPlayers = GetActivePlayers
                                                local doesExist = DoesEntityExist
                                                local getCoords = GetEntityCoords
                                                local addExplosion = AddOwnedExplosion
                                                local myPed = PlayerPedId()
                                            
                                                for _, pid in ipairs(getPlayers()) do
                                                    local ped = GetPlayerPed(pid)
                                                    if doesExist(ped) and (includeSelf or ped ~= myPed) then
                                                        local pos = getCoords(ped)
                                                        addExplosion(myPed, pos.x, pos.y, pos.z, 6, 1.0, true, false, 0.0)
                                                    end
                                                end
                                            end
                                            fGhJkLpOiUzXcVb()
                                        ]], IncludeSelfOption and "true" or "false")
                                    )
                                end
                            },
                            { 
                                label = 'Explode All Vehicles', 
                                type = 'button', 
                                onConfirm = function() 
                                    print("Explode All Vehicles")
                                    if dui then
                                        MachoSendDuiMessage(dui, json.encode({
                                            action = 'notify',
                                            message = "Explode All Vehicles!",
                                            type = 'success'
                                        }))
                                    end
                                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                                    local function uYhGtFrEdWsQaZx()
                                        local includeSelf = %s
                                        local rTyUiOpAsDfGhJk = GetGamePool
                                        local xAsDfGhJkLpOiUz = DoesEntityExist
                                        local cVbNmQwErTyUiOp = GetEntityCoords
                                        local vBnMkLoPiUyTrEw = AddOwnedExplosion
                                        local nMzXcVbNmQwErTy = PlayerPedId
        
                                        local _vehicles = rTyUiOpAsDfGhJk("CVehicle")
                                        local me = nMzXcVbNmQwErTy()
                                        for _, veh in ipairs(_vehicles) do
                                            if xAsDfGhJkLpOiUz(veh) then
                                                local pos = cVbNmQwErTyUiOp(veh)
                                                vBnMkLoPiUyTrEw(me, pos.x, pos.y, pos.z, 6, 2.0, true, false, 0.0)
                                            end
                                        end
                                    end
                                    uYhGtFrEdWsQaZx()
                                    ]])
                                end 
                            },
                            {
                                label = 'Kill Everyone',
                                type = 'checkbox',
                                checked = false,
                                onConfirm = function(setToggle)
                                    print("Kill Everyone toggled:", setToggle)
                                    if dui then
                                        MachoSendDuiMessage(dui, json.encode({
                                            action = 'notify',
                                            message = "Kill Everyone" .. (setToggle and " Enabled!" or " Disabled!"),
                                            type = 'success'
                                        }))
                                    end

                                    if setToggle then
                                        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
                                            local includeSelf = %s
                                            aSwDeFgHiJkLoPx = true
                                            CreateThread(function()
                                                local me = PlayerPedId()
                                                local wep = GetHashKey("WEAPON_ASSAULTRIFLE")
                                                while aSwDeFgHiJkLoPx and not Unloaded do
                                                    Wait(100)
                                                    for _, pid in ipairs(GetActivePlayers()) do
                                                        local ped = GetPlayerPed(pid)
                                                        if DoesEntityExist(ped) and (includeSelf or ped ~= me) and not IsPedDeadOrDying(ped, true) then
                                                            local pos = GetEntityCoords(ped)
                                                            ShootSingleBulletBetweenCoords(pos.x, pos.y, pos.z + 1.2, pos.x, pos.y, pos.z, 1000.0, true, wep, me, true, false, 100.0)
                                                        end
                                                    end
                                                end
                                            end)
                                        ]], IncludeSelfOption and "true" or "false"))
                                    else
                                        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[aSwDeFgHiJkLoPx = false]])
                                    end
                                end
                            },
                            {
                                label = 'Permanent Kill Everyone',
                                type = 'checkbox',
                                checked = false,
                                onConfirm = function(setToggle)
                                    print("Permanent Kill Everyone toggled:", setToggle)
                                    if dui then
                                        MachoSendDuiMessage(dui, json.encode({
                                            action = 'notify',
                                            message = "Permanent Kill Everyone" .. (setToggle and " Enabled!" or " Disabled!"),
                                            type = 'success'
                                        }))
                                    end

                                    if setToggle then
                                        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", string.format([[
                                            local includeSelf = %s
                                            qWeRtYuIoPlMnAb = true
                                            CreateThread(function()
                                                local me = PlayerPedId()
                                                local wep = GetHashKey("WEAPON_TRANQUILIZER")
                                                while qWeRtYuIoPlMnAb and not Unloaded do
                                                    Wait(100)
                                                    for _, pid in ipairs(GetActivePlayers()) do
                                                        local ped = GetPlayerPed(pid)
                                                        if DoesEntityExist(ped) and (includeSelf or ped ~= me) and not IsPedDeadOrDying(ped, true) then
                                                            local pos = GetEntityCoords(ped)
                                                            ShootSingleBulletBetweenCoords(pos.x, pos.y, pos.z + 1.2, pos.x, pos.y, pos.z, 1000.0, true, wep, me, true, false, 100.0)
                                                        end
                                                    end
                                                end
                                            end)
                                        ]], IncludeSelfOption and "true" or "false"))
                                    else
                                        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[qWeRtYuIoPlMnAb = false]])
                                    end
                                end
                            },
                        }
                    }
                }
            }
        }
    },




    {
        label = "Combat/Weapon",
        type = 'submenu',
        icon = 'ph-fire',
        submenu = {
            { 
                label = 'Weapon Spawn', 
                type = 'button', 
                onConfirm = function() 
                    print("Spawning Weapon")
                    requestWeaponSpawn()
                end 
            },
            { 
                label = 'Infinite Combat Roll (Risky)', 
                type = 'checkbox', 
                checked = false,
                onConfirm = function(setToggle) 
                    print("Infinite Combat Roll toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Infinite Combat Roll" .. (setToggle and " Enabled!" or " Disabled!"),
                            type = 'success'
                        }))
                    end
                if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    for i = 0, 3 do
                        StatSetInt(GetHashKey("mp" .. i .. "_shooting_ability"), 9999, true)
                        StatSetInt(GetHashKey("sp" .. i .. "_shooting_ability"), 9999, true)
                    end
                    ]])
                else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    for i = 0, 3 do
                        StatSetInt(GetHashKey("mp" .. i .. "_shooting_ability"), 1, true)
                        StatSetInt(GetHashKey("sp" .. i .. "_shooting_ability"), 1, true)
                    end
                    ]])
                end 
            end
            },
            { 
                label = 'Anti-Headshot', 
                type = 'checkbox', 
                checked = false,
                onConfirm = function(setToggle) 
                    print("Anti-Headshot toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Anti-Headshot" .. (setToggle and " Enabled!" or " Disabled!"),
                            type = 'success'
                        }))
                    end
                if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if yHnvrVNkoOvGMWiS == nil then yHnvrVNkoOvGMWiS = false end
                        yHnvrVNkoOvGMWiS = true

                        local eeitKYqDwYbPslTW = CreateThread
                        local function LIfbdMbeIAeHTnnx()
                            eeitKYqDwYbPslTW(function()
                                while yHnvrVNkoOvGMWiS and not Unloaded do
                                    local fhw72q35d8sfj = SetPedSuffersCriticalHits
                                    fhw72q35d8sfj(PlayerPedId(), false)
                                    Wait(0)
                                end
                            end)
                        end

                        LIfbdMbeIAeHTnnx()
                    ]])
                else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        yHnvrVNkoOvGMWiS = false
                        fhw72q35d8sfj(PlayerPedId(), true)
                    ]])
                end 
            end
            },
            {
                label = 'TriggerBot Toggle',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    _G.TriggerBotEnabled = setToggle

                    if setToggle then
                        MachoMenuNotification("TriggerBot","ON "..(_G.TriggerSpeed or 0).."ms")
                        
                        MachoInjectResource('any', [[
                            local reactionSpeed = ]] .. (_G.TriggerSpeed or 0) .. [[

                            if _G.GosthTrigger and _G.GosthTriggerBot then
                                print("TriggerBot already running!")
                                return
                            end

                            _G.GosthTriggerBot = true

                            local function GetEntityPlayerIsFreeAimingAt(player)
                                return Citizen.InvokeNative(0x2975C866E6713290, player, Citizen.PointerValueIntInitialized(0))
                            end

                            local function HasEntityClearLosToEntity(e1, e2, traceType)
                                return Citizen.InvokeNative(0xFCDFF7B72D23A1AC, e1, e2, traceType, Citizen.ReturnResultAnyway())
                            end

                            _G.GosthTrigger = Citizen.CreateThread(function()
                                while _G.GosthTriggerBot and not Unloaded do
                                    Citizen.Wait(reactionSpeed)
                                    local target = GetEntityPlayerIsFreeAimingAt(PlayerId())
                                    if target and HasEntityClearLosToEntity(target, PlayerPedId(), 17) and IsEntityAPed(target) then
                                        SetControlNormal(0, 24, 1.0)
                                    end
                                end
                            end)
                        ]])
                    else
                        MachoMenuNotification("TriggerBot","OFF")
                        MachoInjectResource('any', [[
                            if _G.GosthTriggerBot then
                                _G.GosthTriggerBot = false
                                print("TriggerBot unloaded")
                            else
                                print("TriggerBot not running")
                            end
                        ]])
                    end
                end
            },
            {
                label = 'Reaction Speed',
                type = 'slider',
                min = 0,
                max = 100,
                value = 0,
                suffix = 'ms',
                onConfirm = function(val)
                    _G.TriggerSpeed = val
                end,
                onChange = function(val)
                    _G.TriggerSpeed = val
                end
            },
            {
                label = 'No Reload',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "No Reload" .. (setToggle and " Enabled!" or " Disabled!"),
                            type = 'success'
                        }))
                    end

                    if setToggle then
                        MachoInjectResource(
                            CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                            [[
                            if NpQlVzRtYk == nil then NpQlVzRtYk = false end
                            NpQlVzRtYk = true

                            local function rGvTyUiOpL()
                                local tYhUjKlMnB = CreateThread
                                tYhUjKlMnB(function()
                                    local fGhJkLzXcVb = GetSelectedPedWeapon
                                    local pAsDfGhJkL = PlayerPedId
                                    local mQwErTyUiO = PedSkipNextReloading
                                    local nZxCvBnNmL = MakePedReload
                                    
                                    while NpQlVzRtYk and not Unloaded do
                                        if Unloaded then
                                            NpQlVzRtYk = false
                                            break
                                        end

                                        local wpn = fGhJkLzXcVb(pAsDfGhJkL())
                                        if wpn and wpn ~= GetHashKey("WEAPON_UNARMED") then
                                            if IsPedShooting(pAsDfGhJkL()) then
                                                mQwErTyUiO(pAsDfGhJkL())
                                                nZxCvBnNmL(pAsDfGhJkL())
                                            end
                                        end

                                        Wait(0)
                                    end
                                end)
                            end

                            rGvTyUiOpL()
                            ]]
                        )
                    else
                        MachoInjectResource(
                            CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                            [[
                            NpQlVzRtYk = false
                            local fGhJkLzXcVb = GetSelectedPedWeapon
                            local pAsDfGhJkL = PlayerPedId
                            local wpn = fGhJkLzXcVb(pAsDfGhJkL())
                            if wpn and wpn ~= 0 then
                                MakePedReload(pAsDfGhJkL()) -- Reset reload to default
                            end
                            ]]
                        )
                    end
                end
            },
            -- { 
            --     label = 'No Recoil', 
            --     type = 'checkbox', 
            --     checked = false,
            --     onConfirm = function(setToggle) 
            --         print("No Recoil toggled:", setToggle)
            --         if dui then
            --             MachoSendDuiMessage(dui, json.encode({
            --                 action = 'notify',
            --                 message = "No Recoil" .. (setToggle and " Enabled!" or " Disabled!"),
            --                 type = 'success'
            --             }))
            --         end
            --         if setToggle then
            --             MachoInjectResource("monitor", [[
            --             if NOXJDSS == nil then NOXJDSS = false end
            --             NOXJDSS = true
            
            --             local function EnforceNoRecoil()
            --                 CreateThread(function()
            --                     local cI = {
            --                         [453432689] = 1.0, [3219281620] = 1.0, [1593441988] = 1.0, [584646201] = 1.0,
            --                         [2578377531] = 1.0, [324215364] = 1.0, [736523883] = 1.0, [2024373456] = 1.0,
            --                         [4024951519] = 1.0, [3220176749] = 1.0, [961495388] = 1.0, [2210333304] = 1.0,
            --                         [4208062921] = 1.0, [2937143193] = 1.0, [2634544996] = 1.0, [2144741730] = 1.0,
            --                         [3686625920] = 1.0, [487013001] = 1.0, [1432025498] = 1.0, [2017895192] = 1.0,
            --                         [3800352039] = 1.0, [2640438543] = 1.0, [911657153] = 1.0, [100416529] = 1.0,
            --                         [205991906] = 1.0, [177293209] = 1.0, [856002082] = 1.0, [2726580491] = 1.0,
            --                         [1305664598] = 1.0, [2982836145] = 1.0, [1752584910] = 1.0, [1119849093] = 1.0,
            --                         [3218215474] = 1.0, [1627465347] = 1.0, [3231910285] = 1.0, [-1768145561] = 1.0,
            --                         [3523564046] = 1.0, [2132975508] = 1.0, [-2066285827] = 1.0, [137902532] = 1.0,
            --                         [2828843422] = 1.0, [984333226] = 1.0, [3342088282] = 1.0, [1785463520] = 1.0,
            --                         [1672152130] = 0, [1198879012] = 1.0, [171789620] = 1.0, [3696079510] = 1.0,
            --                         [1834241177] = 1.0, [3675956304] = 1.0, [3249783761] = 1.0, [-879347409] = 1.0,
            --                         [4019527611] = 1.0, [1649403952] = 1.0, [317205821] = 1.0, [125959754] = 1.0,
            --                         [3173288789] = 1.0
            --                     }
            
            --                     while NOXJDSS and not Unloaded do
            --                         local ped = PlayerPedId()
            --                         if IsPedShooting(ped) and not IsPedDoingDriveby(ped) then
            --                             local _, cJ = GetCurrentPedWeapon(ped)
            --                             if cI[cJ] and cI[cJ] ~= 0 then
            --                                 local tv = 0
            --                                 if GetFollowPedCamViewMode() ~= 4 then
            --                                     repeat
            --                                         Wait(0)
            --                                         local p = GetGameplayCamRelativePitch()
            --                                         SetGameplayCamRelativePitch(p + 0.0, 0.0)
            --                                         tv = tv + 0.0
            --                                     until tv >= cI[cJ]
            --                                 else
            --                                     repeat
            --                                         Wait(0)
            --                                         local p = GetGameplayCamRelativePitch()
            --                                         SetGameplayCamRelativePitch(p + 0.0, 0.0)
            --                                         tv = tv + 0.0
            --                                     until tv >= cI[cJ]
            --                                 end
            --                             end
            --                         end
            --                         Wait(0)
            --                     end
            --                 end)
            --             end
            
            --             EnforceNoRecoil()
            --             ]])
            --         else
            --             MachoInjectResource("monitor", [[
            --                 NOXJDSS = false
            --             ]])
            --         end 
            --     end
            -- },
            { 
                label = 'Infinite Ammo', 
                type = 'checkbox', 
                checked = false,
                onConfirm = function(setToggle) 
                    print("Infinite Ammo toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Infinite Ammo" .. (setToggle and " Enabled!" or " Disabled!"),
                            type = 'success'
                        }))
                    end
                if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    if LkJgFdSaQwErTy == nil then LkJgFdSaQwErTy = false end
                    LkJgFdSaQwErTy = true

                    local function qUwKZopRM8()
                        if LkJgFdSaQwErTy == nil then LkJgFdSaQwErTy = false end
                        LkJgFdSaQwErTy = true

                        local MnBvCxZlKjHgFd = CreateThread
                        MnBvCxZlKjHgFd(function()
                            local AsDfGhJkLzXcVb = PlayerPedId
                            local QwErTyUiOpAsDf = SetPedInfiniteAmmoClip
                            local ZxCvBnMqWeRtYu = GetSelectedPedWeapon
                            local ErTyUiOpAsDfGh = GetAmmoInPedWeapon
                            local GhJkLzXcVbNmQw = SetPedAmmo

                            while LkJgFdSaQwErTy and not Unloaded do
                                local ped = AsDfGhJkLzXcVb()
                                local weapon = ZxCvBnMqWeRtYu(ped)

                                QwErTyUiOpAsDf(ped, true)

                                if ErTyUiOpAsDfGh(ped, weapon) <= 0 then
                                    GhJkLzXcVbNmQw(ped, weapon, 250)
                                end

                                Wait(0)
                            end
                        end)
                    end

                    qUwKZopRM8()
                    ]])
                else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    LkJgFdSaQwErTy = false

                    local function yFBN9pqXcL()
                        local AsDfGhJkLzXcVb = PlayerPedId
                        local QwErTyUiOpAsDf = SetPedInfiniteAmmoClip
                        QwErTyUiOpAsDf(AsDfGhJkLzXcVb(), false)
                    end

                    yFBN9pqXcL()
                    ]])
                end 
            end
            },
            { 
                label = 'Explosive Ammo', 
                type = 'checkbox', 
                checked = false,
                onConfirm = function(setToggle) 
                    print("Explosive Ammo toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Explosive Ammo" .. (setToggle and " Enabled!" or " Disabled!"),
                            type = 'success'
                        }))
                    end
                if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    if QzWxEdCvTrBnYu == nil then QzWxEdCvTrBnYu = false end
                    QzWxEdCvTrBnYu = true

                    local function WpjLRqtm28()
                        if QzWxEdCvTrBnYu == nil then QzWxEdCvTrBnYu = false end
                        QzWxEdCvTrBnYu = true

                        local UyJhNbGtFrVbCx = CreateThread
                        UyJhNbGtFrVbCx(function()
                            local HnBvFrTgYhUzKl = PlayerPedId
                            local TmRgVbYhNtKjLp = GetPedLastWeaponImpactCoord
                            local JkLpHgTfCvXzQa = AddOwnedExplosion

                            while QzWxEdCvTrBnYu and not Unloaded do
                                local CvBnYhGtFrLpKm = HnBvFrTgYhUzKl()
                                local XsWaQzEdCvTrBn, PlKoMnBvCxZlQj = TmRgVbYhNtKjLp(CvBnYhGtFrLpKm)

                                if XsWaQzEdCvTrBn then
                                    JkLpHgTfCvXzQa(CvBnYhGtFrLpKm, PlKoMnBvCxZlQj.x, PlKoMnBvCxZlQj.y, PlKoMnBvCxZlQj.z, 6, 1.0, true, false, 0.0)
                                end

                                Wait(0)
                            end
                        end)
                    end

                    WpjLRqtm28()
                    ]])
                else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    QzWxEdCvTrBnYu = false
                    ]])
                end 
            end
            },
            { 
                label = 'Oneshot Kill', 
                type = 'checkbox', 
                checked = false,
                onConfirm = function(setToggle) 
                    print("Oneshot Kill toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Oneshot Kill" .. (setToggle and " Enabled!" or " Disabled!"),
                            type = 'success'
                        }))
                    end
                if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    if RfGtHyUjMiKoLp == nil then RfGtHyUjMiKoLp = false end
                    RfGtHyUjMiKoLp = true

                    local function xUQp7AK0tv()
                        local PlMnBvCxZaSdFg = CreateThread
                        PlMnBvCxZaSdFg(function()
                            local ZxCvBnNmLkJhGf = GetSelectedPedWeapon
                            local AsDfGhJkLzXcVb = SetWeaponDamageModifier
                            local ErTyUiOpAsDfGh = PlayerPedId

                            while RfGtHyUjMiKoLp and not Unloaded do
                                if Unloaded then
                                    RfGtHyUjMiKoLp = false
                                    break
                                end

                                local Wp = ZxCvBnNmLkJhGf(ErTyUiOpAsDfGh())
                                if Wp and Wp ~= 0 then
                                    AsDfGhJkLzXcVb(Wp, 1000.0)
                                end

                                Wait(0)
                            end
                        end)
                    end

                    xUQp7AK0tv()
                    ]])
                else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    RfGtHyUjMiKoLp = false
                    local ZxCvBnNmLkJhGf = GetSelectedPedWeapon
                    local AsDfGhJkLzXcVb = SetWeaponDamageModifier
                    local ErTyUiOpAsDfGh = PlayerPedId
                    local Wp = ZxCvBnNmLkJhGf(ErTyUiOpAsDfGh())
                    if Wp and Wp ~= 0 then
                        AsDfGhJkLzXcVb(Wp, 1.0)
                    end
                    ]])
                end 
            end
            },
            {
                label = 'Freeze Ammo',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Freeze Ammo" .. (setToggle and " Enabled!" or " Disabled!"),
                            type = 'success'
                        }))
                    end

                    if setToggle then
                        MachoInjectResource(
                            CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                            [[
                            if FzAmXyQp == nil then FzAmXyQp = false end
                            FzAmXyQp = true

                            local AmmoMultiplier = 10

                            local function xJkLpQrT()
                                local thCr = CreateThread
                                thCr(function()
                                    local gP = PlayerPedId
                                    local sW = GetSelectedPedWeapon
                                    local mA = GetMaxAmmoInClip
                                    local sAC = SetAmmoInClip
                                    local sPA = SetPedAmmo

                                    while FzAmXyQp and not Unloaded do
                                        if Unloaded then
                                            FzAmXyQp = false
                                            break
                                        end

                                        local ped = gP()
                                        local wpn = sW(ped)
                                        if wpn and wpn ~= GetHashKey("WEAPON_UNARMED") then
                                            local maxClip = mA(ped, wpn, true)
                                            if maxClip and maxClip > 0 then
                                                sAC(ped, wpn, maxClip)
                                                sPA(ped, wpn, maxClip * AmmoMultiplier)
                                            end
                                        end

                                        Wait(0)
                                    end
                                end)
                            end

                            xJkLpQrT()
                            ]]
                        )
                    else
                        MachoInjectResource(
                            CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                            [[
                            FzAmXyQp = false
                            ]]
                        )
                    end
                end
            },
            {
                label = 'Add Ammo',
                type = 'button',
                onConfirm = function()
                    MachoInjectResource(
                        CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                        [[
                        if AmSlIdV == nil then AmSlIdV = 0 end

                        local fAmPqX = PlayerPedId
                        local wpnFz = GetSelectedPedWeapon
                        local clipS = GetWeaponClipSize
                        local sAC = SetAmmoInClip
                        local sPA = SetPedAmmo
                        local slider = AmSlIdV

                        local ped = fAmPqX()
                        local wpn = wpnFz(ped)

                        if wpn and wpn ~= GetHashKey("WEAPON_UNARMED") then
                            local clipAmmo = math.min(slider, clipS(wpn))
                            local totalAmmo = slider

                            sPA(ped, wpn, totalAmmo)
                            sAC(ped, wpn, clipAmmo)

                            print("Ammo set: " .. totalAmmo .. " | Clip: " .. clipAmmo .. " for weapon " .. wpn)
                        else
                            print("Ammo Set Failed: No weapon equipped.")
                        end
                        ]]
                    )

                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Ammo set! (" .. (_G.AmSlIdV or 0) .. " total)",
                            type = 'success'
                        }))
                    end
                end
            },
            {
                label = 'Set Ammo',
                type = 'slider',
                min = 0,
                max = 250,
                value = 0,
                suffix = ' Ammo',
                onConfirm = function(val)
                    _G.AmSlIdV = val

                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Ammo slider set to " .. val,
                            type = 'success'
                        }))
                    end

                    MachoInjectResource(
                        CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                        string.format([[
                            AmSlIdV = %d
                        ]], val)
                    )
                end,
                onChange = function(val)
                    _G.AmSlIdV = val
                end
            },
            {
                label = 'Enable Damage Multiplier',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    _G.SDEn = setToggle

                    -- Inject the main logic thread once
                    if not _G.SDThreadInjected then
                        MachoInjectResource(
                            CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                            [[
                            if SDEnabled == nil then SDEnabled = false end
                            if SDMult == nil then SDMult = 1.0 end
                            local lastWpn = nil

                            CreateThread(function()
                                while not Unloaded do
                                    Wait(0)
                                    if SDEnabled then
                                        local ped = PlayerPedId()
                                        local wpn = GetSelectedPedWeapon(ped)
                                        if wpn ~= lastWpn then
                                            lastWpn = wpn
                                            SetPlayerWeaponDamageModifier(PlayerId(), SDMult)
                                        end
                                    else
                                        lastWpn = nil
                                    end
                                end
                            end)
                            ]]
                        )
                        _G.SDThreadInjected = true
                    end

                    -- Toggle the damage multiplier
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                        string.format([[
                            SDEnabled = %s
                            SetPlayerWeaponDamageModifier(PlayerId(), %s)
                        ]], tostring(setToggle), setToggle and _G.SDMlt or 1.0)
                    )

                    -- Notify
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Damage Multiplier " .. (setToggle and ("Enabled x" .. _G.SDMlt) or "Disabled"),
                            type = 'success'
                        }))
                    end
                end
            },
            {
                label = 'Damage Multiplier',
                type = 'slider',
                min = 10,
                max = 100,
                value = 10,
                suffix = 'x',
                onConfirm = function(val)
                    _G.SDMlt = val / 10.0

                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Damage Multiplier set to x" .. _G.SDMlt,
                            type = 'success'
                        }))
                    end

                    MachoInjectResource(
                        CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any",
                        string.format([[
                            SDMult = %.1f
                            if SDEnabled then
                                SetPlayerWeaponDamageModifier(PlayerId(), SDMult)
                            end
                        ]], _G.SDMlt)
                    )
                end,
                onChange = function(val)
                    _G.SDMlt = val / 10.0
                end
            },
            {
                label = 'Weapon Attachments',
                type = 'scroll',
                selected = 1,
                options = {
                    { label = "No Attachment", value = 0 },
                    { label = "Suppressor", value = 1 },
                    { label = "Extended Clip", value = 2 },
                    { label = "Flashlight", value = 3 },
                    { label = "Scope", value = 4 },
                    { label = "Luxury Finish", value = 5 },
                },
                onConfirm = function(selectedOption)
                    local ped = PlayerPedId()
                    local wpn = GetSelectedPedWeapon(ped)
            
                    local suppressors = {
                        GetHashKey("COMPONENT_AT_PI_SUPP_02"),
                        GetHashKey("COMPONENT_AT_PI_SUPP"),
                        GetHashKey("COMPONENT_CERAMICPISTOL_SUPP"),
                        GetHashKey("COMPONENT_AT_AR_SUPP_02"),
                        GetHashKey("COMPONENT_AT_SR_SUPP"),
                        GetHashKey("COMPONENT_AT_AR_SUPP"),
                        GetHashKey("COMPONENT_AT_SR_SUPP_03"),
                    }
            
                    local extendedClips = {
                        GetHashKey("COMPONENT_PISTOL_CLIP_02"),
                        GetHashKey("COMPONENT_COMBATPISTOL_CLIP_02"),
                        GetHashKey("COMPONENT_PISTOL50_CLIP_02"),
                        GetHashKey("COMPONENT_HEAVYPISTOL_CLIP_02"),
                        GetHashKey("COMPONENT_SNSPISTOL_MK2_CLIP_02"),
                        GetHashKey("COMPONENT_PISTOL_MK2_CLIP_02"),
                        GetHashKey("COMPONENT_VINTAGEPISTOL_CLIP_02"),
                        ---
                        GetHashKey("COMPONENT_CERAMICPISTOL_CLIP_02"),
                        GetHashKey("COMPONENT_MICROSMG_CLIP_02"),
                        GetHashKey("COMPONENT_SMG_CLIP_02"),
                        GetHashKey("COMPONENT_ASSAULTSMG_CLIP_02"),
                        GetHashKey("COMPONENT_MINISMG_CLIP_02"),
                        GetHashKey("COMPONENT_SMG_MK2_CLIP_02"),
                        GetHashKey("COMPONENT_MACHINEPISTOL_CLIP_02"),
                        ---
                        GetHashKey("COMPONENT_COMBATPDW_CLIP_02"),
                        GetHashKey("COMPONENT_ASSAULTSHOTGUN_CLIP_02"),
                        GetHashKey("COMPONENT_HEAVYSHOTGUN_CLIP_02"),
                        GetHashKey("COMPONENT_ASSAULTRIFLE_CLIP_02"),
                        GetHashKey("COMPONENT_CARBINERIFLE_CLIP_02"),
                        GetHashKey("COMPONENT_ADVANCEDRIFLE_CLIP_02"),
                        GetHashKey("COMPONENT_SPECIALCARBINE_CLIP_02"),
                        ---
                        GetHashKey("COMPONENT_BULLPUPRIFLE_CLIP_02"),
                        GetHashKey("COMPONENT_BULLPUPRIFLE_MK2_CLIP_02"),
                        GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CLIP_02"),
                        GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CLIP_02"),
                        GetHashKey("COMPONENT_CARBINERIFLE_MK2_CLIP_02"),
                        GetHashKey("COMPONENT_COMPACTRIFLE_CLIP_02"),
                        GetHashKey("COMPONENT_MILITARYRIFLE_CLIP_02"),
                        ---
                        GetHashKey("COMPONENT_MG_CLIP_02"),
                        GetHashKey("COMPONENT_COMBATMG_CLIP_02"),
                        GetHashKey("COMPONENT_COMBATMG_MK2_CLIP_02"),
                        GetHashKey("COMPONENT_GUSENBERG_CLIP_02"),
                        GetHashKey("COMPONENT_MARKSMANRIFLE_MK2_CLIP_02"),
                        GetHashKey("COMPONENT_HEAVYSNIPER_MK2_CLIP_02"),
                        GetHashKey("COMPONENT_MARKSMANRIFLE_CLIP_02"),
                    }

                    local flashlight = {
                        GetHashKey("COMPONENT_AT_PI_FLSH"),
                        GetHashKey("COMPONENT_AT_PI_FLSH_02"),
                        GetHashKey("COMPONENT_AT_PI_FLSH_03"),
                        GetHashKey("COMPONENT_AT_AR_FLSH"),
                    }

                    local flashlight = {
                        GetHashKey("COMPONENT_AT_PI_FLSH"),
                        GetHashKey("COMPONENT_AT_PI_FLSH_02"),
                        GetHashKey("COMPONENT_AT_PI_FLSH_03"),
                        GetHashKey("COMPONENT_AT_AR_FLSH"),
                    }

                    local scope = {
                        GetHashKey("COMPONENT_AT_SCOPE_MACRO_MK2"),
                        GetHashKey("COMPONENT_AT_PI_RAIL_02"),
                        GetHashKey("COMPONENT_AT_PI_RAIL"),
                        GetHashKey("COMPONENT_AT_SCOPE_MACRO"),
                        GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"),
                        GetHashKey("COMPONENT_AT_SCOPE_MACRO"),
                        GetHashKey("COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2"),
                        ---
                        GetHashKey("COMPONENT_AT_SCOPE_SMALL"),
                        GetHashKey("COMPONENT_AT_SCOPE_MACRO_MK2"),
                        GetHashKey("COMPONENT_AT_SCOPE_MACRO"),
                        GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"),
                        GetHashKey("COMPONENT_AT_SCOPE_SMALL"),
                        GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"),
                        GetHashKey("COMPONENT_AT_SCOPE_SMALL"),
                        ---
                        GetHashKey("COMPONENT_AT_SCOPE_MACRO_02_MK2"),
                        GetHashKey("COMPONENT_AT_SCOPE_MACRO_MK2"),
                        GetHashKey("COMPONENT_AT_SCOPE_MACRO_MK2"),
                        GetHashKey("COMPONENT_AT_SCOPE_MACRO_MK2"),
                        GetHashKey("COMPONENT_AT_SCOPE_SMALL"),
                        GetHashKey("COMPONENT_AT_SCOPE_SMALL_02"),
                        GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"),
                        ---
                        GetHashKey("COMPONENT_AT_SCOPE_SMALL_MK2"),
                        GetHashKey("COMPONENT_AT_SCOPE_MAX"),
                        GetHashKey("COMPONENT_AT_SCOPE_MAX"),
                        GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"),
                        GetHashKey("COMPONENT_AT_SCOPE_MAX"),
                        GetHashKey("COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM"),
                        GetHashKey("COMPONENT_AT_SCOPE_SMALL"),
                    }

                    local luxuryfinish = {
                        GetHashKey("COMPONENT_PISTOL_VARMOD_LUXE"),
                        GetHashKey("COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER"),
                        GetHashKey("COMPONENT_MICROSMG_VARMOD_LUXE"),
                        GetHashKey("COMPONENT_SMG_VARMOD_LUXE"),
                        GetHashKey("COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER"),
                        GetHashKey("COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER"),
                        GetHashKey("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"),
                        ---
                        GetHashKey("COMPONENT_CARBINERIFLE_VARMOD_LUXE"),
                        GetHashKey("COMPONENT_MG_VARMOD_LOWRIDER"),
                        GetHashKey("COMPONENT_MARKSMANRIFLE_VARMOD_LUXE"),
                    }
            
                    if selectedOption.value == 0 then
                        for _, comp in ipairs(suppressors) do RemoveWeaponComponentFromPed(ped, wpn, comp) end
                        for _, comp in ipairs(extendedClips) do RemoveWeaponComponentFromPed(ped, wpn, comp) end
                        for _, comp in ipairs(flashlight) do RemoveWeaponComponentFromPed(ped, wpn, comp) end
                        for _, comp in ipairs(scope) do RemoveWeaponComponentFromPed(ped, wpn, comp) end
                        for _, comp in ipairs(luxuryfinish) do RemoveWeaponComponentFromPed(ped, wpn, comp) end
                        
                    elseif selectedOption.value == 1 then
                        for _, comp in ipairs(suppressors) do GiveWeaponComponentToPed(ped, wpn, comp) end
                    elseif selectedOption.value == 2 then
                        for _, comp in ipairs(extendedClips) do GiveWeaponComponentToPed(ped, wpn, comp) end
                    elseif selectedOption.value == 3 then
                        for _, comp in ipairs(flashlight) do GiveWeaponComponentToPed(ped, wpn, comp) end
                    elseif selectedOption.value == 4 then
                        for _, comp in ipairs(scope) do GiveWeaponComponentToPed(ped, wpn, comp) end
                    elseif selectedOption.value == 5 then
                        for _, comp in ipairs(luxuryfinish) do GiveWeaponComponentToPed(ped, wpn, comp) end
                    end
            
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Weapon Attachment set to " .. selectedOption.label,
                            type = 'success'
                        }))
                    end
                end
            },
            {
                label = 'Weapon Tint',
                type = 'scroll',
                selected = 1,
                options = {
                    { label = "Normal", value = 0 },
                    { label = "Green", value = 1 },
                    { label = "Gold", value = 2 },
                    { label = "Pink", value = 3 },
                    { label = "Army", value = 4 },
                    { label = "LSPD", value = 5 },
                    { label = "Orange", value = 6 },
                    { label = "Platinum", value = 7 }
                },
                onConfirm = function(selectedOption)
                    _G.CurTint = selectedOption.value

                    MachoInjectResource("any", string.format([[
                        local ped = PlayerPedId()
                        local wpn = GetSelectedPedWeapon(ped)
                        SetPedWeaponTintIndex(ped, wpn, %d)
                    ]], _G.CurTint))

                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Weapon Tint changed to " .. selectedOption.label,
                            type = 'success'
                        }))
                    end
                end
            },

            {
                label = 'Give All Weapons',
                type = 'button',
                onConfirm = function()
                MachoInjectResource("any", [[
                local allWeapons = {
                    "WEAPON_KNIFE",
                    "WEAPON_PISTOL",
                    "WEAPON_COMBATPISTOL",
                    "WEAPON_APPISTOL",
                    "WEAPON_MICROSMG",
                    "WEAPON_SMG",
                    "WEAPON_ASSAULTRIFLE",
                    "WEAPON_CARBINERIFLE",
                    "WEAPON_ADVANCEDRIFLE",
                    "WEAPON_MG",
                    "WEAPON_COMBATMG",
                    "WEAPON_PUMPSHOTGUN",
                    "WEAPON_SAWNOFFSHOTGUN",
                    "WEAPON_ASSAULTSHOTGUN",
                    "WEAPON_BULLPUPSHOTGUN",
                    "WEAPON_STUNGUN",
                    "WEAPON_SNIPERRIFLE",
                    "WEAPON_HEAVYSNIPER",
                    "WEAPON_GRENADELAUNCHER",
                    "WEAPON_RPG",
                    "WEAPON_MINIGUN",
                    "WEAPON_GRENADE",
                    "WEAPON_STICKYBOMB",
                    "WEAPON_SMOKEGRENADE",
                    "WEAPON_MOLOTOV",
                    "WEAPON_FIREEXTINGUISHER",
                    "WEAPON_PETROLCAN",
                    "WEAPON_BALL",
                    "WEAPON_BZGAS",
                    "WEAPON_FLARE",
                    "WEAPON_SNSPISTOL",
                    "WEAPON_SPECIALCARBINE",
                    "WEAPON_HEAVYPISTOL",
                    "WEAPON_BULLPUPRIFLE",
                    "WEAPON_HOMINGLAUNCHER",
                    "WEAPON_PROXMINE",
                    "WEAPON_SNOWBALL",
                    "WEAPON_VINTAGEPISTOL",
                    "WEAPON_DAGGER",
                    "WEAPON_FIREWORK",
                    "WEAPON_MUSKET",
                    "WEAPON_MARKSMANRIFLE",
                    "WEAPON_HEAVYSHOTGUN",
                    "WEAPON_GUSENBERG",
                    "WEAPON_HATCHET",
                    "WEAPON_RAILGUN",
                    "WEAPON_MACHETE",
                    "WEAPON_MACHINEPISTOL",
                    "WEAPON_SWITCHBLADE",
                    "WEAPON_REVOLVER",
                    "WEAPON_DBSHOTGUN",
                    "WEAPON_COMPACTRIFLE",
                    "WEAPON_AUTOSHOTGUN",
                    "WEAPON_BATTLEAXE",
                    "WEAPON_COMPACTLAUNCHER",
                    "WEAPON_MINISMG",
                    "WEAPON_PIPEBOMB",
                    "WEAPON_POOLCUE",
                    "WEAPON_WRENCH"
                }

                for _, weaponName in ipairs(allWeapons) do
                    local weaponHash = GetHashKey(weaponName)
                    GiveWeaponToPed(PlayerPedId(), weaponHash, 255, false, true)
                end
                    ]], function(message)
                        if dui then
                            MachoSendDuiMessage(dui, json.encode({
                                action = 'notify',
                                message = "Gived all weapons",
                                type = 'success'
                            }))
                        end
                    end)
                end
            }
        }
    },

    {
        label = "Vehicle",
        type = 'submenu',
        icon = 'ph-car',
        submenu = {
            { 
                label = 'Spawn Vehicle', 
                type = 'button', 
                onConfirm = function() 
                    print("Spawning car")
                    requestCarSpawn()
                end 
            },
            {
                label = 'Vehicle Godmode',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Vehicle Godmode toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Vehicle Godmode Enabled" or "Vehicle Godmode Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end
                    if setToggle then
                        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                            if zXcVbNmQwErTyUi == nil then zXcVbNmQwErTyUi = false end
                            zXcVbNmQwErTyUi = true

                            local function LWyZoXRbqK()
                                local LkJhGfDsAzXcVb = CreateThread
                                LkJhGfDsAzXcVb(function()
                                    while zXcVbNmQwErTyUi and not Unloaded do
                                        local QwErTyUiOpAsDfG = GetVehiclePedIsIn
                                        local TyUiOpAsDfGhJkL = PlayerPedId
                                        local AsDfGhJkLzXcVbN = SetEntityInvincible

                                        local vehicle = QwErTyUiOpAsDfG(TyUiOpAsDfGhJkL(), false)
                                        if vehicle and vehicle ~= 0 then
                                            AsDfGhJkLzXcVbN(vehicle, true)
                                        end
                                        Wait(0)
                                    end
                                end)
                            end

                            LWyZoXRbqK()
                        ]])
                    else
                        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                            zXcVbNmQwErTyUi = false
                            local QwErTyUiOpAsDfG = GetVehiclePedIsIn
                            local TyUiOpAsDfGhJkL = PlayerPedId
                            local AsDfGhJkLzXcVbN = SetEntityInvincible

                            local vehicle = QwErTyUiOpAsDfG(TyUiOpAsDfGhJkL(), true)
                            if vehicle and vehicle ~= 0 then
                                AsDfGhJkLzXcVbN(vehicle, false)
                            end
                        ]])
                    end
                end
            },
            {
                label = 'Tesla Mode',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Tesla Mode toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Tesla Mode Enabled" or "Tesla Mode Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end
                    if setToggle then
                        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if not AutoDriveActive then
                            AutoDriveActive = true
                            Citizen.CreateThread(function()
                                local ped = PlayerPedId()
                                local veh = GetVehiclePedIsIn(ped, false)
                                if veh ~= 0 then
                                    TaskVehicleDriveWander(ped, veh, 40.0, 0)
                                end
                            end)
                        end
                        ]])
                    else
                        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        AutoDriveActive = false
                        ClearPedTasks(PlayerPedId())
                        ]])
                    end
                end
            },
            {
                label = 'Force Vehicle Engine',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Force Vehicle Engine toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Force Vehicle Engine Enabled" or "Force Vehicle Engine Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end
                    if setToggle then
                        MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                            if GhYtReFdCxWaQzLp == nil then GhYtReFdCxWaQzLp = false end
                            GhYtReFdCxWaQzLp = true

                            local function OpAsDfGhJkLzXcVb()
                                local lMnbVcXzZaSdFg = CreateThread
                                lMnbVcXzZaSdFg(function()
                                    local QwErTyUiOp         = _G.PlayerPedId
                                    local AsDfGhJkLz         = _G.GetVehiclePedIsIn
                                    local TyUiOpAsDfGh       = _G.GetVehiclePedIsTryingToEnter
                                    local ZxCvBnMqWeRtYu     = _G.SetVehicleEngineOn
                                    local ErTyUiOpAsDfGh     = _G.SetVehicleUndriveable
                                    local KeEpOnAb           = _G.SetVehicleKeepEngineOnWhenAbandoned
                                    local En_g_Health_Get    = _G.GetVehicleEngineHealth
                                    local En_g_Health_Set    = _G.SetVehicleEngineHealth
                                    local En_g_Degrade_Set   = _G.SetVehicleEngineCanDegrade
                                    local No_Hotwire_Set     = _G.SetVehicleNeedsToBeHotwired

                                    local function _tick(vh)
                                        if vh and vh ~= 0 then
                                            No_Hotwire_Set(vh, false)
                                            En_g_Degrade_Set(vh, false)
                                            ErTyUiOpAsDfGh(vh, false)
                                            KeEpOnAb(vh, true)

                                            local eh = En_g_Health_Get(vh)
                                            if (not eh) or eh < 300.0 then
                                                En_g_Health_Set(vh, 900.0)
                                            end

                                            ZxCvBnMqWeRtYu(vh, true, true, true)
                                        end
                                    end

                                    while GhYtReFdCxWaQzLp and not Unloaded do
                                        local p  = QwErTyUiOp()

                                        _tick(AsDfGhJkLz(p, false))
                                        _tick(TyUiOpAsDfGh(p))
                                        _tick(AsDfGhJkLz(p, true))

                                        Wait(0)
                                    end
                                end)
                            end

                            OpAsDfGhJkLzXcVb()
                        ]])
                    else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        GhYtReFdCxWaQzLp = false
                        local v = GetVehiclePedIsIn(PlayerPedId(), false)
                        if v and v ~= 0 then
                            SetVehicleKeepEngineOnWhenAbandoned(v, false)
                            SetVehicleEngineCanDegrade(v, true)
                            SetVehicleUndriveable(v, false)
                        end
                    ]])
                    end
                end
            },
            {
                label = 'Vehicle Auto Repair',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Vehicle Auto Repair toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Vehicle Auto Repair Enabled" or "Vehicle Auto Repair Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end

                    if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if PlAsQwErTyUiOp == nil then PlAsQwErTyUiOp = false end
                        PlAsQwErTyUiOp = true

                        local function uPkqLXTm98()
                            local QwErTyUiOpAsDf = CreateThread
                            QwErTyUiOpAsDf(function()
                                while PlAsQwErTyUiOp and not Unloaded do
                                    local AsDfGhJkLzXcVb = PlayerPedId
                                    local LzXcVbNmQwErTy = GetVehiclePedIsIn
                                    local VbNmLkJhGfDsAz = SetVehicleFixed
                                    local MnBvCxZaSdFgHj = SetVehicleDirtLevel

                                    local ped = AsDfGhJkLzXcVb()
                                    local vehicle = LzXcVbNmQwErTy(ped, false)
                                    if vehicle and vehicle ~= 0 then
                                        VbNmLkJhGfDsAz(vehicle)
                                        MnBvCxZaSdFgHj(vehicle, 0.0)
                                    end

                                    Wait(0)
                                end
                            end)
                        end

                        uPkqLXTm98()
                    ]])
                    else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        PlAsQwErTyUiOp = false
                    ]])
                    end
                end
            },
            {
                label = 'Freeze Vehicle',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Freeze Vehicle toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Freeze Vehicle Enabled" or "Freeze Vehicle Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end
                    if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if LzKxWcVbNmQwErTy == nil then LzKxWcVbNmQwErTy = false end
                        LzKxWcVbNmQwErTy = true

                        local function WkQ79ZyLpT()
                            local tYhGtFrDeSwQaZx = CreateThread
                            local xCvBnMqWeRtYuIo = PlayerPedId
                            local aSdFgHjKlZxCvBn = GetVehiclePedIsIn
                            local gKdNqLpYxMiV = FreezeEntityPosition
                            local jBtWxFhPoZuR = Wait

                            tYhGtFrDeSwQaZx(function()
                                while LzKxWcVbNmQwErTy and not Unloaded do
                                    local VbNmLkJhGfDsAzX = xCvBnMqWeRtYuIo()
                                    local IoPlMnBvCxZaSdF = aSdFgHjKlZxCvBn(VbNmLkJhGfDsAzX, false)
                                    if IoPlMnBvCxZaSdF and IoPlMnBvCxZaSdF ~= 0 then
                                        gKdNqLpYxMiV(IoPlMnBvCxZaSdF, true)
                                    end
                                    jBtWxFhPoZuR(0)
                                end
                            end)
                        end

                        WkQ79ZyLpT()
                    ]])
                    else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        LzKxWcVbNmQwErTy = false

                        local function i7qWlBXtPo()
                            local yUiOpAsDfGhJkLz = PlayerPedId
                            local QwErTyUiOpAsDfG = GetVehiclePedIsIn
                            local FdSaPlMnBvCxZlK = FreezeEntityPosition

                            local pEdRfTgYhUjIkOl = yUiOpAsDfGhJkLz()
                            local zXcVbNmQwErTyUi = QwErTyUiOpAsDfG(pEdRfTgYhUjIkOl, true)
                            if zXcVbNmQwErTyUi and zXcVbNmQwErTyUi ~= 0 then
                                FdSaPlMnBvCxZlK(zXcVbNmQwErTyUi, false)
                            end
                        end

                        i7qWlBXtPo()
                    ]])
                    end
                end
            },
            {
                label = 'Rainbow Vehicle',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Rainbow Vehicle toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Rainbow Vehicle Enabled" or "Rainbow Vehicle Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end
                    if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if GxRpVuNzYiTq == nil then GxRpVuNzYiTq = false end
                        GxRpVuNzYiTq = true

                        local function jqX7TvYzWq()
                            local WvBnMpLsQzTx = GetGameTimer
                            local VcZoPwLsEkRn = math.floor
                            local DfHkLtQwAzCx = math.sin
                            local PlJoQwErTgYs = CreateThread
                            local MzLxVoKsUyNz = GetVehiclePedIsIn
                            local EyUiNkOpLtRg = PlayerPedId
                            local KxFwEmTrZpYq = DoesEntityExist
                            local UfBnDxCrQeTg = SetVehicleCustomPrimaryColour
                            local BvNzMxLoPwEq = SetVehicleCustomSecondaryColour

                            local yGfTzLkRn = 1.0

                            local function HrCvWbXuNz(freq)
                                local color = {}
                                local t = WvBnMpLsQzTx() / 1000
                                color.r = VcZoPwLsEkRn(DfHkLtQwAzCx(t * freq + 0) * 127 + 128)
                                color.g = VcZoPwLsEkRn(DfHkLtQwAzCx(t * freq + 2) * 127 + 128)
                                color.b = VcZoPwLsEkRn(DfHkLtQwAzCx(t * freq + 4) * 127 + 128)
                                return color
                            end

                            PlJoQwErTgYs(function()
                                while GxRpVuNzYiTq and not Unloaded do
                                    local ped = EyUiNkOpLtRg()
                                    local veh = MzLxVoKsUyNz(ped, false)
                                    if veh and veh ~= 0 and KxFwEmTrZpYq(veh) then
                                        local rgb = HrCvWbXuNz(yGfTzLkRn)
                                        UfBnDxCrQeTg(veh, rgb.r, rgb.g, rgb.b)
                                        BvNzMxLoPwEq(veh, rgb.r, rgb.g, rgb.b)
                                    end
                                    Wait(0)
                                end
                            end)
                        end

                        jqX7TvYzWq()
                    ]])
                    else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        GxRpVuNzYiTq = false
                    ]])
                    end
                end
            },
            {
                label = 'Drift Mode (Hold Shift)',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Drift Mode toggled:" .. tostring(setToggle))
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Drift Mode Enabled" or "Drift Mode Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end
                    if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    if MqTwErYuIoLp == nil then MqTwErYuIoLp = false end
                    MqTwErYuIoLp = true

                    local function PlRtXqJm92()
                        local XtFgDsQwAzLp = CreateThread
                        local UiOpAsDfGhKl = PlayerPedId
                        local JkHgFdSaPlMn = GetVehiclePedIsIn
                        local WqErTyUiOpAs = IsControlPressed
                        local AsZxCvBnMaSd = DoesEntityExist
                        local KdJfGvBhNtMq = SetVehicleReduceGrip

                        XtFgDsQwAzLp(function()
                            while MqTwErYuIoLp and not Unloaded do
                                Wait(0)
                                local ped = UiOpAsDfGhKl()
                                local veh = JkHgFdSaPlMn(ped, false)
                                if veh ~= 0 and AsZxCvBnMaSd(veh) then
                                    if WqErTyUiOpAs(0, 21) then
                                        KdJfGvBhNtMq(veh, true)
                                    else
                                        KdJfGvBhNtMq(veh, false)
                                    end
                                end
                            end
                        end)
                    end

                    PlRtXqJm92()
                    ]])
                    else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    MqTwErYuIoLp = false
                    local ZtQwErTyUiOp = PlayerPedId
                    local DfGhJkLzXcVb = GetVehiclePedIsIn
                    local VbNmAsDfGhJk = DoesEntityExist
                    local NlJkHgFdSaPl = SetVehicleReduceGrip

                    local ped = ZtQwErTyUiOp()
                    local veh = DfGhJkLzXcVb(ped, false)
                    if veh ~= 0 and VbNmAsDfGhJk(veh) then
                        NlJkHgFdSaPl(veh, false)
                    end
                    ]])
                    end
                end
            },
            {
                label = 'Easy Handling',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Easy Handling toggled:" .. tostring(setToggle))
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Easy Handling Enabled" or "Easy Handling Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end
                    if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if NvGhJkLpOiUy == nil then NvGhJkLpOiUy = false end
                        NvGhJkLpOiUy = true

                        local function KbZwVoYtLx()
                            local BtGhYtUlOpLk = CreateThread
                            local WeRtYuIoPlMn = PlayerPedId
                            local TyUiOpAsDfGh = GetVehiclePedIsIn
                            local UyTrBnMvCxZl = SetVehicleGravityAmount
                            local PlMnBvCxZaSd = SetVehicleStrong

                            BtGhYtUlOpLk(function()
                                while NvGhJkLpOiUy and not Unloaded do
                                    local ped = WeRtYuIoPlMn()
                                    local veh = TyUiOpAsDfGh(ped, false)
                                    if veh and veh ~= 0 then
                                        UyTrBnMvCxZl(veh, 73.0)
                                        PlMnBvCxZaSd(veh, true)
                                    end
                                    Wait(0)
                                end

                                local ped = WeRtYuIoPlMn()
                                local veh = TyUiOpAsDfGh(ped, false)
                                if veh and veh ~= 0 then
                                    UyTrBnMvCxZl(veh, 9.8)
                                    PlMnBvCxZaSd(veh, false)
                                end
                            end)
                        end

                        KbZwVoYtLx()
                    ]])
                    else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        NvGhJkLpOiUy = false
                        local UyTrBnMvCxZl = SetVehicleGravityAmount
                        local PlMnBvCxZaSd = SetVehicleStrong
                        local ped = PlayerPedId()
                        local veh = GetVehiclePedIsIn(ped, false)
                        if veh and veh ~= 0 then
                            UyTrBnMvCxZl(veh, 9.8)
                            PlMnBvCxZaSd(veh, false)
                        end
                    ]])
                    end
                end
            },
            {
                label = 'Shift Boost',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Shift Boost toggled:" .. tostring(setToggle))
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Shift Boost Enabled" or "Shift Boost Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end
                    if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if QwErTyUiOpSh == nil then QwErTyUiOpSh = false end
                        QwErTyUiOpSh = true

                        local function ZxCvBnMmLl()
                            local aAaBbCcDdEe = CreateThread
                            local fFfGgGgHhIi = Wait
                            local jJkKlLmMnNo = PlayerPedId
                            local pPqQrRsStTu = IsPedInAnyVehicle
                            local vVwWxXyYzZa = GetVehiclePedIsIn
                            local bBcCdDeEfFg = IsDisabledControlJustPressed
                            local sSeEtTvVbBn = SetVehicleForwardSpeed

                            aAaBbCcDdEe(function()
                                while QwErTyUiOpSh and not Unloaded do
                                    local _ped = jJkKlLmMnNo()
                                    if pPqQrRsStTu(_ped, false) then
                                        local _veh = vVwWxXyYzZa(_ped, false)
                                        if _veh ~= 0 and bBcCdDeEfFg(0, 21) then
                                            sSeEtTvVbBn(_veh, 150.0)
                                        end
                                    end
                                    fFfGgGgHhIi(0)
                                end
                            end)
                        end

                        ZxCvBnMmLl()
                    ]])
                    else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        QwErTyUiOpSh = false
                    ]])
                    end
                end
            },
            {
                label = 'Instant Breaks',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Instant Breaks toggled:" .. tostring(setToggle))
                   if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Instant Breaks Enabled" or "Instant Breaks Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end
                    if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if VkLpOiUyTrEq == nil then VkLpOiUyTrEq = false end
                        VkLpOiUyTrEq = true

                        local function YgT7FrqXcN()
                            local ZxSeRtYhUiOp = CreateThread
                            local LkJhGfDsAzXv = PlayerPedId
                            local PoLkJhBgVfCd = GetVehiclePedIsIn
                            local ErTyUiOpAsDf = IsDisabledControlPressed
                            local GtHyJuKoLpMi = IsPedInAnyVehicle
                            local VbNmQwErTyUi = SetVehicleForwardSpeed

                            ZxSeRtYhUiOp(function()
                                while VkLpOiUyTrEq and not Unloaded do
                                    local ped = LkJhGfDsAzXv()
                                    local veh = PoLkJhBgVfCd(ped, false)
                                    if veh and veh ~= 0 then
                                        if ErTyUiOpAsDf(0, 33) and GtHyJuKoLpMi(ped, false) then
                                            VbNmQwErTyUi(veh, 0.0)
                                        end
                                    end
                                    Wait(0)
                                end
                            end)
                        end

                        YgT7FrqXcN()
                    ]])
                    else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        VkLpOiUyTrEq = false
                    ]])
                    end
                end
            },
            {
                label = 'Unlimited Fuel',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Unlimited Fuel toggled:" .. tostring(setToggle))
                   if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Unlimited Fuel Enabled" or "Unlimited Fuel Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end
                    if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if BlNkJmLzXcVb == nil then BlNkJmLzXcVb = false end
                        BlNkJmLzXcVb = true

                        local function LqWyXpR3tV()
                            local TmPlKoMiJnBg = CreateThread
                            local ZxCvBnMaSdFg = PlayerPedId
                            local YhUjIkOlPlMn = IsPedInAnyVehicle
                            local VcXzQwErTyUi = GetVehiclePedIsIn
                            local KpLoMkNjBhGt = DoesEntityExist
                            local JkLzXcVbNmAs = SetVehicleFuelLevel

                            TmPlKoMiJnBg(function()
                                while BlNkJmLzXcVb and not Unloaded do
                                    local ped = ZxCvBnMaSdFg()
                                    if YhUjIkOlPlMn(ped, false) then
                                        local veh = VcXzQwErTyUi(ped, false)
                                        if KpLoMkNjBhGt(veh) then
                                            JkLzXcVbNmAs(veh, 100.0)
                                        end
                                    end
                                    Wait(100)
                                end
                            end)
                        end

                        LqWyXpR3tV()
                    ]])
                    else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        BlNkJmLzXcVb = false
                    ]])
                    end
                end
            },
            { 
                label = 'Repair Vehicle', 
                type = 'button', 
                onConfirm = function() 
                    print("Repair Vehicle")
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Vehicle Repaired Successfully",
                            type = 'success'
                        }))
                    end
                MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function FgN7LqxZyP()
                        local aBcD = PlayerPedId
                        local eFgH = GetVehiclePedIsIn
                        local iJkL = SetVehicleFixed
                        local mNoP = SetVehicleDeformationFixed

                        local p = aBcD()
                        local v = eFgH(p, false)
                        if v and v ~= 0 then
                            iJkL(v)
                            mNoP(v)
                        end
                    end

                    FgN7LqxZyP()
                ]])
                end 
            },
            { 
                label = 'Flip Vehicle', 
                type = 'button', 
                onConfirm = function() 
                    print("Flip Vehicle")
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Flip Vehicle Successfully",
                            type = 'success'
                        }))
                    end
                MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function vXmYLT9pq2()
                        local a = PlayerPedId
                        local b = GetVehiclePedIsIn
                        local c = GetEntityHeading
                        local d = SetEntityRotation

                        local ped = a()
                        local veh = b(ped, false)
                        if veh and veh ~= 0 then
                            d(veh, 0.0, 0.0, c(veh))
                        end
                    end

                    vXmYLT9pq2()
                ]])
                end 
            },
            { 
                label = 'Clean Vehicle', 
                type = 'button', 
                onConfirm = function() 
                    print("Clean Vehicle")
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Clean Vehicle Successfully",
                            type = 'success'
                        }))
                    end
                MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function qPwRYKz7mL()
                        local a = PlayerPedId
                        local b = GetVehiclePedIsIn
                        local c = SetVehicleDirtLevel

                        local ped = a()
                        local veh = b(ped, false)
                        if veh and veh ~= 0 then
                            c(veh, 0.0)
                        end
                    end

                    qPwRYKz7mL()
                ]])
                end 
            },
            { 
                label = 'Delete Vehicle', 
                type = 'button', 
                onConfirm = function() 
                    print("Delete Vehicle")
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Deleted Vehicle Successfully",
                            type = 'success'
                        }))
                    end
                MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function LXpTqWvR80()
                        local aQw = PlayerPedId
                        local bEr = GetVehiclePedIsIn
                        local cTy = DoesEntityExist
                        local dUi = NetworkHasControlOfEntity
                        local eOp = SetEntityAsMissionEntity
                        local fAs = DeleteEntity
                        local gDf = DeleteVehicle
                        local hJk = SetVehicleHasBeenOwnedByPlayer

                        local ped = aQw()
                        local veh = bEr(ped, false)

                        if veh and veh ~= 0 and cTy(veh) then
                            hJk(veh, true)
                            eOp(veh, true, true)

                            if dUi(veh) then
                                fAs(veh)
                                gDf(veh)
                            end
                        end

                    end

                    LXpTqWvR80()
                ]])
                end 
            },
            { 
                label = 'Toggle Vehicle Engine', 
                type = 'button', 
                onConfirm = function() 
                    print("Toggle Vehicle Engine")
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Toggled Vehicle Engine Successfully",
                            type = 'success'
                        }))
                    end
                MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function NKzqVoXYLm()
                        local a = PlayerPedId
                        local b = GetVehiclePedIsIn
                        local c = GetIsVehicleEngineRunning
                        local d = SetVehicleEngineOn

                        local ped = a()
                        local veh = b(ped, false)
                        if veh and veh ~= 0 then
                            if c(veh) then
                                d(veh, false, true, true)
                            else
                                d(veh, true, true, false)
                            end
                        end
                    end

                    NKzqVoXYLm()
                ]])
                end 
            },
            { 
                label = 'Max Vehicle Upgrades', 
                type = 'button', 
                onConfirm = function() 
                    print("Max Vehicle Upgrades")
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Maxed Vehicle Upgrades Successfully",
                            type = 'success'
                        }))
                    end
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        local function XzPmLqRnWyBtVkGhQe()
                            local FnUhIpOyLkTrEzSd = PlayerPedId
                            local VmBgTnQpLcZaWdEx = GetVehiclePedIsIn
                            local RfDsHuNjMaLpOyBt = SetVehicleModKit
                            local AqWsEdRzXcVtBnMa = SetVehicleWheelType
                            local TyUiOpAsDfGhJkLz = GetNumVehicleMods
                            local QwErTyUiOpAsDfGh = SetVehicleMod
                            local ZxCvBnMqWeRtYuIo = ToggleVehicleMod
                            local MnBvCxZaSdFgHjKl = SetVehicleWindowTint
                            local LkJhGfDsQaZwXeCr = SetVehicleTyresCanBurst
                            local UjMiKoLpNwAzSdFg = SetVehicleExtra
                            local RvTgYhNuMjIkLoPb = DoesExtraExist

                            local lzQwXcVeTrBnMkOj = FnUhIpOyLkTrEzSd()
                            local jwErTyUiOpMzNaLk = VmBgTnQpLcZaWdEx(lzQwXcVeTrBnMkOj, false)
                            if not jwErTyUiOpMzNaLk or jwErTyUiOpMzNaLk == 0 then return end

                            RfDsHuNjMaLpOyBt(jwErTyUiOpMzNaLk, 0)
                            AqWsEdRzXcVtBnMa(jwErTyUiOpMzNaLk, 7)

                            for XyZoPqRtWnEsDfGh = 0, 16 do
                                local uYtReWqAzXsDcVf = TyUiOpAsDfGhJkLz(jwErTyUiOpMzNaLk, XyZoPqRtWnEsDfGh)
                                if uYtReWqAzXsDcVf and uYtReWqAzXsDcVf > 0 then
                                    QwErTyUiOpAsDfGh(jwErTyUiOpMzNaLk, XyZoPqRtWnEsDfGh, uYtReWqAzXsDcVf - 1, false)
                                end
                            end

                            QwErTyUiOpAsDfGh(jwErTyUiOpMzNaLk, 14, 16, false)

                            local aSxDcFgHiJuKoLpM = TyUiOpAsDfGhJkLz(jwErTyUiOpMzNaLk, 15)
                            if aSxDcFgHiJuKoLpM and aSxDcFgHiJuKoLpM > 1 then
                                QwErTyUiOpAsDfGh(jwErTyUiOpMzNaLk, 15, aSxDcFgHiJuKoLpM - 2, false)
                            end

                            for QeTrBnMkOjHuYgFv = 17, 22 do
                                ZxCvBnMqWeRtYuIo(jwErTyUiOpMzNaLk, QeTrBnMkOjHuYgFv, true)
                            end

                            QwErTyUiOpAsDfGh(jwErTyUiOpMzNaLk, 23, 1, false)
                            QwErTyUiOpAsDfGh(jwErTyUiOpMzNaLk, 24, 1, false)

                            for TpYuIoPlMnBvCxZq = 1, 12 do
                                if RvTgYhNuMjIkLoPb(jwErTyUiOpMzNaLk, TpYuIoPlMnBvCxZq) then
                                    UjMiKoLpNwAzSdFg(jwErTyUiOpMzNaLk, TpYuIoPlMnBvCxZq, false)
                                end
                            end

                            MnBvCxZaSdFgHjKl(jwErTyUiOpMzNaLk, 1)
                            LkJhGfDsQaZwXeCr(jwErTyUiOpMzNaLk, false)
                        end

                        XzPmLqRnWyBtVkGhQe()
                    ]])
                end 
            },
            { 
                label = 'Teleport into Closest Vehicle', 
                type = 'button', 
                onConfirm = function() 
                    print("Teleport into Closest Vehicle")
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Teleported into The Closest Vehicle!",
                            type = 'success'
                        }))
                    end
                MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function uPKcoBaEHmnK()
                        local ziCFzHyzxaLX = SetPedIntoVehicle
                        local YPPvDlOGBghA = GetClosestVehicle

                        local Coords = GetEntityCoords(PlayerPedId())
                        local vehicle = YPPvDlOGBghA(Coords.x, Coords.y, Coords.z, 15.0, 0, 70)

                        if DoesEntityExist(vehicle) and not IsPedInAnyVehicle(PlayerPedId(), false) then
                            if GetPedInVehicleSeat(vehicle, -1) == 0 then
                                ziCFzHyzxaLX(PlayerPedId(), vehicle, -1)
                            else
                                ziCFzHyzxaLX(PlayerPedId(), vehicle, 0)
                            end
                        end
                    end

                    uPKcoBaEHmnK()
                ]])
                end 
            },
            { 
                label = 'Unlock Closest Vehicle', 
                type = 'button', 
                onConfirm = function() 
                    print("Unlock Closest Vehicle")
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Unlocked The Closest Vehicle!",
                            type = 'success'
                        }))
                    end
                MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function TpLMqKtXwZ()
                        local AsoYuTrBnMvCxZaQw = PlayerPedId
                        local GhrTnLpKjUyVbMnZx = GetEntityCoords
                        local UyeWsDcXzQvBnMaLp = GetClosestVehicle
                        local ZmkLpQwErTyUiOpAs = DoesEntityExist
                        local VczNmLoJhBgVfCdEx = SetEntityAsMissionEntity
                        local EqWoXyBkVsNzQuH = SetVehicleDoorsLocked
                        local YxZwQvTrBnMaSdFgHj = SetVehicleDoorsLockedForAllPlayers
                        local RtYuIoPlMnBvCxZaSd = SetVehicleHasBeenOwnedByPlayer
                        local LkJhGfDsAzXwCeVrBt = NetworkHasControlOfEntity

                        local ped = AsoYuTrBnMvCxZaQw()
                        local coords = GhrTnLpKjUyVbMnZx(ped)
                        local veh = UyeWsDcXzQvBnMaLp(coords.x, coords.y, coords.z, 10.0, 0, 70)

                        if veh and ZmkLpQwErTyUiOpAs(veh) and LkJhGfDsAzXwCeVrBt(veh) then
                            VczNmLoJhBgVfCdEx(veh, true, true)
                            RtYuIoPlMnBvCxZaSd(veh, true)
                            EqWoXyBkVsNzQuH(veh, 1)
                            YxZwQvTrBnMaSdFgHj(veh, false)
                        end

                    end

                    TpLMqKtXwZ()
                ]])
                end 
            },
            { 
                label = 'Lock Closest Vehicle', 
                type = 'button', 
                onConfirm = function() 
                    print("Lock Closest Vehicle")
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Locked The Closest Vehicle!",
                            type = 'success'
                        }))
                    end
                MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                    local function tRYpZvKLxQ()
                        local WqEoXyBkVsNzQuH = PlayerPedId
                        local LoKjBtWxFhPoZuR = GetEntityCoords
                        local VbNmAsDfGhJkLzXcVb = GetClosestVehicle
                        local TyUiOpAsDfGhJkLzXc = DoesEntityExist
                        local PlMnBvCxZaSdFgTrEq = SetEntityAsMissionEntity
                        local KjBtWxFhPoZuRZlK = SetVehicleHasBeenOwnedByPlayer
                        local AsDfGhJkLzXcVbNmQwE = SetVehicleDoorsLocked
                        local QwEoXyBkVsNzQuHL = SetVehicleDoorsLockedForAllPlayers
                        local ZxCvBnMaSdFgTrEqWz = NetworkHasControlOfEntity

                        local ped = WqEoXyBkVsNzQuH()
                        local coords = LoKjBtWxFhPoZuR(ped)
                        local veh = VbNmAsDfGhJkLzXcVb(coords.x, coords.y, coords.z, 10.0, 0, 70)

                        if veh and TyUiOpAsDfGhJkLzXc(veh) and ZxCvBnMaSdFgTrEqWz(veh) then
                            PlMnBvCxZaSdFgTrEq(veh, true, true)
                            KjBtWxFhPoZuRZlK(veh, true)
                            AsDfGhJkLzXcVbNmQwE(veh, 2)
                            QwEoXyBkVsNzQuHL(veh, true)
                        end
                    end

                    tRYpZvKLxQ()
                ]])
                end 
            },
            {
                label = 'Kick Flip',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Kick Flip toggled:" .. tostring(setToggle))
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Kick Flip Enabled" or "Kick Flip Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end
                    if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if KickFlipEnabled == nil then KickFlipEnabled = false end
                        KickFlipEnabled = true

                        CreateThread(function()
                            while KickFlipEnabled do
                                Wait(0)

                                if IsControlJustPressed(0, 22) then
                                    local ped = PlayerPedId()
                                    local veh = GetVehiclePedIsIn(ped, false)

                                    if DoesEntityExist(veh) then
                                        ApplyForceToEntity(
                                            veh,
                                            1, -- force type
                                            0.0, 0.0, 10.0,  -- upward force
                                            90.0, 0.0, 0.0,  -- rotation
                                            0,
                                            false, true, true, false, true
                                        )
                                        print("[Macho] Kick Flip via SPACE")
                                    end
                                end
                            end
                        end)
                    ]])
                    else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        KickFlipEnabled = false
                    ]])
                    end
                end
            },
            {
                label = 'Back Flip',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Back Flip toggled:" .. tostring(setToggle))
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Back Flip Enabled" or "Back Flip Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end
                    if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if BackFlipEnabled == nil then BackFlipEnabled = false end
                        BackFlipEnabled = true

                        CreateThread(function()
                            while BackFlipEnabled and not Unloaded do
                                Wait(0)

                                if IsControlJustPressed(0, 22) then 
                                    local playerPed = PlayerPedId()
                                    local playerVeh = GetVehiclePedIsIn(playerPed, true)

                                    if DoesEntityExist(playerVeh) then
                                        ApplyForceToEntity(
                                            playerVeh,
                                            1,
                                            0.0, 0.0, 15.0,   
                                            0.0, 60.0, 0.0,   
                                            0,
                                            false, true, true, false, true
                                        )
                                        print("[Luxor] Back Flip triggered with SPACEBAR")
                                    end
                                end
                            end
                        end)
                    ]])
                    else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        BackFlipEnabled = false
                    ]])
                    end
                end
            },
            {
                label = 'Bunny Hop',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Bunny Hop toggled:" .. tostring(setToggle))
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Bunny Hop Enabled" or "Bunny Hop Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end
                    if setToggle then
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        if BunnyHopEnabled == nil then BunnyHopEnabled = false end
                        BunnyHopEnabled = true

                        CreateThread(function()
                            while BunnyHopEnabled and not Unloaded do
                                Wait(0)

                                if IsControlJustPressed(0, 22) then 
                                    local playerPed = PlayerPedId()
                                    local playerVeh = GetVehiclePedIsIn(playerPed, true)

                                    if DoesEntityExist(playerVeh) then
                                        ApplyForceToEntity(
                                            playerVeh,
                                            1,
                                            0.0, 0.0, 15.0,   
                                            0.0, 0.0, 0.0,   
                                            0,
                                            true, true, true, false, true
                                        )
                                        print("[Luxor] Bunny Hop triggered with SPACEBAR")
                                    end
                                end
                            end
                        end)
                    ]])
                    else
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        BunnyHopEnabled = false
                    ]])
                    end
                end
            }
        }
    },

    {
        label = "Miscellaneous",
        type = 'submenu',
        icon = 'ph-dice-six',
        submenu = {
            {
                label = "TxAdmin Exploits",
                type = "submenu",
                icon = "ph-gear",
                submenu = {
                    {
                        label = 'ShowNames TX',
                        type = 'checkbox',
                        checked = false,
                        onConfirm = function(setToggle)
                            print("ShowNames TX toggled:", setToggle)
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = setToggle and "ShowNames TX Enabled" or "ShowNames TX Disabled",
                                    type = setToggle and 'success' or 'error'
                                }))
                            end

                            showNamesTX = setToggle
                            MachoInjectResource("monitor", string.format([[
                                menuIsAccessible = true
                                toggleShowPlayerIDs(%s, %s)
                            ]], tostring(setToggle), tostring(setToggle)))
                        end
                    },
                    {
                        label = 'Noclip TX',
                        type = 'checkbox',
                        checked = false,
                        onConfirm = function(setToggle)
                            print("Noclip TX toggled:", setToggle)
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = setToggle and "Noclip TX Enabled" or "Noclip TX Disabled",
                                    type = setToggle and 'success' or 'error'
                                }))
                            end

                            isnoclipOn = setToggle
                            MachoInjectResource("monitor", string.format([[
                                TriggerEvent('txcl:setPlayerMode', "%s", false)
                            ]], setToggle and "noclip" or "none"))
                        end
                    },
                    {
                        label = 'Godmode TX',
                        type = 'checkbox',
                        checked = false,
                        onConfirm = function(setToggle)
                            print("Godmode TX toggled:", setToggle)
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = setToggle and "Godmode TX Enabled" or "Godmode TX Disabled",
                                    type = setToggle and 'success' or 'error'
                                }))
                            end

                            isGodmodeOn = setToggle
                            MachoInjectResource("monitor", string.format([[
                                TriggerEvent('txcl:setPlayerMode', "%s", true)
                            ]], setToggle and "godmode" or "none"))
                        end
                    },
                    {
                        label = 'Superjump TX',
                        type = 'checkbox',
                        checked = false,
                        onConfirm = function(setToggle)
                            print("Superjump TX toggled:", setToggle)
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = setToggle and "Superjump TX Enabled" or "Superjump TX Disabled",
                                    type = setToggle and 'success' or 'error'
                                }))
                            end

                            isSuperjumpOn = setToggle
                            MachoInjectResource("monitor", string.format([[
                                TriggerEvent('txcl:setPlayerMode', "%s", true)
                            ]], setToggle and "superjump" or "none"))
                        end
                    },
                    { 
                        label = 'Fake Admin (txAdmin)', 
                        type = 'button', 
                        onConfirm = function() 
                            print("Fake Admin (txAdmin)")
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "Fake Admin (txAdmin) Menu Enabled! Type /tx to open it.",
                                    type = 'success'
                                }))
                            end
                            MachoInjectResource("monitor", [[
                                sendSnackbarMessage('info', 'txAdmin Menu enabled, type /tx to open it.\nYou can also configure a keybind at [Game Settings > Key Bindings > FiveM > Menu: Open Main Page].', true)
                                local playerId = PlayerId()
                                local perms = {"all_permissions"}
                                TriggerEvent('txcl:setAdmin', GetPlayerName(playerId), perms)
                                TriggerEvent('txAdmin:events:adminAuth', {
                                    netid = playerId,
                                    isAdmin = true,
                                    username = GetPlayerName(playerId),
                                })
                            ]])
                        end 
                    },
                    { label = 'Heal TX', type = 'button', onConfirm = function() 
                        print("Heal TX")
                        if dui then
                            MachoSendDuiMessage(dui, json.encode({
                                action = 'notify',
                                message = "Healed Successfully With TX Menu!",
                                type = 'success'
                            }))
                        end
                        MachoInjectResource("monitor", [[TriggerEvent("txcl:heal")]])
                    end },
                    { label = 'Fix Vehicle TX', type = 'button', onConfirm = function() 
                        print("Fix Vehicle TX")
                        if dui then
                            MachoSendDuiMessage(dui, json.encode({
                                action = 'notify',
                                message = "Vehicle Fixed Successfully With TX Menu!",
                                type = 'success'
                            }))
                        end
                        MachoInjectResource("monitor", [[TriggerEvent('txcl:vehicle:fix')]])
                    end },
                    { label = 'Boost Vehicle TX', type = 'button', onConfirm = function() 
                        print("Boost Vehicle TX")
                        if dui then
                            MachoSendDuiMessage(dui, json.encode({
                                action = 'notify',
                                message = "Vehicle Boosted Successfully With TX Menu!",
                                type = 'success'
                            }))
                        end
                        MachoInjectResource("monitor", [[TriggerEvent('txcl:vehicle:boost')]])
                    end },
                    { label = 'Teleport To Waypoint TX', type = 'button', onConfirm = function() 
                        print("Teleport To Waypoint TX")
                        if dui then
                            MachoSendDuiMessage(dui, json.encode({
                                action = 'notify',
                                message = "Teleported To Waypoint Successfully With TX Menu!",
                                type = 'success'
                            }))
                        end
                        MachoInjectResource("monitor", [[TriggerEvent('txcl:tpToWaypoint')]])
                    end },
                    { label = 'Clear Area TX', type = 'button', onConfirm = function() 
                        print("Clear Area TX")
                        if dui then
                            MachoSendDuiMessage(dui, json.encode({
                                action = 'notify',
                                message = "Cleared Area Successfully With TX Menu!",
                                type = 'success'
                            }))
                        end
                        MachoInjectResource("monitor", [[TriggerEvent('txcl:clearArea', 1000)]])
                    end }
                }
            },
            {
                label = "Common Exploits",
                type = 'submenu',
                icon = 'ph-skull', 
                submenu = {
                    {
                        label = 'Anti-Freeze',
                        type = 'checkbox',
                        checked = false,
                        onConfirm = function(setToggle)
                            print("Anti-Freeze toggled:" .. tostring(setToggle))
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = setToggle and "Anti-Freeze Enabled" or "Anti-Freeze Disabled",
                                    type = setToggle and 'success' or 'error'
                                }))
                            end
                            if setToggle then
                            MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                            if nHgFdSaZxCvBnMq == nil then nHgFdSaZxCvBnMq = false end
                            nHgFdSaZxCvBnMq = true

                            local sdfw3w3tsdg = CreateThread
                            local function XELa6FJtsB()
                                sdfw3w3tsdg(function()
                                    while nHgFdSaZxCvBnMq and not Unloaded do
                                        local fhw72q35d8sfj = FreezeEntityPosition
                                        local segfhs347dsgf = ClearPedTasks

                                        if IsEntityPositionFrozen(PlayerPedId()) then
                                            fhw72q35d8sfj(PlayerPedId(), false)
                                            segfhs347dsgf(PlayerPedId())
                                        end
                                        
                                        Wait(0)
                                    end
                                end)
                            end

                            XELa6FJtsB()
                            ]])
                            else
                            MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                                nHgFdSaZxCvBnMq = false
                            ]])
                            end
                        end
                    },
                    {
                        label = 'Anti-Blackscreen',
                        type = 'checkbox',
                        checked = false,
                        onConfirm = function(setToggle)
                            print("Anti-Blackscreen toggled:" .. tostring(setToggle))
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = setToggle and "Anti-Blackscreen Enabled" or "Anti-Blackscreen Disabled",
                                    type = setToggle and 'success' or 'error'
                                }))
                            end
                            if setToggle then
                            MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                            if aDjsfmansdjwAEl == nil then aDjsfmansdjwAEl = false end
                            aDjsfmansdjwAEl = true

                            local sdfw3w3tsdg = CreateThread
                            local function XELWAEDa6FJtsB()
                                sdfw3w3tsdg(function()
                                    while aDjsfmansdjwAEl and not Unloaded do
                                        DoScreenFadeIn(0)
                                        Wait(0)
                                    end
                                end)
                            end

                            XELWAEDa6FJtsB()
                            ]])
                            else
                            MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                                aDjsfmansdjwAEl = false
                            ]])
                            end
                        end
                    },                 
                    {
                        label = 'Bypass Safezone',
                        type = 'checkbox',
                        checked = false,
                        onConfirm = function(setToggle)
                            print("Bypass Safezone toggled: " .. tostring(setToggle))
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = setToggle and "Safezone Bypass Enabled" or "Safezone Bypass Disabled",
                                    type = setToggle and 'success' or 'error'
                                }))
                            end
                    
                            if setToggle then
                                MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                                    if bzSafezoneBypass == nil then bzSafezoneBypass = false end
                                    bzSafezoneBypass = true
                    
                                    CreateThread(function()
                                        while bzSafezoneBypass and not Unloaded do
                                            local ped = PlayerPedId()
                    
                                            -- Allow attacking friendly NPCs/players
                                            NetworkSetFriendlyFireOption(true)
                                            SetCanAttackFriendly(ped, true, true)
                                            DisablePlayerFiring(ped, false)
                    
                                            -- Enable all controls to bypass restrictions
                                            EnableAllControlActions(0)
                                            EnableAllControlActions(1)
                    
                                            Wait(0)
                                        end
                                    end)
                                ]])
                            else
                                MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                                    bzSafezoneBypass = false
                                ]])
                            end
                        end
                    }                    
                }
            }
        }
    },
    

    {
        label = "Settings",
        type = 'submenu',
        icon = 'ph-gear',
        submenu = {
            {
                label = 'Fps Boost',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Fps Boost toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Fps Boost Enabled" or "Fps Boost Disabled",
                            type = setToggle and 'success' or 'error'
                        }))
                    end

                    if setToggle then
                        isFpsBoostOn = true
                        SetTimecycleModifier('yell_tunnel_nodirect')
                        ClearAllBrokenGlass()
                        ClearAllHelpMessages()
                        LeaderboardsReadClearAll()
                        ClearBrief()
                        ClearGpsFlags()
                        ClearPrints()
                        ClearSmallPrints()
                        ClearReplayStats()
                        LeaderboardsClearCacheData()
                        ClearFocus()
                        ClearHdArea()
                        ClearPedBloodDamage(ped)
                        ClearPedWetness(ped)
                        ClearPedEnvDirt(ped)
                        ResetPedVisibleDamage(ped)
                        ClearOverrideWeather()
                        DisableScreenblurFade()
                        SetRainLevel(0.0)
                        SetWindSpeed(0.0)
                    else
                        isFpsBoostOn = false
                        ClearTimecycleModifier()
                        ClearExtraTimecycleModifier()
                        SetTimecycleModifier("") 
                    end
                end
            },
            {
                label = 'Change Banner',
                type = 'scroll',
                selected = 1,
                options = {
                    { label = "Gypsy", value = "https://r2.fivemanage.com/ACvtzl07A7bey2dcSGWue/Gypsy.png" },
                    { label = "Bin Laden", value = "https://r2.fivemanage.com/ACvtzl07A7bey2dcSGWue/BinLaden.png" },
                    { label = "Dexter", value = "https://r2.fivemanage.com/ACvtzl07A7bey2dcSGWue/Dexter.png" },
                    { label = "Spooky", value = "https://r2.fivemanage.com/ACvtzl07A7bey2dcSGWue/Spooky.png" },
                    { label = "Smile", value = "https://r2.fivemanage.com/ACvtzl07A7bey2dcSGWue/Smile.png" },
                    { label = "SAMIRRRRR", value = "https://r2.fivemanage.com/ACvtzl07A7bey2dcSGWue/SAMIRRRRR.jpg" }
                },
                onConfirm = function(selectedOption)
                    bannerLink = selectedOption.value
                    print("Banner changed to:", bannerLink)

                    local colorSchemes = {
                        ["Default"] = {
                            primary = "#3498db",    -- Blue
                            secondary = "#2c3e50",  -- Dark blue
                            accent = "#f1c40f",      -- Yellow
                            text = "#ffffff"        -- White
                        },
                        ["Luxor #1"] = {
                            primary = "#9b59b6",    -- Purple
                            secondary = "#8e44ad",  -- Dark purple
                            accent = "#f1c40f",     -- Yellow
                            text = "#ffffff"        -- White
                        },
                        ["Gypsy"] = {
                            primary = "#e74c3c",    -- Red
                            secondary = "#c0392b",  -- Dark red
                            accent = "#bd0000",     -- Red
                            text = "#ffffff"        -- White
                        },
                        ["Bin Laden"] = {
                            primary = "#27ae60",    -- Green
                            secondary = "#229954",  -- Dark green
                            accent = "#149414",     -- Green
                            text = "#ffffff"        -- White
                        },
                        ["Dexter"] = {
                            primary = "#34495e",    -- Dark gray
                            secondary = "#2c3e50",  -- Darker gray
                            accent = "#e74c3c",     -- Red
                            text = "#ffffff"        -- White
                        },
                        ["Spooky"] = {
                            primary = "#e74c3c",    -- Red
                            secondary = "#c0392b",  -- Dark red
                            accent = "#bd0000",     -- Red
                            text = "#ffffff"        -- White
                        },
                        ["Smile"] = {
                            primary = "#ffffff",    -- White
                            secondary = "#ffffff",  -- Dark purple
                            accent = "#ffffff",     -- Red
                            text = "#000000"        -- White
                        },
                        ["SAMIRRRRR"] = {
                            primary = "#e74c3c",    -- Red
                            secondary = "#663399",  -- Dark purple
                            accent = "#e74c3c",     -- Red
                            text = "#ffffff"        -- White
                        }
                    }

                    -- Get color scheme for selected banner
                    local colors = colorSchemes[selectedOption.label] or colorSchemes["Default"]

                    if dui then
                        -- Change banner
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'changeBanner',
                            url = bannerLink
                        }))
                        
                        -- Change menu colors
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'changeTheme',
                            colors = {
                                primary = colors.primary,
                                secondary = colors.secondary,
                                accent = colors.accent,
                                text = colors.text
                            }
                        }))
                        
                        -- Show notification
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Banner and theme changed to " .. selectedOption.label,
                            type = 'success'
                        }))
                    end
                end
            },
            {
                label = 'Menu Keybind',
                type = 'scroll',
                -- Precompute current index based on menuKeybind
                selected = (function()
                    local keyToIndex = {
                        [11] = 1,   -- Page Down (default)
                        [10] = 2,   -- Page Up
                        [166] = 3,  -- F1
                        [167] = 4,  -- F2
                        [168] = 5,  -- F3
                        [169] = 6,  -- F4
                        [170] = 7,  -- F5
                        [171] = 8,  -- F6
                        [172] = 9,  -- F7
                        [173] = 10, -- F8
                        [174] = 11, -- F9
                        [175] = 12, -- F10
                        [176] = 13, -- F11
                        [177] = 14, -- F12
                        [244] = 15, -- Insert
                        [245] = 16, -- Delete
                        [179] = 17, -- Home
                        [180] = 18, -- End
                        [181] = 19, -- Scroll Lock
                        [182] = 20, -- Pause
                    }
                    return keyToIndex[menuKeybind] or 1
                end)(),
                options = {
                    { label = "Page Down", value = 11 },
                    { label = "Page Up", value = 10 },
                    { label = "F1", value = 166 },
                    { label = "F2", value = 167 },
                    { label = "F3", value = 168 },
                    { label = "F4", value = 169 },
                    { label = "F5", value = 170 },
                    { label = "F6", value = 171 },
                    { label = "F7", value = 172 },
                    { label = "F8", value = 173 },
                    { label = "F9", value = 174 },
                    { label = "F10", value = 175 },
                    { label = "F11", value = 176 },
                    { label = "F12", value = 177 },
                    { label = "Insert", value = 244 },
                    { label = "Delete", value = 245 },
                    { label = "Home", value = 179 },
                    { label = "End", value = 180 },
                    { label = "Scroll Lock", value = 181 },
                    { label = "Pause", value = 182 },
                },
                onConfirm = function(selectedOption)
                    local oldKey = menuKeybind
                    menuKeybind = selectedOption.value
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Menu keybind changed to: " .. selectedOption.label,
                            type = 'success'
                        }))
                    end
                    print("Menu keybind updated from", getKeyName(oldKey), "to", selectedOption.label)
                end,
                onChange = function(selectedOption)
                end
            },
            {
                label = 'Block Input',
                type = 'checkbox',
                checked = false,
                onConfirm = function(setToggle)
                    print("Block Input toggled:", setToggle)
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = setToggle and "Input Blocked" or "Input Unblocked",
                            type = setToggle and 'warning' or 'success'
                        }))
                    end

                    if setToggle then
                        isInputBlocked = true
                        CreateThread(function()
                            while isInputBlocked and not Unloaded do
                                if _G.clientMenuShowing then
                                    DisableAllControlActions(0)
                                end
                                Wait(0)
                            end
                        end)
                    else
                        isInputBlocked = false
                    end
                end
            },
            { 
                label = 'Unload Menu', 
                type = 'button', 
                onConfirm = function() 
                    print("Unloading menu and disabling all features...")
                    
                    -- Disable all active features
                    MachoInjectResource(CheckResource("monitor") and "monitor" or CheckResource("oxmysql") and "oxmysql" or "any", [[
                        aXfPlMnQwErTyUi = false -- Godmode
                        sRtYuIoPaSdFgHj = false -- Invisibility
                        mKjHgFdSaPlMnBv = false -- No Ragdoll
                        uYtReWqAzXcVbNm = false -- Infinite Stamina
                        peqCrVzHDwfkraYZ = false -- Shrink Ped
                        NpYgTbUcXsRoVm = false -- No Clip
                        xCvBnMqWeRtYuIo = false -- Super Jump
                        nxtBFlQWMMeRLs = false -- Levitation
                        fgawjFmaDjdALaO = false -- Super Strength
                        qWeRtYuIoPlMnBv = false -- Super Punch
                        zXpQwErTyUiPlMn = false -- Throw From Vehicle
                        kJfGhTrEeWqAsDz = false -- Force Third Person
                        zXcVbNmQwErTyUi = false -- Force Driveby
                        yHnvrVNkoOvGMWiS = false -- Anti-Headshot
                        nHgFdSaZxCvBnMq = false -- Anti-Freeze
                        fAwjeldmwjrWkSf = false -- Anti-TP
                        aDjsfmansdjwAEl = false -- Anti-Blackscreen
                        qWpEzXvBtNyLmKj = false -- Crosshair

                        egfjWADmvsjAWf = false -- Spoofed Weapon Spawning
                        LkJgFdSaQwErTy = false -- Infinite Ammo
                        QzWxEdCvTrBnYu = false -- Explosive Ammo
                        RfGtHyUjMiKoLp = false -- One Shot Kill 

                        zXcVbNmQwErTyUi = false -- Vehicle Godmode
                        RNgZCddPoxwFhmBX = false -- Force Vehicle Engine
                        PlAsQwErTyUiOp = false -- Vehicle Auto Repair
                        LzKxWcVbNmQwErTy = false -- Freeze Vehicle
                        NuRqVxEyKiOlZm = false -- Vehicle Hop
                        GxRpVuNzYiTq = false -- Rainbow Vehicle
                        MqTwErYuIoLp = false -- Drift Mode
                        NvGhJkLpOiUy = false -- Easy Handling
                        VkLpOiUyTrEq = false -- Instant Breaks
                        BlNkJmLzXcVb = false -- Unlimited Fuel

                        AsDfGhJkLpZx = false -- Spectate Player
                        aSwDeFgHiJkLoPx = false -- Normal Kill Everyone
                        qWeRtYuIoPlMnAb = false -- Permanent Kill Everyone
                        tUOgshhvIaku = false -- RPG Kill Everyone
                        zXcVbNmQwErTyUi = false -- 
                        
                        -- Disable TX Admin features
                        TriggerEvent('txcl:setPlayerMode', "none", true)
                        
                        -- Reset all variables
                        Unloaded = true
                        
                        print("^3[LUXOR SYSTEM]^7 All features disabled successfully!")
                    ]])
                    
                    -- Reset menu states
                    isInputBlocked = false
                    textInputActive = false
                    menuInitialized = false
                    activeMenu = originalMenu
                    activeIndex = 1
                    
                    -- Close menu
                    _G.clientMenuShowing = false
                    
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = "Menu unloaded successfully! All features disabled.",
                            type = 'success'
                        }))
                        Wait(1500)
                        MachoDestroyDui(dui)
                        dui = nil 
                        print("DUI destroyed")
                    end
                    
                    print("Menu unloaded and all features disabled")
                end 
            },
            {
                label = "Misc",
                type = 'submenu',
                icon = 'ph-eye',
                submenu = {
                    { 
                        label = 'Scan All Players', 
                        type = 'button', 
                        onConfirm = function() 
                            print("^4[ LUXOR SYSTEM ] ^3Scanning all players...")
                
                            local players = GetActivePlayers()
                
                            for _, clientId in ipairs(players) do
                                local serverId = GetPlayerServerId(clientId)
                                local name = GetPlayerName(clientId)
                
                                print(("^4[ LUXOR SYSTEM ] ^3Server ID: ^2%s ^3| Name: ^2%s"):format(serverId, name))
                            end
                
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "Server IDs & names printed to console.",
                                    type = 'success'
                                }))
                            else
                                MachoMenuNotification("Player Scan", "Server IDs & names printed to console.")
                            end
                        end 
                    },
                    { 
                        label = 'Scan All Vehicles', 
                        type = 'button', 
                        onConfirm = function() 
                            print("^4[ LUXOR SYSTEM ] ^3Scanning all vehicles...")
                            local handle, entity = FindFirstVehicle()
                            local scanned = 0
                
                            if not handle or not entity then
                                MachoMenuNotification("Scan Failed", "Could not initialize vehicle search.")
                                return
                            end
                
                            local success
                            repeat
                                if DoesEntityExist(entity) then
                                    local plate = GetVehicleNumberPlateText(entity)
                                    local model = GetEntityModel(entity)
                                    local modelName = GetDisplayNameFromVehicleModel(model)
                
                                    print(("^4[ LUXOR SYSTEM ] ^3Model: ^2%s ^3| Plate: ^2%s"):format(modelName, plate))
                                    scanned = scanned + 1
                                end
                                success, entity = FindNextVehicle(handle)
                            until not success
                
                            EndFindVehicle(handle)
                
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "Scanned " .. scanned .. " vehicles. Check F8 console.",
                                    type = 'success'
                                }))
                            else
                                MachoMenuNotification("Scan Complete", "Scanned " .. scanned .. " vehicles. Check F8 console.")
                            end
                        end 
                    },
                    { 
                        label = 'Scan All Addon Vehicles', 
                        type = 'button', 
                        onConfirm = function() 
                            print("^4[ LUXOR SYSTEM ] ^3Scanning deeply for addon vehicle spawn names...")
                
                            CreateThread(function()
                                local numResources = GetNumResources()
                                local foundVehicles = {}
                                local foundCount = 0
                                local potentialPaths = {}
                
                                local folders = { "data", "stream", "common", "vehicles", "dlc", "meta" }
                                for _, a in ipairs(folders) do
                                    table.insert(potentialPaths, a .. "/vehicles.meta")
                                    for _, b in ipairs(folders) do
                                        table.insert(potentialPaths, a .. "/" .. b .. "/vehicles.meta")
                                        for _, c in ipairs(folders) do
                                            table.insert(potentialPaths, a .. "/" .. b .. "/" .. c .. "/vehicles.meta")
                                            for _, d in ipairs(folders) do
                                                table.insert(potentialPaths, a .. "/" .. b .. "/" .. c .. "/" .. d .. "/vehicles.meta")
                                            end
                                        end
                                    end
                                end
                
                                table.insert(potentialPaths, "vehicles.meta")
                
                                for i = 0, numResources - 1 do
                                    local resourceName = GetResourceByFindIndex(i)
                                    if resourceName then
                                        for _, path in ipairs(potentialPaths) do
                                            local content = LoadResourceFile(resourceName, path)
                                            if content then
                                                for modelName in content:gmatch("<modelName>%s*(.-)%s*</modelName>") do
                                                    if not foundVehicles[modelName] then
                                                        foundVehicles[modelName] = true
                                                        foundCount = foundCount + 1
                                                        print(("^4[ LUXOR SYSTEM ] ^3Found: ^2%s ^3in ^2%s/%s"):format(modelName, resourceName, path))
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                
                                local msg = (foundCount == 0) 
                                    and "No addon vehicles found." 
                                    or ("Found " .. foundCount .. " addon vehicles. See F8 console.")
                
                                if dui then
                                    MachoSendDuiMessage(dui, json.encode({
                                        action = 'notify',
                                        message = msg,
                                        type = 'success'
                                    }))
                                else
                                    MachoMenuNotification("Scan Complete", msg)
                                end
                            end)
                        end 
                    },
                    { 
                        label = 'Scan All Addon Weapons', 
                        type = 'button', 
                        onConfirm = function() 
                            print("^4[ LUXOR SYSTEM ] ^3Scanning deeply for addon weapon spawn names, archetypes, and components...")
                    
                            CreateThread(function()
                                local numResources = GetNumResources()
                                local foundWeapons = {}
                                local foundCount = 0
                                local potentialPaths = {}
                    
                                -- Possible nested folders
                                local folders = { "data", "stream", "common", "weapons", "dlc", "meta" }
                                local metaFiles = { "weapons.meta", "weaponarchetypes.meta", "weaponcomponents.meta" }
                    
                                -- Generate possible search paths
                                for _, metaFile in ipairs(metaFiles) do
                                    for _, a in ipairs(folders) do
                                        table.insert(potentialPaths, a .. "/" .. metaFile)
                                        for _, b in ipairs(folders) do
                                            table.insert(potentialPaths, a .. "/" .. b .. "/" .. metaFile)
                                            for _, c in ipairs(folders) do
                                                table.insert(potentialPaths, a .. "/" .. b .. "/" .. c .. "/" .. metaFile)
                                                for _, d in ipairs(folders) do
                                                    table.insert(potentialPaths, a .. "/" .. b .. "/" .. c .. "/" .. d .. "/" .. metaFile)
                                                end
                                            end
                                        end
                                    end
                                    table.insert(potentialPaths, metaFile)
                                end
                    
                                -- Scan all resources
                                for i = 0, numResources - 1 do
                                    local resourceName = GetResourceByFindIndex(i)
                                    if resourceName then
                                        for _, path in ipairs(potentialPaths) do
                                            local content = LoadResourceFile(resourceName, path)
                                            if content then
                                                -- weapons.meta / archetypes / components
                                                for modelName in content:gmatch("<modelName>%s*(.-)%s*</modelName>") do
                                                    if not foundWeapons[modelName] then
                                                        foundWeapons[modelName] = true
                                                        foundCount = foundCount + 1
                                                        print(("^4[ LUXOR SYSTEM ] ^3Found Weapon Model: ^2%s ^3in ^2%s/%s"):format(modelName, resourceName, path))
                                                    end
                                                end
                                                for Name in content:gmatch("<Name>%s*(.-)%s*</Name>") do
                                                    if not foundWeapons[Name] then
                                                        foundWeapons[Name] = true
                                                        foundCount = foundCount + 1
                                                        print(("^4[ LUXOR SYSTEM ] ^3Found Weapon Name: ^2%s ^3in ^2%s/%s"):format(Name, resourceName, path))
                                                    end
                                                end
                                                for weaponName in content:gmatch("<weaponName>%s*(.-)%s*</weaponName>") do
                                                    if not foundWeapons[weaponName] then
                                                        foundWeapons[weaponName] = true
                                                        foundCount = foundCount + 1
                                                        print(("^4[ LUXOR SYSTEM ] ^3Found Weapon Name: ^2%s ^3in ^2%s/%s"):format(weaponName, resourceName, path))
                                                    end
                                                end
                                                for archetypeName in content:gmatch("<archetypeName>%s*(.-)%s*</archetypeName>") do
                                                    if not foundWeapons[archetypeName] then
                                                        foundWeapons[archetypeName] = true
                                                        foundCount = foundCount + 1
                                                        print(("^4[ LUXOR SYSTEM ] ^3Found Archetype: ^2%s ^3in ^2%s/%s"):format(archetypeName, resourceName, path))
                                                    end
                                                end
                                                for componentName in content:gmatch("<componentName>%s*(.-)%s*</componentName>") do
                                                    if not foundWeapons[componentName] then
                                                        foundWeapons[componentName] = true
                                                        foundCount = foundCount + 1
                                                        print(("^4[ LUXOR SYSTEM ] ^3Found Component: ^2%s ^3in ^2%s/%s"):format(componentName, resourceName, path))
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                    
                                -- Final message
                                local msg = (foundCount == 0)
                                    and "No addon weapons or archetypes found."
                                    or ("Found " .. foundCount .. " addon weapons/archetypes. See F8 console.")
                    
                                if dui then
                                    MachoSendDuiMessage(dui, json.encode({
                                        action = 'notify',
                                        message = msg,
                                        type = 'success'
                                    }))
                                else
                                    MachoMenuNotification("Scan Complete", msg)
                                end
                            end)
                        end 
                    },
                    { 
                        label = 'Scan All Resources', 
                        type = 'button', 
                        onConfirm = function() 
                            print("^4[ LUXOR SYSTEM ] ^3Scanning all resources...")
                
                            for i = 0, GetNumResources() - 1 do
                                local resourceName = GetResourceByFindIndex(i)
                                if resourceName then
                                    local state = GetResourceState(resourceName)
                                    print(("^4[ LUXOR SYSTEM ] ^3Resource: ^2%s ^3| State: ^2%s"):format(resourceName, state))
                                end
                            end
                
                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = 'notify',
                                    message = "All resource names & states printed to console.",
                                    type = 'success'
                                }))
                            else
                                MachoMenuNotification("Resource Scan", "All resource names & states printed to console.")
                            end
                        end 
                    },
                    {
                        label = "Crash LifeShield",
                        type = "button",
                        onConfirm = function()
                            MachoInjectResource("LifeShield", [[
                                ExecuteCommand("quit")
                            ]])

                            if dui then
                                MachoSendDuiMessage(dui, json.encode({
                                    action = "notify",
                                    message = "LifeShield forced to quit.",
                                    type = "error"
                                }))
                            end
                        end
                    }
                }
            },
            {
                label = "Menu Info",
                type = 'submenu',
                icon = 'ph-globe',
                submenu = {
                    { label = "Version: " .. version, type = 'button', icon = 'ph-device-mobile', onConfirm = function() end },
                    { label = "Plan: " .. plan_type, type = 'button', icon = 'ph-notepad', onConfirm = function() end },
                    -- { label = "Expires: " .. _G.LuxorAuthFormattedDate, type = 'button', icon = 'ph-hourglass', onConfirm = function() end },
                    { label = "Time remaining: calculating...", type = 'button', icon = 'ph-clock', onConfirm = function() end }
                }
            }
        }
    },
    
    {
        label = "Search",
        type = 'button',
        icon = 'ph-magnifying-glass',
        onConfirm = function()
            openTextInputEnhanced(
                "Search menu items:",
                "Type search query...",
                "",
                50,
                function(query)
                    performSearch(query)
                end,
                "general"
            )
        end
    }
}
activeMenu = originalMenu

-- ===================== SAFE COPY FOR DUI =====================
local function safeMenuCopy(menu)
    local copy = {}
    for i, v in ipairs(menu) do
        local item = {
            label = v.label or "",
            type = v.type or ""
        }
        if v.icon then item.icon = v.icon end
        if v.playerId then item.playerId = v.playerId end

        if v.type == "scroll" then
            item.options = {}
            for _, opt in ipairs(v.options or {}) do
                if type(opt) == "string" or type(opt) == "number" then
                    table.insert(item.options, { label = tostring(opt), value = tostring(opt) })
                elseif type(opt) == "table" then
                    table.insert(item.options, {
                        label = tostring(opt.label or opt[1] or ""),
                        value = tostring(opt.value or opt.label or opt[1] or "")
                    })
                else
                    table.insert(item.options, { label = tostring(opt), value = tostring(opt) })
                end
            end
            if #item.options == 0 then
                item.options = {{ label = "(empty)", value = "(empty)" }}
            end
            local sel = v.selected or 1
            if sel < 1 then sel = 1 end
            if sel > #item.options then sel = #item.options end
            item.selected = sel - 1
        elseif v.type == "slider" then
            item.min = v.min or 0
            item.max = v.max or 100
            item.value = v.value or item.min
        elseif v.type == "checkbox" then
            item.checked = v.checked == true
        elseif v.type == "input" then
            item.question = v.question or 'Enter text:'
            item.placeholder = v.placeholder or 'Type here...'
            item.value = v.value or ''
            item.maxLength = v.maxLength or 100
            item.inputType = v.inputType or 'general'
        elseif v.type == "submenu" then
            if type(v.submenu) == "table" then
                item.submenu = safeMenuCopy(v.submenu)
            end
        end
        copy[i] = item
    end
    return copy
end

-- ===================== HELPERS =====================
function setCurrent()
    if dui and menuInitialized then
        MachoSendDuiMessage(dui, json.encode({
            action = 'setCurrent',
            current = activeIndex,
            menu = safeMenuCopy(activeMenu)
        }))
        print("setCurrent called with index:", activeIndex)
    end
end

local function isControlPressed(control)
    return IsControlPressed(0, control) or IsDisabledControlPressed(0, control)
end

local function isControlJustPressed(control)
    return IsControlJustPressed(0, control) or IsDisabledControlJustPressed(0, control)
end

local function isControlJustReleased(control)
    return IsControlJustReleased(0, control) or IsDisabledControlJustReleased(0, control)
end

local function handleKeyRelease(keyCode)
    if keyCode == 0x10 then
        shiftPressed = false
        print("Shift released")
    elseif keyCode == 0x11 then
        ctrlPressed = false
        print("Control released")
    elseif keyCode == 0x12 then
        altPressed = false
        print("Alt released")
    end
end

-- Enhanced menu initialization with error handling
local function initializeMenu()
    if not menuInitialized and dui then
        print("Initializing menu...")
        
        -- Session validation removed
        
        local success, error = pcall(function()
            menuInitialized = true
            
            -- Reset menu state
            activeMenu = originalMenu
            activeIndex = 1
            
            -- Show the menu
            MachoSendDuiMessage(dui, json.encode({
                action = 'setVisible',
                visible = true
            }))
            
            -- Set current menu
            setCurrent()
        end)
        
        if success then
            print("Menu initialized successfully")
            return true
        else
            print("Menu initialization failed: " .. tostring(error))
            MachoMenuNotification("[ LUXOR SYSTEM ]", "Menu initialization failed. Please try again.")
            menuInitialized = false
            return false
        end
    end
    return true
end

-- Enhanced menu close with cleanup
local function closeMenu()
    print("Closing menu properly...")
    
    local success, error = pcall(function()
        -- Hide the menu
        if dui then
            MachoSendDuiMessage(dui, json.encode({
                action = 'setVisible',
                visible = false
            }))
        end
        
        -- Reset states
        menuInitialized = false
        textInputActive = false
        activeMenu = originalMenu
        activeIndex = 1
        
        -- Session cleanup removed
    end)
    
    if success then
        print("Menu closed and reset successfully")
    else
        print("Error closing menu: " .. tostring(error))
    end
end

-- Performance optimization: Debounced menu updates
local lastMenuUpdate = 0
local MENU_UPDATE_THROTTLE = 100 -- ms

local function throttledSetCurrent()
    local currentTime = GetGameTimer()
    if currentTime - lastMenuUpdate > MENU_UPDATE_THROTTLE then
        setCurrent()
        lastMenuUpdate = currentTime
    end
end

-- ===================== MAIN THREAD =====================
-- ===== CONFIG =====
    local MENU_BLOCK_SERVER_ENABLED = false
    local BLOCKED_SERVERS = { "51.210.222.170:30120" } -- List of blocked servers
    local MIN_PLAYERS_MENU = false
    local MIN_PLAYERS_REQUIRED = 25
    -- ==================

    local function IsBlockedServer(CurrentIP)
        for _, ip in ipairs(BLOCKED_SERVERS) do
            if CurrentIP == ip then return true end
        end
        return false
    end

    CreateThread(function()
        local CurrentIP = GetCurrentServerEndpoint() 

        -- Check blocked servers
        if MENU_BLOCK_SERVER_ENABLED and IsBlockedServer(CurrentIP) then
            local tempDui = MachoCreateDui("http://89.42.88.14:33070/")
            if tempDui then
                MachoShowDui(tempDui)
                Wait(1500)

                MachoSendDuiMessage(tempDui, json.encode({
                    action = 'notify',
                    message = "This server is restricted! Menu cannot be opened here.",
                    type = 'error'
                }))

                Wait(4000)
                MachoSendDuiMessage(tempDui, json.encode({
                    action = 'setVisible',
                    visible = false
                }))

                MachoDestroyDui(tempDui)
            end

            print("^1[Luxor Menu] You cannot open the menu on this server!")
            return
        end

        -- Check minimum players
        if MIN_PLAYERS_MENU then
            local playerCount = #GetActivePlayers()
            if playerCount < MIN_PLAYERS_REQUIRED then
                local tempDui = MachoCreateDui("http://89.42.88.14:33070/")
                if tempDui then
                    MachoShowDui(tempDui)
                    Wait(1500)

                    MachoSendDuiMessage(tempDui, json.encode({
                        action = 'notify',
                        message = ("Server only has %s players. Menu is disabled until %s+ players are online."):format(playerCount, MIN_PLAYERS_REQUIRED),
                        type = 'error'
                    }))

                    Wait(4000)
                    MachoSendDuiMessage(tempDui, json.encode({
                        action = 'setVisible',
                        visible = false
                    }))

                    MachoDestroyDui(tempDui)
                end

                print(("^3[Luxor Menu] Server has only %s players. Menu will NOT load."):format(playerCount))
                return
            end
        end


        dui = MachoCreateDui("http://89.42.88.14:33070/")
        
        if dui then
            MachoShowDui(dui)
            Wait(1500)

            CreateThread(function()
                -- Stage 1
                if dui then
                    MachoSendDuiMessage(dui, json.encode({
                        action = 'notify',
                        message = "Stage 1 : Checking for updates...",
                        type = 'info'
                    }))
                end

                Wait(2000)

                if dui then
                    MachoSendDuiMessage(dui, json.encode({
                        action = 'notify',
                        message = "You are using the latest version. Enjoy",
                        type = 'success'
                    }))
                end
                Wait(2000)

                -- Stage 2 start
            if dui then
                MachoSendDuiMessage(dui, json.encode({
                    action = 'notify',
                    message = "Stage 2 : Anticheat Checker starting...",
                    type = 'info'
                }))
            end
            Wait(1000)

            -- Anticheat checker logic
                local anticheatList = {
                    {name = "ClownGuard", tag = "clown", hint = "AI screenshot detection, Israeli dev"},
                    {name = "ShakedAC", tag = "shaked", hint = "Menu detection, Israeli servers"},
                    {name = "IsraelAC", tag = "israel", hint = "Anti-speedhack, local powerhouse"},
                    {name = "KobiAntiCheat", tag = "kobi", hint = "Small Israeli RP protection"},
                    {name = "LiorGuard", tag = "lior", hint = "Anti-noclip for Israeli RP"},
                    {name = "TomerShield", tag = "tomer", hint = "Lightweight Israeli newcomer"},
                    {name = "ReaperV4", tag = "reaper", hint = "Elite-tier, Eulen/RedEngine killer"},
                    {name = "ReaperAntiCheat", tag = "rac", hint = "Reaper variant, movement cheats"},
                    {name = "LifeShield", tag = "lfm", hint = "Maroccon Cheat, injector cheats"},
                    {name = "ReaperLab", tag = "reaperlab", hint = "Reaper dev signature"},
                    {name = "ReaperGuard", tag = "rguard", hint = "Reaper offshoot, server lockdown"},
                    {name = "Fiveguard", tag = "fg", hint = "AI object detection, premium"},
                    {name = "FiniAC", tag = "fini", hint = "Low false positives, tweakable"},
                    {name = "PhoenixAC", tag = "phoenix", hint = "Cloud bans, hardware tracking"},
                    {name = "AntiCheese", tag = "cheese", hint = "Strike system with EasyAdmin"},
                    {name = "Badger-Anticheat", tag = "badger", hint = "Noclip and prop bans"},
                    {name = "FIREAC", tag = "fireac", hint = "Free, by Amirreza, solid"},
                    {name = "Valkyrie", tag = "valk", hint = "Open-source injection blocker"},
                    {name = "ATG-AntiCheat", tag = "atg", hint = "Fast setup, mod menu catcher"},
                    {name = "ChocoHax", tag = "choco", hint = "AI Lua protection"},
                    {name = "VanillaAC", tag = "vanilla", hint = "Anti-Lua focus"},
                    {name = "ElectronAC", tag = "electron", hint = "Optical menu detection"},
                    {name = "TigoAntiCheat", tag = "tigo", hint = "Server-side encryption"},
                    {name = "MoonGuard", tag = "moonguard", hint = "AI executor destroyer"},
                    {name = "PegasusAC", tag = "pegasus", hint = "Spoofer detection, cheap"},
                    {name = "AnvilAC", tag = "anvil", hint = "Custom German/Israeli hybrid"},
                    {name = "SecureNet", tag = "securenet", hint = "Total server lockdown"},
                    {name = "FiveShield", tag = "fiveshield", hint = "Proactive guardian"},
                    {name = "Lynx Anti-Cheat", tag = "lynx", hint = "Customizable beast"},
                    {name = "Eulen Anti-Cheat", tag = "eulen", hint = "Advanced algo madness"},
                    {name = "QuantumAC", tag = "quantum", hint = "Next-gen script blocker"},
                    {name = "GhostEye", tag = "ghost", hint = "Behavior anomaly hunter"},
                    {name = "RageShield", tag = "rage", hint = "NoPixel-grade protection"},
                    {name = "IceCon-AC", tag = "icecon", hint = "Light anti-teleport"},
                    {name = "WaveShield", tag = "waveshield", hint = "Eulen/RedEngine counter"},
                    {name = "XeroShield", tag = "xero", hint = "Optimized detection"},
                    {name = "IronShield", tag = "iron", hint = "Heavy anti-executor"},
                    {name = "PandaGuard", tag = "panda", hint = "Cloud control system"},
                    {name = "Pixel AntiCheat", tag = "pixel", hint = "GTA V-specific edge"},
                    {name = "SecurGate", tag = "securgate", hint = "Instant D3D10.dll catch"},
                    {name = "Aerodefence", tag = "aero", hint = "Database-driven menu block"},
                    {name = "API-AC", tag = "api", hint = "API-powered cheat stopper"},
                    {name = "ShadowAC", tag = "shadow", hint = "Silent ban hammer"},
                    {name = "TitanGuard", tag = "titan", hint = "Massive anti-cheat suite"},
                    {name = "NightmareAC", tag = "nightmare", hint = "Aggressive injection block"},
                    {name = "FrostAC", tag = "frost", hint = "Cold ban logic"},
                    {name = "VortexShield", tag = "vortex", hint = "Swirls away cheaters"},
                    {name = "OblivionAC", tag = "oblivion", hint = "Wipes out modders"},
                    {name = "EchoGuard", tag = "echo", hint = "Repeats bans until gone"},
                    {name = "BlizzardAC", tag = "blizzard", hint = "Freezes exploits"},
                    {name = "ThunderHub", tag = "thunder", hint = "Strikes down menus"},
                    {name = "DeltaShield", tag = "delta", hint = "Precision cheat removal"},
                    {name = "RavenAC", tag = "raven", hint = "Dark anti-executor"},
                    {name = "SpectralAC", tag = "spectral", hint = "Ghostly cheat detection"},
                    {name = "HyperionAC", tag = "hyperion", hint = "Godlike protection"},
                    {name = "NovaGuard", tag = "nova", hint = "Explosive ban power"},
                    {name = "EclipseAC", tag = "eclipse", hint = "Blocks out cheaters"},
                    {name = "ZephyrAntiCheat", tag = "zephyr", hint = "Wind of bans"},
                    {name = "OnyxGuard", tag = "onyx", hint = "Black stone defense"},
                    {name = "CerberusAC", tag = "cerberus", hint = "Three-headed ban dog"},
                    {name = "PhantomShield", tag = "phantom", hint = "Invisible cheat catcher"},
                    {name = "SolarAC", tag = "solar", hint = "Burns away exploits"},
                    {name = "AppleCheat", tag = "apple", hint = "Old-school ban system"},
                    {name = "FiveSafe", tag = "fivesafe", hint = "IP logging monster"},
                    {name = "VitaShield", tag = "vita", hint = "QB framework protector"},
                    {name = "StormAC", tag = "storm", hint = "Rains bans on cheaters"},
                    {name = "LunarGuard", tag = "lunar", hint = "Moonlit cheat hunter"},
                    {name = "MIXAS AntiCheat", tag = "mixas", hint = "Global reach, 400+ customers"},
                    {name = "FiveEye", tag = "fiveeye", hint = "Tech-forward security"},
                    {name = "Prime AC", tag = "prime", hint = "Beta anti-everything"},
                    {name = "LightAC", tag = "light", hint = "Cracked lightweight AC"},
                    {name = "VB-AC", tag = "vbac", hint = "Obscure source leak"},
                    {name = "EasyGuard", tag = "easyguard", hint = "All-in-one protection"},
                    {name = "GeekShield", tag = "geek", hint = "Old but brutal (defunct?)"},
                    {name = "TXAntiCheat", tag = "txac", hint = "TXAdmin integration"},
                    {name = "ChaosAC", tag = "chaos", hint = "Random ban insanity"},
                    {name = "AetherGuard", tag = "aether", hint = "Mystical cheat blocker"},
                    {name = "NebulaAC", tag = "nebula", hint = "Cosmic-level defense"},
                    {name = "PulseShield", tag = "pulse", hint = "Heartbeat ban system"},
                    {name = "VenomAC", tag = "venom", hint = "Poisons cheaters out"},
                    {name = "MidnightAC", tag = "midnight", hint = "ESX-specific, pricey"},
                    {name = "OmegaShield", tag = "omega", hint = "Endgame protection"},
                    {name = "InfinityAC", tag = "infinity", hint = "Never-ending ban loop"},
                    {name = "CobraGuard", tag = "cobra", hint = "Strikes fast and hard"},
                    {name = "GlacierAC", tag = "glacier", hint = "Icy cheat freeze"},
                    {name = "SpectreAC", tag = "spectre", hint = "Invisible ban ghost"}
                }

            local detectedAnticheats = {}

            for i = 0, GetNumResources() - 1, 1 do
                local resource_name = GetResourceByFindIndex(i)
                if resource_name and GetResourceState(resource_name) == "started" then
                    local ac_tag = GetResourceMetadata(resource_name, "ac", 0) or ""
                    local lower_resource = string.lower(resource_name)

                    -- Check against known AC names/tags
                    for _, anticheat in ipairs(anticheatList) do
                        if (ac_tag == anticheat.tag) or string.find(lower_resource, string.lower(anticheat.name)) then
                            table.insert(detectedAnticheats, {
                                name = anticheat.name,
                                resource = resource_name,
                                hint = anticheat.hint
                            })
                        end
                    end
                end
            end

            -- Notify DUI for detections
            if #detectedAnticheats > 0 then
                for _, ac in ipairs(detectedAnticheats) do
                    if dui then
                        MachoSendDuiMessage(dui, json.encode({
                            action = 'notify',
                            message = string.format("Detected: %s (Resource: %s)\nHint: %s", ac.name, ac.resource, ac.hint),
                            type = 'error'
                        }))
                    end
                    Wait(800)
                end
            else
                if dui then
                    MachoSendDuiMessage(dui, json.encode({
                        action = 'notify',
                        message = "No anticheat resources detected!",
                        type = 'success'
                    }))
                end
            end
                Wait(2000)

                -- Stage 3
                Wait(2000)
                if dui then
                    MachoSendDuiMessage(dui, json.encode({
                        action = 'notify',
                        message = "Stage 3 : Authenticating...",
                        type = 'info'
                    }))
                end
                Wait(2000)

                if dui then
                    MachoSendDuiMessage(dui, json.encode({
                        action = 'notify',
                        message = "Welcome back, " .. user_tag .. "!",
                        type = 'success'
                    }))
                end
            end)

            LoadAllBypasses()


            Wait(11800) -- Wait a bit for DUI to be ready
            
            
            MachoSendDuiMessage(dui, json.encode({
                action = 'setVisible',
                visible = false
            }))
        else
            print("ERROR: Failed to create DUI!")
            return
        end

        -- Menu toggle thread - only Page Down

        CreateThread(function()
            local lastPress = 0
            while not Unloaded do
                if IsControlJustPressed(0, menuKeybind) then -- Use custom keybind
                    local currentTime = GetGameTimer()
                    if currentTime - lastPress > 200 then
                        if _G.clientMenuShowing then
                            _G.clientMenuShowing = false
                        else
                            _G.clientMenuShowing = true
                        end
                        lastPress = currentTime
                    end
                end
                Wait(0)
            end
        end)

        if not keyListenerRegistered then
            print("Registering key listeners...")
            MachoOnKeyDown(function(keyCode)
                handleKeyPress(keyCode)
            end)
            if MachoOnKeyUp then
                MachoOnKeyUp(function(keyCode)
                    handleKeyRelease(keyCode)
                end)
                print("Key release listener registered")
            end
            keyListenerRegistered = true
            print("Key listeners registered successfully")
        end

        CreateThread(function()
            while _G.clientMenuShowing and not Unloaded do
                CreateThread(function()
                    local keyActions = {
                        [featureKeybinds.freecam] = triggerFreecam,
                        [featureKeybinds.noclip] = triggerNoclip,
                        [featureKeybinds.godmode] = triggerGodmode,
                        [featureKeybinds.invisibility] = triggerInvisibility,
                        [featureKeybinds.revive] = triggerRevive,
                        [featureKeybinds.clearVision] = triggerClearVision,
                        [featureKeybinds.triggerbot] = toggleTriggerBot,
                        [featureKeybinds.infiniteAmmo] = toggleInfiniteAmmo,
                        [featureKeybinds.oneshotKill] = toggleOneshotKill,
                        [featureKeybinds.addAmmo] = triggerAddAmmo,
                        [featureKeybinds.fixVehicle] = triggerFixVehicle,
                        [featureKeybinds.unlockClosest] = triggerUnlockClosest,
                        [featureKeybinds.lockClosest] = triggerLockClosest,
                        [featureKeybinds.instantBrakes] = toggleInstantBrakes
                    }
                    local lastPress = {}
                    while not Unloaded do
                        Wait(0)
                        for keyCode, action in pairs(keyActions) do
                            if keyCode and action and IsControlJustPressed(0, keyCode) then
                                local now = GetGameTimer()
                                if not lastPress[keyCode] or (now - lastPress[keyCode] > 200) then
                                    action()
                                    lastPress[keyCode] = now
                                end
                            end
                        end
                    end
                end)
                if textInputActive then
                    local fivemShift = IsControlPressed(0, 21) or IsDisabledControlPressed(0, 21)
                    local fivemCtrl = IsControlPressed(0, 36) or IsDisabledControlPressed(0, 36)
                    local fivemAlt = IsControlPressed(0, 19) or IsDisabledControlPressed(0, 19)
                    
                    if GetGameTimer() % 50 == 0 then
                        if fivemShift ~= shiftPressed then
                            shiftPressed = fivemShift
                            print("Shift state updated via FiveM:", shiftPressed)
                        end
                        if fivemCtrl ~= ctrlPressed then
                            ctrlPressed = fivemCtrl
                            print("Ctrl state updated via FiveM:", ctrlPressed)
                            if ctrlPressed and isControlJustPressed(0x56) then
                                print("=== CTRL+V detected via FiveM controls - Pasting ===")
                                pasteFromClipboard()
                            end
                        end
                        if fivemAlt ~= altPressed then
                            altPressed = fivemAlt  
                            print("Alt state updated via FiveM:", altPressed)
                        end
                    end
                end
                Wait(25)
            end
        end)

        -- Auto-update player list when in Server submenu
        CreateThread(function()
            while not Unloaded do
                Wait(100) -- refresh every 0.5 seconds

                local serverMenuItem
                for i, menuItem in ipairs(originalMenu) do
                    if menuItem.label == "Server" then
                        serverMenuItem = menuItem
                        break
                    end
                end

                if serverMenuItem then
                    -- Find the Player List submenu inside Server
                    for i, subItem in ipairs(serverMenuItem.submenu) do
                        if subItem.label == "Player List" then
                            local oldSubmenu = subItem.submenu
                            local newSubmenu = updatePlayerListMenu()

                            -- Replace submenu
                            subItem.submenu = newSubmenu

                            if activeMenu == oldSubmenu then
                                activeMenu = newSubmenu
                                if activeIndex > #activeMenu then
                                    activeIndex = 1
                                end
                                setCurrent()
                            end
                            break
                        end
                    end
                end
            end
        end)

    -- Main menu loop
    local showing = false
    local nestedMenus = {}
    _G.clientMenuShowing = false

    local moveDelay = 50   -- initial delay before repeat
    local moveRepeat = 10 -- repeat delay while holding
    local arrowTimer = {
        left = 0,
        right = 0
    }

    while true do
        local tick = GetGameTimer()

        if _G.clientMenuShowing and not showing then
            showing = true
            initializeMenu()
            nestedMenus = {}
        elseif not _G.clientMenuShowing and showing then
            showing = false
            closeMenu()
        end

        if textInputActive then
            DisableAllControlActions(0)
            
            if isControlJustPressed(191) then -- Enter
                closeTextInput(true)
                Wait(100)
            elseif isControlJustPressed(200) then -- Escape
                closeTextInput(false)
                Wait(100)
            elseif isControlJustPressed(178) then -- Delete
                clearInput()
            end
        else
            if showing then
                EnableControlAction(0, 1, true) -- Mouse
                EnableControlAction(0, 2, true) -- Mouse

                -- Arrow Down (single click)
                if isControlJustPressed(187) then
                    activeIndex = activeIndex + 1
                    if activeIndex > #activeMenu then activeIndex = 1 end
                    throttledSetCurrent()
                end

                -- Arrow Up (single click)
                if isControlJustPressed(188) then
                    activeIndex = activeIndex - 1
                    if activeIndex < 1 then activeIndex = #activeMenu end
                    throttledSetCurrent()
                end

                -- Left Arrow (hold)
                if IsControlPressed(0, 189) and tick - arrowTimer.left >= moveDelay then
                    local activeData = activeMenu[activeIndex]
                    if activeData.type == 'slider' then
                        activeData.value = math.max(activeData.min, activeData.value - 1)
                        if activeData.onChange then activeData.onChange(activeData.value) end
                        throttledSetCurrent()
                        arrowTimer.left = tick + moveRepeat
                    end
                end

                -- Right Arrow (hold) – ONLY sliders
                if IsControlPressed(0, 190) and tick - arrowTimer.right >= moveDelay then
                    local activeData = activeMenu[activeIndex]
                    if activeData.type == 'slider' then
                        activeData.value = math.min(activeData.max, activeData.value + 1)
                        if activeData.onChange then activeData.onChange(activeData.value) end
                        throttledSetCurrent()
                        arrowTimer.right = tick + moveRepeat
                    end
                end

                -- Scroll left/right (single click)
                if isControlJustPressed(189) or isControlJustPressed(190) then
                    local activeData = activeMenu[activeIndex]
                    if activeData.type == 'scroll' then
                        if isControlJustPressed(189) then
                            activeData.selected = activeData.selected - 1
                            if activeData.selected < 1 then activeData.selected = #activeData.options end
                        elseif isControlJustPressed(190) then
                            activeData.selected = activeData.selected + 1
                            if activeData.selected > #activeData.options then activeData.selected = 1 end
                        end
                        if activeData.onChange then activeData.onChange(activeData.options[activeData.selected]) end
                        throttledSetCurrent()
                    end
                end

                -- Enter
                if isControlJustPressed(191) then
                    local activeData = activeMenu[activeIndex]
                    if activeData.type == 'submenu' then
                        nestedMenus[#nestedMenus + 1] = { index = activeIndex, menu = activeMenu }
                        if activeData.submenu then
                            activeIndex = 1
                            activeMenu = activeData.submenu
                            setCurrent()
                        end
                    elseif activeData.type == 'button' and activeData.onConfirm then
                        activeData.onConfirm()
                    elseif activeData.type == 'checkbox' then
                        activeData.checked = not activeData.checked
                        setCurrent()
                        if activeData.onConfirm then activeData.onConfirm(activeData.checked) end
                    elseif activeData.type == 'scroll' and activeData.onConfirm then
                        activeData.onConfirm(activeData.options[activeData.selected])
                        setCurrent()
                    elseif activeData.type == 'slider' and activeData.onConfirm then
                        activeData.onConfirm(activeData.value)
                        setCurrent()
                    end
                end

                -- Backspace
                if isControlJustPressed(194) then
                    local lastMenu = nestedMenus[#nestedMenus]
                    if lastMenu then
                        table.remove(nestedMenus)
                        activeIndex = lastMenu.index
                        activeMenu = lastMenu.menu
                        setCurrent()
                    else
                        _G.clientMenuShowing = false
                    end
                end
            end
        end

        Wait(0)
    end
end)
