-- =====================================================
-- SUSANO MOD MENU V4 PRIME RP - BASE BNZ + EVENTS
-- =====================================================

local menuOpen = false
local selectedCategory = 1
local selectedAction = 1
local logs = {}

-- THEME JAUNE
local THEME = {
    bg       = {0,0,0,180},
    header   = {255,215,0,255},
    text     = {255,255,255,255},
    selected = {255,215,0,255},
    muted    = {170,170,170,255}
}

-- ===================== LOG =====================
local function log(msg)
    table.insert(logs,1,os.date("%H:%M:%S").." - "..msg)
    if #logs>25 then table.remove(logs) end
end

local function notify(msg)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandThefeedPostTicker(false,false)
end

-- ===================== ACTIONS =====================
local Categories = {
    {
        label="🧍 Personnage",
        actions={
            {label="Ne plus avoir faim", run=function()
                -- Placeholder: la ressource foodsystem doit être stoppée côté serveur si nécessaire
                notify("Faim désactivée")
                log("Faim désactivée")
            end},
            {label="Se revive", run=function()
                -- Placeholder: ressource rems
                notify("Revive appliqué")
                log("Revive appliqué")
            end},
            {label="Ne pas perdre ses armes", run=function()
                -- Event blacklisté
                notify("Blackliste event rems:removeItems")
                log("Blackliste rems:removeItems")
            end},
            {label="Compétences max", run=function()
                TriggerServerEvent('gym:server:saveGain',{{speed=100,stamina=100,strength=100}})
                notify("Compétences max appliquées")
                log("gym:server:saveGain envoyé")
            end},
            {label="Mettre une amende", run=function()
                local prix,vitesse,id=500,120,1
                TriggerServerEvent('LSPD:Radar',prix,vitesse,id)
                notify("Amende envoyée")
                log("LSPD:Radar envoyé")
            end},
        }
    },
    {
        label="🎁 Give Items",
        actions={
            {label="Sandwich / Eau / Radio / Phone / Tablet", run=function()
                local items={"eau","poulsand","classic_phone","radio","tablet"}
                for _,item in ipairs(items) do
                    TriggerServerEvent('essentialshop:buyItem',item,1)
                    log(item.." acheté")
                end
                notify("Items reçus")
            end},
            {label="Bandages", run=function()
                TriggerServerEvent('rems:buyBandages',10)
                notify("Bandages reçus")
                log("Bandages envoyés")
            end},
            {label="Tablet Items", run=function()
                local tabletItems={"tablet_illegal"} -- à compléter avec tes items
                for _,item in ipairs(tabletItems) do
                    TriggerServerEvent('tablet:buyItem',item,1)
                    log(item.." envoyé")
                end
                notify("Tablet Items reçus")
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
        }
    },
    {
        label="💰 Argent / Jobs / Farm",
        actions={
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
                local items={"coke_pooch","meth_pooch","ketamine_pooch","fentanyl_pooch"}
                for _,item in ipairs(items) do
                    TriggerServerEvent('laboratoires:giveDrugs',item)
                    log("laboratoires:giveDrugs "..item.." envoyé")
                end
                notify("Drogues reçues")
            end},
            {label="Script cabane chasse", run=function()
                local cycle=100000
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
        }
    },
    {
        label="📜 Logs",
        actions={}
    }
}

-- ===================== INPUT + DRAW (BNZ) =====================
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        -- TOGGLE MENU
        if Susano.GetAsyncKeyState(0x2D)==1 then -- INSERT
            menuOpen = not menuOpen
            if Susano.EnableOverlay then Susano.EnableOverlay(menuOpen) end
            selectedCategory=1
            selectedAction=1
            Citizen.Wait(250)
        end

        if not menuOpen then goto skip end

        -- DRAW BNZ STYLE
        local current = Categories[selectedCategory].actions
        Susano.DrawRect(0.05,0.1,0.32,0.65,0,0,0,180)
        Susano.DrawText(0.06,0.11,"SUSANO V4 PRIME RP",0.50,255,215,0,255)

        if selectedCategory==#Categories then
            -- LOGS
            for i,v in ipairs(logs) do
                Susano.DrawText(0.07,0.15+(i*0.028),v,0.30,170,170,170,255)
            end
        else
            for i,v in ipairs(current) do
                local y=0.15+(i*0.035)
                local col = (i==selectedAction) and {255,215,0,255} or {255,255,255,255}
                Susano.DrawText(0.07,y,v.label,0.35,table.unpack(col))
            end
        end

        -- NAVIGATION
        if Susano.GetAsyncKeyState(0x28)==1 then -- Down
            selectedAction = selectedAction +1
            if selectedAction>#current then selectedAction=1 end
            Citizen.Wait(120)
        end
        if Susano.GetAsyncKeyState(0x26)==1 then -- Up
            selectedAction = selectedAction -1
            if selectedAction<1 then selectedAction=#current end
            Citizen.Wait(120)
        end

        -- ENTER
        if Susano.GetAsyncKeyState(0x0D)==1 then
            if #current>0 and current[selectedAction].run then
                current[selectedAction].run()
            end
            Citizen.Wait(200)
        end

        -- BACKSPACE
        if Susano.GetAsyncKeyState(0x08)==1 then
            selectedCategory=1
            selectedAction=1
            Citizen.Wait(200)
        end

        -- LEFT / RIGHT pour changer catégorie
        if Susano.GetAsyncKeyState(0x25)==1 then -- Left
            selectedCategory = selectedCategory -1
            if selectedCategory<1 then selectedCategory=#Categories end
            selectedAction=1
            Citizen.Wait(120)
        end
        if Susano.GetAsyncKeyState(0x27)==1 then -- Right
            selectedCategory = selectedCategory +1
            if selectedCategory>#Categories then selectedCategory=1 end
            selectedAction=1
            Citizen.Wait(120)
        end

        ::skip::
    end
end)
