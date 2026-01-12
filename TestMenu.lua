-- =====================================================
-- SUSANO MOD MENU V4 - GENERIC / CLEAN / WORKING
-- =====================================================

-- ===================== STATE =====================
local menuOpen = false
local menuState = "categories"
local selectedIndex = 1
local logs = {}

-- ===================== THEME (JAUNE) =====================
local THEME = {
    bg       = {0, 0, 0, 180},
    header   = {255, 215, 0, 255},
    text     = {255, 255, 255, 255},
    selected = {255, 215, 0, 255},
    muted    = {170, 170, 170, 255}
}

-- ===================== UTILS =====================
local function notify(msg)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandThefeedPostTicker(false, false)
end

local function log(msg)
    table.insert(logs, 1, os.date("%H:%M:%S") .. " - " .. msg)
    if #logs > 25 then table.remove(logs) end
end

-- ===================== CATEGORIES =====================
local Categories = {
    { label = "⚙ Event Executor (Local)", state = "executor" },
    { label = "🧍 Personnage (Local)", state = "personnage" },
    { label = "📜 Logs", state = "logs" }
}

-- ===================== EXECUTOR (LOCAL DEMO) =====================
local ExecutorActions = {
    {
        label = "Test Event Local",
        run = function()
            notify("Event local exécuté ✔")
            log("Test Event Local")
        end
    },
    {
        label = "Print Console",
        run = function()
            print("[Susano V4] Action console OK")
            notify("Check console (F8)")
            log("Print Console")
        end
    },
    {
        label = "Effet Visuel",
        run = function()
            StartScreenEffect("SuccessNeutral", 1500, false)
            notify("Effet visuel déclenché")
            log("Effet Visuel")
        end
    }
}

-- ===================== PERSONNAGE (LOCAL) =====================
local PersonnageActions = {
    {
        label = "Heal joueur",
        run = function()
            local ped = PlayerPedId()
            SetEntityHealth(ped, GetEntityMaxHealth(ped))
            notify("Joueur soigné")
            log("Heal joueur")
        end
    },
    {
        label = "Donner armure",
        run = function()
            SetPedArmour(PlayerPedId(), 100)
            notify("Armure 100")
            log("Armure donnée")
        end
    },
    {
        label = "Boost vitesse (5s)",
        run = function()
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.25)
            notify("Boost vitesse ON")
            log("Boost vitesse ON")
            Citizen.SetTimeout(5000, function()
                SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
                notify("Boost vitesse OFF")
                log("Boost vitesse OFF")
            end)
        end
    }
}

-- ===================== DRAW =====================
local function drawBox()
    Susano.DrawRect(0.05, 0.1, 0.32, 0.65, table.unpack(THEME.bg))
end

local function drawMenu(title, list)
    drawBox()
    Susano.DrawText(0.06, 0.11, title, 0.50, table.unpack(THEME.header))

    for i, v in ipairs(list) do
        local y = 0.15 + (i * 0.035)
        local col = (i == selectedIndex) and THEME.selected or THEME.text
        Susano.DrawText(0.07, y, v.label, 0.35, table.unpack(col))
    end
end

local function drawLogs()
    drawBox()
    Susano.DrawText(0.06, 0.11, "LOGS", 0.50, table.unpack(THEME.header))

    for i, v in ipairs(logs) do
        Susano.DrawText(0.07, 0.15 + (i * 0.028), v, 0.30, table.unpack(THEME.muted))
    end
end

-- ===================== INPUT LOOP =====================
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        -- TOGGLE MENU
        if Susano.GetAsyncKeyState(0x2D) == 1 then -- INSERT
            menuOpen = not menuOpen
            menuState = "categories"
            selectedIndex = 1
            Citizen.Wait(250)
        end

        if not menuOpen then goto skip end

        -- DRAW
        if menuState == "categories" then
            drawMenu("SUSANO MOD MENU V4", Categories)
        elseif menuState == "executor" then
            drawMenu("EVENT EXECUTOR (LOCAL)", ExecutorActions)
        elseif menuState == "personnage" then
            drawMenu("PERSONNAGE (LOCAL)", PersonnageActions)
        elseif menuState == "logs" then
            drawLogs()
        end

        -- NAV DOWN
        if Susano.GetAsyncKeyState(0x28) == 1 then
            selectedIndex = selectedIndex + 1
            Citizen.Wait(120)
        end

        -- NAV UP
        if Susano.GetAsyncKeyState(0x26) == 1 then
            selectedIndex = math.max(selectedIndex - 1, 1)
            Citizen.Wait(120)
        end

        -- ENTER
        if Susano.GetAsyncKeyState(0x0D) == 1 then
            local list =
                menuState == "categories" and Categories or
                menuState == "executor" and ExecutorActions or
                menuState == "personnage" and PersonnageActions or
                nil

            local entry = list and list[selectedIndex]
            if entry then
                if entry.state then
                    menuState = entry.state
                    selectedIndex = 1
                elseif entry.run then
                    entry.run()
                end
            end
            Citizen.Wait(200)
        end

        -- BACK
        if Susano.GetAsyncKeyState(0x08) == 1 then
            menuState = "categories"
            selectedIndex = 1
            Citizen.Wait(200)
        end

        ::skip::
    end
end)
