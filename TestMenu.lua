-- ==========================================
-- SUSANO MOD MENU V4 - FIXED
-- ==========================================

local menuOpen = false
local menuState = "categories"
local selectedIndex = 1
local logs = {}
local BlacklistedEvents = {}

-- ========== THEME ==========
local THEME = {
    bg = {0, 0, 0, 200},
    accent = {255, 215, 0, 255},
    text = {255, 255, 255, 255},
    selected = {255, 215, 0, 255},
    muted = {160, 160, 160, 255}
}

-- ========== CATEGORIES ==========
local Categories = {
    { label = "Event Executor", state = "executor" },
    { label = "Personnage", state = "personnage" },
    { label = "Logs", state = "logs" }
}

-- ========== EVENTS ==========
local EventList = {
    { label = "Compétences max", event = "gym:server:saveGain",
      args = { { speed = 100, stamina = 100, strength = 100 } } },

    { label = "Bandages x10", event = "rems:buyBandages", args = { 10 } },

    { label = "Braquage Banque", event = "robberys:finish", args = { 6 } },
    { label = "Braquage ATM", event = "robatm:succes", args = {} },
}

local PersonnageEvents = {
    {
        label = "Bloquer perte armes (coma)",
        action = "blacklistEvent",
        event = "rems:removeItems"
    }
}

-- ========== LOGGER ==========
local function Log(label)
    table.insert(logs, 1, os.date("%H:%M:%S") .. " - " .. label)
    if #logs > 20 then table.remove(logs) end
end

-- ========== EXEC ==========
local function Execute(entry)

    if entry.action == "blacklistEvent" then
        if not BlacklistedEvents[entry.event] then
            BlacklistedEvents[entry.event] = true
            RegisterNetEvent(entry.event)
            AddEventHandler(entry.event, function()
                CancelEvent()
            end)
            Log("Blacklist: " .. entry.event)
        end
        return
    end

    if entry.event then
        TriggerServerEvent(entry.event, table.unpack(entry.args or {}))
        TriggerEvent(entry.event, table.unpack(entry.args or {}))
        Log("Event: " .. entry.event)
    end
end

-- ========== DRAW ==========
local function DrawMenu(title, list)
    Susano.DrawRect(0.05, 0.1, 0.3, 0.6, table.unpack(THEME.bg))
    Susano.DrawText(0.06, 0.11, title, 0.45, table.unpack(THEME.accent))

    for i, v in ipairs(list) do
        local y = 0.14 + (i * 0.03)
        local col = (i == selectedIndex) and THEME.selected or THEME.text
        Susano.DrawText(0.07, y, v.label, 0.35, table.unpack(col))
    end
end

local function DrawLogs()
    Susano.DrawRect(0.05, 0.1, 0.3, 0.6, table.unpack(THEME.bg))
    Susano.DrawText(0.06, 0.11, "LOGS", 0.45, table.unpack(THEME.accent))

    for i, v in ipairs(logs) do
        Susano.DrawText(0.07, 0.14 + (i * 0.025), v, 0.30, table.unpack(THEME.muted))
    end
end

-- ========== LOOP ==========
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if Susano.GetAsyncKeyState(0x2D) == 1 then
            menuOpen = not menuOpen
            menuState = "categories"
            selectedIndex = 1
            Citizen.Wait(250)
        end

        if not menuOpen then goto skip end

        if menuState == "categories" then
            DrawMenu("SUSANO V4", Categories)
        elseif menuState == "executor" then
            DrawMenu("EVENT EXECUTOR", EventList)
        elseif menuState == "personnage" then
            DrawMenu("PERSONNAGE", PersonnageEvents)
        elseif menuState == "logs" then
            DrawLogs()
        end

        if Susano.GetAsyncKeyState(0x28) == 1 then
            selectedIndex = selectedIndex + 1
            Citizen.Wait(120)
        end

        if Susano.GetAsyncKeyState(0x26) == 1 then
            selectedIndex = math.max(selectedIndex - 1, 1)
            Citizen.Wait(120)
        end

        if Susano.GetAsyncKeyState(0x0D) == 1 then
            local list =
                menuState == "categories" and Categories or
                menuState == "executor" and EventList or
                menuState == "personnage" and PersonnageEvents

            local entry = list and list[selectedIndex]
            if entry then
                if entry.state then
                    menuState = entry.state
                    selectedIndex = 1
                else
                    Execute(entry)
                end
            end
            Citizen.Wait(200)
        end

        if Susano.GetAsyncKeyState(0x08) == 1 then
            menuState = "categories"
            selectedIndex = 1
            Citizen.Wait(200)
        end

        ::skip::
    end
end)
