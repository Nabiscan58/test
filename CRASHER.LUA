-- ========================================
-- FTK CRASHER 2.0 - MENU SYSTEM
-- By: Eleven & Rev
-- ========================================

-- Configuration
local Config = {
    pedModel = "player_one",
    spawnRadius = 4.5,
    totalPeds = 110,
    spawnDelay = 200,
    lifetimeDuration = 3500,
    batchSize = 6,
    menuKey = 170 -- F3 key (change if needed)
}

-- State management
local SpawnState = {
    active = false,
    executed = false,
    entities = {}
}

local MenuState = {
    isOpen = false,
    selectedIndex = 1,
    playerList = {},
    scrollOffset = 0,
    maxVisible = 10
}

-- ========================================
-- MENU FUNCTIONS
-- ========================================

local function RefreshPlayerList()
    MenuState.playerList = {}
    
    for _, playerId in ipairs(GetActivePlayers()) do
        if playerId ~= PlayerId() then
            local playerPed = GetPlayerPed(playerId)
            if DoesEntityExist(playerPed) then
                local serverID = GetPlayerServerId(playerId)
                local playerName = GetPlayerName(playerId)
                local distance = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(playerPed))
                
                table.insert(MenuState.playerList, {
                    id = playerId,
                    serverId = serverID,
                    name = playerName,
                    distance = distance
                })
            end
        end
    end
    
    -- Sort by distance
    table.sort(MenuState.playerList, function(a, b)
        return a.distance < b.distance
    end)
end

local function DrawText3D(text, x, y, scale, font)
    SetTextFont(font or 4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

local function DrawMenu()
    if not MenuState.isOpen then return end
    
    local screenW, screenH = GetActiveScreenResolution()
    local baseX = 0.20
    local baseY = 0.25
    local width = 0.25
    local headerHeight = 0.03
    local itemHeight = 0.025
    
    -- Background
    DrawRect(baseX + width/2, baseY + 0.25, width, 0.52, 0, 0, 0, 200)
    
    -- Header
    DrawRect(baseX + width/2, baseY + headerHeight/2, width, headerHeight, 0, 0, 0, 0)
    DrawText3D("~b~FTK Crasher V2.0 [Beta]", baseX + 0.05, baseY - 0.01, 0.7, wd4)
    DrawText3D("~w~Created By: Rev & Eleven", baseX + 0.08, baseY + 0.035, 0.35, 1)
    
    -- Instructions
    local instrY = baseY + headerHeight + 0.035
    DrawText3D("~b~[F3] Open/Close | [ENTER] Select | [ARROWS] Navigate", baseX + 0.030, instrY, 0.40, 4)

    -- Crowd crash option
    local crowdY = instrY + 0.04
    local crowdColor = MenuState.selectedIndex == 0 and "~b~→ " or "~w~   "
    DrawText3D(crowdColor .. "FTK Crasher V1 (Crowd Crash)", baseX + 0.07, crowdY, 0.40, 4)
    
    -- Divider
    DrawRect(baseX + width/2, crowdY + 0.040, width - 0.01, 0.002, 250, 250, 255, 255)
    
    -- Player list header
    local listHeaderY = crowdY + 0.05
    DrawText3D("~b~Online Players:", baseX + 0.10, listHeaderY, 0.40, 4)
    
    if #MenuState.playerList == 0 then
        DrawText3D("~w~           No Players Found. Press [RIGHTCTRL] To Refresh List.", baseX + 0.004, listHeaderY + 0.04, 0.40, 4)
        return
    end
    
    -- Player list
    local startY = listHeaderY + 0.04
    local visibleStart = MenuState.scrollOffset
    local visibleEnd = math.min(MenuState.scrollOffset + MenuState.maxVisible, #MenuState.playerList)
    
    for i = visibleStart + 1, visibleEnd do
        local player = MenuState.playerList[i]
        local yPos = startY + ((i - visibleStart - 1) * itemHeight)
        
        local isSelected = MenuState.selectedIndex == i
        local prefix = isSelected and "~b~→ " or "~w~   "
        local distText = string.format("%.0fm", player.distance)
        
        local displayText = string.format("%s[%d] %s ~c~(%s)", 
            prefix, player.serverId, player.name, distText)
        
        DrawText3D(displayText, baseX + 0.09, yPos, 0.35, 4)
    end
    
    -- Scroll indicator
    if #MenuState.playerList > MenuState.maxVisible then
        local scrollY = startY + (MenuState.maxVisible * itemHeight) + 0.02
        DrawText3D(string.format("~y~Showing %d-%d of %d", 
            visibleStart + 1, visibleEnd, #MenuState.playerList), 
            baseX + 0.005, scrollY, 0.3, 4)
    end
end

local function HandleMenuInput()
    if not MenuState.isOpen then return end
    
    -- Navigate up
    if IsControlJustPressed(0, 172) then -- Up arrow
        MenuState.selectedIndex = MenuState.selectedIndex - 1
        if MenuState.selectedIndex < 0 then
            MenuState.selectedIndex = #MenuState.playerList
        end
        
        -- Adjust scroll
        if MenuState.selectedIndex < MenuState.scrollOffset + 1 then
            MenuState.scrollOffset = math.max(0, MenuState.selectedIndex - 1)
        end
    end
    
    -- Navigate down
    if IsControlJustPressed(0, 173) then -- Down arrow
        MenuState.selectedIndex = MenuState.selectedIndex + 1
        if MenuState.selectedIndex > #MenuState.playerList then
            MenuState.selectedIndex = 0
        end
        
        -- Adjust scroll
        if MenuState.selectedIndex > MenuState.scrollOffset + MenuState.maxVisible then
            MenuState.scrollOffset = MenuState.selectedIndex - MenuState.maxVisible
        end
    end
    
    -- Select/Execute
    if IsControlJustPressed(0, 191) then -- Enter
        if MenuState.selectedIndex == 0 then
            -- Crowd crash
            MenuState.isOpen = false
            ExecuteSpawn(nil)
        elseif MenuState.selectedIndex > 0 and MenuState.selectedIndex <= #MenuState.playerList then
            -- Single target
            local target = MenuState.playerList[MenuState.selectedIndex]
            MenuState.isOpen = false
            ExecuteSpawn(target.id)
        end
    end
    
    -- Refresh list
    if IsControlJustPressed(0, 70) then -- Left arrow
        RefreshPlayerList()
        MenuState.selectedIndex = math.min(MenuState.selectedIndex, #MenuState.playerList)
    end
end

-- ========================================
-- UTILITY FUNCTIONS
-- ========================================

local function LocateNearestPlayer()
    local myPed = PlayerPedId()
    local myPos = GetEntityCoords(myPed)
    local nearestId = nil
    local shortestDist = math.huge
    
    for _, id in pairs(GetActivePlayers()) do
        if id ~= PlayerId() then
            local theirPed = GetPlayerPed(id)
            if DoesEntityExist(theirPed) and NetworkIsPlayerActive(id) then
                local theirPos = GetEntityCoords(theirPed)
                local dist = #(myPos - theirPos)
                if dist < shortestDist then
                    shortestDist = dist
                    nearestId = id
                end
            end
        end
    end
    
    return nearestId
end

local function ConfigurePed(ped, playerPed)
    SetEntityAlpha(ped, 0, false)
    SetEntityVisible(ped, false, false)
    FreezeEntityPosition(ped, true)
    
    SetEntityCollision(ped, false, false)
    SetEntityCompletelyDisableCollision(ped, false, false)
    SetEntityNoCollisionEntity(ped, playerPed, true)
    SetEntityNoCollisionEntity(playerPed, ped, true)
    
    SetEntityCanBeDamaged(ped, false)
    SetEntityInvincible(ped, true)
    SetEntityProofs(ped, true, true, true, true, true, true, true, true)
    
    SetPedCanRagdoll(ped, false)
    SetPedCanRagdollFromPlayerImpact(ped, false)
    
    local flags = {17, 128, 149, 223, 229, 281, 287, 292, 297, 301, 430, 435}
    for _, flag in ipairs(flags) do
        SetPedConfigFlag(ped, flag, true)
    end
    
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedFleeAttributes(ped, 0, false)
    SetPedAsEnemy(ped, false)
    
    local combatAttrs = {0, 5, 17, 46}
    for _, attr in ipairs(combatAttrs) do
        SetPedCombatAttributes(ped, attr, false)
    end
    SetPedCombatAbility(ped, 0)
    SetPedCombatRange(ped, 0)
    SetPedCombatMovement(ped, 0)
    
    DisablePedPainAudio(ped, true)
    SetPedMute(ped, true)
    StopPedSpeaking(ped, true)
    
    SetPedSeeingRange(ped, 0.0)
    SetPedHearingRange(ped, 0.0)
    SetPedAlertness(ped, 0)
end

local function CalculateSpawnPosition(centerCoords, radius)
    local angle = math.random() * 2 * math.pi
    local distance = math.random() * radius
    local x = centerCoords.x + (distance * math.cos(angle))
    local y = centerCoords.y + (distance * math.sin(angle))
    local z = centerCoords.z
    
    local hasGround, groundZ = GetGroundZFor_3dCoord(x, y, z + 2.0, false)
    if hasGround then
        z = groundZ
    end
    
    return vector3(x, y, z)
end

local function CleanupEntities()
    for _, entity in ipairs(SpawnState.entities) do
        if DoesEntityExist(entity) then
            DeleteEntity(entity)
        end
    end
    SpawnState.entities = {}
end

-- ========================================
-- MAIN CRASHER EXECUTION
-- ========================================

function ExecuteSpawn(targetPlayerId)
    if SpawnState.active then
        return
    end
    
    SpawnState.active = true
    
    -- If no target specified, find nearest
    if not targetPlayerId then
        targetPlayerId = LocateNearestPlayer()
    end
    
    if not targetPlayerId then
        print("^3[FTK] No target found^0")
        SpawnState.active = false
        return
    end
    
    local targetName = GetPlayerName(targetPlayerId)
    local targetServer = GetPlayerServerId(targetPlayerId)
    print(string.format("^2[FTK] Targeting: [%d] %s^0", targetServer, targetName))
    
    local modelHash = GetHashKey(Config.pedModel)
    RequestModel(modelHash)
    
    local timeout = 0
    while not HasModelLoaded(modelHash) and timeout < 50 do
        Citizen.Wait(100)
        timeout = timeout + 1
    end
    
    if not HasModelLoaded(modelHash) then
        print("^1[FTK] Failed to load model^0")
        SpawnState.active = false
        return
    end
    
    local myPed = PlayerPedId()
    local iterations = math.ceil(Config.totalPeds / Config.batchSize)
    
    for iteration = 1, iterations do
        local targetPed = GetPlayerPed(targetPlayerId)
        
        if not DoesEntityExist(targetPed) or not NetworkIsPlayerActive(targetPlayerId) then
            CleanupEntities()
            SetModelAsNoLongerNeeded(modelHash)
            SpawnState.active = false
            print("^3[FTK] Target disconnected^0")
            return
        end
        
        local targetCoords = GetEntityCoords(targetPed)
        
        for i = 1, Config.batchSize do
            local spawnPos = CalculateSpawnPosition(targetCoords, Config.spawnRadius)
            local heading = math.random(0, 359)
            
            local entity = CreatePed(28, modelHash, spawnPos.x, spawnPos.y, spawnPos.z, heading, true, false)
            
            if DoesEntityExist(entity) then
                ConfigurePed(entity, myPed)
                TaskWanderInArea(entity, spawnPos.x, spawnPos.y, spawnPos.z, 8.0, 8.0, 8.0)
                SetPedAsNoLongerNeeded(entity)
                table.insert(SpawnState.entities, entity)
            end
        end
        
        Citizen.Wait(Config.spawnDelay)
    end
    
    SetModelAsNoLongerNeeded(modelHash)
    print("^2[FTK] Crasher executed successfully^0")
    
    Citizen.CreateThread(function()
        Citizen.Wait(Config.lifetimeDuration)
        CleanupEntities()
        SpawnState.active = false
    end)
end

-- ========================================
-- MAIN THREADS
-- ========================================

-- Menu display thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if MenuState.isOpen then
            DrawMenu()
            HandleMenuInput()
        end
    end
end)

-- Menu toggle thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if IsControlJustPressed(0, Config.menuKey) then -- F3 Key
            MenuState.isOpen = not MenuState.isOpen
            
            if MenuState.isOpen then
                RefreshPlayerList()
                MenuState.selectedIndex = 0
                MenuState.scrollOffset = 0
                print("^2[FTK] Menu opened^0")
            else
                print("^2[FTK] Menu closed^0")
            end
        end
    end
end)

-- Initialize
print("^5========================================^0")
print("^5[FTK CRASHER V2.0] Loaded^0")
print("^5Press F3 To Open Menu^0")
print("^5Created By: Eleven & Rev^0")
print("^5========================================^0")
