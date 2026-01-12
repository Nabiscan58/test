-- =====================================================
-- SUSANO MOD MENU V4 - BASE BNZ + CUSTOM EVENTS
-- =====================================================

-- ===================== STATE =====================
local menuOpen = false
local selectedCategory = 1
local selectedAction = 1
local currentActions = {}
local logs = {}

-- ===================== THEME =====================
local THEME = {
    bg       = {0,0,0,180},
    header   = {255,215,0,255},
    text     = {255,255,255,255},
    selected = {255,215,0,255},
    muted    = {170,170,170,255}
}

-- ===================== UTILS =====================
local function notify(msg)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandThefeedPostTicker(false,false)
end

local function log(msg)
    table.insert(logs, 1, os.date("%H:%M:%S") .. " - " .. msg)
    if #logs > 25 then table.remove(logs) end
end

-- ===================== CATEGORIES & ACTIONS =====================
local Categories = {
    {label="🧍 Personnage", actions={
        {label="Ne plus avoir faim", run=function()
            notify("Faim désactivée")
            log("Faim désactivée")
        end},
        {label="Se revive", run=function()
            notify("Revive appliqué")
            log("Revive appliqué")
        end},
        {label="Ne pas perdre ses armes", run=function()
            notify("Blackliste event rems:removeItems")
            log("Blackliste event rems:removeItems")
        end},
        {label="Compétences max", run=function()
            TriggerServerEvent('gym:server:saveGain', {{speed=100, stamina=100, strength=100}})
            notify("Compétences max appliquées")
            log("gym:server:saveGain envoyé")
        end},
        {label="Mettre une amende", run=function()
            local prix,vitesse,id = 500,120,1
            TriggerServerEvent('LSPD:Radar', prix,vitesse,id)
            notify("Amende envoyée")
            log("LSPD:Radar envoyé")
        end}
    }},
    {label="🎁 Give Items", actions={
        {label="Sandwich / Eau / Radio / Phone / Tablet", run=function()
            local item = "poulsand"
            TriggerServerEvent('essentialshop:buyItem', item,1)
            notify(item.." reçu")
            log(item.." envoyé")
        end},
        {label="Bandages", run=function()
            TriggerServerEvent('rems:buyBandages',10)
            notify("Bandages reçus")
            log("Bandages envoyés")
        end},
        {label="Tablet items", run=function()
            local item = "tablet_illegal"
            TriggerServerEvent('tablet:buyItem',item,1)
            notify(item.." reçu")
            log(item.." envoyé")
        end},
        {label="Se donner un Skate", run=function()
            TriggerServerEvent('skateItem:give')
            notify("Skate reçu")
            log("Skate donné")
        end},
        {label="Se donner un BMX", run=function()
            TriggerServerEvent('bmxItem:give')
            notify("BMX reçu")
            log("BMX donné")
        end}
    }},
    {label="💰 Argent / Jobs / Farm", actions={
        {label="Braquage banque (1M$)", run=function()
            TriggerServerEvent('robberys:finish',6)
            notify("Braquage banque terminé")
            log("robberys:finish 6 envoyé")
        end},
        {label="Braquage ATM", run=function()
            TriggerServerEvent('robatm:succes')
            notify("ATM braqué")
            log("robatm:succes envoyé")
        end},
        {label="Job bûcheron", run=function()
            TriggerServerEvent('bucheron:payStop')
            notify("Job bûcheron exécuté")
            log("bucheron:payStop envoyé")
        end},
        {label="Job guide", run=function()
            TriggerServerEvent('guide:payStop')
            notify("Job guide exécuté")
            log("guide:payStop envoyé")
        end},
        {label="Farm drogue", run=function()
            local item = "coke_pooch"
            TriggerServerEvent('laboratoires:giveDrugs',item)
            notify(item.." reçu")
            log("laboratoires:giveDrugs "..item.." envoyé")
        end},
        {label="Script cabane chasse", run=function()
            local cycle = 100000
            Citizen.CreateThread(function()
                for i=1,cycle do
                    TriggerServerEvent('hunting:animalSkinned',"a_c_rhesus")
                    Citizen.Wait(1200)
                    TriggerServerEvent('hunting:sellAnimal',"peausinge",1)
                end
            end)
            notify("Cabane chasse lancé")
            log("Cabane chasse exécuté")
        end}
    }},
    {label="📜 Logs", actions={}}
}

-- ===================== DRAW =====================
local function drawMenu()
    Susano.DrawRect(0.05,0.1,0.32,0.65,table.unpack(THEME.bg))
    Susano.DrawText(0.06,0.11,"SUSANO V4 PRIME RP",0.50,table.unpack(THEME.header))
    
    local current = Categories[selectedCategory].actions
    if menuOpen and #current>0 then
        for i,v in ipairs(current) do
            local y = 0.15 + (i*0.035)
            local col = (i==selectedAction) and THEME.selected or THEME.text
            Susano.DrawText(0.07,y,v.label,0.35,table.unpack(col))
        end
    else
        for i,v in ipairs(Categories) do
            local y = 0.15 + (i*0.035)
            local col = (i==selectedCategory) and THEME.selected or THEME.text
            Susano.DrawText(0.07,y,v.label,0.35,table.unpack(col))
        end
    end
end

local function drawLogs()
    Susano.DrawRect(0.05,0.1,0.32,0.65,table.unpack(THEME.bg))
    Susano.DrawText(0.06,0.11,"LOGS",0.50,table.unpack(THEME.header))
    for i,v in ipairs(logs) do
        Susano.DrawText(0.07,0.15+(i*0.028),v,0.30,table.unpack(THEME.muted))
    end
end

-- ===================== INPUT LOOP =====================
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        -- TOGGLE MENU INSERT
        if Susano.GetAsyncKeyState(0x2D) == 1 then
            menuOpen = not menuOpen
            if Susano.EnableOverlay then Susano.EnableOverlay(menuOpen) end
            selectedCategory = 1
            selectedAction = 1
            Citizen.Wait(250)
        end

        if menuOpen then
            -- DRAW
            if selectedCategory==#Categories then
                drawLogs()
            else
                drawMenu()
            end

            -- NAVIGATION
            if Susano.GetAsyncKeyState(0x28)==1 then -- Down
                selectedAction = selectedAction +1
                local maxActions = #Categories[selectedCategory].actions
                if selectedAction>maxActions then selectedAction=1 end
                Citizen.Wait(120)
            end
            if Susano.GetAsyncKeyState(0x26)==1 then -- Up
                selectedAction = selectedAction -1
                if selectedAction<1 then selectedAction=#Categories[selectedCategory].actions end
                Citizen.Wait(120)
            end

            -- ENTER
            if Susano.GetAsyncKeyState(0x0D)==1 then
                local current = Categories[selectedCategory].actions
                if #current>0 and current[selectedAction].run then
                    current[selectedAction].run()
                end
                Citizen.Wait(200)
            end

            -- BACKSPACE
            if Susano.GetAsyncKeyState(0x08)==1 then
                selectedCategory = 1
                selectedAction = 1
                Citizen.Wait(200)
            end

            -- LEFT / RIGHT pour changer catégorie
            if Susano.GetAsyncKeyState(0x25)==1 then -- Left
                selectedCategory = selectedCategory -1
                if selectedCategory<1 then selectedCategory=#Categories end
                selectedAction = 1
                Citizen.Wait(120)
            end
            if Susano.GetAsyncKeyState(0x27)==1 then -- Right
                selectedCategory = selectedCategory +1
                if selectedCategory>#Categories then selectedCategory=1 end
                selectedAction = 1
                Citizen.Wait(120)
            end
        end
    end
end)
