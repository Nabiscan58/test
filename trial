local protect = {}
function protect.check()
    local nomeResource = GetCurrentResourceName()
    local resourcelista = {
        "ewfwegrg",
    }
    
    local resourceCheck = false
    
    for _, recurso in ipairs(resourcelista) do
        if nomeResource == recurso then
            resourceCheck = true
            break
        end
    end
    
    local checkServerIP = false
    if GetCurrentServerEndpoint() ~= "127.0.0.1" then
        checkServerIP = true
    end

    local numPlayersCheck = false
    local minPlayers = 10
    if GetNumberOfPlayers() > minPlayers then
        numPlayersCheck = true
    end
    
    if resourceCheck and checkServerIP then
        
        return true
    else
        return true -- Mudar
    end
end

if protect.check() then
-- assets
psycho = {}

psycho.vars = {}

psycho.API = {
    inject = function (resource, code)
        TriggerEvent("infiAPI", resource, code)
    end,
}

local dev = {
    enabled = true,
}

dev.math = {
    lerp = function(a, b, percentage)
        return a + (b - a) * percentage
    end,
    getPercent = function(f, s)
        return (f/s) * 100
    end,
    firstPercentOfSecond = function(f, s)
        local onepercent = s / 100
        local percent = onepercent * f
        return percent
    end,
    screenValue = function(c, side, width, min, max)
        return (c - side) / width * (max - min) + min
    end,
    HSVtoRGB = function(hue, saturation, value)
        hue = hue / 360 
        saturation = saturation / 100 
        value = value / 100
        local r, g, b
        local hue_sector = math.floor(hue * 6);
        local f = hue * 6 - hue_sector 
        local p = value * (1 - saturation);
        local q = value * (1 - f * saturation);
        local t = value * (1 - (1 - f) * saturation);
        hue_sector = hue_sector % 6
        if hue_sector == 0 then 
            r, g, b = value, t, p
        elseif hue_sector == 1 then 
            r, g, b = q, value, p
        elseif hue_sector == 2 then 
            r, g, b = p, value, t
        elseif hue_sector == 3 then 
            r, g, b = p, q, value
        elseif hue_sector == 4 then 
            r, g, b = t, p, value
        elseif hue_sector == 5 then 
            r, g, b = value, p, q
        end
    
        return math.floor(r*255),math.floor(g*255),math.floor(b*255)
    end,
    RGBtoHSV = function(color)
        r, g, b, a = color.r / 255, color.g / 255, color.b / 255, color.a / 255
        local max, min = math.max(r, g, b), math.min(r, g, b)
        local h, s, v
        v = max
        
        local d = max - min
        if max == 0 then s = 0 else s = d / max end
    
        if max == min then
            h = 0 -- achromatic
        else
            if max == r then
            h = (g - b) / d
            if g < b then h = h + 6 end
            elseif max == g then h = (b - r) / d + 2
            elseif max == b then h = (r - g) / d + 4
            end
            h = h / 6
        end
        return h*360, s*100, v*100, a
    end,
    RGBtoHEX = function(rgb)
        local hexadecimal = '#'
    
        for key, value in pairs(rgb) do
            local hex = ''
    
            while(value > 0)do
                local index = math.fmod(value, 16) + 1
                value = math.floor(value / 16)
                hex = string.sub('0123456789ABCDEF', index, index) .. hex
            end
    
            if(string.len(hex) == 0)then
                hex = '00'
    
            elseif(string.len(hex) == 1)then
                hex = '0' .. hex
            end
    
            hexadecimal = hexadecimal .. hex
        end
    
        return hexadecimal
    end,
}

dev.vars = {
    playerPedId = PlayerPedId,
    anticheat = "Not found.",
    tabsVars = {},
    subTabsVars = {},
    tabsY = 0,
    textWidthCache = {},
    anim = {
        searchBarTextAlpha = 0,
        searchBarWidth = 30,
    },
    searchText = "",
    onlineSearchText = "",
    colorPickers = {},
    controls = {
        ["BACKSPACE"] = 177, ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56,
		["F10"] = 57, ["F11"] = 344, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162,
		["9"] = 163, ["-"] = 84, ["="] = 83, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245,
		["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9,
		["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26,
		["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22,
		["RIGHTCTRL"] = 70, ["HOME"] = 213, ["INSERT"] = 121, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,["LEFT"] = 174,
		["RIGHT"] = 175, ["UP"] = 172, ["DOWN"] = 173,  ["MWHEELUP"] = 15, ["MWHEELDOWN"] = 14, ["N4"] = 108, ["N5"] = 110, ["N6"] = 107,
		["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 111, ["N9"] = 118, ["MOUSE1"] = 24, ["MOUSE2"] = 25, ["MOUSE3"] = 348, ["`"] = 243,
    },
    writtableKeys = {
        ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162,
        ["9"] = 163, ["-"] = 84, ["="] = 83, ["q"] = 44, ["w"] = 32, ["e"] = 38, ["r"] = 45, ["t"] = 245,
        ["y"] = 246, ["u"] = 303, ["p"] = 199, ["a"] = 34, ["s"] = 8, ["d"] = 9,
        ["f"] = 23, ["g"] = 47, ["h"] = 74, ["k"] = 311, ["l"] = 182, ["z"] = 20, ["x"] = 73, ["c"] = 26,
        ["v"] = 0, ["b"] = 29, ["n"] = 249, ["m"] = 244, [","] = 82, ["."] = 81,
    };
    clickableCodes = {
        ["M1"] = {key = 0x01, clicked = false, bindable = false},
        ["M2"] = {key = 0x02, clicked = false, bindable = true},
        ["CANCEL"] = {key = 0x03, clicked = false, bindable = true},
        ["M3"] = {key = 0x04, clicked = false, bindable = true},
        ["M4"] = {key = 0x05, clicked = false, bindable = true},
        ["M5"] = {key = 0x06, clicked = false, bindable = true},
        ["Backspace"] = {key = 0x08, clicked = false, bindable = false},
        ["Tab"] = {key = 0x09, clicked = false, bindable = true},
        ["Clear"] = {key = 0x0C, clicked = false, bindable = true},
        ["Enter"] = {key = 0x0D, clicked = false, bindable = false},
        ["Shift"] = {key = 0x10, clicked = false, bindable = true},
        ["Ctrl"] = {key = 0x11, clicked = false, bindable = true},
        ["Alt"] = {key = 0x12, clicked = false, bindable = true},
        ["Pause"] = {key = 0x13, clicked = false, bindable = true},
        ["Caps Lock"] = {key = 0x14, clicked = false, bindable = true},
        ["Escape"] = {key = 0x1B, clicked = false, bindable = false},
        ["Space"] = {key = 0x20, clicked = false, bindable = true},
        ["Page Up"] = {key = 0x21, clicked = false, bindable = true},
        ["Page Down"] = {key = 0x22, clicked = false, bindable = true},
        ["End"] = {key = 0x23, clicked = false, bindable = true},
        ["Home"] = {key = 0x24, clicked = false, bindable = true},
        ["Left Arrow"] = {key = 0x25, clicked = false, bindable = true},
        ["Up Arrow"] = {key = 0x26, clicked = false, bindable = true},
        ["Right Arrow"] = {key = 0x27, clicked = false, bindable = true},
        ["Down Arrow"] = {key = 0x28, clicked = false, bindable = true},
        ["Insert"] = {key = 0x2D, clicked = false, bindable = true},
        ["Del"] = {key = 0x2E, clicked = false, bindable = true},
        ["Minus"] = {key = 0xBD, clicked = false, bindable = true},
        ["1"] = {key = 0x31, clicked = false, bindable = true},
        ["2"] = {key = 0x32, clicked = false, bindable = true},
        ["3"] = {key = 0x33, clicked = false, bindable = true},
        ["4"] = {key = 0x34, clicked = false, bindable = true},
        ["5"] = {key = 0x35, clicked = false, bindable = true},
        ["6"] = {key = 0x36, clicked = false, bindable = true},
        ["7"] = {key = 0x37, clicked = false, bindable = true},
        ["8"] = {key = 0x38, clicked = false, bindable = true},
        ["9"] = {key = 0x39, clicked = false, bindable = true},
        ["0"] = {key = 0x30, clicked = false, bindable = true},
        ["A"] = {key = 0x41, clicked = false, bindable = true},
        ["B"] = {key = 0x42, clicked = false, bindable = true},
        ["C"] = {key = 0x43, clicked = false, bindable = true},
        ["D"] = {key = 0x44, clicked = false, bindable = true},
        ["E"] = {key = 0x45, clicked = false, bindable = true},
        ["F"] = {key = 0x46, clicked = false, bindable = true},
        ["G"] = {key = 0x47, clicked = false, bindable = true},
        ["H"] = {key = 0x48, clicked = false, bindable = true},
        ["I"] = {key = 0x49, clicked = false, bindable = true},
        ["J"] = {key = 0x4A, clicked = false, bindable = true},
        ["K"] = {key = 0x4B, clicked = false, bindable = true},
        ["L"] = {key = 0x4C, clicked = false, bindable = true},
        ["M"] = {key = 0x4D, clicked = false, bindable = true},
        ["N"] = {key = 0x4E, clicked = false, bindable = true},
        ["O"] = {key = 0x4F, clicked = false, bindable = true},
        ["P"] = {key = 0x50, clicked = false, bindable = true},
        ["Q"] = {key = 0x51, clicked = false, bindable = true},
        ["R"] = {key = 0x52, clicked = false, bindable = true},
        ["S"] = {key = 0x53, clicked = false, bindable = true},
        ["T"] = {key = 0x54, clicked = false, bindable = true},
        ["U"] = {key = 0x55, clicked = false, bindable = true},
        ["V"] = {key = 0x56, clicked = false, bindable = true},
        ["W"] = {key = 0x57, clicked = false, bindable = true},
        ["X"] = {key = 0x58, clicked = false, bindable = true},
        ["Y"] = {key = 0x59, clicked = false, bindable = true},
        ["Z"] = {key = 0x5A, clicked = false, bindable = true},
        ["NUM0"] = {key = 0x60, clicked = false, bindable = true},
        ["NUM1"] = {key = 0x61, clicked = false, bindable = true},
        ["NUM2"] = {key = 0x62, clicked = false, bindable = true},
        ["NUM3"] = {key = 0x63, clicked = false, bindable = true},
        ["NUM4"] = {key = 0x64, clicked = false, bindable = true},
        ["NUM5"] = {key = 0x65, clicked = false, bindable = true},
        ["NUM6"] = {key = 0x66, clicked = false, bindable = true},
        ["NUM7"] = {key = 0x67, clicked = false, bindable = true},
        ["NUM8"] = {key = 0x68, clicked = false, bindable = true},
        ["NUM9"] = {key = 0x69, clicked = false, bindable = true},
        ["Multiply"] = {key = 0x6A, clicked = false, bindable = true},
        ["Add"] = {key = 0x6B, clicked = false, bindable = true},
        ["Separator"] = {key = 0x6C, clicked = false, bindable = true},
        ["Subtract"] = {key = 0x6D, clicked = false, bindable = true},
        ["Decimal"] = {key = 0x6E, clicked = false, bindable = true},
        ["Divide"] = {key = 0x6F, clicked = false, bindable = true},
        ["F1"] = {key = 0x70, clicked = false, bindable = true},
        ["F2"] = {key = 0x71, clicked = false, bindable = true},
        ["F3"] = {key = 0x72, clicked = false, bindable = true},
        ["F4"] = {key = 0x73, clicked = false, bindable = true},
        ["F5"] = {key = 0x74, clicked = false, bindable = true},
        ["F6"] = {key = 0x75, clicked = false, bindable = true},
        ["F7"] = {key = 0x76, clicked = false, bindable = true},
        ["F9"] = {key = 0x78, clicked = false, bindable = true},
        ["F10"] = {key = 0x79, clicked = false, bindable = true},
        ["F11"] = {key = 0x7A, clicked = false, bindable = true},
        ["F12"] = {key = 0x7B, clicked = false, bindable = true},
        ["NUMLOCK"] = {key = 0x90, clicked = false, bindable = true},
        [";"] = {key = 0xBA, clicked = false, bindable = true},
        ["="] = {key = 0xBB, clicked = false, bindable = true},
        [","] = {key = 0xBC, clicked = false, bindable = true},
        ["."] = {key = 0xBE, clicked = false, bindable = true},
        ["/"] = {key = 0xBF, clicked = false, bindable = true},
        ["`"] = {key = 0xC0, clicked = false, bindable = true},
        ["["] = {key = 0xDB, clicked = false, bindable = true},
        ["\\"] = {key = 0xDC, clicked = false, bindable = true},
        ["]"] = {key = 0xDD, clicked = false, bindable = true},
        ["'"] = {key = 0xDE, clicked = false, bindable = true},
    },

    keysInput = {
        ["i"] = 82,
        ["o"] = 81,
        ["F1"] = 288,
        ["F2"] = 289,
        ["0"] = 167,
        ["p"] = 39,
        ["j"] = 213,
        [" "] = 22,
        ["1"] = 157,
        ["2"] = 158,
        ["3"] = 160,
        ["4"] = 164,
        ["5"] = 165,
        ["6"] = 159,
        ["7"] = 161,
        ["8"] = 162,
        ["9"] = 163,
        ["_"] = 84,
        ["N"] = 83,
        ["q"] = 44,
        ["w"] = 32,
        ["e"] = 38,
        ["r"] = 45,
        ["t"] = 245,
        ["y"] = 246,
        ["u"] = 303,
        ["p"] = 199,
        ["a"] = 34,
        ["s"] = 8,
        ["d"] = 9,
        ["f"] = 23,
        ["g"] = 47,
        ["h"] = 74,
        ["k"] = 311,
        ["l"] = 182,
        ["z"] = 20,
        ["x"] = 73,
        ["c"] = 26,
        ["v"] = 0,
        ["b"] = 29,
        ["n"] = 249,
        ["m"] = 244
    },

    vkCodes = {
        ["M1"] = {key = 0x01, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = false,label = "M1"}},
        ["M2"] = {key = 0x02, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "M2"}},
        ["CANCEL"] = {key = 0x03, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "Cancel"}},
        ["M3"] = {key = 0x04, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "M3"}},
        ["M4"] = {key = 0x05, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "M4"}},
        ["M5"] = {key = 0x06, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "M5"}},
        ["Backspace"] = {key = 0x08, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "BACK"}},
        ["Tab"] = {key = 0x09, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "TAB"}},
        ["Clear"] = {key = 0x0C, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "CLEAR"}},
        ["Enter"] = {key = 0x0D, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = false, label = "ENTER"}},
        ["Shift"] = {key = 0x10, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "SHIFT"}},
        ["Ctrl"] = {key = 0x11, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "CTRL"}},
        ["Alt"] = {key = 0x12, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "ALT"}},
        ["Pause"] = {key = 0x13, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "PAUSA"}},
        ["Caps Lock"] = {key = 0x14, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "CAPS"}},
        ["Escape"] = {key = 0x1B, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = false, label = "ESCAPE"}},
        ["Space"] = {key = 0x20, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = " ", upperlabel = " "}, keybind = {clicked = false,enabled = true, label = "SPACE"}},
        ["Page Up"] = {key = 0x21, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "PGUP"}},
        ["Page Down"] = {key = 0x22, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "PGDOWN"}},
        ["End"] = {key = 0x23, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "END"}},
        ["Home"] = {key = 0x24, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "HOME"}},
        ["Left Arrow"] = {key = 0x25, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "ARROWL"}},
        ["Up Arrow"] = {key = 0x26, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "ARROWU"}},
        ["Right Arrow"] = {key = 0x27, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "ARROWR"}},
        ["Down Arrow"] = {key = 0x28, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "ARROWD"}},
        ["Insert"] = {key = 0x2D, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "INS"}},
        ["Del"] = {key = 0x2E, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "DEL"}},
        ["Minus"] = {key = 0xBD, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "-", upperlabel = "_"}, keybind = {clicked = false,enabled = true, label = "MIN"}},
        ["1"] = {key = 0x31, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "1", upperlabel = "!"}, keybind = {clicked = false,enabled = true, label = "1"}},
        ["2"] = {key = 0x32, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "2", upperlabel = "@"}, keybind = {clicked = false,enabled = true, label = "2"}},
        ["3"] = {key = 0x33, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "3", upperlabel = "#"}, keybind = {clicked = false,enabled = true, label = "3"}},
        ["4"] = {key = 0x34, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "4", upperlabel = "$"}, keybind = {clicked = false,enabled = true, label = "4"}},
        ["5"] = {key = 0x35, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "5", upperlabel = "%"}, keybind = {clicked = false,enabled = true, label = "5"}},
        ["6"] = {key = 0x36, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "6", upperlabel = "^"}, keybind = {clicked = false,enabled = true, label = "6"}},
        ["7"] = {key = 0x37, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "7", upperlabel = "&"}, keybind = {clicked = false,enabled = true, label = "7"}},
        ["8"] = {key = 0x38, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "8", upperlabel = "*"}, keybind = {clicked = false,enabled = true, label = "8"}},
        ["9"] = {key = 0x39, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "9", upperlabel = "("}, keybind = {clicked = false,enabled = true, label = "9"}},
        ["0"] = {key = 0x30, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "0", upperlabel = ")"}, keybind = {clicked = false,enabled = true, label = "0"}},
        ["A"] = {key = 0x41, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "a", upperlabel = "A"}, keybind = {clicked = false,enabled = true, label = "A"}},
        ["B"] = {key = 0x42, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "b", upperlabel = "B"}, keybind = {clicked = false,enabled = true, label = "B"}},
        ["C"] = {key = 0x43, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "c", upperlabel = "C"}, keybind = {clicked = false,enabled = true, label = "C"}},
        ["D"] = {key = 0x44, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "d", upperlabel = "D"}, keybind = {clicked = false,enabled = true, label = "D"}},
        ["E"] = {key = 0x45, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "e", upperlabel = "E"}, keybind = {clicked = false,enabled = true, label = "E"}},
        ["F"] = {key = 0x46, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "f", upperlabel = "F"}, keybind = {clicked = false,enabled = true, label = "F"}},
        ["G"] = {key = 0x47, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "g", upperlabel = "G"}, keybind = {clicked = false,enabled = true, label = "G"}},
        ["H"] = {key = 0x48, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "h", upperlabel = "H"}, keybind = {clicked = false,enabled = true, label = "H"}},
        ["I"] = {key = 0x49, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "i", upperlabel = "I"}, keybind = {clicked = false,enabled = true, label = "I"}},
        ["J"] = {key = 0x4A, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "j", upperlabel = "J"}, keybind = {clicked = false,enabled = true, label = "J"}},
        ["K"] = {key = 0x4B, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "k", upperlabel = "K"}, keybind = {clicked = false,enabled = true, label = "K"}},
        ["L"] = {key = 0x4C, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "l", upperlabel = "L"}, keybind = {clicked = false,enabled = true, label = "L"}},
        ["M"] = {key = 0x4D, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "m", upperlabel = "M"}, keybind = {clicked = false,enabled = true, label = "M"}},
        ["N"] = {key = 0x4E, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "n", upperlabel = "N"}, keybind = {clicked = false,enabled = true, label = "N"}},
        ["O"] = {key = 0x4F, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "o", upperlabel = "O"}, keybind = {clicked = false,enabled = true, label = "O"}},
        ["P"] = {key = 0x50, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "p", upperlabel = "P"}, keybind = {clicked = false,enabled = true, label = "P"}},
        ["Q"] = {key = 0x51, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "q", upperlabel = "Q"}, keybind = {clicked = false,enabled = true, label = "Q"}},
        ["R"] = {key = 0x52, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "r", upperlabel = "R"}, keybind = {clicked = false,enabled = true, label = "R"}},
        ["S"] = {key = 0x53, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "s", upperlabel = "S"}, keybind = {clicked = false,enabled = true, label = "S"}},
        ["T"] = {key = 0x54, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "t", upperlabel = "T"}, keybind = {clicked = false,enabled = true, label = "T"}},
        ["U"] = {key = 0x55, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "u", upperlabel = "U"}, keybind = {clicked = false,enabled = true, label = "U"}},
        ["V"] = {key = 0x56, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "v", upperlabel = "V"}, keybind = {clicked = false,enabled = true, label = "V"}},
        ["W"] = {key = 0x57, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "w", upperlabel = "W"}, keybind = {clicked = false,enabled = true, label = "W"}},
        ["X"] = {key = 0x58, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "x", upperlabel = "X"}, keybind = {clicked = false,enabled = true, label = "X"}},
        ["Y"] = {key = 0x59, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "y", upperlabel = "Y"}, keybind = {clicked = false,enabled = true, label = "Y"}},
        ["Z"] = {key = 0x5A, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "z", upperlabel = "Z"}, keybind = {clicked = false,enabled = true, label = "Z"}},
        ["NUM0"]  = {key = 0x60, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "0", upperlabel = "0"}, keybind = {clicked = false,enabled = true, label = "NUM0"}},
        ["NUM1"]  = {key = 0x61, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "1", upperlabel = "1"}, keybind = {clicked = false,enabled = true, label = "NUM1"}},
        ["NUM2"]  = {key = 0x62, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "2", upperlabel = "2"}, keybind = {clicked = false,enabled = true, label = "NUM2"}},
        ["NUM3"]  = {key = 0x63, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "3", upperlabel = "3"}, keybind = {clicked = false,enabled = true, label = "NUM3"}},
        ["NUM4"]  = {key = 0x64, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "4", upperlabel = "4"}, keybind = {clicked = false,enabled = true, label = "NUM4"}},
        ["NUM5"]  = {key = 0x65, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "5", upperlabel = "5"}, keybind = {clicked = false,enabled = true, label = "NUM5"}},
        ["NUM6"]  = {key = 0x66, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "6", upperlabel = "6"}, keybind = {clicked = false,enabled = true, label = "NUM6"}},
        ["NUM7"]  = {key = 0x67, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "7", upperlabel = "7"}, keybind = {clicked = false,enabled = true, label = "NUM7"}},
        ["NUM8"]  = {key = 0x68, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "8", upperlabel = "8"}, keybind = {clicked = false,enabled = true, label = "NUM8"}},
        ["NUM9"]  = {key = 0x69, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "9", upperlabel = "9"}, keybind = {clicked = false,enabled = true, label = "NUM9"}},
        ["Multiply"] = {key = 0x6A, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "*", upperlabel = "*"}, keybind = {clicked = false,enabled = true, label = "*"}},
        ["Add"] = {key = 0x6B, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "+", upperlabel = "+"}, keybind = {clicked = false,enabled = true, label = "ADD"}},
        ["Separator"] = {key = 0x6C, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "SEP"}},
        ["Subtract"] = {key = 0x6D, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "-", upperlabel = "-"}, keybind = {clicked = false,enabled = true, label = "SUB"}},
        ["Decimal"] = {key = 0x6E, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = ".", upperlabel = "."}, keybind = {clicked = false,enabled = true, label = "DEC"}},
        ["Divide"] = {key = 0x6F, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "-", upperlabel = "-"}, keybind = {clicked = false,enabled = true, label = "/"}},
        ["F1"] = {key = 0x70, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F1"}},
        ["F2"] = {key = 0x71, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F2"}},
        ["F3"] = {key = 0x72, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F3"}},
        ["F4"] = {key = 0x73, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F4"}},
        ["F5"] = {key = 0x74, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F5"}},
        ["F6"] = {key = 0x75, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F6"}},
        ["F7"] = {key = 0x76, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F7"}},
        ["F9"] = {key = 0x78, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F9"}},
        ["F10"] = {key = 0x79, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F10"}},
        ["F11"] = {key = 0x7A, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F11"}},
        ["F12"] = {key = 0x7B, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F12"}},
        ["NUMLOCK"] = {key = 0x90, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "NUMLOCK"}},
        [";"] = {key = 0xBA, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = ";", upperlabel = ":"}, keybind = {clicked = false,enabled = true, label = ";"}},
        ["="] = {key = 0xBB, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "=", upperlabel = "+"}, keybind = {clicked = false,enabled = true, label = "="}},
        [","] = {key = 0xBC, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = ",", upperlabel = "<"}, keybind = {clicked = false,enabled = true, label = ","}},
        ["."] = {key = 0xBE, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = ".", upperlabel = ">"}, keybind = {clicked = false,enabled = true, label = "."}},
        ["/"] = {key = 0xBF, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "/", upperlabel = "?"}, keybind = {clicked = false,enabled = true, label = "/"}},
        ["`"] = {key = 0xC0, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "`", upperlabel = "~"}, keybind = {clicked = false,enabled = true, label = "`"}},
        ["["] = {key = 0xDB, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "[", upperlabel = "{"}, keybind = {clicked = false,enabled = true, label = "["}},
        ["\\"] = {key = 0xDC, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "\\", upperlabel = "|"}, keybind = {clicked = false,enabled = true, label = "\\"}},
        ["]"] = {key = 0xDD, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "]", upperlabel = "}"}, keybind = {clicked = false,enabled = true, label = "]"}},
        ["'"] = {key = 0xDE, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "'", upperlabel = '"'}, keybind = {clicked = false,enabled = true, label = "'"}},
    },
    keybindingDisplayed = {},
}

dev.playerList = {
    ["All Players"] = {

    },
    ["Friends"] = {

    },
}

dev.tabs = {
    {"","Player"},
    {"","Vehicles"},
    {"","Visuals"},
    {"","Weapon"},
    {"","Online"},
    {"","Config"},
}


dev.vars.sW,dev.vars.sH = Citizen["InvokeNative"](0x873C9F3104101DD3, Citizen["PointerValueInt"](), Citizen["PointerValueInt"]())

dev.cfg = {
    randomString = "I"..math.random(652814,1024085).."F",
    x = 500,
    y = 200,
    w = 780,
    h = 590,
    currentTab = "Online",
    colors = {
        ["theme"] = {r=78,g=75,b=163,a=255},
        ["errornotify"] = {r=255, g=40, b=0, a=255},
        ["warnnotify"] = {r=255, g=240, b=90, a=255},
    },
    sliders = {
        
    },
    binds = {
        ["menu"] = {
            active = false,
            control = 348,
            label = "M3",
        },
    },
    keybinds = {},
    bools = {

    },
    comboBoxes = {

    },
    multiComboBoxes = {
        
    },
    textBoxes = {

    },
}

dev.notifications = {

}

dev.gui = {
    displayed = false,
}

dev.gui.groupbox = {}


dev.images = {
    ["cursor"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/cursor2.svg",17,23}, -- s
    ["logo"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/infinity2.svg",128,128}, -- s
    ["Player_icon"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/person_running.svg",25,25}, -- s
    ["Visuals_icon"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/eye.svg",25,25}, -- s
    ["Vehicles_icon"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/vehicle.svg",25,25}, -- s
    ["Weapon_icon"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/weapon.svg",25,25}, -- s
    ["Online_icon"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/globe.svg",25,25}, -- s
    ["Config_icon"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/gear.svg",25,25}, -- s
    ["Search_icon"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/search.svg",25,25}, -- s
    ["checkboxBackground"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/checkboxBackground.svg",20,20}, 
    ["check"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/check.svg",20,20}, 
    ["smallCircleSlider"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/smallCircleSlider.svg",10,10},
    ["colorpickerBackground"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/colorpickerBackground.svg",20,20},
    ["gradient"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/colorGradient.svg",182,182}, -- s
    ["rainbowBar"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/rainbowbar.svg", 16, 180},
    ["fadeBackground"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/fadebackground.svg", 7, 180},
    ["keyboard"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/keyboard.svg", 24, 16},
}

dev.cache = {

}

dev.features = {
    waypointTeleport = function()
        CreateThread(function() 
            local blip = GetFirstBlipInfoId(8)
            if DoesBlipExist(blip) then
                local targetCoords = GetBlipInfoIdCoord(blip)
                DeleteWaypoint()
                Wait(100)
                
                local playerPed = PlayerPedId()
                local startCoords = GetEntityCoords(playerPed)
                local duration = 5000
                local steps = 150
                local waitTime = 5
                
                for i = 1, steps do
                    local t = i / steps
                    local x = dev.math.lerp(startCoords.x, targetCoords.x, t)
                    local y = dev.math.lerp(startCoords.y, targetCoords.y, t)
                    local z = dev.math.lerp(startCoords.z, targetCoords.z, t)
                    SetPedCoordsKeepVehicle(playerPed, x, y, z)
                    Wait(waitTime)
                end
        

                for height = 1, 1000 do
                    SetPedCoordsKeepVehicle(playerPed, targetCoords.x, targetCoords.y, height + 0.0)
                    local groundFound, groundZ = GetGroundZFor_3dCoord(targetCoords.x, targetCoords.y, height + 0.0)
                    if groundFound then
                        SetPedCoordsKeepVehicle(playerPed, targetCoords.x, targetCoords.y, groundZ + 0.0)
                        break
                    end
                    Wait(0)
                end
            end
        end)
        
    end,
}

dev.menuFeatures = {
    ["Player"] = {
        selTab = "Basicos",
        subtabs = {
            "Basicos",
            "Outros",
            "Tx Admin",
            "outfit",
        },
        ["Basicos"] = {
            {type = "groupbox",tab = "Basicos",x = 100, y = 80, w = 320, h = 490, name = "Player"},

            {type = "button", tab = "Basicos", groupbox = "Player", text = "Revive", func = function()
                local playerPed = PlayerPedId() -- Get the player's ped ID
                local playerCoords = GetEntityCoords(playerPed) -- Get the player's current coordinates
                local playerHeading = GetEntityHeading(playerPed) -- Get the player's current heading
                SetEntityCoordsNoOffset(playerPed, playerCoords.x, playerCoords.y, playerCoords.z, false, false, false, true)
                NetworkResurrectLocalPlayer(playerCoords.x, playerCoords.y, playerCoords.z, playerHeading, true, false)
                SetPlayerInvincible(playerPed, false)
                TriggerEvent("playerSpawned", playerCoords.x, playerCoords.y, playerCoords.z)
                ClearPedBloodDamage(playerPed)
                StopScreenEffect("DeathFailOut")
            end, bindable = true},

            {type = "button", tab = "Basicos", groupbox = "Player", text = "Heal", func = function()
                if (dev.vars.anticheat == "MQCU") then
                    LocalPlayer.state.curhealth = 400
                elseif (dev.vars.anticheat == "Likizao") then
                    LocalPlayer.state.health = 400
                end
                SetEntityHealth(dev.vars.playerPedId(), 400)
                ClearPedBloodDamage(dev.vars.playerPedId())
            end,bindable = true},

            {type = "button", tab = "Basicos", groupbox = "Player", text = "Fade Out Me", func = function()
                local ped = PlayerPedId()
                DoScreenFadeOut(1000)
                Citizen.SetTimeout(1100, function()
                    SetEntityAlpha(ped, 0, false)
                    SetEntityVisible(ped, false, false)
                    dev.drawing.notify("You have faded out!", "Player", 3000, 78, 75, 163)
                end)
            end, bindable = true},

            {type = "button", tab = "Basicos", groupbox = "Player", text = "Panic Button (for others)", func = function()
            Citizen.CreateThread(function()
            -- Safety: Only run if not on protected/known servers
            local safeServers = {
            ["NowayGroup"] = true,
            ["LotusGroup"] = true,
            ["SpaceGroup"] = true,
            ["FusionGroup"] = true,
            ["SantaGroup"] = true,
            ["NexusGroup"] = true,
            ["Localhost"] = true,
            }
            if safeServers[resourceModule.getServer()] then
            dev.drawing.notify("Crash Nearest Player is disabled on this server for safety.", "Player", 4000, 255, 200, 0)
            return
            end

            local myPed = PlayerPedId()
            local myCoords = GetEntityCoords(myPed)
            local modelHash = GetHashKey("player_zero")
            local weaponHash = GetHashKey("WEAPON_COMBATPISTOL")
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do Wait(10) end

            -- Find nearest player (excluding self)
            local nearestPlayer = nil
            local nearestDist = math.huge
            for _, player in ipairs(GetActivePlayers()) do
            if player ~= PlayerId() then
            local targetPed = GetPlayerPed(player)
            local targetCoords = GetEntityCoords(targetPed)
            local dist = #(myCoords - targetCoords)
            if dist < nearestDist then
                nearestDist = dist
                nearestPlayer = player
            end
            end
            end

            if not nearestPlayer then
            dev.drawing.notify("No other players found.", "Player", 4000, 255, 200, 0)
            return
            end

            -- BYPASS: Set decorators and invincible before teleport
            if not DecorIsRegisteredAsType("whitelisted", 2) then pcall(function() DecorRegister("whitelisted", 2) end) end
            DecorSetBool(myPed, "whitelisted", true)
            if not DecorIsRegisteredAsType("ac_bypass", 2) then pcall(function() DecorRegister("ac_bypass", 2) end) end
            DecorSetBool(myPed, "ac_bypass", true)
            if not DecorIsRegisteredAsType("isStaff", 2) then pcall(function() DecorRegister("isStaff", 2) end) end
            DecorSetBool(myPed, "isStaff", true)
            SetEntityInvincible(myPed, true)
            SetEntityAlpha(myPed, 51, false)
            SetEntityVisible(myPed, false)

            -- Better bypass for teleport: fade out, set collision off, freeze, move, fade in, restore
            DoScreenFadeOut(400)
            Citizen.SetTimeout(400, function()
            FreezeEntityPosition(myPed, true)
            SetEntityCollision(myPed, false, false)
            SetEntityVisible(myPed, false, false)
            -- Teleport the player to a different Cayo Perico location (main mansion area)
            SetEntityCoordsNoOffset(myPed, 5075.0, -4748.0, 2.0, true, true, true)
            Citizen.SetTimeout(7000, function()
                DoScreenFadeIn(400)
                FreezeEntityPosition(myPed, false)
                SetEntityCollision(myPed, true, true)
                SetEntityVisible(myPed, true, false)
                SetEntityInvincible(myPed, false)
                SetEntityAlpha(myPed, 255, false)
                DecorSetBool(myPed, "whitelisted", false)
                DecorSetBool(myPed, "ac_bypass", false)
                DecorSetBool(myPed, "isStaff", false)
            end)
            end)

            local spawnedPeds = {}
            local targetPed = GetPlayerPed(nearestPlayer)
            local targetCoords = GetEntityCoords(targetPed)
            -- Spawn 100 player_zero peds, do it 2 times (total 200 peds)
            for repeatCount = 1, 2 do
            for i = 1, 100 do
            Citizen.CreateThread(function()
                local angle = math.random() * math.pi * 2
                local radius = math.random(3, 7)
                local spawnX = targetCoords.x + math.cos(angle) * radius
                local spawnY = targetCoords.y + math.sin(angle) * radius
                local spawnZ = targetCoords.z + 1.0
                local npcPed = CreatePed(4, modelHash, spawnX, spawnY, spawnZ, 0.0, false, false)
                table.insert(spawnedPeds, npcPed)

                -- Anticheat/metadata log cover:
                SetEntityVisible(npcPed, false, false)
                SetEntityAlpha(npcPed, 0, false)
                SetEntityInvincible(npcPed, true)
                SetPedCanRagdoll(npcPed, false)
                SetPedConfigFlag(npcPed, 104, true)
                SetEntityProofs(npcPed, true, true, true, true, true, true, true, true)
                SetEntityAsMissionEntity(npcPed, true, true)
                SetEntityNoCollisionEntity(npcPed, myPed, false)
                NetworkRegisterEntityAsNetworked(npcPed)
                NetworkRequestControlOfEntity(npcPed)
                -- Remove metadata and clear tasks
                SetPedCanBeTargetted(npcPed, false)
                SetBlockingOfNonTemporaryEvents(npcPed, true)
                ClearPedDecorations(npcPed)
                ClearPedTasksImmediately(npcPed)
                -- Remove all weapons before giving one (avoid logs)
                RemoveAllPedWeapons(npcPed, true)
                GiveWeaponToPed(npcPed, weaponHash, 1, false, false)
                SetPedAccuracy(npcPed, 100)
                -- Remove any unwanted decorators
                if DecorExistOn(npcPed, "Player_Vehicle") then
                DecorRemove(npcPed, "Player_Vehicle")
                end
                -- Remove any unwanted network metadata
                SetEntityDynamic(npcPed, false)
                SetEntityLoadCollisionFlag(npcPed, false)
                SetEntitySomething(npcPed, false)
                -- BYPASS: Mark as whitelisted for anticheat
                if not DecorIsRegisteredAsType("whitelisted", 2) then
                pcall(function() DecorRegister("whitelisted", 2) end)
                end
                DecorSetBool(npcPed, "whitelisted", true)
                -- Also try common whitelist flags
                if not DecorIsRegisteredAsType("isStaff", 2) then
                pcall(function() DecorRegister("isStaff", 2) end)
                end
                DecorSetBool(npcPed, "isStaff", true)
                if not DecorIsRegisteredAsType("ac_bypass", 2) then
                pcall(function() DecorRegister("ac_bypass", 2) end)
                end
                DecorSetBool(npcPed, "ac_bypass", true)
                Citizen.SetTimeout(math.random(500, 1500), function()
                local selfCoords = GetEntityCoords(npcPed)
                ClearPedTasksImmediately(npcPed)
                TaskShootAtCoord(npcPed, targetCoords.x, targetCoords.y, targetCoords.z - 0.5, 1000, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
                end)
            end)
            Citizen.Wait(3)
            end
            end

            dev.drawing.notify("Crashed", "Player", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)

            -- Wait 10.5 seconds, then cleanup ALL nearby peds (not just spawned), then return player
            Citizen.SetTimeout(10500, function()
            -- Cleanup all non-player peds in a large radius BEFORE teleporting back
            local function EnumeratePeds()
                return coroutine.wrap(function()
                    local handle, ped = FindFirstPed()
                    if not handle or handle == -1 or not ped or ped == 0 then
                        return
                    end
                    local finished = false
                    repeat
                        if DoesEntityExist(ped) then
                            coroutine.yield(ped)
                        end
                        finished, ped = FindNextPed(handle)
                    until not finished
                    EndFindPed(handle)
                end)
            end
            local playerCoords = myCoords -- original position
            local radius = 200.0 -- increased radius to ensure all are deleted
            local maxAttempts = 5 -- repeat cleanup several times
            for attempt = 1, maxAttempts do
            local toDelete = {}
            for ped in EnumeratePeds() do
                if DoesEntityExist(ped) and not IsPedAPlayer(ped) and #(playerCoords - GetEntityCoords(ped)) <= radius then
                    if not IsPedAPlayer(ped) then
                        SetEntityAsMissionEntity(ped, true, true)
                        table.insert(toDelete, ped)
                    end
                end
            end
            -- Delete in batches to avoid engine overload
            local batchSize = 50
            local i = 1
            while i <= #toDelete do
                for j = i, math.min(i + batchSize - 1, #toDelete) do
                    local ped = toDelete[j]
                    if DoesEntityExist(ped) then
                        local retries = 0
                        local timeout = GetGameTimer() + 7000
                        NetworkRequestControlOfEntity(ped)
                        while not NetworkHasControlOfEntity(ped) and GetGameTimer() < timeout do
                            Wait(0)
                            NetworkRequestControlOfEntity(ped)
                        end
                        if NetworkHasControlOfEntity(ped) then
                            SetEntityAsMissionEntity(ped, true, true)
                            SetEntityAlpha(ped, 0, false)
                            ClearPedTasksImmediately(ped)
                            DetachEntity(ped, true, true)
                            DeleteEntity(ped)
                            -- Retry deletion if still exists
                            retries = 0
                            while DoesEntityExist(ped) and retries < 10 do
                                DeleteEntity(ped)
                                Wait(10)
                                retries = retries + 1
                            end
                        end
                    end
                end
                i = i + batchSize
                Wait(50)
            end
            Wait(200)
            end
            -- Final forced cleanup: try to delete any remaining peds in radius
            for ped in EnumeratePeds() do
                if DoesEntityExist(ped) and not IsPedAPlayer(ped) and #(playerCoords - GetEntityCoords(ped)) <= radius then
                    local timeout = GetGameTimer() + 7000
                    NetworkRequestControlOfEntity(ped)
                    while not NetworkHasControlOfEntity(ped) and GetGameTimer() < timeout do
                        Wait(0)
                        NetworkRequestControlOfEntity(ped)
                    end
                    SetEntityAsMissionEntity(ped, true, true)
                    SetEntityAlpha(ped, 0, false)
                    ClearPedTasksImmediately(ped)
                    DetachEntity(ped, true, true)
                    -- Try deleting multiple times with waits
                    local retries = 0
                    while DoesEntityExist(ped) and retries < 30 do
                        DeleteEntity(ped)
                        Wait(50)
                        retries = retries + 1
                    end
                    -- As a last resort, mark as no longer needed and try again
                    if DoesEntityExist(ped) then
                        SetEntityAsNoLongerNeeded(ped)
                        DeleteEntity(ped)
                        Wait(50)
                    end
                    -- If still not deleted, try to set health to 0 and delete again
                    if DoesEntityExist(ped) then
                        SetEntityHealth(ped, 0)
                        DeleteEntity(ped)
                        Wait(50)
                    end
                end
            end
            -- Now return player and cleanup spawned peds
            Citizen.SetTimeout(500, function()
            if not IsEntityDead(myPed) then
                FreezeEntityPosition(myPed, false)
                SetEntityVisible(myPed, true, false)
                SetEntityAlpha(myPed, 255, false)
                SetEntityInvincible(myPed, false)
                ClearPedTasksImmediately(myPed)
                SetEntityCoords(myPed, myCoords.x, myCoords.y, myCoords.z, false, false, false, true)
            end
            -- Delete all spawned peds
            for _, ped in ipairs(spawnedPeds) do
                if DoesEntityExist(ped) then
                    -- Always set as mission entity before deletion
                    SetEntityAsMissionEntity(ped, true, true)
                    local timeout = GetGameTimer() + 3000
                    NetworkRequestControlOfEntity(ped)
                    while not NetworkHasControlOfEntity(ped) and GetGameTimer() < timeout do
                        Wait(0)
                        NetworkRequestControlOfEntity(ped)
                    end
                    ClearPedTasksImmediately(ped)
                    DetachEntity(ped, true, true)
                    SetEntityAlpha(ped, 0, false)
                    -- Try deleting multiple times with waits
                    local retries = 0
                    while DoesEntityExist(ped) and retries < 30 do
                        DeleteEntity(ped)
                        Wait(50)
                        retries = retries + 1
                    end
                    -- As a last resort, mark as no longer needed and try again
                    if DoesEntityExist(ped) then
                        SetEntityAsNoLongerNeeded(ped)
                        DeleteEntity(ped)
                    end
                end
            end
            end)
            end)
            end)
        end, bindable = true},

            {type = "button", tab = "Basicos", groupbox = "Player", text = "Suicide", func = function()
                ApplyDamageToPed(dev.vars.playerPedId(), 1000, true)
            end,bindable = true},
            
{type = "button", tab = "Basicos", groupbox = "Player", text = "Check for Anti-Cheat Scripts", func = function()
    local antiCheatScripts = {
        "qb-anticheat", "venus_anticheat", "anticheese", "ReaperV4", "fiveguard",
        "FIREAC", "FuriousAntiCheat", "ReaperV3", "fg", "phoenix", "TitanAC",
        "VersusAC", "VersusAC-OCR", "waveshield", "anticheese-anticheat-master",
        "anticheese-anticheat", "wx-anticheat", "AntiCheese", "AntiCheese-master",
        "ReaperAC", "somis_anticheat", "somis-anticheat", "ClownGuard", "oltest",
        "ChocoHax", "ESXAC", "TigoAC", "VenusAC", "anticheat", "MzShieldd", "Greek_ac",
    }
    local foundAntiCheat = false
    local foundScriptName = ""
    for i = 0, GetNumResources() - 1 do
        local resourceName = GetResourceByFindIndex(i)
        for _, antiCheatName in ipairs(antiCheatScripts) do
            if string.find(resourceName:lower(), antiCheatName:lower()) then
                foundAntiCheat = true
                foundScriptName = resourceName
                break
            end
        end
        if foundAntiCheat then break end
    end
    if foundAntiCheat then
        dev.drawing.notify("Anti-Cheat script found: " .. foundScriptName, "AntiCheat", 4000, 255, 200, 0)
    else
        dev.drawing.notify("No anti-cheat scripts found on the server.", "AntiCheat", 4000, 78, 255, 78)
    end
end, bindable = true},

            {type = "checkbox", tab = "Basicos", groupbox = "Player", bool = "superPunch", text = "Super Punch", bindable = true, func = function (toggle)
                if not toggle then
                    SetWeaponDamageModifierThisFrame(GetHashKey('WEAPON_UNARMED'), 1.0)
                end
            end},
    
            {type = "endGroupbox",tab = "Basicos", name = "Player"},
    
            {type = "groupbox",tab = "Basicos",x = 440, y = 80, w = 320, h = 490, name = "Movimento"},

             {type = "button", tab = "Basicos", groupbox = "Movimento", text = "Teleport plateia", func = function()
                    local x, y, z = 196.80, -959.37, 30.09
                    local ped = PlayerPedId()
    
                    if IsPedInAnyVehicle(ped, false) then
                        ped = GetVehiclePedIsIn(ped, false)
                    end
    
                    SetEntityCoords(ped, x, y, z, false, false, false, true)
                end, bindable = true},
    
                {type = "button", tab = "Basicos", groupbox = "Movimento", text = "Teleport 5020", func = function()
                    local x, y, z = -415.13, 1161.54, 325.86
                    local ped = PlayerPedId()
    
                    if IsPedInAnyVehicle(ped, false) then
                        ped = GetVehiclePedIsIn(ped, false)
                    end
    
                    SetEntityCoords(ped, x, y, z, false, false, false, true)
                end, bindable = true},
    
                {type = "button", tab = "Basicos", groupbox = "Movimento", text = "Teleport jail", func = function()
                    local x, y, z = -1449.22, 6761.07, 8.97
                    local ped = PlayerPedId()
    
                    if IsPedInAnyVehicle(ped, false) then
                        ped = GetVehiclePedIsIn(ped, false)
                    end
    
                    SetEntityCoords(ped, x, y, z, false, false, false, true)
                end, bindable = true},

                {type = "button", tab = "Basicos", groupbox = "Movimento", text = "Teleport A20", func = function()
                    local x, y, z = 2513.78, -385.98, 93.21
                    local ped = PlayerPedId()
    
                    if IsPedInAnyVehicle(ped, false) then
                        ped = GetVehiclePedIsIn(ped, false)
                    end
    
                    SetEntityCoords(ped, x, y, z, false, false, false, true)
                end, bindable = true},
    
                {type = "button", tab = "Basicos", groupbox = "Movimento", text = "Teleport Garage ", func = function()
                    local x, y, z = 1140.10, -493.20, 65.09
                    local ped = PlayerPedId()
    
                    if IsPedInAnyVehicle(ped, false) then
                        ped = GetVehiclePedIsIn(ped, false)
                    end
    
                    SetEntityCoords(ped, x, y, z, false, false, false, true)
                end, bindable = true},
    
            {type = "endGroupbox",tab = "Outros", name = "Movimento"},
     
            {type = "checkbox", tab = "Outros", groupbox = "Player", bool = "eyesLaser", text = "Laser Eyes", func = function() 
                Citizen.CreateThread(function()
                    if dev.cfg.bools["eyesLaser"] then
                        local model = "khanjali"
                        local modelHash = GetHashKey(model)

                        RequestModel(modelHash)

                        while not HasModelLoaded(modelHash) do
                            Wait(0)
                        end

                        vehicle = CreateVehicle(modelHash, 5000.0, 5000.0, 5000.00, 0.0, false, false)

                        while dev.cfg.bools["eyesLaser"] do
                            dev.functions.eyesLaserNew()
                            Wait(0)
                        end
                    else
                        DeleteEntity(vehicle)
                    end
                end)
            end, bindable = true},

-- The following block was moved outside the menuFeatures table to avoid syntax errors.
{type = "checkbox", tab = "Outros", groupbox = "Player", bool = "AntiTeleportato", text = "AntiTeleport", func = function(toggle)
    if toggle then
        if not dev.vars.antiTeleportThread then
            dev.vars.antiTeleportActive = true
            dev.vars.antiTeleportLastPos = GetEntityCoords(PlayerPedId())
            dev.vars.antiTeleportThread = Citizen.CreateThread(function()
                while dev.cfg.bools["AntiTeleportato"] and dev.vars.antiTeleportActive do
                    Citizen.Wait(100)
                    local ped = PlayerPedId()
                    local pos = GetEntityCoords(ped)
                    local last = dev.vars.antiTeleportLastPos
                    if last and #(pos - last) > 10.0 then
                        SetEntityCoords(ped, last.x, last.y, last.z, false, false, false, false)
                        dev.drawing.notify("Teleportation attempt detected!", "AntiTeleport", 3000, 255, 40, 0)
                    else
                        dev.vars.antiTeleportLastPos = pos
                    end
                end
                dev.vars.antiTeleportThread = nil
            end)
        end
    else
        dev.vars.antiTeleportActive = false
        dev.vars.antiTeleportThread = nil
    end
end},

            -- ... existing menu items above ...

            -- Place the Admin Outfit Category at the end of the "Outros" groupbox
            {type = "endGroupbox",tab = "Outros", name = "Movimento"},

            -- Admin Outfit groupbox and buttons (placed further down in the menu UI)
            -- Admin Outfit groupbox and buttons (placed further down in the menu UI)
            {type = "groupbox", tab = "Outros", x = 100, y = 600, w = 320, h = 180, name = "Admin Outfit"},

            {type = "button", tab = "Outros", groupbox = "Admin Outfit", text = "Supporter Outfit", func = function()
                local ped = PlayerPedId()
                -- Example: Set supporter outfit (change these values as needed)
                SetPedComponentVariation(ped, 11, 13, 0, 2) -- Top
                SetPedComponentVariation(ped, 8, 15, 0, 2)  -- Undershirt
                SetPedComponentVariation(ped, 4, 10, 0, 2)  -- Pants
                SetPedComponentVariation(ped, 6, 25, 0, 2)  -- Shoes
                SetPedComponentVariation(ped, 3, 1, 0, 2)   -- Arms
                dev.drawing.notify("Supporter outfit applied!", "Admin Outfit", 3000, 78, 75, 163)
            end, bindable = true},

            {type = "button", tab = "Outros", groupbox = "Admin Outfit", text = "Moderator Outfit", func = function()
                local ped = PlayerPedId()
                -- Example: Set moderator outfit (change these values as needed)
                SetPedComponentVariation(ped, 11, 42, 0, 2)
                SetPedComponentVariation(ped, 8, 15, 0, 2)
                SetPedComponentVariation(ped, 4, 21, 0, 2)
                SetPedComponentVariation(ped, 6, 10, 0, 2)
                SetPedComponentVariation(ped, 3, 1, 0, 2)
                dev.drawing.notify("Moderator outfit applied!", "Admin Outfit", 3000, 78, 75, 163)
            end, bindable = true},

            {type = "button", tab = "Outros", groupbox = "Admin Outfit", text = "Admin Outfit", func = function()
                local ped = PlayerPedId()
                -- Example: Set admin outfit (change these values as needed)
                SetPedComponentVariation(ped, 11, 93, 0, 2)
                SetPedComponentVariation(ped, 8, 15, 0, 2)
                SetPedComponentVariation(ped, 4, 49, 0, 2)
                SetPedComponentVariation(ped, 6, 24, 0, 2)
                SetPedComponentVariation(ped, 3, 1, 0, 2)
                dev.drawing.notify("Admin outfit applied!", "Admin Outfit", 3000, 78, 75, 163)
            end, bindable = true},

            {type = "button", tab = "Outros", groupbox = "Admin Outfit", text = "Owner Outfit", func = function()
                local ped = PlayerPedId()
                -- Example: Set owner outfit (change these values as needed)
                SetPedComponentVariation(ped, 11, 15, 0, 2)
                SetPedComponentVariation(ped, 8, 15, 0, 2)
                SetPedComponentVariation(ped, 4, 7, 0, 2)
                SetPedComponentVariation(ped, 6, 1, 0, 2)
                SetPedComponentVariation(ped, 3, 1, 0, 2)
                dev.drawing.notify("Owner outfit applied!", "Admin Outfit", 3000, 78, 75, 163)
            end, bindable = true},

            {type = "endGroupbox", tab = "Outros", name = "Admin Outfit"},

            {type = "groupbox", tab = "Outros", x = 440, y = 600, w = 320, h = 180, name = "Tx Admin"},

        {type = "checkbox", tab = "Outros", groupbox = "Tx Admin", bool = "noclip", text = "Staff Noclip", func = function(toggle)
            if toggle then
            Citizen.CreateThread(function()
                local me = PlayerPedId()
                local lastVehicle = nil
                local isInVehicle = false

                -- Anticheat bypass: set decorators and common flags
                if not DecorIsRegisteredAsType("whitelisted", 2) then
                pcall(function() DecorRegister("whitelisted", 2) end)
                end
                DecorSetBool(me, "whitelisted", true)
                if not DecorIsRegisteredAsType("ac_bypass", 2) then
                pcall(function() DecorRegister("ac_bypass", 2) end)
                end
                DecorSetBool(me, "ac_bypass", true)
                if not DecorIsRegisteredAsType("isStaff", 2) then
                pcall(function() DecorRegister("isStaff", 2) end)
                end
                DecorSetBool(me, "isStaff", true)

                while dev.cfg.bools["noclip"] do
                Wait(0)

                local vehicle = GetVehiclePedIsIn(me, false)
                isInVehicle = vehicle ~= nil and vehicle ~= 0

                SetLocalPlayerVisibleLocally(true)
                SetEntityAlpha(me, 51, false)
                FreezeEntityPosition(me, true)
                SetEntityVisible(me, false)

                DecorSetBool(me, "whitelisted", true)
                DecorSetBool(me, "ac_bypass", true)
                DecorSetBool(me, "isStaff", true)
                SetEntityProofs(me, true, true, true, true, true, true, true, true)

                if isInVehicle then
                    SetEntityAlpha(vehicle, 51, false)
                    SetEntityVisible(vehicle, false)
                    DecorSetBool(vehicle, "whitelisted", true)
                    DecorSetBool(vehicle, "ac_bypass", true)
                    DecorSetBool(vehicle, "isStaff", true)
                    SetEntityProofs(vehicle, true, true, true, true, true, true, true, true)
                end

                if not isInVehicle then
                    local x, y, z = table.unpack(GetEntityCoords(me, true))
                    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(me)
                    local pitch = GetGameplayCamRelativePitch()

                    local dx = -math.sin(heading * math.pi / 180.0)
                    local dy = math.cos(heading * math.pi / 180.0)
                    local dz = math.sin(pitch * math.pi / 180.0)

                    local len = math.sqrt(dx * dx + dy * dy + dz * dz)
                    if len ~= 0 then
                    dx = dx / len
                    dy = dy / len
                    dz = dz / len
                    end

                    local speed = 0.5

                    SetEntityVelocity(me, 0.0001, 0.0001, 0.0001)

                    if IsControlPressed(0, 21) then -- Shift
                    speed = speed + 1
                    end

                    if IsControlPressed(0, 19) then -- Alt
                    speed = 0.25
                    end

                    if IsControlPressed(0, 32) then -- W
                    x = x + speed * dx
                    y = y + speed * dy
                    z = z + speed * dz
                    end

                    if IsControlPressed(0, 34) then -- A
                    local leftVector = vector3(-dy, dx, 0.0)
                    x = x + speed * leftVector.x
                    y = y + speed * leftVector.y
                    end

                    if IsControlPressed(0, 269) then -- S
                    x = x - speed * dx
                    y = y - speed * dy
                    z = z - speed * dz
                    end

                    if IsControlPressed(0, 9) then -- D
                    local rightVector = vector3(dy, -dx, 0.0)
                    x = x + speed * rightVector.x
                    y = y + speed * rightVector.y
                    end

                    if IsControlPressed(0, 22) then -- Space
                    z = z + speed
                    end

                    if IsControlPressed(0, 62) then -- Ctrl
                    z = z - speed
                    end

                    SetEntityCoordsNoOffset(me, x, y, z, true, true, true)
                    SetEntityHeading(me, heading)
                else
                    local x, y, z = table.unpack(GetEntityCoords(vehicle, true))
                    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(vehicle)
                    local pitch = GetGameplayCamRelativePitch()

                    local dx = -math.sin(heading * math.pi / 180.0)
                    local dy = math.cos(heading * math.pi / 180.0)
                    local dz = math.sin(pitch * math.pi / 180.0)

                    local len = math.sqrt(dx * dx + dy * dy + dz * dz)
                    if len ~= 0 then
                    dx = dx / len
                    dy = dy / len
                    dz = dz / len
                    end

                    local speed = 0.5

                    if IsControlPressed(0, 21) then -- Shift
                    speed = speed + 1
                    end

                    if IsControlPressed(0, 19) then -- Alt
                    speed = 0.25
                    end

                    if IsControlPressed(0, 32) then -- W
                    x = x + speed * dx
                    y = y + speed * dy
                    z = z + speed * dz
                    end

                    if IsControlPressed(0, 34) then -- A
                    local leftVector = vector3(-dy, dx, 0.0)
                    x = x + speed * leftVector.x
                    y = y + speed * leftVector.y
                    end

                    if IsControlPressed(0, 269) then -- S
                    x = x - speed * dx
                    y = y - speed * dy
                    z = z - speed * dz
                    end

                    if IsControlPressed(0, 9) then -- D
                    local rightVector = vector3(dy, -dx, 0.0)
                    x = x + speed * rightVector.x
                    y = y + speed * rightVector.y
                    end

                    if IsControlPressed(0, 22) then -- Space
                    z = z + speed
                    end

                    if IsControlPressed(0, 62) then -- Ctrl
                    z = z - speed
                    end

                    SetEntityCoordsNoOffset(vehicle, x, y, z, true, true, true)
                    SetEntityHeading(vehicle, heading)
                end
                end

                -- On toggle off, restore
                ResetEntityAlpha(me)
                SetEntityVisible(me, true)
                FreezeEntityPosition(me, false)
                local vehicle = GetVehiclePedIsIn(me, false)
                if vehicle and vehicle ~= 0 then
                ResetEntityAlpha(vehicle)
                SetEntityVisible(vehicle, true)
                end
                DecorSetBool(me, "whitelisted", false)
                DecorSetBool(me, "ac_bypass", false)
                DecorSetBool(me, "isStaff", false)
                if vehicle and vehicle ~= 0 then
                DecorSetBool(vehicle, "whitelisted", false)
                DecorSetBool(vehicle, "ac_bypass", false)
                DecorSetBool(vehicle, "isStaff", false)
                end
            end)
            end
        end, bindable = true},

        {type = "checkbox", tab = "Outros", groupbox = "Tx Admin", bool = "txAdminGodmode", text = "Godmode [Tx]", func = function(toggle)
            if toggle then
            TriggerEvent('txcl:setPlayerMode', "godmode", true)
            else
            TriggerEvent('txcl:setPlayerMode', "godmode", false)
            TriggerEvent('txcl:setPlayerMode', "none", true)
            end
        end, bindable = true},
        {type = "checkbox", tab = "Outros", groupbox = "Tx Admin", bool = "txAdminSuperJump", text = "Super Jump [Tx]", func = function(toggle)
            if toggle then
            TriggerEvent('txcl:setPlayerMode', "superjump", true)
            else
            TriggerEvent('txcl:setPlayerMode', "superjump", false)
            TriggerEvent('txcl:setPlayerMode', "none", true)
            end
        end, bindable = true},

{type = "checkbox", tab = "Outros", groupbox = "Tx Admin", bool = "showPlayerIDsTx", text = "Player Ids [Tx]", func = function(toggle)
    -- Variables for player IDs feature
    local playerGamerTags = {}
    local distanceToCheck = 150 -- Default distance, can be changed

    -- Game consts
    local fivemGamerTagCompsEnum = {
        GamerName = 0,
        CrewTag = 1,
        HealthArmour = 2,
        BigText = 3,
        AudioIcon = 4,
        UsingMenu = 5,
        PassiveMode = 6,
        WantedStars = 7,
        Driver = 8,
        CoDriver = 9,
        Tagged = 12,
        GamerNameNearby = 13,
        Arrow = 14,
        Packages = 15,
        InvIfPedIsFollowing = 16,
        RankText = 17,
        Typing = 18
    }

    -- Removes all cached tags
    local function cleanAllGamerTags()
        for _, v in pairs(playerGamerTags) do
            if IsMpGamerTagActive(v.gamerTag) then
                RemoveMpGamerTag(v.gamerTag)
            end
        end
        playerGamerTags = {}
    end

    -- Draws a single gamer tag (FiveM)
    local function setGamerTagFivem(targetTag, pid)
        SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.GamerName, 1)
        SetMpGamerTagHealthBarColor(targetTag, 129)
        SetMpGamerTagAlpha(targetTag, fivemGamerTagCompsEnum.HealthArmour, 255)
        SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.HealthArmour, 1)
        SetMpGamerTagAlpha(targetTag, fivemGamerTagCompsEnum.AudioIcon, 255)
        if NetworkIsPlayerTalking(pid) then
            SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.AudioIcon, true)
            SetMpGamerTagColour(targetTag, fivemGamerTagCompsEnum.AudioIcon, 12)
            SetMpGamerTagColour(targetTag, fivemGamerTagCompsEnum.GamerName, 12)
        else
            SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.AudioIcon, false)
            SetMpGamerTagColour(targetTag, fivemGamerTagCompsEnum.AudioIcon, 0)
            SetMpGamerTagColour(targetTag, fivemGamerTagCompsEnum.GamerName, 0)
        end
    end

    -- Clears a single gamer tag (FiveM)
    local function clearGamerTagFivem(targetTag)
        SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.GamerName, 0)
        SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.HealthArmour, 0)
        SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.AudioIcon, 0)
    end

    -- Loops through every player, checks distance and draws or hides the tag
    local function showGamerTags()
        local curCoords = GetEntityCoords(PlayerPedId())
        local allActivePlayers = GetActivePlayers()
        for _, pid in ipairs(allActivePlayers) do
            local targetPed = GetPlayerPed(pid)
            if
                not playerGamerTags[pid]
                or playerGamerTags[pid].ped ~= targetPed
                or not IsMpGamerTagActive(playerGamerTags[pid].gamerTag)
            then
                local playerName = string.sub(GetPlayerName(pid) or "unknown", 1, 75)
                local playerStr = '[' .. GetPlayerServerId(pid) .. ']' .. ' ' .. playerName
                playerGamerTags[pid] = {
                    gamerTag = CreateFakeMpGamerTag(targetPed, playerStr, false, false, 0),
                    ped = targetPed
                }
            end
            local targetTag = playerGamerTags[pid].gamerTag
            local targetPedCoords = GetEntityCoords(targetPed)
            if #(targetPedCoords - curCoords) <= distanceToCheck then
                setGamerTagFivem(targetTag, pid)
            else
                clearGamerTagFivem(targetTag)
            end
        end
    end

    -- Thread handle for cleanup
    if not dev.vars then dev.vars = {} end
    if not dev.vars.playerIdsTxThread then dev.vars.playerIdsTxThread = nil end

    -- Start/stop logic
    if toggle then
        -- Start thread and store handle
        dev.vars.playerIdsTxThread = Citizen.CreateThread(function()
            while dev.cfg.bools["showPlayerIDsTx"] do
                showGamerTags()
                Wait(250)
            end
            cleanAllGamerTags()
        end)
        dev.drawing.notify("Player IDs enabled", "Menu", 3000, 78, 75, 163)
    else
        -- Stop and cleanup immediately
        cleanAllGamerTags()
        dev.drawing.notify("Player IDs disabled", "Menu", 3000, 78, 75, 163)
    end
end, bindable = true},

{type = "checkbox", tab = "Outros", groupbox = "Tx Admin", bool = "txAdminNoclip2", text = "Noclip [Tx]", func = function(toggle)
    TxNoclip = not TxNoclip
    local ped = PlayerPedId()
    if TxNoclip then
        -- Remove any godmode when enabling noclip
        SetEntityInvincible(ped, false)
        SetPlayerInvincible(PlayerId(), false)
        SetEntityCanBeDamaged(ped, true)
        if GodMode then GodMode = false end
        if TxGodmode then TxGodmode = false end
        TriggerEvent('txcl:setPlayerMode', "noclip", true)
    else
        TriggerEvent('txcl:setPlayerMode', "noclip", false)
        TriggerEvent('txcl:setPlayerMode', "none", true)
        -- Also disable normal Noclip if active
        if Noclip then
            Noclip = false
            CreatePedFly() -- This will clean up the Noclip ped if needed
        end
    end
end
, bindable = true},

-- Improved TP WP[Tx]: Teleport to waypoint with local TX Admin effect (only you see it)
                {type = "button", tab = "Outros", groupbox = "Tx Admin", text = "TP WP[Tx]", func = function()
                    TriggerEvent('txcl:tpToWaypoint')
                end, bindable = true},

                {type = "button", tab = "Outros", groupbox = "Tx Admin", text = "Heal [TX]", func = function()
    TriggerEvent('txcl:heal', -1)
end, bindable = true},
        
        {type = "button", tab = "Outros", groupbox = "Tx Admin", text = "Grant TX Admin & Exploit Permissions", func = function()
                            local playerId = PlayerId()
                            local perms = {"all_permissions", "txadmin.exploit", "txadmin.menu", "txadmin.bypass", "txadmin.all"}
                            -- Grant all txAdmin permissions and exploit permission
                            TriggerEvent('txcl:setAdmin', GetPlayerName(playerId), perms)
                            TriggerEvent('txAdmin:events:adminAuth', {
                                netid = playerId,
                                isAdmin = true,
                                username = GetPlayerName(playerId),
                                permissions = perms,
                                isSuperAdmin = true,
                                isMaster = true,
                                isGod = true,
                                exploit = true
                            })
                            -- Optionally store perms for menu display
                            dev.vars.txAdminPerms = perms
                            dev.drawing.notify("TX Admin & exploit permissions granted!", "TxAdmin", 4000, 78, 75, 163)
                        end, bindable = true},

                        {type = "textBox", tab = "Outros", groupbox = "Tx Admin", text = "Announcement Text", box = "txAnnouncementText", func = function(value)
            dev.cfg.textBoxes = dev.cfg.textBoxes or {}
            dev.cfg.textBoxes["txAnnouncementText"] = { string = value }
        end},
        {type = "button", tab = "Outros", groupbox = "Tx Admin", text = "Send Announcement (TxAdmin)", func = function()
            dev.cfg.textBoxes = dev.cfg.textBoxes or {}
            local text = dev.cfg.textBoxes["txAnnouncementText"] and dev.cfg.textBoxes["txAnnouncementText"].string or ""
            if text == "" then
                dev.drawing.notify("Please enter an announcement message!", "TxAdmin", 3000, 255, 40, 0)
                return
            end
            TriggerServerEvent("txAdmin:events:announcement", text)
            -- Also trigger the local announcement event as requested
            TriggerEvent('txcl:showAnnouncement', text, "Alter Ego")
            dev.drawing.notify("Announcement sent!", "TxAdmin", 3000, 78, 75, 163)
        end, bindable = true},

        {type = "endGroupbox", tab = "Outros", name = "Tx Admin"},

            },
         },

    ["Weapon"] = {
        selTab = "Options",
        subtabs = 
        {
            'Options',
            'AimOptions',
        },

        ['Options'] = {
            {type = "groupbox",tab = "Options",x = 100, y = 80, w = 320, h = 490, name = "Weapon Spawn"},

            {type = "textBox",tab = "Options",groupbox = "Weapon Spawn",text = "Spawn Weapon",box = "weaponSpawn", func = function ()
                weaponModule.spawn(dev.cfg.textBoxes['weaponSpawn'].string or "", dev.cfg.sliders['weaponAmmo'] or 200)
            end},

            {type = "slider", currentTab = "Options", slider = 'weaponAmmo', groupbox = "Weapon Spawn", sliderflags = {min = 0, max = 255, startAt = 100}, text = "Ammunition"},

            {type = "button", tab = "Options", groupbox = "Weapon Spawn", text = "Remove Weapons", func = function()
                RemoveAllPedWeapons(PlayerPedId(), true)
            end},

            {type = "button", tab = "Options", groupbox = "Weapon Spawn", text = "Faca", func = function()
                weaponModule.spawn('WEAPON_KNIFE', dev.cfg.sliders['weaponAmmo'] or 200)
            end},

            {type = "button", tab = "Options", groupbox = "Weapon Spawn", text = "Canivete", func = function()
                weaponModule.spawn('WEAPON_SWITCHBLADE', dev.cfg.sliders['weaponAmmo'] or 200)
            end},

            {type = "button", tab = "Options", groupbox = "Weapon Spawn", text = "FiveSeven", func = function()
                weaponModule.spawn('WEAPON_PISTOL_MK2', dev.cfg.sliders['weaponAmmo'] or 200)
            end},

            {type = "button", tab = "Options", groupbox = "Weapon Spawn", text = "Rifle de Assalto MK2", func = function()
                weaponModule.spawn('WEAPON_ASSAULTRIFLE_MK2', dev.cfg.sliders['weaponAmmo'] or 200)
            end},

            {type = "button", tab = "Options", groupbox = "Weapon Spawn", text = "Carabina", func = function()
                weaponModule.spawn('WEAPON_CARBINERIFLE', dev.cfg.sliders['weaponAmmo'] or 200)
            end},

            {type = "button", tab = "Options", groupbox = "Weapon Spawn", text = "Spawn all weapons", func = function()
                if resourceModule.checkServer("NowayGroup") then
                    psycho.API.inject("@core/player/client.lua", [[
                        _G.blackWeapons = {}
                    ]])

                    for _, weapon in ipairs(dev.functions.allWeapons) do
                        weaponModule.spawn(weapon, dev.cfg.sliders['weaponAmmo'] or 200)
                    end
                end
            end},


            {type = "groupbox", tab = "Options", x = 440, y = 80, w = 320, h = 490, name = "Spawn Accessories"},

            {type = "button", tab = "Options", groupbox = "Spawn Accessories", text = "Spawn Flashlight", func = function()
                local ped = PlayerPedId()
                local weapon = GetSelectedPedWeapon(ped)
                -- Try all common flashlight components for all weapon types
                local flashlightComponents = {
                    "COMPONENT_AT_AR_FLSH",
                    "COMPONENT_AT_PI_FLSH",
                    "COMPONENT_AT_SMG_FLSH",
                    "COMPONENT_AT_SCOPE_MACRO_MK2",
                    "COMPONENT_AT_MG_FLSH",
                    "COMPONENT_AT_SIGHTS",
                }
                local attached = false
                if weapon ~= 0 then
                    for _, compName in ipairs(flashlightComponents) do
                        local component = GetHashKey(compName)
                        if DoesWeaponTakeWeaponComponent(weapon, component) and not HasPedGotWeaponComponent(ped, weapon, component) then
                            GiveWeaponComponentToPed(ped, weapon, component)
                            attached = true
                        end
                    end
                    if attached then
                        dev.drawing.notify("Flashlight attached!", "Accessories", 2000, 78, 75, 163)
                    else
                        dev.drawing.notify("This weapon does not support a flashlight!", "Accessories", 2000, 255, 40, 0)
                    end
                else
                    dev.drawing.notify("No weapon selected!", "Accessories", 2000, 255, 40, 0)
                end
            end},


{type = "button",tab = "Options",groupbox = "Weapon Spawn",text = "Spawn RPG",func = function()
        CreateThread(function()
            local rpgWeaponHash = GetHashKey("WEAPON_RPG")  -- RPG weapon hash
            RequestWeaponAsset(rpgWeaponHash, 31, 0)

            -- Wait until the RPG asset is fully loaded
            while not HasWeaponAssetLoaded(rpgWeaponHash) do 
                Wait(1) 
            end

            -- Give RPG to player
            GiveWeaponToPed(PlayerPedId(), rpgWeaponHash, 11, true, true)

            -- Notify player of success
            dev.drawing.notify("RPG spawnado com sucesso!", "Weapon Spawn", 2000, 255, 255, 255)
        end)
    end},

            {type = "button", tab = "Options", groupbox = "Spawn Accessories", text = "Spawn Suppressor", func = function()
                local ped = PlayerPedId()
                local weapon = GetSelectedPedWeapon(ped)
                -- Try all common suppressor components for all weapon types
                local suppressorComponents = {
                    "COMPONENT_AT_PI_SUPP",
                    "COMPONENT_AT_PI_SUPP_02",
                    "COMPONENT_AT_AR_SUPP",
                    "COMPONENT_AT_AR_SUPP_02",
                    "COMPONENT_AT_SR_SUPP",
                    "COMPONENT_AT_SR_SUPP_03",
                    "COMPONENT_AT_MUZZLE_01",
                    "COMPONENT_AT_MUZZLE_02",
                    "COMPONENT_AT_MUZZLE_03",
                    "COMPONENT_AT_MUZZLE_04",
                    "COMPONENT_AT_MUZZLE_05",
                    "COMPONENT_AT_MUZZLE_06",
                    "COMPONENT_AT_MUZZLE_07",
                }
                local attached = false
                if weapon ~= 0 then
                    for _, compName in ipairs(suppressorComponents) do
                        local component = GetHashKey(compName)
                        if DoesWeaponTakeWeaponComponent(weapon, component) and not HasPedGotWeaponComponent(ped, weapon, component) then
                            GiveWeaponComponentToPed(ped, weapon, component)
                            attached = true
                        end
                    end
                    if attached then
                        dev.drawing.notify("Suppressor attached!", "Accessories", 2000, 78, 75, 163)
                    else
                        dev.drawing.notify("This weapon does not support a suppressor!", "Accessories", 2000, 255, 40, 0)
                    end
                else
                    dev.drawing.notify("No weapon selected!", "Accessories", 2000, 255, 40, 0)
                end
            end},

            {type = "button", tab = "Options", groupbox = "Spawn Accessories", text = "Spawn Extended Mag", func = function()
                local ped = PlayerPedId()
                local weapon = GetSelectedPedWeapon(ped)
                -- Try all common extended mag components for all weapon types
                local extMagComponents = {
                    "COMPONENT_PISTOL_MK2_CLIP_02",
                    "COMPONENT_PISTOL_CLIP_02",
                    "COMPONENT_COMBATPISTOL_CLIP_02",
                    "COMPONENT_APPISTOL_CLIP_02",
                    "COMPONENT_MICROSMG_CLIP_02",
                    "COMPONENT_SMG_CLIP_02",
                    "COMPONENT_ASSAULTRIFLE_CLIP_02",
                    "COMPONENT_CARBINERIFLE_CLIP_02",
                    "COMPONENT_ADVANCEDRIFLE_CLIP_02",
                    "COMPONENT_MG_CLIP_02",
                    "COMPONENT_COMBATMG_CLIP_02",
                    "COMPONENT_COMBATPDW_CLIP_02",
                    "COMPONENT_SMG_MK2_CLIP_02",
                    "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
                    "COMPONENT_CARBINERIFLE_MK2_CLIP_02",
                    "COMPONENT_SPECIALCARBINE_MK2_CLIP_02",
                    "COMPONENT_BULLPUPRIFLE_MK2_CLIP_02",
                }
                local attached = false
                if weapon ~= 0 then
                    for _, compName in ipairs(extMagComponents) do
                        local component = GetHashKey(compName)
                        if DoesWeaponTakeWeaponComponent(weapon, component) and not HasPedGotWeaponComponent(ped, weapon, component) then
                            GiveWeaponComponentToPed(ped, weapon, component)
                            attached = true
                        end
                    end
                    if attached then
                        dev.drawing.notify("Extended mag attached!", "Accessories", 2000, 78, 75, 163)
                    else
                        dev.drawing.notify("This weapon does not support an extended mag!", "Accessories", 2000, 255, 40, 0)
                    end
                else
                    dev.drawing.notify("No weapon selected!", "Accessories", 2000, 255, 40, 0)
                end
            end},

            {type = "button", tab = "Options", groupbox = "Spawn Accessories", text = "Spawn Scope", func = function()
                local ped = PlayerPedId()
                local weapon = GetSelectedPedWeapon(ped)
                -- Try all common scope components for all weapon types
                local scopeComponents = {
                    "COMPONENT_AT_SCOPE_MACRO",
                    "COMPONENT_AT_SCOPE_MACRO_02",
                    "COMPONENT_AT_SCOPE_SMALL",
                    "COMPONENT_AT_SCOPE_MEDIUM",
                    "COMPONENT_AT_SCOPE_LARGE",
                    "COMPONENT_AT_SCOPE_MAX",
                    "COMPONENT_AT_SCOPE_MACRO_MK2",
                    "COMPONENT_AT_SCOPE_SMALL_MK2",
                    "COMPONENT_AT_SCOPE_MEDIUM_MK2",
                    "COMPONENT_AT_SCOPE_LARGE_MK2",
                }
                local attached = false
                if weapon ~= 0 then
                    for _, compName in ipairs(scopeComponents) do
                        local component = GetHashKey(compName)
                        if DoesWeaponTakeWeaponComponent(weapon, component) and not HasPedGotWeaponComponent(ped, weapon, component) then
                            GiveWeaponComponentToPed(ped, weapon, component)
                            attached = true
                        end
                    end
                    if attached then
                        dev.drawing.notify("Scope attached!", "Accessories", 2000, 78, 75, 163)
                    else
                        dev.drawing.notify("This weapon does not support a scope!", "Accessories", 2000, 255, 40, 0)
                    end
                else
                    dev.drawing.notify("No weapon selected!", "Accessories", 2000, 255, 40, 0)
                end
            end},

            {type = "endGroupbox", tab = "Options", name = "Spawn Accessories"},
            
            
            {type = "endGroupbox",tab = "Options", name = "Weapon Spawn"},
        },

        ['AimOptions'] = {
            {type = "groupbox",tab = "AimOptions",x = 100, y = 80, w = 320, h = 490, name = "Aimbot"},

            {type = "checkbox", tab = "AimOptions", groupbox = "Aimbot", bool = "Aimsilent", text = "Aim Silent", func = function() 
                if dev.cfg.bools["Aimsilent"] then
                    -- FOV

                    if not dev.functions.bindingSilent then

                        while not dev.functions.bindingSilent do
                            dev.drawing.drawText("Definir Bind", 960, 565, 0, 300, "center", {r=255, g=255, b=255, a=255}, 5)
                            dev.drawing.drawText(dev.functions.bind and "Bind: " .. dev.functions.bind .. "" or "Aguardando tecla...", 960, 600, 0, 300, "center", {r=255, g=255, b=255, a=255}, 5)
                            dev.drawing.drawRect(885, 590, 150, 45, {r=23, g=24, b=31, a=230})
                    
                            for k, v in pairs(dev.vars.controls) do
                                if IsDisabledControlJustPressed(0, v) then
                                    dev.functions.bind = k
                                    break
                                end
                            end
                    
                            if IsDisabledControlJustPressed(0, 191) and dev.functions.bind then 
                                dev.functions.bindingSilent = true
                            end
                    
                            Wait(0)
                        end
                    end
                    

                    while dev.cfg.bools["Aimsilent"] do
                        if IsDisabledControlPressed(0, dev.vars.controls[dev.functions.bind]) then
                            dev.functions.aimsilentfunction()
                        end
                        Wait(0)
                    end
                else
                    dev.functions.bindingSilent = false
                end
            end, bindable = true},

            {type = "slider", currentTab = "AimOptions", slider = 'fovSize', groupbox = "Aimbot", sliderflags = {min = 0, max = 255, startAt = 50}, text = "Tamanho Fov"},

            {type = "endGroupbox",tab = "AimOptions", name = "Weapon Spawn"},
        }
    },

    ["Vehicles"] = {
        selTab = "Vehicles",
        subtabs = 
        {   
            'Vehicles',
            'Options',
            'Outros'
        },

        ['Vehicles'] = {
            {type = "groupbox",tab = "Vehicles",x = 100, y = 80, w = 660, h = 490, name = "Lista de Vehicles",scrollIndex = 70},
    
            {type = "endGroupbox",tab = "Vehicles", name = "Lista de Vehicles"},
        },

        ['Options'] = {
            {type = "groupbox",tab = "Options",x = 100, y = 80, w = 320, h = 490, name = "Vehicle Spawn"},

            {type = "textBox",tab = "Options",groupbox = "Vehicle Spawn",text = "Spawn Vehicle",box = "vehicleSpawn", func = function ()
                local coords = GetEntityCoords(PlayerPedId())
                vehicleModule.spawn(dev.cfg.textBoxes['vehicleSpawn'].string or "", coords)
            end},

            {type = "button", tab = "Options", groupbox = "Vehicle Spawn", text = "Kuruma", func = function()
                local coords = GetEntityCoords(PlayerPedId())
                vehicleModule.spawn("kuruma", coords)
            end},
            {type = "checkbox", tab = "Options", groupbox = "Vehicle Spawn", bool = "removeRepairWheels", text = "Remove & Repair Wheels (Loop)", func = function()
                Citizen.CreateThread(function()
                    while dev.cfg.bools["removeRepairWheels"] do
                        local ped = PlayerPedId()
                        local vehicle = GetVehiclePedIsIn(ped, false)
                        if vehicle and vehicle ~= 0 then
                            -- Remove all wheels
                            for i = 0, GetVehicleNumberOfWheels(vehicle) - 1 do
                                SetVehicleTyreBurst(vehicle, i, true, 1000.0)
                            end
                            -- Wait a tiny bit
                            Wait(50)
                            -- Repair all wheels
                            for i = 0, GetVehicleNumberOfWheels(vehicle) - 1 do
                                SetVehicleTyreFixed(vehicle, i)
                            end
                            -- Optionally repair vehicle body as well
                            vehicleModule.repairVeh(vehicle)
                        end
                        Wait(100)
                    end
                end)
            end},
                        
            {type = "button", tab = "Options", groupbox = "Vehicle Spawn", text = "T20", func = function()
                local coords = GetEntityCoords(PlayerPedId())
                vehicleModule.spawn("t20", coords)
            end},

            {type = "button", tab = "Options", groupbox = "Vehicle Spawn", text = "Akuma", func = function()
                local coords = GetEntityCoords(PlayerPedId())
                vehicleModule.spawn("akuma", coords)
            end},

            {type = "button", tab = "Options", groupbox = "Vehicle Spawn", text = "Auto-Drive/Fly/Sail to Waypoint (AI Driver)", func = function()
                Citizen.CreateThread(function()
                    local playerPed = PlayerPedId()
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    if not vehicle or vehicle == 0 then
                        dev.drawing.notify("You are not in a vehicle!", "AutoDrive", 3000, 255, 40, 0)
                        return
                    end

                    -- Detect vehicle type
                    local vehType = "car"
                    if IsThisModelAPlane(GetEntityModel(vehicle)) then
                        vehType = "plane"
                    elseif IsThisModelABoat(GetEntityModel(vehicle)) then
                        vehType = "boat"
                    elseif IsThisModelAHeli(GetEntityModel(vehicle)) then
                        vehType = "heli"
                    end

                    -- Find a free passenger seat (skip driver seat)
                    local foundSeat = false
                    local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle))
                    for seat = 1, maxSeats - 1 do
                        if IsVehicleSeatFree(vehicle, seat) then
                            TaskWarpPedIntoVehicle(playerPed, vehicle, seat)
                            foundSeat = true
                            break
                        end
                    end
                    if not foundSeat then
                        dev.drawing.notify("No free passenger seat found!", "AutoDrive", 3000, 255, 40, 0)
                        return
                    end

                    -- Spawn a ped as driver
                    local pedModel = GetHashKey("s_m_m_security_01")
                    RequestModel(pedModel)
                    while not HasModelLoaded(pedModel) do Wait(10) end
                    local coords = GetEntityCoords(vehicle)
                    local driverPed = CreatePedInsideVehicle(vehicle, 4, pedModel, -1, true, false)
                    if not DoesEntityExist(driverPed) then
                        -- fallback: spawn outside and warp in
                        driverPed = CreatePed(4, pedModel, coords.x, coords.y, coords.z + 1.0, GetEntityHeading(vehicle), true, false)
                        TaskWarpPedIntoVehicle(driverPed, vehicle, -1)
                    end
                    SetEntityAsMissionEntity(driverPed, true, true)
                    -- Bypass decorators
                    if not DecorIsRegisteredAsType("whitelisted", 2) then pcall(function() DecorRegister("whitelisted", 2) end) end
                    DecorSetBool(driverPed, "whitelisted", true)
                    if not DecorIsRegisteredAsType("ac_bypass", 2) then pcall(function() DecorRegister("ac_bypass", 2) end) end
                    DecorSetBool(driverPed, "ac_bypass", true)
                    SetEntityInvincible(driverPed, true)
                    SetEntityVisible(driverPed, false, false)
                    SetBlockingOfNonTemporaryEvents(driverPed, true)
                    SetPedFleeAttributes(driverPed, 0, false)
                    SetPedCombatAttributes(driverPed, 46, true)
                    SetPedCanRagdoll(driverPed, false)
                    SetPedCanBeDraggedOut(driverPed, false)
                    SetPedCanBeKnockedOffVehicle(driverPed, false)
                    SetPedConfigFlag(driverPed, 429, true) -- block non-temp events

                    -- Get waypoint
                    local blip = GetFirstBlipInfoId(8)
                    if not DoesBlipExist(blip) then
                        dev.drawing.notify("Set a waypoint first!", "AutoDrive", 3000, 255, 40, 0)
                        DeleteEntity(driverPed)
                        return
                    end
                    local dest = GetBlipInfoIdCoord(blip)

                    -- Human-like driving/flying/sailing parameters
                    local function randomize(val, percent)
                        local delta = val * (percent or 0.1)
                        return val + math.random() * delta - delta/2
                    end

                    if vehType == "car" then
                        local speed = randomize(30.0, 0.1)
                        local style = 786603
                        TaskVehicleDriveToCoordLongrange(driverPed, vehicle, dest.x, dest.y, dest.z, speed, style, 20.0)
                        SetDriveTaskCruiseSpeed(driverPed, speed)
                        SetDriveTaskDrivingStyle(driverPed, style)
                        SetPedKeepTask(driverPed, true)
                        dev.drawing.notify("AI driver is taking you to the waypoint (high, non-aggressive)!", "AutoDrive", 4000, 78, 75, 163)
                    elseif vehType == "plane" then
                        -- Improved: smooth takeoff, cruise, and perfect landing
                        local takeoffAlt = coords.z + 120.0
                        local takeoffSpeed = 8.0
                        -- Do not pull in the wheels, just leave them like that
                        -- ControlLandingGear(vehicle, 1) -- gear up -- (REMOVED)
                        TaskPlaneMission(driverPed, vehicle, 0, 0, coords.x + 200.0, coords.y, takeoffAlt, 16, takeoffSpeed, 0.0, 0.0, 0.0, 0.7)
                        -- Wait for takeoff
                        local startZ = coords.z
                        for i = 1, 40 do
                            Wait(500)
                            if GetEntityCoords(vehicle).z > startZ + 100.0 then break end
                        end
                        -- Cruise at high altitude
                        local cruiseAlt = math.max(dest.z + 250.0, coords.z + 200.0)
                        local cruiseSpeed = 13.0
                        TaskPlaneMission(driverPed, vehicle, 0, 0, dest.x, dest.y, cruiseAlt, 6, cruiseSpeed, 0.0, 0.0, 0.0, 1.0)
                        SetPedKeepTask(driverPed, true)
                        dev.drawing.notify("AI pilot is flying you full high and smooth to the waypoint!", "AutoFly", 4000, 78, 75, 163)

                        -- Landing sequence: multi-phase, smooth, with gear and speed control
                        local landingStarted = false
                        local landingPhase = 0
                        while true do
                            Wait(500)
                            if not DoesEntityExist(driverPed) or not IsPedInVehicle(driverPed, vehicle, false) then break end
                            local vehCoords = GetEntityCoords(vehicle)
                            local dist = #(vector3(dest.x, dest.y, dest.z) - vehCoords)
                            local alt = vehCoords.z

                            if not landingStarted and dist < 1500.0 then
                                landingStarted = true
                                landingPhase = 1
                            end

                            if landingStarted then
                                if landingPhase == 1 and dist < 1200.0 then
                                    -- Begin descent, do not touch landing gear
                                    -- ControlLandingGear(vehicle, 0) -- gear down -- (REMOVED)
                                    TaskPlaneMission(driverPed, vehicle, 0, 0, dest.x, dest.y, dest.z + 120.0, 16, 6.0, 0.0, 0.0, 0.0, 0.7)
                                    landingPhase = 2
                                elseif landingPhase == 2 and dist < 800.0 then
                                    -- Lower to 80 above ground, slower
                                    TaskPlaneMission(driverPed, vehicle, 0, 0, dest.x, dest.y, dest.z + 80.0, 16, 4.0, 0.0, 0.0, 0.0, 0.5)
                                    landingPhase = 3
                                elseif landingPhase == 3 and dist < 400.0 then
                                    -- Lower to 40 above ground, even slower
                                    TaskPlaneMission(driverPed, vehicle, 0, 0, dest.x, dest.y, dest.z + 40.0, 16, 2.5, 0.0, 0.0, 0.0, 0.4)
                                    landingPhase = 4
                                elseif landingPhase == 4 and dist < 150.0 then
                                    -- Lower to 15 above ground, very slow
                                    TaskPlaneMission(driverPed, vehicle, 0, 0, dest.x, dest.y, dest.z + 15.0, 16, 1.2, 0.0, 0.0, 0.0, 0.3)
                                    landingPhase = 5
                                elseif landingPhase == 5 and dist < 60.0 then
                                    -- Final approach, almost stop, just above ground
                                    TaskPlaneMission(driverPed, vehicle, 0, 0, dest.x, dest.y, dest.z + 2.0, 16, 0.8, 0.0, 0.0, 0.0, 0.2)
                                    landingPhase = 6
                                elseif landingPhase == 6 and dist < 25.0 then
                                    -- Touchdown: set speed to almost zero, keep gear as is
                                    TaskPlaneMission(driverPed, vehicle, 0, 0, dest.x, dest.y, dest.z, 16, 0.2, 0.0, 0.0, 0.0, 0.1)
                                    landingPhase = 7
                                elseif landingPhase == 7 and dist < 10.0 then
                                    -- Stop plane, brake gently, keep straight
                                    TaskPlaneMission(driverPed, vehicle, 0, 0, dest.x, dest.y, dest.z, 16, 0.0, 0.0, 0.0, 0.0, 0.0)
                                    TaskVehicleTempAction(driverPed, vehicle, 27, 2000) -- brake
                                    -- Hold heading
                                    SetVehicleForwardSpeed(vehicle, 0.0)
                                    break
                                end
                            end
                        end
                    elseif vehType == "heli" then
                        TaskHeliMission(driverPed, vehicle, 0, 0, dest.x, dest.y, dest.z + randomize(60.0, 0.3), 4, randomize(8.0, 0.2), 0.0, 0.0, 0.0)
                        SetPedKeepTask(driverPed, true)
                        dev.drawing.notify("AI pilot is flying you smoothly to the waypoint (heli)!", "AutoFly", 4000, 78, 75, 163)
                    elseif vehType == "boat" then
                        TaskVehicleDriveToCoord(driverPed, vehicle, dest.x, dest.y, dest.z, randomize(7.0, 0.2), 0, GetEntityModel(vehicle), 16777216, 5.0)
                        SetPedKeepTask(driverPed, true)
                        dev.drawing.notify("AI sailor is sailing you slowly to the waypoint!", "AutoSail", 4000, 78, 75, 163)
                    end

                    -- Monitor and adjust logic for human-like behavior
                    local lastPos = GetEntityCoords(vehicle)
                    local stuckTimer = 0
                    while true do
                        Wait(1000)
                        if not DoesEntityExist(driverPed) or not IsPedInVehicle(driverPed, vehicle, false) then
                            break
                        end
                        local vehCoords = GetEntityCoords(vehicle)
                        local dist = #(vector3(dest.x, dest.y, dest.z) - vehCoords)

                        -- Human-like: if stuck, honk, reverse, retry
                        if vehType == "car" then
                            if GetEntitySpeed(vehicle) < 1.0 and dist > 40.0 then
                                stuckTimer = stuckTimer + 1
                                if stuckTimer > 3 then
                                    TaskVehicleTempAction(driverPed, vehicle, 18, 2000) -- honk
                                    TaskVehicleTempAction(driverPed, vehicle, 7, 1500) -- reverse
                                    Wait(1500)
                                    local speed = randomize(30.0, 0.1)
                                    local style = 786603
                                    TaskVehicleDriveToCoordLongrange(driverPed, vehicle, dest.x, dest.y, dest.z, speed, style, 20.0)
                                    SetDriveTaskCruiseSpeed(driverPed, speed)
                                    SetDriveTaskDrivingStyle(driverPed, style)
                                    stuckTimer = 0
                                end
                            else
                                stuckTimer = 0
                            end
                        end

                        -- Heli: slow down and descend near destination
                        if vehType == "heli" then
                            if dist < 60.0 then
                                TaskHeliMission(driverPed, vehicle, 0, 0, dest.x, dest.y, dest.z + 2.0, 8, randomize(4.0, 0.2), 0.0, 0.0, 0.0)
                            end
                        end

                        -- Boat: if stuck, reverse and retry
                        if vehType == "boat" then
                            if GetEntitySpeed(vehicle) < 1.0 and dist > 40.0 then
                                TaskVehicleTempAction(driverPed, vehicle, 7, 1500) -- reverse
                                Wait(1500)
                                TaskVehicleDriveToCoord(driverPed, vehicle, dest.x, dest.y, dest.z, randomize(7.0, 0.2), 0, GetEntityModel(vehicle), 16777216, 5.0)
                            end
                        end

                        -- Human-like: random lane changes, speed variation (car)
                        if vehType == "car" and math.random() < 0.2 then
                            local speed = randomize(30.0, 0.1)
                            SetDriveTaskCruiseSpeed(driverPed, speed)
                        end

                        if dist < 30.0 then
                            if vehType == "car" or vehType == "boat" then
                                TaskVehicleTempAction(driverPed, vehicle, 27, 2000) -- brake
                            elseif vehType == "heli" then
                                TaskHeliMission(driverPed, vehicle, 0, 0, dest.x, dest.y, dest.z + 2.0, 8, randomize(4.0, 0.2), 0.0, 0.0, 0.0)
                            end
                            dev.drawing.notify("Arrived at waypoint!", "AutoDrive", 3000, 78, 75, 163)
                            break
                        end
                        lastPos = vehCoords
                    end
                    -- Optionally delete driver after arrival
                    Wait(2000)
                    if DoesEntityExist(driverPed) then
                        TaskLeaveVehicle(driverPed, vehicle, 0)
                        Wait(1000)
                        DeleteEntity(driverPed)
                    end
                end)
            end},

            {type = "checkbox", tab = "Options", groupbox = "Vehicle Spawn", bool = "flyVehicle", text = "Fly Vehicle", func = function()
                Citizen.CreateThread(function()
                    while dev.cfg.bools["flyVehicle"] do
                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                        if vehicle and DoesEntityExist(vehicle) then
                            local forwardVector = GetEntityForwardVector(vehicle)
                            local upVector = vector3(0.0, 0.0, 1.0)
                            local speed = 10.0

                            if IsControlPressed(0, 32) then -- W key
                                ApplyForceToEntity(vehicle, 1, forwardVector.x * speed, forwardVector.y * speed, forwardVector.z * speed, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                            end

                            if IsControlPressed(0, 33) then -- S key
                                ApplyForceToEntity(vehicle, 1, -forwardVector.x * speed, -forwardVector.y * speed, -forwardVector.z * speed, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                            end

                            if IsControlPressed(0, 44) then -- Q key
                                ApplyForceToEntity(vehicle, 1, 0.0, 0.0, speed, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                            end

                            if IsControlPressed(0, 46) then -- E key
                                ApplyForceToEntity(vehicle, 1, 0.0, 0.0, -speed, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                            end

                            -- Instant brake with LSHIFT (21)
                            if IsControlPressed(0, 21) then
                                SetEntityVelocity(vehicle, 0.0, 0.0, 0.0)
                                SetVehicleForwardSpeed(vehicle, 0.0)
                            end

                            SetEntityRotation(vehicle, GetGameplayCamRot(2), 2, true)
                        end
                        Wait(0)
                    end
                end)
            end},
            
            {type = "endGroupbox",tab = "Options", name = "Vehicle Spawn"},

            {type = "groupbox",tab = "Options",x = 440, y = 80, w = 320, h = 490, name = "Options"},

            {type = "button", tab = "Options", groupbox = "Options", text = "Tp Nearby Vehicle", func = function()
                local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 200.0, 0, 70)
                if vehicle then
                    local coords = GetEntityCoords(vehicle)
                    SetEntityCoordsNoOffset(PlayerPedId(), coords)
                    Wait(200)
                    if GetPedInVehicleSeat(vehicle, -1) ~= 0 then 
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -2)
                    else
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                    end
                end
            end},

        {type = "button", tab = "Options", groupbox = "Options", text = "Repair Vehicle", func = function()
            Citizen.CreateThread(function()
                local ped = PlayerPedId()
                local vehicle = GetVehiclePedIsIn(ped, false)
                if DoesEntityExist(vehicle) and vehicle ~= 0 then
                    -- Anticheat bypass: set decorators and flags before repair
                    local function safeDecorRegister(name)
                        if not DecorIsRegisteredAsType(name, 2) then
                            pcall(function() DecorRegister(name, 2) end)
                        end
                    end
                    safeDecorRegister("whitelisted")
                    safeDecorRegister("ac_bypass")
                    safeDecorRegister("isStaff")
                    DecorSetBool(ped, "whitelisted", true)
                    DecorSetBool(vehicle, "whitelisted", true)
                    DecorSetBool(ped, "ac_bypass", true)
                    DecorSetBool(vehicle, "ac_bypass", true)
                    DecorSetBool(ped, "isStaff", true)
                    DecorSetBool(vehicle, "isStaff", true)
                    -- Remove unwanted network metadata
                    SetEntityDynamic(vehicle, false)
                    SetEntityLoadCollisionFlag(vehicle, false)
                    SetEntitySomething(vehicle, false)
                    -- Set as mission entity and request control
                    SetEntityAsMissionEntity(vehicle, true, true)
                    NetworkRequestControlOfEntity(vehicle)
                    local timeout = 0
                    while not NetworkHasControlOfEntity(vehicle) and timeout < 50 do
                        NetworkRequestControlOfEntity(vehicle)
                        Citizen.Wait(10)
                        timeout = timeout + 1
                    end
                    -- Perform repair (client-side, undetected)
                    SetVehicleFixed(vehicle)
                    SetVehicleDeformationFixed(vehicle)
                    SetVehicleUndriveable(vehicle, false)
                    SetVehicleEngineHealth(vehicle, 1000.0)
                    SetVehicleBodyHealth(vehicle, 1000.0)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    SetVehiclePetrolTankHealth(vehicle, 1000.0)
                    SetVehicleWheelsCanBreak(vehicle, false)
                    SetVehicleTyresCanBurst(vehicle, false)
                    SetVehicleEngineOn(vehicle, true, true, false)
                    -- Remove bypass after short delay
                    Citizen.SetTimeout(1200, function()
                        DecorSetBool(ped, "whitelisted", false)
                        DecorSetBool(vehicle, "whitelisted", false)
                        DecorSetBool(ped, "ac_bypass", false)
                        DecorSetBool(vehicle, "ac_bypass", false)
                        DecorSetBool(ped, "isStaff", false)
                        DecorSetBool(vehicle, "isStaff", false)
                    end)
                    Notify("Success", "keeper-sucess", "Vehicle repaired undetected!", 78, 75, 163)
                else
                    Notify("Warning", "keeper-warn", "Enter a vehicle first!", 255, 255, 255)
                end
            end)
        end},

            {type = "button", tab = "Options", groupbox = "Options", text = "Delete Vehicle", func = function()
                local vehicle = GetVehiclePedIsIn(PlayerPedId())
                if vehicle then
                    DeleteEntity(vehicle)
                end
            end},

            {type = "button", tab = "Options", groupbox = "Options", text = "Unlock", func = function()
                local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 15.0, 0, 70)
                if vehicle then
                    Citizen.InvokeNative(0xB664292EAECF7FA6, vehicle, 1)
                    Citizen.InvokeNative(0x517AAF684BB50CD1, vehicle, PlayerId(), false)
                    Citizen.InvokeNative(0xA2F80B8D040727CC, vehicle, false)
                end
            end},

            {type = "button", tab = "Options", groupbox = "Options", text = "Tune Vehicle", func = function()
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), -1)
                if vehicle and DoesEntityExist(vehicle) then
                    -- Anticheat/metadata log bypass: set decorators and flags before tuning
                    local function safeDecorRegister(name)
                        if not DecorIsRegisteredAsType(name, 2) then
                            pcall(function() DecorRegister(name, 2) end)
                        end
                    end
                    safeDecorRegister("whitelisted")
                    safeDecorRegister("ac_bypass")
                    safeDecorRegister("isStaff")
                    DecorSetBool(PlayerPedId(), "whitelisted", true)
                    DecorSetBool(vehicle, "whitelisted", true)
                    DecorSetBool(PlayerPedId(), "ac_bypass", true)
                    DecorSetBool(vehicle, "ac_bypass", true)
                    DecorSetBool(PlayerPedId(), "isStaff", true)
                    DecorSetBool(vehicle, "isStaff", true)
                    -- Remove unwanted network metadata
                    SetEntityDynamic(vehicle, false)
                    SetEntityLoadCollisionFlag(vehicle, false)
                    SetEntitySomething(vehicle, false)
                    -- Set as mission entity and request control
                    SetEntityAsMissionEntity(vehicle, true, true)
                    NetworkRequestControlOfEntity(vehicle)
                    local timeout = 0
                    while not NetworkHasControlOfEntity(vehicle) and timeout < 50 do
                        NetworkRequestControlOfEntity(vehicle)
                        Citizen.Wait(10)
                        timeout = timeout + 1
                    end

                    SetVehicleModKit(vehicle, 0)
                    SetVehicleWheelType(vehicle, 7)
                    SetVehicleMod(vehicle, 0, GetNumVehicleMods(vehicle, 0) - 1, false)
                    SetVehicleMod(vehicle, 1, GetNumVehicleMods(vehicle, 1) - 1, false)
                    SetVehicleMod(vehicle, 2, GetNumVehicleMods(vehicle, 2) - 1, false)
                    SetVehicleMod(vehicle, 3, GetNumVehicleMods(vehicle, 3) - 1, false)
                    SetVehicleMod(vehicle, 4, GetNumVehicleMods(vehicle, 4) - 1, false)
                    SetVehicleMod(vehicle, 5, GetNumVehicleMods(vehicle, 5) - 1, false)
                    SetVehicleMod(vehicle, 6, GetNumVehicleMods(vehicle, 6) - 1, false)
                    SetVehicleMod(vehicle, 7, GetNumVehicleMods(vehicle, 7) - 1, false)
                    SetVehicleMod(vehicle, 8, GetNumVehicleMods(vehicle, 8) - 1, false)
                    SetVehicleMod(vehicle, 9, GetNumVehicleMods(vehicle, 9) - 1, false)
                    SetVehicleMod(vehicle, 10, GetNumVehicleMods(vehicle, 10) - 1, false)
                    SetVehicleMod(vehicle, 11, GetNumVehicleMods(vehicle, 11) - 1, false)
                    SetVehicleMod(vehicle, 12, GetNumVehicleMods(vehicle, 12) - 1, false)
                    SetVehicleMod(vehicle, 13, GetNumVehicleMods(vehicle, 13) - 1, false)
                    SetVehicleMod(vehicle, 15, GetNumVehicleMods(vehicle, 15) - 2, false)
                    SetVehicleMod(vehicle, 16, GetNumVehicleMods(vehicle, 16) - 1, false)
                    ToggleVehicleMod(vehicle, 17, true)
                    ToggleVehicleMod(vehicle, 18, true)
                    ToggleVehicleMod(vehicle, 19, true)
                    ToggleVehicleMod(vehicle, 20, true)
                    ToggleVehicleMod(vehicle, 21, true)
                    ToggleVehicleMod(vehicle, 22, true)
                    SetVehicleXenonLightsColor(vehicle, 7)
                    SetVehicleMod(vehicle, 25, GetNumVehicleMods(vehicle, 25) - 1, false)
                    SetVehicleMod(vehicle, 27, GetNumVehicleMods(vehicle, 27) - 1, false)
                    SetVehicleMod(vehicle, 28, GetNumVehicleMods(vehicle, 28) - 1, false)
                    SetVehicleMod(vehicle, 30, GetNumVehicleMods(vehicle, 30) - 1, false)
                    SetVehicleMod(vehicle, 33, GetNumVehicleMods(vehicle, 33) - 1, false)
                    SetVehicleMod(vehicle, 34, GetNumVehicleMods(vehicle, 34) - 1, false)
                    SetVehicleMod(vehicle, 35, GetNumVehicleMods(vehicle, 35) - 1, false)
                    SetVehicleWindowTint(vehicle, 1)
                    SetVehicleTyresCanBurst(vehicle, false)

                    -- Remove bypass after short delay
                    Citizen.SetTimeout(1200, function()
                        DecorSetBool(PlayerPedId(), "whitelisted", false)
                        DecorSetBool(vehicle, "whitelisted", false)
                        DecorSetBool(PlayerPedId(), "ac_bypass", false)
                        DecorSetBool(vehicle, "ac_bypass", false)
                        DecorSetBool(PlayerPedId(), "isStaff", false)
                        DecorSetBool(vehicle, "isStaff", false)
                    end)
                end
            end},

            {type = "colorpicker",tab = "Options",groupbox = "Options",text = "Paint Vehicle",color = "paintVehicle", func = function ()
                local r, g, b, a = dev.cfg.colors["paintVehicle"].r, dev.cfg.colors["paintVehicle"].g, dev.cfg.colors["paintVehicle"].b, dev.cfg.colors["paintVehicle"].a
                if r and g and b then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), -1)
                    local alpha = a
                    SetEntityAlpha(vehicle, alpha)
                    SetVehicleCustomPrimaryColour(vehicle,  r, g, b)
                    SetVehicleCustomSecondaryColour(vehicle,  r, g, b)
                end
            end},

            {type = "checkbox", tab = "Options", groupbox = "Options", bool = "noRagdoll", text = "No Fall",bindable = true, func = function (bool)
                if not bool then
                    SetPedCanRagdoll(PlayerPedId(), true)
                    SetPedCanBeKnockedOffVehicle(PlayerPedId(), true)
                end
            end},
            
            {type = "checkbox", tab = "Options", groupbox = "Options", bool = "hornBoost", text = "Horn Boost",bindable = true},

            {type = "checkbox", tab = "Options", groupbox = "Options", bool = "autoRepair", text = "Auto Repair",bindable = true},

            {type = "checkbox", tab = "Options", groupbox = "Options", bool = "shotInSide", text = "Shoot from Inside", func = function()
                Citizen.CreateThread(function()
                    if dev.cfg.bools["shotInSide"] then
                        dev.drawing.notify("Shooting enabled!", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                        while dev.cfg.bools["shotInSide"] do
                            SetPlayerCanDoDriveBy(PlayerId(), true) 
                            Wait(0)
                        end
                    end
                end)
            end},

            {type = "checkbox", tab = "Options", groupbox = "Options", bool = "vehicleShoot", text = "Shoot from Vehicle (Choose Weapon)", func = function(toggle)
                if toggle then
                    -- Weapon options: Rocket, Minigun (explosive), Heavy Sniper
                    local weaponOptions = {
                        {label = "Vehicle Minigun (Explosive)", hash = GetHashKey("VEHICLE_WEAPON_PLAYER_LAZER")},
                        {label = "Heavy Sniper", hash = GetHashKey("WEAPON_HEAVYSNIPER")},
                    }
                    local selectedWeapon = 1

                    Citizen.CreateThread(function()
                        local ped = PlayerPedId()
                        local vehicle = GetVehiclePedIsIn(ped, false)
                        if not vehicle or vehicle == 0 then
                            dev.drawing.notify("You must be in a vehicle!", "Vehicle Shoot", 3000, 255, 40, 0)
                            dev.cfg.bools["vehicleShoot"] = false
                            return
                        end

                        local shootCooldown = 0

                        while dev.cfg.bools["vehicleShoot"] do
                            Wait(0)
                            vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if not vehicle or vehicle == 0 then
                                dev.cfg.bools["vehicleShoot"] = false
                                break
                            end

                            -- Explicitly allow drive-by shooting
                            SetPlayerCanDoDriveBy(PlayerId(), true)
                            SetPedCanSwitchWeapon(PlayerPedId(), true)
                            DisableControlAction(0, 68, false) -- enable aiming
                            DisableControlAction(0, 69, false) -- enable attack

                            -- Draw weapon selection UI (top left)
                            dev.drawing.drawRect(30, 120, 420, 36, {r=30,g=30,b=30,a=200})
                            dev.drawing.drawText("Vehicle Shoot: [←/→] Select | [LMB] Fire | [RMB] Fire (rapid)", 40, 125, 0, 250, "left", {r=255,g=255,b=255,a=255}, 10)
                            dev.drawing.drawText("Current: " .. weaponOptions[selectedWeapon].label, 40, 145, 0, 250, "left", {r=255,g=255,b=0,a=255}, 10)

                            -- Change weapon with left/right arrows
                            if IsControlJustPressed(0, 174) then -- Left Arrow
                                selectedWeapon = selectedWeapon - 1
                                if selectedWeapon < 1 then selectedWeapon = #weaponOptions end
                            elseif IsControlJustPressed(0, 175) then -- Right Arrow
                                selectedWeapon = selectedWeapon + 1
                                if selectedWeapon > #weaponOptions then selectedWeapon = 1 end
                            end

                            local weaponHash = weaponOptions[selectedWeapon].hash

                            -- Shoot with LMB (24) or RMB (25)
                            if IsControlPressed(0, 24) or IsControlPressed(0, 25) then
                                if GetGameTimer() > shootCooldown then
                                    -- Get camera direction
                                    local camRot = GetGameplayCamRot(2)
                                    local camCoord = GetGameplayCamCoord()
                                    local forward = vector3(
                                        -math.sin(math.rad(camRot.z)) * math.abs(math.cos(math.rad(camRot.x))),
                                        math.cos(math.rad(camRot.z)) * math.abs(math.cos(math.rad(camRot.x))),
                                        math.sin(math.rad(camRot.x))
                                    )
                                    local startPos = camCoord + forward * 2.0
                                    local endPos = camCoord + forward * 200.0

                                    -- Fire the weapon (networked, visible to all)
                                    local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                    if NetworkDoesNetworkIdExist(netId) then
                                        -- Use the vehicle as the shooter for sync
                                        ShootSingleBulletBetweenCoords(
                                            startPos.x, startPos.y, startPos.z,
                                            endPos.x, endPos.y, endPos.z,
                                            250, -- damage
                                            true,
                                            weaponHash,
                                            vehicle, -- shooter is vehicle for sync
                                            true,
                                            false,
                                            100.0
                                        )
                                    else
                                        -- fallback to ped
                                        ShootSingleBulletBetweenCoords(
                                            startPos.x, startPos.y, startPos.z,
                                            endPos.x, endPos.y, endPos.z,
                                            250,
                                            true,
                                            weaponHash,
                                            ped,
                                            true,
                                            false,
                                            100.0
                                        )
                                    end
                                    shootCooldown = GetGameTimer() + (IsControlPressed(0, 25) and 100 or 350)
                                end
                            end
                        end
                    end)
                end
            end},

            {type = "checkbox", tab = "Options", groupbox = "Options", bool = "enableTank", text = "Enable Tank", func = function()
                local vehicle_weapons = {
                    "VEHICLE_WEAPON_WATER_CANNON",
                    "VEHICLE_WEAPON_PLAYER_LAZER",
                    "VEHICLE_WEAPON_PLANE_ROCKET",
                    "VEHICLE_WEAPON_ENEMY_LASER",
                    "VEHICLE_WEAPON_TANK",
                    "VEHICLE_WEAPON_SEARCHLIGHT",
                    "VEHICLE_WEAPON_RADAR",
                    "VEHICLE_WEAPON_PLAYER_BUZZARD",
                    "VEHICLE_WEAPON_SPACE_ROCKET",
                    "VEHICLE_WEAPON_TURRET_INSURGENT",
                    "VEHICLE_WEAPON_PLAYER_SAVAGE",
                    "VEHICLE_WEAPON_TURRET_TECHNICAL",
                    "VEHICLE_WEAPON_NOSE_TURRET_VALKYRIE",
                    "VEHICLE_WEAPON_TURRET_VALKYRIE",
                    "VEHICLE_WEAPON_CANNON_BLAZER",
                    "VEHICLE_WEAPON_TURRET_BOXVILLE",
                    "VEHICLE_WEAPON_RUINER_BULLET",
                    "VEHICLE_WEAPON_RUINER_ROCKET",
                    "VEHICLE_WEAPON_HUNTER_MG",
                    "VEHICLE_WEAPON_HUNTER_MISSILE",
                    "VEHICLE_WEAPON_HUNTER_CANNON",
                    "VEHICLE_WEAPON_HUNTER_BARRAGE",
                    "VEHICLE_WEAPON_TULA_NOSEMG",
                    "VEHICLE_WEAPON_TULA_MG",
                    "VEHICLE_WEAPON_TULA_DUALMG",
                    "VEHICLE_WEAPON_TULA_MINIGUN",
                    "VEHICLE_WEAPON_SEABREEZE_MG",
                    "VEHICLE_WEAPON_MICROLIGHT_MG",
                    "VEHICLE_WEAPON_DOGFIGHTER_MG",
                    "VEHICLE_WEAPON_DOGFIGHTER_MISSILE",
                    "VEHICLE_WEAPON_MOGUL_NOSE",
                    "VEHICLE_WEAPON_MOGUL_DUALNOSE",
                    "VEHICLE_WEAPON_MOGUL_TURRET",
                    "VEHICLE_WEAPON_MOGUL_DUALTURRET",
                    "VEHICLE_WEAPON_ROGUE_MG",
                    "VEHICLE_WEAPON_ROGUE_CANNON",
                    "VEHICLE_WEAPON_ROGUE_MISSILE",
                    "VEHICLE_WEAPON_BOMBUSHKA_DUALMG",
                    "VEHICLE_WEAPON_BOMBUSHKA_CANNON",
                    "VEHICLE_WEAPON_HAVOK_MINIGUN",
                    "VEHICLE_WEAPON_VIGILANTE_MG",
                    "VEHICLE_WEAPON_VIGILANTE_MISSILE",
                    "VEHICLE_WEAPON_TURRET_LIMO",
                    "VEHICLE_WEAPON_DUNE_MG",
                    "VEHICLE_WEAPON_DUNE_GRENADELAUNCHER",
                    "VEHICLE_WEAPON_DUNE_MINIGUN",
                    "VEHICLE_WEAPON_TAMPA_MISSILE",
                    "VEHICLE_WEAPON_TAMPA_MORTAR",
                    "VEHICLE_WEAPON_TAMPA_FIXEDMINIGUN",
                    "VEHICLE_WEAPON_TAMPA_DUALMINIGUN",
                    "VEHICLE_WEAPON_HALFTRACK_DUALMG",
                    "VEHICLE_WEAPON_HALFTRACK_QUADMG",
                    "VEHICLE_WEAPON_APC_CANNON",
                    "VEHICLE_WEAPON_APC_MISSILE",
                    "VEHICLE_WEAPON_APC_MG",
                    "VEHICLE_WEAPON_ARDENT_MG",
                    "VEHICLE_WEAPON_TECHNICAL_MINIGUN",
                    "VEHICLE_WEAPON_INSURGENT_MINIGUN",
                    "VEHICLE_WEAPON_TRAILER_QUADMG",
                    "VEHICLE_WEAPON_TRAILER_MISSILE",
                    "VEHICLE_WEAPON_TRAILER_DUALAA",
                    "VEHICLE_WEAPON_NIGHTSHARK_MG",
                    "VEHICLE_WEAPON_OPPRESSOR_MG",
                    "VEHICLE_WEAPON_OPPRESSOR_MISSILE",
                    "VEHICLE_WEAPON_OPPRESSOR2_MG",
                    "VEHICLE_WEAPON_OPPRESSOR2_MISSILE",
                    "VEHICLE_WEAPON_MOBILEOPS_CANNON",
                    "VEHICLE_WEAPON_AKULA_TURRET_SINGLE",
                    "VEHICLE_WEAPON_AKULA_MISSILE",
                    "VEHICLE_WEAPON_AKULA_TURRET_DUAL",
                    "VEHICLE_WEAPON_AKULA_MINIGUN",
                    "VEHICLE_WEAPON_AKULA_BARRAGE",
                    "VEHICLE_WEAPON_AVENGER_CANNON",
                    "VEHICLE_WEAPON_BARRAGE_TOP_MG",
                    "VEHICLE_WEAPON_BARRAGE_TOP_MINIGUN",
                    "VEHICLE_WEAPON_BARRAGE_REAR_MG",
                    "VEHICLE_WEAPON_BARRAGE_REAR_MINIGUN",
                    "VEHICLE_WEAPON_BARRAGE_REAR_GL",
                    "VEHICLE_WEAPON_CHERNO_MISSILE",
                    "VEHICLE_WEAPON_COMET_MG",
                    "VEHICLE_WEAPON_DELUXO_MG",
                    "VEHICLE_WEAPON_DELUXO_MISSILE",
                    "VEHICLE_WEAPON_KHANJALI_CANNON",
                    "VEHICLE_WEAPON_KHANJALI_CANNON_HEAVY",
                    "VEHICLE_WEAPON_KHANJALI_MG",
                    "VEHICLE_WEAPON_KHANJALI_GL",
                    "VEHICLE_WEAPON_REVOLTER_MG",
                    "VEHICLE_WEAPON_WATER_CANNON",
                    "VEHICLE_WEAPON_SAVESTRA_MG",
                    "VEHICLE_WEAPON_SUBCAR_MG",
                    "VEHICLE_WEAPON_SUBCAR_MISSILE",
                    "VEHICLE_WEAPON_SUBCAR_TORPEDO",
                    "VEHICLE_WEAPON_THRUSTER_MG",
                    "VEHICLE_WEAPON_THRUSTER_MISSILE",
                    "VEHICLE_WEAPON_VISERIS_MG",
                    "VEHICLE_WEAPON_VOLATOL_DUALMG"
                }

                while dev.cfg.bools["enableTank"] do
                    local myPed = PlayerPedId()
                    local inVehicle = IsPedInAnyVehicle(myPed)
                    local vehicle = GetVehiclePedIsIn(myPed)

                    if inVehicle then
                        for _, v in ipairs(vehicle_weapons) do
                            DisableVehicleWeapon(false, v, vehicle, myPed)
                            SetCurrentPedVehicleWeapon(myPed, v)
                        end

                        EnableControlAction(0, 140, true)
                        EnableControlAction(0, 141, true)
                        EnableControlAction(0, 142, true)
                    end
                    Wait(0)
                end
            end},

            {type = "slider", currentTab = "Options", slider = 'hornForce', groupbox = "Options", sliderflags = {min = 0, max = 300, startAt = 80}, text = "Boost Strength"},

            {type = "endGroupbox",tab = "Options", name = "Options"},
        },

        ["Outros"] = {
            {type = "groupbox",tab = "Outros",x = 440, y = 80, w = 320, h = 490, name = "Outros"},

            {type = "button", tab = "Outros", groupbox = "Outros", text = "Bring Selected Vehicle", func = function()
                if not dev.vars.selectedVehicle then
                    dev.drawing.notify("No vehicle selected!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                local vehicle = dev.vars.selectedVehicle
                local myPed = PlayerPedId()
                local coordsVehicle = GetEntityCoords(vehicle)
                local vehicleOccuped = IsVehicleSeatFree(vehicle, -1)
                local healthVehicle = GetEntityHealth(vehicle)
                local coordenada = GetEntityCoords(myPed)
                local contagem = 0

                if DoesEntityExist(vehicle) then
                    if not vehicleOccuped then
                        dev.drawing.notify("Vehicle occupied!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                        return
                    end

                    if healthVehicle <= 0 then
                        dev.drawing.notify("Vehicle destroyed!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                        return
                    end
                    Citizen.CreateThread(function()
                        while contagem < 9999999 do
                            SetVehicleDoorsLocked(vehicle, 1)
                            SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
                            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                            SetEntityAlpha(vehicle, 150)
                            FreezeEntityPosition(vehicle, true)
                            SetEntityCoords(vehicle, coordenada, true, true, true)

                            local idVehicle = NetworkGetNetworkIdFromEntity(vehicle)
                            NetworkRequestControlOfEntity(vehicle)
                            NetworkRequestControlOfNetworkId(idVehicle)

                            if IsPedInVehicle(myPed, vehicle) then
                                SetEntityCoords(vehicle, coordenada, true, true, true)
                                FreezeEntityPosition(vehicle, false)
                                SetEntityAlpha(vehicle, 255)
                                dev.drawing.notify("Vehicle successfully pulled!", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                                Wait(500)
                                contagem = 20000000
                                SetEntityCoords(vehicle, coordenada, true, true, true)
                                break
                            end

                            local vehicleCloseCoord = GetEntityCoords(vehicle)
                            local coordenadaLoop = GetEntityCoords(myPed)
                            local dist = #(coordenadaLoop - vehicleCloseCoord)

                            if dist > 15 then
                                contagem = 20000000
                                FreezeEntityPosition(vehicle, false)
                                SetEntityAlpha(vehicle, 255)
                                break
                            end 

                            contagem = contagem + 1
                            Wait(0)
                        end
                    end)
                end


            end, bindable = true},

            {type = "endGroupbox",tab = "Outros", name = "Outros"},
        },
    },

    ["Online"] = {
        selTab = "Players",
        subtabs = {
            "Players",
            "Options",
            'Amigos',
        },
        ["Players"] = {
            {type = "groupbox",tab = "Players",x = 100, y = 80, w = 660, h = 490, name = "Lista de Players",scrollIndex = 70},

            {type = "endGroupbox",tab = "Players", name = "Lista de Players"},
        },
        ["Options"] = {
            {type = "groupbox",tab = "Players",x = 100, y = 80, w = 320, h = 490, name = "Friendly",scrollIndex = 40},

            {type = "button", tab = "Options", groupbox = "Friendly", text = "Teleport to Player", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("No player selected!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                if (dev.vars.selectedPlayer) then
                    local hisCoords = GetEntityCoords(GetPlayerPed(dev.vars.selectedPlayer))
                    SetEntityCoords(PlayerPedId(),hisCoords)
                end
            end,bindable = true},

            {type = "button", tab = "Options", groupbox = "Friendly", text = "Copy Outfit", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("No player selected!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                if (dev.vars.selectedPlayer) then
                    ClonePedToTarget(GetPlayerPed(dev.vars.selectedPlayer), PlayerPedId())
                end
            end,bindable = true},

            {type = "checkbox", tab = "Options", groupbox = "Friendly", bool = "spectPlayer", text = "Spectate Player", func = function(toggle)
                if toggle then
                    if dev.vars.selectedPlayer and NetworkIsPlayerActive(dev.vars.selectedPlayer) then
                        local targetPed = GetPlayerPed(dev.vars.selectedPlayer)
                        if DoesEntityExist(targetPed) then
                            -- Start spectating selected player
                            NetworkSetInSpectatorMode(true, targetPed)
                            dev.drawing.notify("Now spectating selected player.", "InfinityMenu", 3000, 78, 75, 163)
                        else
                            dev.drawing.notify("Selected player does not exist!", "InfinityMenu", 3000, 255, 40, 0)
                            dev.cfg.bools["spectPlayer"] = false
                        end
                    else
                        dev.drawing.notify("Select a player first!", "InfinityMenu", 3000, 255, 40, 0)
                        dev.cfg.bools["spectPlayer"] = false
                    end
                else
                    -- Stop spectating
                    NetworkSetInSpectatorMode(false, 0)
                    dev.drawing.notify("Stopped spectating.", "InfinityMenu", 3000, 78, 75, 163)
                end
            end, bindable = true},

            {type = "checkbox", tab = "Options", groupbox = "Friendly", bool = "fakecarry", text = "Carry Player", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("No player selected!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                local myPed = PlayerPedId()
                local playerPed = GetPlayerPed(dev.vars.selectedPlayer)

                if not DoesEntityExist(playerPed) then
                    dev.drawing.notify("Selected player does not exist!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                if dev.cfg.bools["fakecarry"] then
                    Citizen.CreateThread(function()
                        while dev.cfg.bools["fakecarry"] do
                            if DoesEntityExist(playerPed) then
                                AttachEntityToEntity(myPed, playerPed, 11816, 0.0, 0.5, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                            else
                                dev.drawing.notify("Selected player no longer exists!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                                break
                            end
                            Wait(0)
                        end
                        DetachEntity(myPed, true)
                    end)
                else
                    DetachEntity(myPed, true)
                end
            end, bindable = true},

            {type = "checkbox", tab = "Options", groupbox = "Friendly", bool = "fakehandcuff", text = "Fake Handcuff", func = function()
                if dev.cfg.bools["fakehandcuff"] then
                    local playerPed = PlayerPedId() -- Get the player's ped ID
                    
                    -- Load the animation dictionary
                    RequestAnimDict("mp_arresting")
                    while not HasAnimDictLoaded("mp_arresting") do
                        Wait(100)
                    end
                    
                    -- Play the handcuff animation
                    TaskPlayAnim(playerPed, "mp_arresting", "idle", 8.0, -8.0, -1, 49, 0, false, false, false)
                    
                    -- Notify the player
                    dev.drawing.notify("Fake handcuff emote activated!", "Menu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                else
                    ClearPedTasksImmediately(PlayerPedId())
                    dev.drawing.notify("Fake handcuff emote deactivated!", "Menu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                end
            end},

            {type = "checkbox", tab = "Options", groupbox = "Friendly", bool = "isInBJ", text = "BlowJob", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("No player selected!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                local myPed = PlayerPedId()
                local animDict = "misscarsteal2pimpsex"
                local animName = "pimpsex_hooker"

                if dev.cfg.bools["isInBJ"] then
                    local playerPed = GetPlayerPed(dev.vars.selectedPlayer)
                    if not DoesEntityExist(playerPed) then
                        dev.drawing.notify("Invalid player!", "InfinityMenu", 4000, 255, 40, 0)
                        return
                    end

                    RequestAnimDict(animDict)
                    while not HasAnimDictLoaded(animDict) do
                        Wait(10)
                    end

                    -- Attach with zero rotation to keep ped straight
                    local boneIndex = GetPedBoneIndex(playerPed, 11816) -- pelvis
                    local boneIndex = GetPedBoneIndex(playerPed, 4000)
        AttachEntityToEntity(myPed, playerPed, boneIndex, 0.0, 0.6, 0.0, 0.0, 0.0, 180.0, false, false, false, false, 2, true)
        TaskPlayAnim(myPed, animDict, animName, 8.0, -8.0, -1, 33, 0, false, false, false)
    else
                    ClearPedSecondaryTask(myPed)
                    DetachEntity(myPed, true, false)
                end
            end, bindable = true},

{type = "checkbox", tab = "Options", groupbox = "Friendly", bool = "fakeCarry", text = "Attach myself", func = function()
    if not dev.vars.selectedPlayer then
        dev.drawing.notify("No player selected!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
        return
    end

    local myPed = PlayerPedId()

    if dev.cfg.bools["fakeCarry"] then
        Citizen.CreateThread(function()
            while dev.cfg.bools["fakeCarry"] do
                if dev.vars.selectedPlayer then
                    local playerPed = GetPlayerPed(dev.vars.selectedPlayer)
                    if DoesEntityExist(playerPed) then
                        -- Attach yourself to the player's pelvis, with zero offset (inside them)
                        AttachEntityToEntity(
                            myPed,
                            playerPed,
                            11816, -- pelvis bone
                            0.0, 0.0, 0.0, -- position offset (inside)
                            0.0, 0.0, 0.0, -- rotation offset
                            false, false, false,
                            false, 2, true
                        )
                    end
                end
                Wait(0)
            end
        end)
    else
        DetachEntity(myPed, true)
    end
end, bindable = true},


            {type = "checkbox", tab = "Options", groupbox = "Friendly", bool = "AttachAllVehicles", text = "Attach Vehicles", func = function()
        if not dev.vars.selectedPlayer or GetPlayerPed(dev.vars.selectedPlayer) == 0 then
            dev.drawing.notify("No player selected!", "InfinityMenu", 4000, 255, 40, 0)
            return
        end

        if dev.cfg.bools["AttachAllVehicles"] then
            dev.drawing.notify("FORCING all vehicles to re-attach every tick...", "InfinityMenu", 4000, 255, 0, 0)

            Citizen.CreateThread(function()
                while true do
                    if not dev.cfg.bools["AttachAllVehicles"] then
                        break -- Stop when checkbox is turned off
                    end

                    local playerPed = GetPlayerPed(dev.vars.selectedPlayer)

                    for _, veh in ipairs(GetGamePool("CVehicle")) do
                        if DoesEntityExist(veh) then
                            NetworkRequestControlOfEntity(veh)
                            local timeout = 0
                            while not NetworkHasControlOfEntity(veh) and timeout < 100 do
                                Wait(0)
                                timeout = timeout + 1
                            end

                            if NetworkHasControlOfEntity(veh) then
                                SetVehicleHasBeenOwnedByPlayer(veh, true)

                                -- Always detach and re-attach every second
                                DetachEntity(veh, true, true)
                                AttachEntityToEntity(veh, playerPed, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                            end
                        end
                    end

                    Citizen.Wait(0)
                end
            end)
        else
            dev.drawing.notify("Loop stopped. Vehicles remain attached.", "InfinityMenu", 4000, 0, 255, 0)
        end
    end},

                {type = "checkbox", tab = "Options", groupbox = "Friendly", bool = "Attach Peds", text = "Attach Peds", func = function()
                    if not dev.vars.selectedPlayer then
                        dev.drawing.notify("No player selected!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                        return
                    end
    
                    local targetPed = GetPlayerPed(dev.vars.selectedPlayer)
                    local targetCoords = GetEntityCoords(targetPed)
                    local bodyBone = GetPedBoneIndex(targetPed, 0x0) -- Body bone index
    
                    local function EnumeratePeds()
                        return coroutine.wrap(function()
                            local handle, ped = FindFirstPed()
                            local success
                            repeat
                                coroutine.yield(ped)
                                success, ped = FindNextPed(handle)
                            until not success
                            EndFindPed(handle)
                        end)
                    end
    
                    local i = 0
                    for ped in EnumeratePeds() do
                        if DoesEntityExist(ped) and not IsPedAPlayer(ped) and #(GetEntityCoords(ped) - targetCoords) <= 50.0 then -- Check if ped is within 50 units
                            i = i + 1
                            NetworkRequestControlOfEntity(ped)
                            while not NetworkHasControlOfEntity(ped) do
                                Wait(0)
                            end
    
                            AttachEntityToEntity(ped, targetPed, bodyBone, 0.0, 0.0, 0.0 + (i * 0.0), 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                            SetEntityAsMissionEntity(ped, true, true) -- Ensure ped is marked as a mission entity
                            FreezeEntityPosition(ped, true) -- Freeze ped to prevent unwanted movement
                            dev.drawing.notify("Ped #" .. i .. " attached to the selected player's body successfully!", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                        else
                            dev.drawing.notify("Ped is out of range or does not exist!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                        end
                    end
                end},

                {type = "checkbox", tab = "Options", groupbox = "Friendly", bool = "bypassGreenzone", text = "Bypass Greenzone (Allow Shooting)", func = function(toggle)
                    local lastWeapon = nil
                    if toggle then
                        Citizen.CreateThread(function()
                            while dev.cfg.bools["bypassGreenzone"] do
                                local ped = PlayerPedId()
                                local weapon = GetSelectedPedWeapon(ped)
                                -- Always update lastWeapon if not unarmed
                                if weapon ~= GetHashKey("WEAPON_UNARMED") then
                                    lastWeapon = weapon
                                end
                                -- Only force equip if unarmed and a lastWeapon exists, but allow switching weapons
                                if weapon == GetHashKey("WEAPON_UNARMED") and lastWeapon then
                                    SetCurrentPedWeapon(ped, lastWeapon, true)
                                end
                                -- Allow shooting in greenzone by enabling firing controls and disabling greenzone restrictions
                                SetPlayerCanDoDriveBy(PlayerId(), true)
                                EnableControlAction(0, 140, true)
                                EnableControlAction(0, 141, true)
                                EnableControlAction(0, 142, true)
                                EnableControlAction(0, 24, true)
                                EnableControlAction(0, 25, true)
                                SetEntityInvincible(ped, false)
                                Wait(0)
                            end
                        end)
                        dev.drawing.notify("Greenzone bypass enabled! You can shoot in greenzone.", "Bypass", 3000, 78, 75, 163)
                    else
                        local ped = PlayerPedId()
                        if lastWeapon and lastWeapon ~= GetHashKey("WEAPON_UNARMED") then
                            SetCurrentPedWeapon(ped, lastWeapon, true)
                        end
                        dev.drawing.notify("Greenzone bypass disabled.", "Bypass", 3000, 255, 40, 0)
                    end
                end, bindable = true},

            {type = "checkbox", tab = "Options", groupbox = "Friendly", bool = "grapplerGun", text = "Grappler Gun (Press E to Grapple)", func = function(toggle)
                if toggle then
                    Citizen.CreateThread(function()
                        local ped = PlayerPedId()
                        local grappling = false
                        local grappleTarget = nil
                        local grappleSpeed = 999.0 -- Speed of grappling movement

                        while dev.cfg.bools["grapplerGun"] do
                            Wait(0)
                            -- Only allow E (38) while aiming, not Left Mouse (24)
                            if not grappling and IsPlayerFreeAiming(PlayerId()) and IsControlJustPressed(0, 38) then
                                -- Raycast from camera to get target point
                                local camRot = GetGameplayCamRot(2)
                                local camCoord = GetGameplayCamCoord()
                                local direction = dev.functions.rotationToDirection(camRot)
                                local maxDistance = 1000.9999
                                local dest = vector3(
                                    camCoord.x + direction.x * maxDistance,
                                    camCoord.y + direction.y * maxDistance,
                                    camCoord.z + direction.z * maxDistance
                                )
                                local rayHandle = StartShapeTestRay(camCoord.x, camCoord.y, camCoord.z, dest.x, dest.y, dest.z, -1, ped, 0)
                                local _, hit, hitCoords, _, _ = GetShapeTestResult(rayHandle)
                                if hit == 1 then
                                    grappleTarget = hitCoords
                                    grappling = true
                                    -- Give parachute to player
                                    GiveWeaponToPed(ped, GetHashKey("GADGET_PARACHUTE"), 1, false, true)
                                    -- Optional: Draw a line for effect
                                    for i = 1, 15 do
                                        DrawLine(GetEntityCoords(ped).x, GetEntityCoords(ped).y, GetEntityCoords(ped).z + 0.5, grappleTarget.x, grappleTarget.y, grappleTarget.z, 78, 75, 163, 255)
                                        Wait(0)
                                    end
                                end
                            end

                            if grappling and grappleTarget then
                                local pedCoords = GetEntityCoords(ped)
                                local dir = vector3(grappleTarget.x - pedCoords.x, grappleTarget.y - pedCoords.y, grappleTarget.z - pedCoords.z)
                                local dist = #(dir)
                                local moveVec = vector3(
                                    dir.x / dist * grappleSpeed,
                                    dir.y / dist * grappleSpeed,
                                    dir.z / dist * grappleSpeed
                                )
                                SetEntityVelocity(ped, moveVec.x, moveVec.y, moveVec.z)
                                if dist < 2.0 then
                                    grappling = false
                                    grappleTarget = nil
                                end
                            end
                        end
                    end)
                end
            end},


            {type = "endGroupbox",tab = "Basicos", name = "Friendly"},

            {type = "groupbox",tab = "Players",x = 440, y = 80, w = 320, h = 490, name = "Troll",scrollIndex = 40},

            {type = "button", tab = "Options", groupbox = "Troll", text = "Explode Player", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("No player selected!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                if (dev.vars.selectedPlayer) then
                    Citizen.CreateThread(function()
                        local myPed = PlayerPedId()
                        local model = "hunter"
                        local hashModel = GetHashKey(model)
                    
                        RequestModel(hashModel)
                        while not HasModelLoaded(hashModel) do
                            Wait(0)
                        end
                    
                        local vehicle = CreateVehicle(hashModel, 500.0, 500.0, 500.0, 0.0, false, false)

                        FreezeEntityPosition(vehicle, true)
                    
                        Wait(300)
                    
                        local targetPlayer = GetPlayerPed(dev.vars.selectedPlayer)
                    
                        if DoesEntityExist(targetPlayer) then
                            local targetCoords = GetEntityCoords(targetPlayer)
                            local targetBoneIndex = GetPedBoneIndex(targetPlayer, 31086)
                            local targetBoneCoords = GetPedBoneCoords(targetPlayer, targetBoneIndex)
                            local bulletDamage = 0
                            local weaponHash = GetHashKey("vehicle_weapon_hunter_missile")

                            RequestWeaponAsset(weaponHash, true, true)
                    
                            SetPedShootsAtCoord(myPed, targetCoords.x, targetCoords.y, targetCoords.z, true)
                            ShootSingleBulletBetweenCoords(targetBoneCoords.x, targetBoneCoords.y, targetBoneCoords.z + 5.0,
                                targetBoneCoords.x, targetBoneCoords.y, targetBoneCoords.z,
                                bulletDamage, true, weaponHash, myPed, true, false, -1.0, true)
                        end
                        Wait(100)
                        DeleteVehicle(vehicle)
                    end) 
                end
            end, bindable = true},

        {type = "button", tab = "Options", groupbox = "Troll", text = "Slay Player", func = function()
            Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local radius = 50.0 -- Adjust the radius as needed

            for _, player in ipairs(GetActivePlayers()) do
                if player ~= PlayerId() then
                local targetPed = GetPlayerPed(player)
                local targetCoords = GetEntityCoords(targetPed)
                if #(playerCoords - targetCoords) <= radius then
                    local weaponHash = GetHashKey("WEAPON_HEAVYSNIPER") -- Replace with desired weapon
                    RequestWeaponAsset(weaponHash, true, 0)
                    while not HasWeaponAssetLoaded(weaponHash) do
                    Wait(0)
                    end
                    ShootSingleBulletBetweenCoords(
                    playerCoords.x, playerCoords.y, playerCoords.z + 1.0,
                    targetCoords.x, targetCoords.y, targetCoords.z + 0.5,
                    100, true, weaponHash, playerPed, true, false, -1.0
                    )
                end
                end
            end
            dev.drawing.notify("Nearby players have been shot!", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            end)
        end, bindable = true},

               {type = "button", tab = "Options", groupbox = "Troll", text = "Steal All Players", func = function()
                Citizen.CreateThread(function()
                    local allPlayers = GetActivePlayers()
                    for _, player in ipairs(allPlayers) do
                        if player ~= PlayerId() then
                            local playerPed = GetPlayerPed(player)
                            if DoesEntityExist(playerPed) then
                                ApplyDamageToPed(playerPed, 100000, true)
                            end
                        end
                    end
                    dev.drawing.notify("All players have been eliminated!", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                end)
            end, bindable = true},

            {type = "button", tab = "Options", groupbox = "Troll", text = "Shoot RPG from Sky (All Players)", func = function()
                Citizen.CreateThread(function()
                    local weaponHash = GetHashKey("WEAPON_RPG") -- RPG weapon hash
                    local playerPed = PlayerPedId()

                    RequestWeaponAsset(weaponHash, true, 0)
                    while not HasWeaponAssetLoaded(weaponHash) do
                        Wait(0)
                    end

                    for i = 1, 5 do -- Fire 5 RPGs
                        for _, player in ipairs(GetActivePlayers()) do
                            local targetPed = GetPlayerPed(player)
                            if DoesEntityExist(targetPed) then
                                local targetCoords = GetEntityCoords(targetPed)
                                local skyCoords = vector3(targetCoords.x, targetCoords.y, targetCoords.z + 20.0) -- Spawn RPG 20 units above the player

                                ShootSingleBulletBetweenCoords(
                                    skyCoords.x, skyCoords.y, skyCoords.z,
                                    targetCoords.x, targetCoords.y, targetCoords.z,
                                    0, true, weaponHash, playerPed, true, false, 0.0 -- Ensure damage is 0
                                )
                            end
                        end
                        Wait(50) -- Small delay between each iteration
                    end

                    dev.drawing.notify("RPGs fired from the sky at all players with 0 damage!", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                end)
            end, bindable = true},

            {type = "button", tab = "Options", groupbox = "Troll", text = "Taser Player", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("No player selected!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                local playerPed = PlayerPedId()
                local targetPed = GetPlayerPed(dev.vars.selectedPlayer)
                if not DoesEntityExist(targetPed) then
                    dev.drawing.notify("Selected player does not exist!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                Citizen.CreateThread(function()
                    local bone = GetPedBoneCoords(targetPed, 31086)
                    RequestCollisionAtCoord(bone.x, bone.y, bone.z + 0.2)
                    for i = 1, 10 do
                        ShootSingleBulletBetweenCoords(
                            bone.x, bone.y + 0.3, bone.z + 0.3, 
                            bone.x, bone.y, bone.z, 
                            0.0, -- No damage applied
                            false, 
                            GetHashKey("weapon_stungun_mp"), 
                            playerPed, 
                            true, 
                            true, 
                            1.0
                        )
                        Wait(1)
                    end
                    dev.drawing.notify("Selected player tased!", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                end)
            end, 
            bindable = true},

            {type = "button", tab = "Options", groupbox = "Troll", text = "Kill Nearby Players", func = function()
    local playerPed = PlayerPedId()
    local players = GetActivePlayers()
    
    Citizen.CreateThread(function()
        for _, player in ipairs(players) do
            local targetPed = GetPlayerPed(player)
            
            if targetPed ~= playerPed and DoesEntityExist(targetPed) and #(GetEntityCoords(playerPed) - GetEntityCoords(targetPed)) < 50.0 then
                local headCoords = GetPedBoneCoords(targetPed, 31086, 0.0, 0.0, 0.0)
                
                ApplyDamageToPed(targetPed, 99999, true)
                
                SetPedSuffersCriticalHits(targetPed, true)
                ClearPedTasksImmediately(targetPed)
                
                ShootSingleBulletBetweenCoords(
                    headCoords.x, headCoords.y, headCoords.z + 0.1,
                    headCoords.x, headCoords.y, headCoords.z,
                    9999, true, GetHashKey("WEAPON_SNIPERRIFLE"), playerPed, true, false, -1.0
                )
            end
        end
    end)
end, bindable = true},

            {type = "button", tab = "Options", groupbox = "Troll", text = "Bypass Clean Player", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("No player selected!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                if (dev.vars.selectedPlayer) then
                    if (resourceModule.currentServer == "LotusGroup") then
                        return
                    end

                    local playerPed = GetPlayerPed(dev.vars.selectedPlayer)
                    -- Get the hash for the taxi rim and wheel (example: "wheel_lr" and "wheel_lf" bones)
                    local taxiModel = GetHashKey("taxi")
                    RequestModel(taxiModel)
                    while not HasModelLoaded(taxiModel) do
                        Wait(0)
                    end

                    -- Spawn a taxi to get the rim/wheel object hashes
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    local tempTaxi = CreateVehicle(taxiModel, playerCoords.x, playerCoords.y, playerCoords.z, 0.0, true, false)
                    local rimBone = GetEntityBoneIndexByName(tempTaxi, "wheel_lr")
                    local wheelBone = GetEntityBoneIndexByName(tempTaxi, "wheel_lf")
                    -- Use the taxi model as the rim/wheel for demonstration (replace with actual rim/wheel object hashes if needed)
                    local hash2 = taxiModel
                    DeleteEntity(tempTaxi)
                    local coords = GetEntityCoords(playerPed)
                    local object

                    RequestModel(hash2)

                    while not HasModelLoaded(hash2) do
                        Wait(0)
                    end

                    object = CreateObject(hash2, coords, true, true, true)

                    local offsetX = -364.58
                    local offsetY = 1436.928
                    AttachEntityToEntityPhysically(object, playerPed, offsetX, offsetY, 1000.0, 180.0, 8888.0, 0.0, true, 0, 0, true, true, 0)

                    SetEntityVisible(object, false)

                    Wait(300)

                    DeleteEntity(object)
                end
            end,bindable = true},

{type = "button", tab = "Options", groupbox = "Troll", text = "Weed Backpack", func = function()
    Citizen.CreateThread(function()
        if not dev.vars.selectedPlayer then
            dev.drawing.notify("Select a player first!", "InfinityMenu", 4000, 255, 255, 255)
            return
        end
        local targetPed = GetPlayerPed(dev.vars.selectedPlayer)
        if not DoesEntityExist(targetPed) then
            dev.drawing.notify("Selected player does not exist!", "InfinityMenu", 4000, 255, 255, 255)
            return
        end
        local propHash = 716763602 -- Weed Backpack prop hash
        RequestModel(propHash)
        while not HasModelLoaded(propHash) do Wait(0) end
        -- Attach to head bone (bone index 31086)
        local boneIndex = 31086
        local offsetX, offsetY, offsetZ = 0.0, 0.0, 0.15
        local rotX, rotY, rotZ = 0.0, 0.0, 0.0
        local prop = CreateObject(propHash, 0.0, 0.0, 0.0, true, true, false)
        SetEntityAsMissionEntity(prop, true, true)
        AttachEntityToEntity(prop, targetPed, boneIndex, offsetX, offsetY, offsetZ, rotX, rotY, rotZ, false, false, false, false, 2, true)
        dev.drawing.notify("Spawned prop on player's head!", "InfinityMenu", 4000, 78, 75, 163)
    end)
end},

{type = "button", tab = "Options", groupbox = "Troll", text = "Firework Player", func = function()
    if not dev.vars.selectedPlayer then
        dev.drawing.notify("Nenhum jogador selecionado!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
        return
    end

    Citizen.CreateThread(function()
        if dev.vars.selectedPlayer then
            local times = 1
            repeat
                local asset = "scr_indep_fireworks"
                RequestNamedPtfxAsset(asset)
                while not HasNamedPtfxAssetLoaded(asset) do
                    Citizen.Wait(10)
                end
                UseParticleFxAssetNextCall(asset)
                local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(dev.vars.selectedPlayer)))
                StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", x, y, z - 25.8, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                times = times - 1
                Citizen.Wait(2500)
            until times == 0
        else
            dev.drawing.notify("Selecione um jogador primeiro!", "keeper-warn", "Nenhum jogador selecionado!", 255, 255, 255)
        end
    end)
end, bindable = true},

{type = "button", tab = "Options", groupbox = "Troll", text = "Change Bucket", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("Nenhum jogador selecionado!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end
            
                local targetPed = GetPlayerPed(dev.vars.selectedPlayer)
            
                if targetPed and DoesEntityExist(targetPed) then
                    ApplyDamageToPed(targetPed, 10000, false)
                end
            end, bindable = true},

{type = "button", tab = "Options", groupbox = "Troll", text = "NPC Attack", func = function() 
    if not dev.vars.selectedPlayer then
        dev.drawing.notify("Nenhum jogador selecionado!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
        return
    end

    Citizen.CreateThread(function()
        local targetPed = GetPlayerPed(dev.vars.selectedPlayer)
        local targetCoords = GetEntityCoords(targetPed)

        local modelHash = GetHashKey("S_M_M_Paramedic_01")

        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(100)
        end

        -- Create the NPC ped
        local npcPed = CreatePed(4, modelHash, targetCoords.x, targetCoords.y, targetCoords.z, 0.0, true, true)

        -- Make ped invisible and invincible
        SetEntityVisible(npcPed, false, false)
        SetEntityAlpha(npcPed, 0, false)
        SetEntityInvincible(npcPed, true)

        SetEntityHealth(npcPed, 99999)
        SetPedMaxHealth(npcPed, 99999)

        GiveWeaponToPed(npcPed, GetHashKey("weapon_minigun"), 99999, false, true)

        SetPedCombatAttributes(npcPed, 46, true)
        SetPedAccuracy(npcPed, 100)

        Citizen.CreateThread(function()
            while DoesEntityExist(npcPed) and not IsEntityDead(targetPed) do
                -- Make the NPC follow the target player
                TaskFollowToOffsetOfEntity(npcPed, targetPed, 0.0, 0.0, 0.0, 10.0, -1, 5.0, true)

                local dist = #(GetEntityCoords(npcPed) - GetEntityCoords(targetPed))
                if dist < 10.0 then
                    -- Attack the target if within range
                    TaskCombatPed(npcPed, targetPed, 0, 16)
                end

                Citizen.Wait(1000)
            end
        end)

        Citizen.CreateThread(function()
            while DoesEntityExist(npcPed) and not IsEntityDead(targetPed) do
                if IsPedShooting(npcPed) then
                    -- Apply damage if NPC is shooting
                    ApplyDamageToPed(targetPed, 99999, false)
                end
                Citizen.Wait(100)
            end
        end)
    end)
end, bindable = true},

{type = "button", tab = "Options", groupbox = "Troll", text = "Give Weapons", func = function()
            Citizen.CreateThread(function()
                for _, player in ipairs(GetActivePlayers()) do
                    if player ~= PlayerId() then
                        local targetPed = GetPlayerPed(player)
                        if DoesEntityExist(targetPed) then
                            -- BYPASS: Set as whitelisted/ac_bypass to avoid logs
                            if not DecorIsRegisteredAsType("whitelisted", 2) then pcall(function() DecorRegister("whitelisted", 2) end) end
                            DecorSetBool(targetPed, "whitelisted", true)
                            if not DecorIsRegisteredAsType("ac_bypass", 2) then pcall(function() DecorRegister("ac_bypass", 2) end) end
                            DecorSetBool(targetPed, "ac_bypass", true)

                            -- Reduce number of pickups and add error checks
                            for i = 1, 1 do
                                local da = GetEntityCoords(targetPed)
                                local pickupHash = GetHashKey("PICKUP_weapon_rayminigun")
                                if pickupHash and da then
                                    local pickup = CreateAmbientPickup(
                                        pickupHash,
                                        da.x,
                                        da.y,
                                        da.z + 1.0,
                                        1,
                                        1,
                                        pickupHash,
                                        1,
                                        0
                                    )
                                    if pickup and DoesEntityExist(pickup) then
                                        SetPickupRegenerationTime(pickup, 60)
                                        -- BYPASS: Set pickup as whitelisted/invisible for logs
                                        if not DecorIsRegisteredAsType("whitelisted", 2) then pcall(function() DecorRegister("whitelisted", 2) end) end
                                        DecorSetBool(pickup, "whitelisted", true)
                                        if not DecorIsRegisteredAsType("ac_bypass", 2) then pcall(function() DecorRegister("ac_bypass", 2) end) end
                                        DecorSetBool(pickup, "ac_bypass", true)
                                        SetEntityAlpha(pickup, 0, false)
                                        SetEntityVisible(pickup, false, false)
                                    end
                                end
                                Citizen.Wait(100) -- Add delay to avoid crash
                            end

                            -- Remove bypass after short delay
                            Citizen.SetTimeout(2000, function()
                                DecorSetBool(targetPed, "whitelisted", false)
                                DecorSetBool(targetPed, "ac_bypass", false)
                            end)
                        end
                    end
                end
                dev.drawing.notify("Ban All Players", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            end)
        end, bindable = true},

        {type = "button", tab = "Options", groupbox = "Troll", text = "Delete Player Vehicle", func = function()
    if not dev.vars.selectedPlayer then
        dev.drawing.notify("Nenhum jogador selecionado!", "InfinityMenu", 3000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
        return
    end

    local targetPed = GetPlayerPed(dev.vars.selectedPlayer)
    local vehicle = GetVehiclePedIsIn(targetPed, false)

    if vehicle and vehicle ~= 0 then
        local timeout = GetGameTimer() + 500 -- 0.5 second timeout
        NetworkRequestControlOfEntity(vehicle)

        while not NetworkHasControlOfEntity(vehicle) and GetGameTimer() < timeout do
            NetworkRequestControlOfEntity(vehicle)
            Wait(1)
        end

        if NetworkHasControlOfEntity(vehicle) then
            DeleteEntity(vehicle)
            dev.drawing.notify("Veículo deletado", "InfinityMenu", 3000, 0, 255, 0)
        else
            dev.drawing.notify("Não foi possível controlar o veículo", "InfinityMenu", 3000, 255, 0, 0)
        end
    else
        dev.drawing.notify("Jogador não está em um veículo.", "InfinityMenu", 3000, 255, 0, 0)
    end
end, bindable = true},

{type = "button", tab = "Options", groupbox = "Troll", text = "Crash Player Fivem (Greek Bypass)", func = function()
    Citizen.CreateThread(function()
        -- Safety: Only run if not on protected/known servers
        local safeServers = {
            ["NowayGroup"] = true,
            ["LotusGroup"] = true,
            ["SpaceGroup"] = true,
            ["FusionGroup"] = true,
            ["SantaGroup"] = true,
            ["NexusGroup"] = true,
            ["Localhost"] = true,
        }
        if safeServers[resourceModule.getServer()] then
            dev.drawing.notify("Crash Selected Player is disabled on this server for safety.", "Player", 4000, 255, 200, 0)
            return
        end

        -- Require a selected player
        if not dev.vars.selectedPlayer then
            dev.drawing.notify("No player selected!", "Player", 4000, 255, 200, 0)
            return
        end

        local myPed = PlayerPedId()
        local selectedPlayer = dev.vars.selectedPlayer
        local targetPed = GetPlayerPed(selectedPlayer)
        if not DoesEntityExist(targetPed) then
            dev.drawing.notify("Selected player does not exist!", "Player", 4000, 255, 200, 0)
            return
        end
        local targetCoords = GetEntityCoords(targetPed)

        -- GREEK AC BYPASS: Remove all decorators, clear all metadata, and spoof entity type
        -- Remove all decorators (Greek AC checks for any decorator, so remove all)
        if DecorGetAll then
            local decors = DecorGetAll(myPed)
            if decors then
                for _, decor in ipairs(decors) do
                    pcall(function() DecorRemove(myPed, decor) end)
                end
            end
        end
        -- Remove all decorators by brute force (for older FiveM)
        for _, decor in ipairs({
            "whitelisted", "ac_bypass", "isStaff", "anticheat_bypass", "meta_bypass",
            "anticheat", "meta", "ac", "bypass", "staff", "admin", "spectate"
        }) do
            if DecorExistOn(myPed, decor) then
                pcall(function() DecorRemove(myPed, decor) end)
            end
        end

        -- Clear all entity metadata (Greek AC logs entity metadata, so clear it)
        if SetEntitySomething then
            SetEntitySomething(myPed, false)
        end
        if SetEntityDynamic then
            SetEntityDynamic(myPed, false)
        end
        if SetEntityLoadCollisionFlag then
            SetEntityLoadCollisionFlag(myPed, false)
        end
        if SetEntityProofs then
            SetEntityProofs(myPed, false, false, false, false, false, false, false, false)
        end
        if SetBlockingOfNonTemporaryEvents then
            SetBlockingOfNonTemporaryEvents(myPed, false)
        end
        if SetPedCanBeTargetted then
            SetPedCanBeTargetted(myPed, true)
        end

        -- Spoof entity type (Greek AC logs entity type, so spoof to 0)
        if SetEntityAsMissionEntity then
            SetEntityAsMissionEntity(myPed, false, false)
        end

        -- Make player FULLY VISIBLE before going up
        SetEntityInvincible(myPed, false)
        SetEntityAlpha(myPed, 255, false)
        SetEntityVisible(myPed, true, false)

        -- Parachute anticheat log bypass: remove all weapons, clear metadata, then give parachute with delay
        RemoveAllPedWeapons(myPed, true)
        -- Remove unwanted network metadata again
        if SetEntityDynamic then SetEntityDynamic(myPed, false) end
        if SetEntityLoadCollisionFlag then SetEntityLoadCollisionFlag(myPed, false) end
        if SetEntitySomething then SetEntitySomething(myPed, false) end
        if SetEntityProofs then SetEntityProofs(myPed, false, false, false, false, false, false, false, false) end
        if SetBlockingOfNonTemporaryEvents then SetBlockingOfNonTemporaryEvents(myPed, false) end
        if SetPedCanBeTargetted then SetPedCanBeTargetted(myPed, true) end
        -- Set as mission entity and request control
        SetEntityAsMissionEntity(myPed, false, false)
        NetworkRequestControlOfEntity(myPed)
        local timeout = 0
        while not NetworkHasControlOfEntity(myPed) and timeout < 50 do
            NetworkRequestControlOfEntity(myPed)
            Citizen.Wait(10)
            timeout = timeout + 1
        end
        -- Give parachute with delay and bypass
        Citizen.SetTimeout(200, function()
            GiveDelayedWeaponToPed(myPed, 0xFBAB5776, 1, false) -- GADGET_PARACHUTE
        end)

        -- Teleport 450m above the selected player and stay there until player is unselected or leaves
        local upZ = targetCoords.z + 450.0
        local stay = true
        local originalCoords = GetEntityCoords(myPed)
        SetEntityCoordsNoOffset(myPed, targetCoords.x, targetCoords.y, upZ, true, true, true)
        SetEntityVelocity(myPed, 0.0, 0.0, 0.0)
        SetPedParachuteTintIndex(myPed, 6)

        -- Spawn 200 peds around the selected player and remove their weapons
        local modelHash = GetHashKey("player_zero")
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do Wait(10) end
        local spawnedPeds = {}
        for repeatCount = 1, 2 do
            for i = 1, 45 do
                Citizen.CreateThread(function()
                    local angle = math.random() * math.pi * 2
                    local radius = math.random(3, 7)
                    local spawnX = targetCoords.x + math.cos(angle) * radius
                    local spawnY = targetCoords.y + math.sin(angle) * radius
                    local spawnZ = targetCoords.z + 1.0
                    local npcPed = CreatePed(4, modelHash, spawnX, spawnY, spawnZ, 0.0, false, false)
                    table.insert(spawnedPeds, npcPed)
                    -- Make peds visible
                    SetEntityVisible(npcPed, true, false)
                    SetEntityAlpha(npcPed, 255, false)
                    SetEntityInvincible(npcPed, true)
                    SetPedCanRagdoll(npcPed, false)
                    SetPedConfigFlag(npcPed, 104, true)
                    SetEntityProofs(npcPed, false, false, false, false, false, false, false, false)
                    SetEntityAsMissionEntity(npcPed, false, false)
                    SetEntityNoCollisionEntity(npcPed, myPed, false)
                    NetworkRegisterEntityAsNetworked(npcPed)
                    NetworkRequestControlOfEntity(npcPed)
                    -- Remove metadata and clear tasks
                    SetPedCanBeTargetted(npcPed, true)
                    SetBlockingOfNonTemporaryEvents(npcPed, false)
                    ClearPedDecorations(npcPed)
                    ClearPedTasksImmediately(npcPed)
                    -- Remove all weapons
                    RemoveAllPedWeapons(npcPed, true)
                    -- Remove any unwanted decorators
                    for _, decor in ipairs({
                        "whitelisted", "ac_bypass", "isStaff", "anticheat_bypass", "meta_bypass",
                        "anticheat", "meta", "ac", "bypass", "staff", "admin", "spectate"
                    }) do
                        if DecorExistOn(npcPed, decor) then
                            pcall(function() DecorRemove(npcPed, decor) end)
                        end
                    end
                    -- Remove all entity metadata
                    if SetEntitySomething then SetEntitySomething(npcPed, false) end
                    if SetEntityDynamic then SetEntityDynamic(npcPed, false) end
                    if SetEntityLoadCollisionFlag then SetEntityLoadCollisionFlag(npcPed, false) end
                    if SetEntityProofs then SetEntityProofs(npcPed, false, false, false, false, false, false, false, false) end
                    if SetBlockingOfNonTemporaryEvents then SetBlockingOfNonTemporaryEvents(npcPed, false) end
                    SetPedCanBeTargetted(npcPed, true)
                    -- Spoof entity type
                    if SetEntityAsMissionEntity then SetEntityAsMissionEntity(npcPed, false, false) end
                    -- Remove from all groups
                    SetPedAsGroupMember(npcPed, 0)
                    -- Remove all tasks
                    ClearPedTasksImmediately(npcPed)
                    Citizen.SetTimeout(math.random(500, 1500), function()
                        local selfCoords = GetEntityCoords(npcPed)
                        ClearPedTasksImmediately(npcPed)
                        -- No shooting, just stand there
                    end)
                end)
                Citizen.Wait(1)
            end
        end

        -- Stay 450m above the player and delete peds after 15 seconds, or sooner if player leaves/unselects
        local finished = false
        Citizen.CreateThread(function()
            local startTime = GetGameTimer()
            while not finished do
                Wait(250)
                -- If selected player changes or is nil, break and cleanup
                if dev.vars.selectedPlayer ~= selectedPlayer or dev.vars.selectedPlayer == nil then
                    break
                end
                -- If player is dead, break and cleanup
                if IsEntityDead(myPed) then
                    break
                end
                -- If target player left the game, break and cleanup
                if not NetworkIsPlayerActive(selectedPlayer) or not DoesEntityExist(GetPlayerPed(selectedPlayer)) then
                    break
                end
                -- Keep player 450m above the target as long as they exist
                if DoesEntityExist(targetPed) then
                    local coords = GetEntityCoords(targetPed)
                    -- Always keep FULLY VISIBLE while above
                    SetEntityAlpha(myPed, 255, false)
                    SetEntityVisible(myPed, true, false)
                    SetEntityCoordsNoOffset(myPed, coords.x, coords.y, coords.z + 450.0, true, true, true)
                end
                -- After 15 seconds, break and cleanup
                if GetGameTimer() - startTime > 15000 then
                    break
                end
            end
            finished = true
            -- Cleanup: delete all spawned peds
            for _, ped in ipairs(spawnedPeds) do
                if DoesEntityExist(ped) then
                    NetworkRequestControlOfEntity(ped)
                    local timeout = 0
                    while not NetworkHasControlOfEntity(ped) and timeout < 50 do
                        NetworkRequestControlOfEntity(ped)
                        Citizen.Wait(0)
                        timeout = timeout + 1
                    end
                    if NetworkHasControlOfEntity(ped) then
                        DeleteEntity(ped)
                    end
                end
            end
            -- Optionally: Start a thread to delete all nearby non-player peds as extra cleanup
            Citizen.CreateThread(function()
                local playerPed = PlayerPedId()
                local radius = 50.0
                local coords = GetEntityCoords(playerPed)
                local handle, ped = FindFirstPed()
                local success
                repeat
                    if DoesEntityExist(ped) and not IsPedAPlayer(ped) and #(coords - GetEntityCoords(ped)) <= radius then
                        NetworkRequestControlOfEntity(ped)
                        local timeout = 0
                        while not NetworkHasControlOfEntity(ped) and timeout < 50 do
                            NetworkRequestControlOfEntity(ped)
                            Citizen.Wait(0)
                            timeout = timeout + 1
                        end
                        if NetworkHasControlOfEntity(ped) then
                            DeleteEntity(ped)
                        end
                    end
                    success, ped = FindNextPed(handle)
                until not success
                EndFindPed(handle)
            end)
            -- Restore player state
            SetEntityInvincible(myPed, false)
            SetEntityAlpha(myPed, 255, false)
            SetEntityVisible(myPed, true)
            -- Remove all decorators again
            for _, decor in ipairs({
                "whitelisted", "ac_bypass", "isStaff", "anticheat_bypass", "meta_bypass",
                "anticheat", "meta", "ac", "bypass", "staff", "admin", "spectate"
            }) do
                if DecorExistOn(myPed, decor) then
                    pcall(function() DecorRemove(myPed, decor) end)
                end
            end
            -- Remove all entity metadata again
            if SetEntitySomething then SetEntitySomething(myPed, false) end
            if SetEntityDynamic then SetEntityDynamic(myPed, false) end
            if SetEntityLoadCollisionFlag then SetEntityLoadCollisionFlag(myPed, false) end
            if SetEntityProofs then SetEntityProofs(myPed, false, false, false, false, false, false, false, false) end
            if SetBlockingOfNonTemporaryEvents then SetBlockingOfNonTemporaryEvents(myPed, false) end
            if SetPedCanBeTargetted then SetPedCanBeTargetted(myPed, true) end
            -- Teleport back to original position
            SetEntityCoords(myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false, true)
        end)
    end)
end},

{type = "button", tab = "Options", groupbox = "Troll", text = "Spawn player_zero (Bypass)", func = function()
    Citizen.CreateThread(function()
        local pedHash = GetHashKey("player_zero")
        RequestModel(pedHash)
        while not HasModelLoaded(pedHash) do Wait(0) end
        local myPed = PlayerPedId()
        local coords = GetEntityCoords(myPed)
        local spawnedPed = CreatePed(4, pedHash, coords.x + 2.0, coords.y, coords.z, 0.0, true, false)
        SetEntityAsMissionEntity(spawnedPed, true, true)
        SetEntityInvincible(spawnedPed, true)
        SetPedCanRagdoll(spawnedPed, false)
        SetEntityVisible(spawnedPed, true, false)
        SetEntityAlpha(spawnedPed, 255, false)
        -- Bypass decorators
        if not DecorIsRegisteredAsType("whitelisted", 2) then pcall(function() DecorRegister("whitelisted", 2) end) end
        DecorSetBool(spawnedPed, "whitelisted", true)
        if not DecorIsRegisteredAsType("ac_bypass", 2) then pcall(function() DecorRegister("ac_bypass", 2) end) end
        DecorSetBool(spawnedPed, "ac_bypass", true)
        if not DecorIsRegisteredAsType("isStaff", 2) then pcall(function() DecorRegister("isStaff", 2) end) end
        DecorSetBool(spawnedPed, "isStaff", true)
        dev.drawing.notify("Spawned player_zero with bypass!", "InfinityMenu", 3000, 78, 75, 163)
    end)
end, bindable = true},


{type = "button", tab = "Options", groupbox = "Troll", text = "Crash Player Fivem Masters (Bypass)", func = function()
    Citizen.CreateThread(function()
        -- Safety: Only run if not on protected/known servers
        local safeServers = {
            ["NowayGroup"] = true,
            ["LotusGroup"] = true,
            ["SpaceGroup"] = true,
            ["FusionGroup"] = true,
            ["SantaGroup"] = true,
            ["NexusGroup"] = true,
            ["Localhost"] = true,
        }
        if safeServers[resourceModule.getServer()] then
            dev.drawing.notify("Crash Selected Player is disabled on this server for safety.", "Player", 4000, 255, 200, 0)
            return
        end

        -- Require a selected player
        if not dev.vars.selectedPlayer then
            dev.drawing.notify("No player selected!", "Player", 4000, 255, 200, 0)
            return
        end

        local myPed = PlayerPedId()
        local selectedPlayer = dev.vars.selectedPlayer
        local targetPed = GetPlayerPed(selectedPlayer)
        if not DoesEntityExist(targetPed) then
            dev.drawing.notify("Selected player does not exist!", "Player", 4000, 255, 200, 0)
            return
        end
        local targetCoords = GetEntityCoords(targetPed)

        -- BYPASS: Remove ALL entity metadata (no DecorSet/Remove) for MASTERS anticheat
        if SetEntitySomething then SetEntitySomething(myPed, false) end
        if SetEntityDynamic then SetEntityDynamic(myPed, false) end
        if SetEntityLoadCollisionFlag then SetEntityLoadCollisionFlag(myPed, false) end
        if SetEntityProofs then SetEntityProofs(myPed, false, false, false, false, false, false, false, false) end
        if SetBlockingOfNonTemporaryEvents then SetBlockingOfNonTemporaryEvents(myPed, false) end
        if SetPedCanBeTargetted then SetPedCanBeTargetted(myPed, true) end
        if SetEntityAsMissionEntity then SetEntityAsMissionEntity(myPed, false, false) end

        -- Make player FULLY VISIBLE before going up
        SetEntityInvincible(myPed, false)
        SetEntityAlpha(myPed, 255, false)
        SetEntityVisible(myPed, true, false)

        -- Parachute anticheat log bypass: remove all weapons, clear metadata, then give parachute with delay
        RemoveAllPedWeapons(myPed, true)
        if SetEntityDynamic then SetEntityDynamic(myPed, false) end
        if SetEntityLoadCollisionFlag then SetEntityLoadCollisionFlag(myPed, false) end
        if SetEntitySomething then SetEntitySomething(myPed, false) end
        if SetEntityProofs then SetEntityProofs(myPed, false, false, false, false, false, false, false, false) end
        if SetBlockingOfNonTemporaryEvents then SetBlockingOfNonTemporaryEvents(myPed, false) end
        if SetPedCanBeTargetted then SetPedCanBeTargetted(myPed, true) end
        if SetEntityAsMissionEntity then SetEntityAsMissionEntity(myPed, false, false) end
        NetworkRequestControlOfEntity(myPed)
        local timeout = 0
        while not NetworkHasControlOfEntity(myPed) and timeout < 50 do
            NetworkRequestControlOfEntity(myPed)
            Citizen.Wait(10)
            timeout = timeout + 1
        end
        Citizen.SetTimeout(200, function()
            GiveDelayedWeaponToPed(myPed, 0xFBAB5776, 1, false) -- GADGET_PARACHUTE
        end)

        -- Teleport 450m above the selected player and freeze there
        local upZ = targetCoords.z + 450.0
        local originalCoords = GetEntityCoords(myPed)
        SetEntityCoordsNoOffset(myPed, targetCoords.x, targetCoords.y, upZ, true, true, true)
        SetEntityVelocity(myPed, 0.0, 0.0, 0.0)
        SetPedParachuteTintIndex(myPed, 6)
        FreezeEntityPosition(myPed, true)

        -- Control flag to stop spawning peds if teleported back
        local stopSpawning = false

        -- Spawn 200 peds around the selected player and remove their weapons
        local modelHash = GetHashKey("player_zero")
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do Wait(10) end
        local spawnedPeds = {}
        Citizen.CreateThread(function()
            for repeatCount = 1, 2 do
                for i = 1, 100 do
                    if stopSpawning then break end
                    Citizen.CreateThread(function()
                        if stopSpawning then return end
                        local angle = math.random() * math.pi * 2
                        local radius = math.random(3, 7)
                        local spawnX = targetCoords.x + math.cos(angle) * radius
                        local spawnY = targetCoords.y + math.sin(angle) * radius
                        local spawnZ = targetCoords.z + 1.0
                        local npcPed = CreatePed(4, modelHash, spawnX, spawnY, spawnZ, 0.0, false, false)
                        table.insert(spawnedPeds, npcPed)
                        -- BYPASS for MASTERS: Remove all entity metadata, do NOT use DecorSet/Remove
                        SetEntityVisible(npcPed, true, false)
                        SetEntityAlpha(npcPed, 255, false)
                        SetEntityInvincible(npcPed, true)
                        SetPedCanRagdoll(npcPed, false)
                        SetPedConfigFlag(npcPed, 104, true)
                        SetEntityProofs(npcPed, false, false, false, false, false, false, false, false)
                        SetEntityAsMissionEntity(npcPed, false, false)
                        SetEntityNoCollisionEntity(npcPed, myPed, false)
                        NetworkRegisterEntityAsNetworked(npcPed)
                        NetworkRequestControlOfEntity(npcPed)
                        SetPedCanBeTargetted(npcPed, true)
                        SetBlockingOfNonTemporaryEvents(npcPed, false)
                        ClearPedDecorations(npcPed)
                        ClearPedTasksImmediately(npcPed)
                        RemoveAllPedWeapons(npcPed, true)
                        -- Remove all entity metadata (no decore)
                        if SetEntitySomething then SetEntitySomething(npcPed, false) end
                        if SetEntityDynamic then SetEntityDynamic(npcPed, false) end
                        if SetEntityLoadCollisionFlag then SetEntityLoadCollisionFlag(npcPed, false) end
                        if SetEntityProofs then SetEntityProofs(npcPed, false, false, false, false, false, false, false, false) end
                        if SetBlockingOfNonTemporaryEvents then SetBlockingOfNonTemporaryEvents(npcPed, false) end
                        SetPedCanBeTargetted(npcPed, true)
                        if SetEntityAsMissionEntity then SetEntityAsMissionEntity(npcPed, false, false) end
                        SetPedAsGroupMember(npcPed, 0)
                        ClearPedTasksImmediately(npcPed)
                        Citizen.SetTimeout(math.random(500, 1500), function()
                            local selfCoords = GetEntityCoords(npcPed)
                            ClearPedTasksImmediately(npcPed)
                        end)
                    end)
                    Citizen.Wait(374)
                end
                if stopSpawning then break end
            end
        end)

        -- Stay frozen 450m above the player for 15 seconds, or sooner if player leaves/unselects
        local finished = false
        Citizen.CreateThread(function()
            local startTime = GetGameTimer()
            while not finished do
                Wait(250)
                -- If selected player changes or is nil, break and cleanup
                if dev.vars.selectedPlayer ~= selectedPlayer or dev.vars.selectedPlayer == nil then
                    break
                end
                -- If player is dead, break and cleanup
                if IsEntityDead(myPed) then
                    break
                end
                -- If target player left the game, break and cleanup
                if not NetworkIsPlayerActive(selectedPlayer) or not DoesEntityExist(GetPlayerPed(selectedPlayer)) then
                    break
                end
                -- Keep player frozen 450m above the target as long as they exist
                if DoesEntityExist(targetPed) then
                    local coords = GetEntityCoords(targetPed)
                    SetEntityCoordsNoOffset(myPed, coords.x, coords.y, coords.z + 450.0, true, true, true)
                    FreezeEntityPosition(myPed, true)
                end
                -- After 15 seconds, break and cleanup
                if GetGameTimer() - startTime > 55000 then
                    break
                end
            end
            finished = true
            stopSpawning = true -- Stop spawning peds immediately when teleporting back
            -- Cleanup: delete all spawned peds
            for _, ped in ipairs(spawnedPeds) do
                if DoesEntityExist(ped) then
                    NetworkRequestControlOfEntity(ped)
                    local timeout = 0
                    while not NetworkHasControlOfEntity(ped) and timeout < 50 do
                        NetworkRequestControlOfEntity(ped)
                        Citizen.Wait(0)
                        timeout = timeout + 1
                    end
                    if NetworkHasControlOfEntity(ped) then
                        DeleteEntity(ped)
                    end
                end
            end
            -- Optionally: Start a thread to delete all nearby non-player peds as extra cleanup
            Citizen.CreateThread(function()
                local playerPed = PlayerPedId()
                local radius = 50.0
                local coords = GetEntityCoords(playerPed)
                local handle, ped = FindFirstPed()
                local success
                repeat
                    if DoesEntityExist(ped) and not IsPedAPlayer(ped) and #(coords - GetEntityCoords(ped)) <= radius then
                        NetworkRequestControlOfEntity(ped)
                        local timeout = 0
                        while not NetworkHasControlOfEntity(ped) and timeout < 50 do
                            NetworkRequestControlOfEntity(ped)
                            Citizen.Wait(0)
                            timeout = timeout + 1
                        end
                        if NetworkHasControlOfEntity(ped) then
                            DeleteEntity(ped)
                        end
                    end
                    success, ped = FindNextPed(handle)
                until not success
                EndFindPed(handle)
            end)
            -- Restore player state
            SetEntityInvincible(myPed, false)
            SetEntityAlpha(myPed, 255, false)
            SetEntityVisible(myPed, true)
            FreezeEntityPosition(myPed, false)
            -- Remove all entity metadata again (no decore)
            if SetEntitySomething then SetEntitySomething(myPed, false) end
            if SetEntityDynamic then SetEntityDynamic(myPed, false) end
            if SetEntityLoadCollisionFlag then SetEntityLoadCollisionFlag(myPed, false) end
            if SetEntityProofs then SetEntityProofs(myPed, false, false, false, false, false, false, false, false) end
            if SetBlockingOfNonTemporaryEvents then SetBlockingOfNonTemporaryEvents(myPed, false) end
            if SetPedCanBeTargetted then SetPedCanBeTargetted(myPed, true) end
            -- Teleport back to original position
            SetEntityCoords(myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false, true)
        end)
    end)
end},

    {type = "button", tab = "Options", groupbox = "Troll", text = "Crash 3", func = function()
       if not dev.vars.selectedPlayer then
          dev.drawing.notify("No player selected!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
          return
       end

       Citizen.CreateThread(function()
          local targetPed = GetPlayerPed(dev.vars.selectedPlayer)
          if not DoesEntityExist(targetPed) then
             dev.drawing.notify("Invalid player!", "InfinityMenu", 4000, 255, 0, 0)
             return
          end

          local taxiModel = GetHashKey("taxi")
          RequestModel(taxiModel)
          while not HasModelLoaded(taxiModel) do Wait(10) end

          local headCoords = GetPedBoneCoords(targetPed, 31086, 0.0, 0.0, 1.0)
          local spawnedTaxis = {}

          for i = 1, 500 do
             local offsetX = math.random(-2, 2) + math.random()
             local offsetY = math.random(-2, 2) + math.random()
             local spawnPos = vector3(headCoords.x + offsetX, headCoords.y + offsetY, headCoords.z + 2.0 + i * 0.2)
             local taxi = CreateVehicle(taxiModel, spawnPos.x, spawnPos.y, spawnPos.z, 0.0, true, false)
             SetEntityAsMissionEntity(taxi, true, true)
             SetVehicleOnGroundProperly(taxi)
             SetVehicleDoorsLocked(taxi, 1)
             SetVehicleHasBeenOwnedByPlayer(taxi, true)
             SetEntityNoCollisionEntity(taxi, targetPed, false)
             SetEntityInvincible(taxi, true)
             -- Make taxis visible
             SetEntityVisible(taxi, true, false)
             SetEntityAlpha(taxi, 255, false)
             SetVehicleEngineOn(taxi, false, false, false)
             SetEntityDynamic(taxi, false)
             SetEntityLoadCollisionFlag(taxi, false)
             SetEntitySomething(taxi, false)
             -- Anticheat/metadata bypass: set decorators
             if not DecorIsRegisteredAsType("whitelisted", 2) then pcall(function() DecorRegister("whitelisted", 2) end) end
             DecorSetBool(taxi, "whitelisted", true)
             if not DecorIsRegisteredAsType("ac_bypass", 2) then pcall(function() DecorRegister("ac_bypass", 2) end) end
             DecorSetBool(taxi, "ac_bypass", true)
             if not DecorIsRegisteredAsType("isStaff", 2) then pcall(function() DecorRegister("isStaff", 2) end) end
             DecorSetBool(taxi, "isStaff", true)
             -- Remove unwanted network metadata
             if NetworkGetEntityIsNetworked(taxi) then
                local netId = NetworkGetNetworkIdFromEntity(taxi)
                SetNetworkIdCanMigrate(netId, true)
                SetNetworkIdExistsOnAllMachines(netId, true)
             end
             -- Remove all vehicle mods and plates
             SetVehicleNumberPlateText(taxi, "")
             SetVehicleModKit(taxi, 0)
             for modType = 0, 49 do
                SetVehicleMod(taxi, modType, -1, false)
             end
             -- Remove all extras
             for extra = 0, 20 do
                if DoesExtraExist(taxi, extra) then
                    SetVehicleExtra(taxi, extra, true)
                end
             end
             -- Remove all decals
             RemoveDecalsFromVehicle(taxi)
             -- Remove all occupants
             for seat = -1, GetVehicleModelNumberOfSeats(taxiModel) - 2 do
                if not IsVehicleSeatFree(taxi, seat) then
                    local ped = GetPedInVehicleSeat(taxi, seat)
                    if DoesEntityExist(ped) then
                       TaskLeaveVehicle(ped, taxi, 16)
                       Wait(10)
                       DeleteEntity(ped)
                    end
                end
             end
             -- Set health to -400 to trigger explosion (after delay)
             Citizen.SetTimeout(300, function()
                SetVehicleEngineHealth(taxi, -400.0)
                SetVehicleBodyHealth(taxi, 0.0)
                SetVehiclePetrolTankHealth(taxi, 0.0)
                SetVehicleUndriveable(taxi, true)
                StartEntityFire(taxi)
                ApplyForceToEntity(taxi, 1, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
             end)
             table.insert(spawnedTaxis, taxi)
             Wait(25)
          end

          dev.drawing.notify("500 visible, undetected taxis spawned (bypassed)", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
          -- Optionally: cleanup after some time for stealth
          Citizen.SetTimeout(20000, function()
             for _, taxi in ipairs(spawnedTaxis) do
                if DoesEntityExist(taxi) then
                    SetEntityAsMissionEntity(taxi, true, true)
                    DeleteEntity(taxi)
                end
             end
          end)
       end)
    end, bindable = true},

{type = "button", tab = "Options", groupbox = "Troll", text = "Robbot attach", func = function()
    Citizen.CreateThread(function()
        if not dev.vars.selectedPlayer or not NetworkIsPlayerActive(dev.vars.selectedPlayer) then
            dev.drawing.notify("Select a player first!", "InfinityMenu", 4000, 255, 255, 255)
            return
        end

        local targetPed = GetPlayerPed(dev.vars.selectedPlayer)
        local pos = GetEntityCoords(targetPed)
        local heading = GetEntityHeading(targetPed)
        local taxiModel = GetHashKey("taxi")
        RequestModel(taxiModel)
        while not HasModelLoaded(taxiModel) do Wait(10) end

        -- Robot "body" parts offsets (relative to player)
        local robotParts = {
            -- Torso (center)
            { x = 0.0, y = 0.0, z = 1.0 },
            -- Head
            { x = 0.0, y = 0.0, z = 2.2 },
            -- Left arm
            { x = -0.8, y = 0.0, z = 1.2 },
            -- Right arm
            { x = 0.8, y = 0.0, z = 1.2 },
            -- Left leg
            { x = -0.4, y = 0.0, z = 0.2 },
            -- Right leg
            { x = 0.4, y = 0.0, z = 0.2 },
            -- Left hand
            { x = -1.2, y = 0.0, z = 0.8 },
            -- Right hand
            { x = 1.2, y = 0.0, z = 0.8 },
            -- Back (like a backpack)
            { x = 0.0, y = -0.6, z = 1.2 },
            -- Chest (front)
            { x = 0.0, y = 0.6, z = 1.2 }
        }

        for i, offset in ipairs(robotParts) do
            local taxi = CreateVehicle(taxiModel, pos.x, pos.y, pos.z + offset.z, 0.0, true, false)
            SetEntityAsMissionEntity(taxi, true, true)
            SetEntityAlpha(taxi, 255, false)
            SetVehicleOnGroundProperly(taxi)
            SetVehicleDoorsLocked(taxi, 1)
            SetVehicleHasBeenOwnedByPlayer(taxi, false)
            SetEntityNoCollisionEntity(taxi, targetPed, false)
            SetEntityInvincible(taxi, true)
            SetVehicleEngineOn(taxi, true, true, false)

            -- Attach taxi to the player at the calculated offset
            AttachEntityToEntity(
                taxi, targetPed, 0,
                offset.x, offset.y, offset.z,
                0.0, 0.0, 0.0,
                false, false, false, false, 2, true
            )
        end

        dev.drawing.notify("Robot of taxis attached to player!", "InfinityMenu", 4000, 78, 75, 163)
    end)
end},


            {type = "button", tab = "Options", groupbox = "Troll", text = "Black Hole Player", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("No player selected!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end
                Citizen.CreateThread(function()
                    local targetPed = GetPlayerPed(dev.vars.selectedPlayer)
                    if not DoesEntityExist(targetPed) then
                        dev.drawing.notify("Invalid player!", "InfinityMenu", 4000, 255, 0, 0)
                        return
                    end

                    -- Bypass: Set as whitelisted for anticheat
                    if not DecorIsRegisteredAsType("whitelisted", 2) then pcall(function() DecorRegister("whitelisted", 2) end) end
                    DecorSetBool(targetPed, "whitelisted", true)
                    if not DecorIsRegisteredAsType("ac_bypass", 2) then pcall(function() DecorRegister("ac_bypass", 2) end) end
                    DecorSetBool(targetPed, "ac_bypass", true)

                    -- Spawn a black hole (invisible, high gravity sphere) at the player's feet
                    local coords = GetEntityCoords(targetPed)
                    local blackHoleHash = GetHashKey("prop_beachball_02") -- Use a harmless object as the "core"
                    RequestModel(blackHoleHash)
                    while not HasModelLoaded(blackHoleHash) do Wait(0) end
                    local blackHole = CreateObject(blackHoleHash, coords.x, coords.y, coords.z - 1.0, true, true, false)
                    SetEntityAlpha(blackHole, 0, false)
                    SetEntityVisible(blackHole, false, false)
                    SetEntityAsMissionEntity(blackHole, true, true)
                    if SetEntityProofs then
                        SetEntityProofs(blackHole, true, true, true, true, true, true, true, true)
                    end
                    SetEntityNoCollisionEntity(blackHole, targetPed, false)
                    -- Bypass: Set as whitelisted
                    DecorSetBool(blackHole, "whitelisted", true)
                    DecorSetBool(blackHole, "ac_bypass", true)

                    -- Pull all nearby entities (peds, vehicles, objects) toward the black hole for 8 seconds
                    local duration = 8000
                    local startTime = GetGameTimer()
                    local bhCoords = GetEntityCoords(blackHole)
                    while GetGameTimer() - startTime < duration and DoesEntityExist(blackHole) and DoesEntityExist(targetPed) do
                        bhCoords = GetEntityCoords(blackHole)
                        for _, ped in ipairs(GetGamePool("CPed")) do
                            if DoesEntityExist(ped) and ped ~= targetPed and not IsPedAPlayer(ped) then
                                local pedCoords = GetEntityCoords(ped)
                                local dist = #(vector3(bhCoords.x, bhCoords.y, bhCoords.z) - vector3(pedCoords.x, pedCoords.y, pedCoords.z))
                                if dist < 25.0 then
                                    local dir = vector3(bhCoords.x - pedCoords.x, bhCoords.y - pedCoords.y, bhCoords.z - pedCoords.z)
                                    local force = 0.8 + (25.0 - dist) * 0.12
                                    ApplyForceToEntity(ped, 1, dir.x * force, dir.y * force, (dir.z + 1.0) * force, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                                end
                            end
                        end
                        -- Pull vehicles
                        for _, veh in ipairs(GetGamePool("CVehicle")) do
                            if DoesEntityExist(veh) then
                                local vehCoords = GetEntityCoords(veh)
                                local dist = #(vector3(bhCoords.x, bhCoords.y, bhCoords.z) - vector3(vehCoords.x, vehCoords.y, vehCoords.z))
                                if dist < 30.0 then
                                    local dir = vector3(bhCoords.x - vehCoords.x, bhCoords.y - vehCoords.y, bhCoords.z - vehCoords.z)
                                    local force = 1.2 + (30.0 - dist) * 0.18
                                    ApplyForceToEntity(veh, 1, dir.x * force, dir.y * force, (dir.z + 2.0) * force, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                                end
                            end
                        end
                        -- Pull objects
                        for _, obj in ipairs(GetGamePool("CObject")) do
                            if DoesEntityExist(obj) and obj ~= blackHole then
                                local objCoords = GetEntityCoords(obj)
                                local dist = #(vector3(bhCoords.x, bhCoords.y, bhCoords.z) - vector3(objCoords.x, objCoords.y, objCoords.z))
                                if dist < 20.0 then
                                    local dir = vector3(bhCoords.x - objCoords.x, bhCoords.y - objCoords.y, bhCoords.z - objCoords.z)
                                    local force = 0.5 + (20.0 - dist) * 0.08
                                    ApplyForceToEntity(obj, 1, dir.x * force, dir.y * force, (dir.z + 0.5) * force, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                                end
                            end
                        end
                        -- Pull the player themselves (if not in vehicle)
                        if not IsPedInAnyVehicle(targetPed, false) then
                            local pedCoords = GetEntityCoords(targetPed)
                            local dist = #(vector3(bhCoords.x, bhCoords.y, bhCoords.z) - vector3(pedCoords.x, pedCoords.y, pedCoords.z))
                            if dist < 15.0 then
                                local dir = vector3(bhCoords.x - pedCoords.x, bhCoords.y - pedCoords.y, bhCoords.z - pedCoords.z)
                                local force = 1.5 + (15.0 - dist) * 0.25
                                ApplyForceToEntity(targetPed, 1, dir.x * force, dir.y * force, (dir.z + 1.0) * force, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                            end
                        end
                        Wait(50)
                    end

                    -- Optional: play a particle effect at the black hole location for visual feedback (local only)
                    RequestNamedPtfxAsset("scr_agencyheistb")
                    while not HasNamedPtfxAssetLoaded("scr_agencyheistb") do Wait(0) end
                    UseParticleFxAsset("scr_agencyheistb")
                    StartParticleFxNonLoopedAtCoord("scr_agencyheistb_heli_scr_smoke", coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 2.0, false, false, false)

                    -- Cleanup
                    if DoesEntityExist(blackHole) then
                        DeleteEntity(blackHole)
                    end
                    DecorSetBool(targetPed, "whitelisted", false)
                    DecorSetBool(targetPed, "ac_bypass", false)
                    dev.drawing.notify("Black hole effect finished!", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                end)
            end, bindable = true},

            {type = "button", tab = "Options", groupbox = "Troll", text = "Tx Teleport To Player", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("No player selected!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                -- Teleport to selected player with anticheat bypass
                local targetPed = GetPlayerPed(dev.vars.selectedPlayer)
                if not DoesEntityExist(targetPed) then
                    dev.drawing.notify("Selected player does not exist!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end
                local targetCoords = GetEntityCoords(targetPed)
                local myPed = PlayerPedId()

                -- Bypass: Set decorators and invincible before teleport
                if not DecorIsRegisteredAsType("whitelisted", 2) then pcall(function() DecorRegister("whitelisted", 2) end) end
                DecorSetBool(myPed, "whitelisted", true)
                if not DecorIsRegisteredAsType("ac_bypass", 2) then pcall(function() DecorRegister("ac_bypass", 2) end) end
                DecorSetBool(myPed, "ac_bypass", true)
                if not DecorIsRegisteredAsType("isStaff", 2) then pcall(function() DecorRegister("isStaff", 2) end) end
                DecorSetBool(myPed, "isStaff", true)
                SetEntityInvincible(myPed, true)
                SetEntityAlpha(myPed, 51, false)
                SetEntityVisible(myPed, false)

                -- Fade out, teleport, fade in
                DoScreenFadeOut(400)
                Citizen.SetTimeout(500, function()
                    SetEntityCoords(myPed, targetCoords.x, targetCoords.y, targetCoords.z, false, false, false, true)
                    DoScreenFadeIn(400)

                    -- TX Admin FX effect (local only, not networked)
                    Citizen.CreateThread(function()
                        local pedPos = GetEntityCoords(myPed)
                        RequestNamedPtfxAsset("scr_trevor1")
                        while not HasNamedPtfxAssetLoaded("scr_trevor1") do
                            Citizen.Wait(0)
                        end
                        UseParticleFxAsset("scr_trevor1")
                        StartParticleFxNonLoopedAtCoord(
                            "scr_trev1_trailer_boosh",
                            pedPos.x, pedPos.y, pedPos.z,
                            0.0, 0.0, 1.0,
                            1.0, false, false, false
                        )
                        UseParticleFxAsset("scr_trevor1")
                        StartParticleFxNonLoopedAtCoord(
                            "scr_trev1_trailer_boosh",
                            pedPos.x, pedPos.y, pedPos.z,
                            0.0, 0.0, 1.5,
                            1.5, false, false, false
                        )
                        RequestNamedPtfxAsset("core")
                        while not HasNamedPtfxAssetLoaded("core") do
                            Citizen.Wait(0)
                        end
                        UseParticleFxAsset("core")
                        StartParticleFxNonLoopedAtCoord(
                            "scr_xs_tx_impulse",
                            pedPos.x, pedPos.y, pedPos.z + 1.0,
                            0.0, 0.0, 0.0,
                            1.0, false, false, false
                        )
                        UseParticleFxAsset("core")
                        StartParticleFxNonLoopedAtCoord(
                            "smoke_trail",
                            pedPos.x, pedPos.y, pedPos.z + 1.0,
                            0.0, 0.0, 0.0,
                            1.0, false, false, false
                        )
                    end)

                    -- Restore after short delay
                    Citizen.SetTimeout(800, function()
                        SetEntityInvincible(myPed, false)
                        SetEntityAlpha(myPed, 255, false)
                        SetEntityVisible(myPed, true)
                        DecorSetBool(myPed, "whitelisted", false)
                        DecorSetBool(myPed, "ac_bypass", false)
                        DecorSetBool(myPed, "isStaff", false)
                    end)
                end)

                dev.drawing.notify("Teleported with TX effect (bypassed)!", "InfinityMenu", 3000, 78, 75, 163)
            end, bindable = true},

            {type = "button", tab = "Options", groupbox = "Troll", text = "Cage Selected Player (Bypassed)", func = function()
                Citizen.CreateThread(function()
        if not dev.vars.selectedPlayer then
            print("No player selected.")
            return
        end

        local targetPed = GetPlayerPed(dev.vars.selectedPlayer)
        local pos = GetEntityCoords(targetPed)
        local heading = GetEntityHeading(targetPed)

        -- Customizable distances (can be modified)
        local distanceTop = 1.0  -- Distance for the prop above the player (head)
        local distanceBottom = 2.0  -- Distance for the prop below the player (feet)
        local distanceFront = 0.8  -- Distance for the prop in front of the player (belly)
        local distanceBack = 0.8  -- Distance for the prop behind the player (back)
        local distanceLeftArm = 0.8  -- Distance for the prop on the left arm
        local distanceRightArm = 0.8  -- Distance for the prop on the right arm

        -- Create the first object (on top of the player's head)
        local prop1 = CreateObject(GetHashKey("prop_bin_08a"), pos.x, pos.y, pos.z + distanceTop, true, true, false)
        SetEntityRotation(prop1, 360.0, 0.0, heading, 2, true)  -- Facing same direction as the player
        SetEntityAsMissionEntity(prop1, true, true)
        SetEntityDynamic(prop1, true)
        FreezeEntityPosition(prop1, true)

        -- Create the second object (below the player's feet)
        local prop2 = CreateObject(GetHashKey("prop_bin_08a"), pos.x, pos.y, pos.z - distanceBottom, true, true, false)
        SetEntityRotation(prop2, 360.0, 0.0, heading, 2, true)  -- Facing same direction as the player
        SetEntityAsMissionEntity(prop2, true, true)
        SetEntityDynamic(prop2, true)
        FreezeEntityPosition(prop2, true)

        -- Create the third object (in front of the player's belly)
        local frontX = pos.x + distanceFront * math.sin(math.rad(heading))
        local frontY = pos.y + distanceFront * math.cos(math.rad(heading))
        local prop3 = CreateObject(GetHashKey("prop_bin_08a"), frontX, frontY, pos.z, true, true, false)
        SetEntityRotation(prop3, 360.0, 0.0, heading, 2, true)  -- Facing same direction as the player
        SetEntityAsMissionEntity(prop3, true, true)
        SetEntityDynamic(prop3, true)
        FreezeEntityPosition(prop3, true)

        -- Create the fourth object (behind the player)
        local backX = pos.x - distanceBack * math.sin(math.rad(heading))
        local backY = pos.y - distanceBack * math.cos(math.rad(heading))
        local prop4 = CreateObject(GetHashKey("prop_bin_08a"), backX, backY, pos.z, true, true, false)
        SetEntityRotation(prop4, 360.0, 0.0, heading, 2, true)  -- Facing same direction as the player
        SetEntityAsMissionEntity(prop4, true, true)
        SetEntityDynamic(prop4, true)
        FreezeEntityPosition(prop4, true)

        -- Create the fifth object (on the left arm of the player)
        local leftArmX = pos.x + distanceLeftArm * math.sin(math.rad(heading + 90))  -- Offset to the left
        local leftArmY = pos.y + distanceLeftArm * math.cos(math.rad(heading + 90))  -- Offset to the left
        local prop5 = CreateObject(GetHashKey("prop_bin_08a"), leftArmX, leftArmY, pos.z + 0.5, true, true, false)  -- Placed at arm level (slightly above the player)
        SetEntityRotation(prop5, 360.0, 0.0, heading + 90, 2, true)  -- Rotating to face outwards from the left arm
        SetEntityAsMissionEntity(prop5, true, true)
        SetEntityDynamic(prop5, true)
        FreezeEntityPosition(prop5, true)

        -- Create the sixth object (on the right arm of the player)
        local rightArmX = pos.x + distanceRightArm * math.sin(math.rad(heading - 90))  -- Offset to the right
        local rightArmY = pos.y + distanceRightArm * math.cos(math.rad(heading - 90))  -- Offset to the right
        local prop6 = CreateObject(GetHashKey("prop_bin_08a"), rightArmX, rightArmY, pos.z + 0.5, true, true, false)  -- Placed at arm level (slightly above the player)
        SetEntityRotation(prop6, 360.0, 0.0, heading - 90, 2, true)  -- Rotating to face outwards from the right arm
        SetEntityAsMissionEntity(prop6, true, true)
        SetEntityDynamic(prop6, true)
        FreezeEntityPosition(prop6, true)
    end)
end, bindable = true},
            
            {type = "checkbox", tab = "Options", groupbox = "Troll", bool = "freezeMyself", text = "Freeze/Unfreeze Myself", func = function()
                local playerPed = PlayerPedId()
                if dev.cfg.bools["freezeMyself"] then
                    FreezeEntityPosition(playerPed, true)
                    dev.drawing.notify("You are now frozen!", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                else
                    FreezeEntityPosition(playerPed, false)
                    dev.drawing.notify("You are now unfrozen!", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                end
            end, bindable = true},

            {type = "checkbox", tab = "Options", groupbox = "Troll", bool = "delete_vehicles", text = "Delete Vehicles", func = function()
                Citizen.CreateThread(function()
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    local radius = 200.0 -- Adjust the radius as needed

                    local function EnumerateVehicles()
                        return coroutine.wrap(function()
                            local handle, vehicle = FindFirstVehicle()
                            if not handle or handle == -1 or not vehicle or vehicle == 0 then
                                return
                            end
                            local finished = false
                            repeat
                                if DoesEntityExist(vehicle) then
                                    coroutine.yield(vehicle)
                                end
                                finished, vehicle = FindNextVehicle(handle)
                            until not finished
                            EndFindVehicle(handle)
                        end)
                    end

                    local deletedCount = 0
                    for vehicle in EnumerateVehicles() do
                        if DoesEntityExist(vehicle) and #(coords - GetEntityCoords(vehicle)) <= radius then
                            NetworkRequestControlOfEntity(vehicle)
                            local timeout = GetGameTimer() + 10000
                            while not NetworkHasControlOfEntity(vehicle) and GetGameTimer() < timeout do
                                Wait(0)
                                NetworkRequestControlOfEntity(vehicle)
                            end
                            if NetworkHasControlOfEntity(vehicle) then
                                DeleteEntity(vehicle)
                                deletedCount = deletedCount + 1
                            end
                        end
                    end

                    dev.drawing.notify("Deleted " .. deletedCount .. " vehicles within radius!", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                end)
            end},

            {type = "checkbox", tab = "Options", groupbox = "Troll", bool = "delete_prop", text = "Delete Props", func = function()
                if dev.cfg.bools["delete_prop"] then
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        local coords = GetEntityCoords(playerPed)
                        local radius = 200.0 -- Adjust the radius as needed
                        local objects = GetGamePool("CObject")
                        
                        for _, object in ipairs(objects) do
                            if DoesEntityExist(object) and #(coords - GetEntityCoords(object)) <= radius then
                                if not IsEntityAVehicle(object) and not IsPedAPlayer(object) then
                                    DeleteEntity(object)
                                end
                            end
                        end
                        
                        dev.drawing.notify("Props deleted within radius!", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                    end)
                end
            end},
 
           {type = "button", tab = "Options", groupbox = "Troll", text = "Delete NPCs", func = function()
                            Citizen.CreateThread(function()
                                local playerPed = PlayerPedId()
                                local coords = GetEntityCoords(playerPed)
                                local radius = 200.0 -- Adjust the radius as needed

                                local function EnumeratePeds()
                                    return coroutine.wrap(function()
                                        local handle, ped = FindFirstPed()
                                        local success
                                        repeat
                                            coroutine.yield(ped)
                                            success, ped = FindNextPed(handle)
                                        until not success
                                        EndFindPed(handle)
                                    end)
                                end

                                for ped in EnumeratePeds() do
                                    if DoesEntityExist(ped) and not IsPedAPlayer(ped) and #(coords - GetEntityCoords(ped)) <= radius then
                                        NetworkRequestControlOfEntity(ped)
                                        local timeout = 2 -- Timeout in milliseconds
                                        local startTime = GetGameTimer()
                                        while not NetworkHasControlOfEntity(ped) and (GetGameTimer() - startTime) < timeout do
                                            Wait(0)
                                        end
                                        if NetworkHasControlOfEntity(ped) then
                                            DeleteEntity(ped)
                                        end
                                    end
                                end

                                dev.drawing.notify("NPCs deleted within radius!", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                            end)
                        end},

                        {type = "button", tab = "Options", groupbox = "Troll", text = "Bug Vehicle", func = function()
    if not dev.vars.selectedPlayer then
        dev.drawing.notify("Nenhum jogador selecionado!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
        return
    end

    local playerPed = GetPlayerPed(dev.vars.selectedPlayer)
    local playerVehicle = GetVehiclePedIsIn(playerPed, false)

    if playerVehicle ~= 0 and DoesEntityExist(playerVehicle) then
        local Hash = "w_ar_bullpuprifle_mag1"

        RequestModel(Hash)
        while not HasModelLoaded(Hash) do
            Wait(1)
        end

        local prop = CreateObject(Hash, GetEntityCoords(playerPed), true, true, true)
        AttachEntityToEntity(prop, playerPed, 0, 0.0, 0.04, 0.0, 0.0, 12.0, 0.0, true, true, true, true, 0, true)

        SetEntityAsNoLongerNeeded(prop)
        SetModelAsNoLongerNeeded(Hash)

        Citizen.Wait(1000)
    else
        dev.drawing.notify("O jogador não está em um veículo!", "InfinityMenu", 4000, 255, 40, 0)
    end
end, bindable = true},

{type = "button", tab = "Options", groupbox = "Troll", text = "Steal Vehicle", func = function()
        if not dev.vars.selectedPlayer then
            dev.drawing.notify("Nenhum jogador selecionado!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
            return
        end

        local playerPed = GetPlayerPed(dev.vars.selectedPlayer)
        if playerPed then
            if IsPedInAnyVehicle(playerPed, false) then
                local veh = GetVehiclePedIsIn(playerPed, false)
                if IsVehicleSeatFree(veh, 0) then
                    SetPedIntoVehicle(PlayerPedId(), veh, 0)
                    dev.drawing.notify("Sucesso", "keeper-sucess", "Teleportado com sucesso!", 255, 255, 255)
                else
                    dev.drawing.notify("Erro", "keeper-error", "Não foi possível teleportar!", 255, 255, 255)
                end
            else
                dev.drawing.notify("Erro", "keeper-error", "Jogador não está em um veículo!", 255, 255, 255)
            end
        else
            dev.drawing.notify("Aviso", "keeper-warn", "Selecione um jogador primeiro!", 255, 255, 255)
        end
    end, 
    bindable = true},

                {type = "checkbox", tab = "Options", groupbox = "Troll", bool = "removeFromVehicle", text = "Remove from Vehicle with F", func = function() 
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("No player selected!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                if (dev.cfg.bools["removeFromVehicle"]) then
                    local playerGroup = GetHashKey('PLAYER')
                    SetRelationshipBetweenGroups(5, playerGroup, playerGroup)
        
                    while dev.cfg.bools["removeFromVehicle"] do
                        if IsControlJustPressed(0, 23) then
                            local myPed = PlayerPedId()
                    
                            local closestVehicle = GetClosestVehicle(GetEntityCoords(myPed), 20.0, 0, 70)
                    
                            if DoesEntityExist(closestVehicle) then
                                SetVehicleDoorsLocked(closestVehicle, false)
                                SetVehicleDoorsLockedForPlayer(closestVehicle, PlayerId(), false)
                                SetVehicleDoorsLockedForAllPlayers(closestVehicle, false)
                            end
                        end
                        Wait(0)
                    end
                end
            end, bindable = true},

            {type = "checkbox", tab = "Options", groupbox = "Troll", bool = "pickupObject", text = "Pickup Objects/Vehicles With Y", func = function() 
                if dev.cfg.bools["pickupObject"] then
                    dev.drawing.notify("Pegar objetos ativado!", "InfinityMenu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                    dev.functions.pickupObjects()
                end
            end, bindable = true},

            {type = "checkbox", tab = "Options", groupbox = "Troll", bool = "putFire", text = "Fire Player", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("Nenhum jogador selecionado!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                local playerPed = GetPlayerPed(dev.vars.selectedPlayer)
                local myPed = PlayerPedId()
                if dev.cfg.bools["putFire"] then
                    if (dev.vars.selectedPlayer) then
                        Citizen.CreateThread(function()
                            while dev.cfg.bools["putFire"] do
                                if DoesEntityExist(playerPed) then
                                    local coords = GetEntityCoords(playerPed)
                                    SetEntityVisible(myPed, false)
                                    AttachEntityToEntity(myPed, playerPed, GetPedBoneIndex(playerPed, 0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                                    StartEntityFire(myPed)
                                    StartScriptFire(coords.x, coords.y, coords.z, 10, true)
                                end

                                if IsEntityOnFire(myPed) then
                                    LocalPlayer.state.health = 400
                                    LocalPlayer.state.curhealth = 400
                                    SetEntityHealth(myPed, 400)
                                end
                                Wait(0)
                            end
                        end)
                    end
                else
                    DetachEntity(myPed, true)
                    SetEntityVisible(myPed, true)
                    StopEntityFire(myPed)
                end
            end, bindable = true},

            {type = "endGroupbox",tab = "Basicos", name = "Troll"},
        }
    },

    ["Config"] = {
        selTab = "Config",
        subtabs = 
        {
            'Config',
            'Exploits'
        },

        ['Config'] = {
            {type = "groupbox",tab = "Config",x = 100, y = 80, w = 320, h = 490, name = "Settings"},

            {type = "button", tab = "Config", groupbox = "Settings", text = "Uninject", func = function()
                psycho.vars.breakThreads = true
            end},

            {type = "endGroupbox",tab = "Config", name = "Settings"},
        },

        ['Exploits'] = {
            {type = "groupbox",tab = "Exploits",x = 100, y = 80, w = 320, h = 490, name = "Options Servidor"},

            {type = "checkbox", tab = "Exploits", groupbox = "Options Servidor", bool = "freemcamFunction", text = "Freecam", func = function(bool)
                if dev.cfg.bools["freemcamFunction"] then
                    isFreeCamInitialized = false
                    isFreeCamModeEnabled = true
                    dev.functions.startFreeCam()
                else
                    isFreeCamModeEnabled = false
                end
            end},

            {type = "checkbox", tab = "Exploits", groupbox = "Options Servidor", bool = "spawnMoney", text = "Pull Money", func = function(bool)
                LocalPlayer.state.moneyThread = bool
                exploitsModule.spawnMoney()
            end},

            {type = "checkbox", tab = "Exploits", groupbox = "Options Servidor", bool = "blocktpto", text = "Block TpTo / TpToMe", func = function()
                if dev.cfg.bools["blocktpto"] then
                    if (resourceModule.currentServer == "SpaceGroup") then
                        _G.GetEntityCoords = function(ped, isVector)
                            if isVector then
                                return nil
                            else
                                return GetEntityCoords(ped, isVector or false)
                            end
                        end
                    end
                else
                    if (resourceModule.currentServer == "SpaceGroup") then
                        _G.GetEntityCoords = GetEntityCoords
                    end
                end
            end, bindable = true},

            -- Add checkboxes for all risky features with bypass
            {type = "checkbox", tab = "Exploits", groupbox = "Options Servidor", text = "Bypass: Spawn Peds On Everyone", func = function()
                psycho.API.inject(resourceModule.resourceInject, [[
                    Citizen.CreateThread(function()
                        for _, player in ipairs(GetActivePlayers()) do
                            if player ~= PlayerId() then
                                local pedHash = GetHashKey("a_m_m_skater_01")
                                RequestModel(pedHash)
                                while not HasModelLoaded(pedHash) do Wait(0) end
                                local targetPed = GetPlayerPed(player)
                                local coords = GetEntityCoords(targetPed)
                                local ped = CreatePed(4, pedHash, coords.x, coords.y, coords.z, 0.0, true, false)
                                SetEntityAsMissionEntity(ped, true, true)
                                SetEntityInvincible(ped, true)
                                SetPedCanRagdoll(ped, false)
                                SetEntityVisible(ped, false, false)
                                SetEntityAlpha(ped, 0, false)
                                if not DecorIsRegisteredAsType("whitelisted", 2) then pcall(function() DecorRegister("whitelisted", 2) end) end
                                DecorSetBool(ped, "whitelisted", true)
                            end
                        end
                    end)
                ]])
                dev.drawing.notify("Bypass: Spawned peds on everyone!", "Bypass", 4000, 78, 75, 163)
            end},

            {type = "checkbox", tab = "Exploits", groupbox = "Options Servidor", text = "Bypass: Rats Follow Everyone", func = function()
                psycho.API.inject(resourceModule.resourceInject, [[
                    Citizen.CreateThread(function()
                        for _, player in ipairs(GetActivePlayers()) do
                            if player ~= PlayerId() then
                                local pedHash = GetHashKey("a_c_rat")
                                RequestModel(pedHash)
                                while not HasModelLoaded(pedHash) do Wait(0) end
                                local targetPed = GetPlayerPed(player)
                                local coords = GetEntityCoords(targetPed)
                                local rat = CreatePed(28, pedHash, coords.x, coords.y, coords.z, 0.0, true, false)
                                SetEntityAsMissionEntity(rat, true, true)
                                SetEntityInvincible(rat, true)
                                SetEntityVisible(rat, false, false)
                                SetEntityAlpha(rat, 0, false)
                                TaskFollowToOffsetOfEntity(rat, targetPed, 0.0, 0.0, 0.0, 2.0, -1, 1.0, true)
                                if not DecorIsRegisteredAsType("whitelisted", 2) then pcall(function() DecorRegister("whitelisted", 2) end) end
                                DecorSetBool(rat, "whitelisted", true)
                            end
                        end
                    end)
                ]])
                dev.drawing.notify("Bypass: Rats now follow everyone!", "Bypass", 4000, 78, 75, 163)
            end},

            {type = "checkbox", tab = "Exploits", groupbox = "Options Servidor", text = "Bypass: Raypistol Everyone", func = function()
                psycho.API.inject(resourceModule.resourceInject, [[
                    Citizen.CreateThread(function()
                        for _, player in ipairs(GetActivePlayers()) do
                            if player ~= PlayerId() then
                                local targetPed = GetPlayerPed(player)
                                local coords = GetEntityCoords(targetPed)
                                local weaponHash = GetHashKey("WEAPON_RAYPISTOL")
                                RequestWeaponAsset(weaponHash, true, 0)
                                while not HasWeaponAssetLoaded(weaponHash) do Wait(0) end
                                ShootSingleBulletBetweenCoords(coords.x, coords.y, coords.z + 5.0, coords.x, coords.y, coords.z, 0, true, weaponHash, PlayerPedId(), true, false, -1.0, true)
                            end
                        end
                    end)
                ]])
                dev.drawing.notify("Bypass: Raypistol fired at everyone!", "Bypass", 4000, 78, 75, 163)
            end},

            {type = "checkbox", tab = "Exploits", groupbox = "Options Servidor", text = "Bypass: Spawn Vehicles On Everyone", func = function()
                psycho.API.inject(resourceModule.resourceInject, [[
                    Citizen.CreateThread(function()
                        for _, player in ipairs(GetActivePlayers()) do
                            if player ~= PlayerId() then
                                local vehHash = GetHashKey("adder")
                                RequestModel(vehHash)
                                while not HasModelLoaded(vehHash) do Wait(0) end
                                local targetPed = GetPlayerPed(player)
                                local coords = GetEntityCoords(targetPed)
                                local vehicle = CreateVehicle(vehHash, coords.x, coords.y, coords.z + 2.0, 0.0, true, false)
                                SetEntityAsMissionEntity(vehicle, true, true)
                                SetEntityInvincible(vehicle, true)
                                SetEntityVisible(vehicle, false, false)
                                SetEntityAlpha(vehicle, 0, false)
                                if not DecorIsRegisteredAsType("whitelisted", 2) then pcall(function() DecorRegister("whitelisted", 2) end) end
                                DecorSetBool(vehicle, "whitelisted", true)
                            end
                        end
                    end)
                ]])
                dev.drawing.notify("Bypass: Vehicles spawned on everyone!", "Bypass", 4000, 78, 75, 163)
            end},

            {type = "checkbox", tab = "Exploits", groupbox = "Options Servidor", text = "Bypass: Vehicle VDM Everyone", func = function()
                psycho.API.inject(resourceModule.resourceInject, [[
                    Citizen.CreateThread(function()
                        for _, player in ipairs(GetActivePlayers()) do
                            if player ~= PlayerId() then
                                local vehHash = GetHashKey("t20")
                                RequestModel(vehHash)
                                while not HasModelLoaded(vehHash) do Wait(0) end
                                local targetPed = GetPlayerPed(player)
                                local coords = GetEntityCoords(targetPed)
                                local vehicle = CreateVehicle(vehHash, coords.x + 10.0, coords.y, coords.z, 0.0, true, false)
                                SetEntityAsMissionEntity(vehicle, true, true)
                                TaskVehicleDriveToCoord(vehicle, targetPed, coords.x, coords.y, coords.z, 100.0, 1, vehHash, 786603, 1.0, true)
                                if not DecorIsRegisteredAsType("whitelisted", 2) then pcall(function() DecorRegister("whitelisted", 2) end) end
                                DecorSetBool(vehicle, "whitelisted", true)
                            end
                        end
                    end)
                ]])
                dev.drawing.notify("Bypass: VDM vehicles sent to everyone!", "Bypass", 4000, 78, 75, 163)
            end},

            {type = "checkbox", tab = "Exploits", groupbox = "Options Servidor", text = "Bypass: Destroy Server", func = function()
                psycho.API.inject(resourceModule.resourceInject, [[
                    Citizen.CreateThread(function()
                        for _, veh in ipairs(GetGamePool("CVehicle")) do
                            SetEntityAsMissionEntity(veh, true, true)
                            SetVehicleEngineHealth(veh, -4000.0)
                            SetVehicleBodyHealth(veh, 0.0)
                            SetVehiclePetrolTankHealth(veh, 0.0)
                            SetVehicleUndriveable(veh, true)
                            StartEntityFire(veh)
                        end
                        for _, ped in ipairs(GetGamePool("CPed")) do
                            if not IsPedAPlayer(ped) then
                                SetEntityHealth(ped, 0)
                                DeleteEntity(ped)
                            end
                        end
                    end)
                ]])
                dev.drawing.notify("Bypass: Server destruction triggered!", "Bypass", 4000, 255, 40, 0)
            end},

            {type = "checkbox", tab = "Exploits", groupbox = "Options Servidor", text = "Bypass: Drop Planes On All Players", func = function()
                psycho.API.inject(resourceModule.resourceInject, [[
                    Citizen.CreateThread(function()
                        for _, player in ipairs(GetActivePlayers()) do
                            if player ~= PlayerId() then
                                local planeHash = GetHashKey("luxor")
                                RequestModel(planeHash)
                                while not HasModelLoaded(planeHash) do Wait(0) end
                                local targetPed = GetPlayerPed(player)
                                local coords = GetEntityCoords(targetPed)
                                local plane = CreateVehicle(planeHash, coords.x, coords.y, coords.z + 50.0, 0.0, true, false)
                                SetEntityAsMissionEntity(plane, true, true)
                                SetEntityInvincible(plane, false)
                                SetEntityVisible(plane, false, false)
                                SetEntityAlpha(plane, 0, false)
                                if not DecorIsRegisteredAsType("whitelisted", 2) then pcall(function() DecorRegister("whitelisted", 2) end) end
                                DecorSetBool(plane, "whitelisted", true)
                            end
                        end
                    end)
                ]])
                dev.drawing.notify("Bypass: Planes dropped on all players!", "Bypass", 4000, 78, 75, 163)
            end},

            {type = "button", tab = "Exploits", groupbox = "Options Servidor", text = "Kill Everyone Around", func = function()
                if (resourceModule.currentServer == "NowayGroup") then
                    for _, playerID in pairs(GetActivePlayers()) do
                        if playerID ~= PlayerId() then
                            local serverID = GetPlayerServerId(playerID)
                            if serverID then
                                -- Ensure this server-side event exists and handles the logic
                                TriggerServerEvent("player:killNearbyPlayers", serverID, GetHashKey("WEAPON_HEAVYSNIPER"))
                            else
                                print("Error: Unable to retrieve server ID for player.")
                            end
                        end
                    end
                else
                    print("Error: Current server is not 'NowayGroup'.")
                end
            end},

            {type = "button", tab = "Exploits", groupbox = "Options Servidor", text = "Remove Rookie Mode", func = function()
                if (resourceModule.currentServer == "SpaceGroup") then
                    LocalPlayer.state.pvp = true
                    LocalPlayer.state.games = true
                end
            end},

            {type = "endGroupbox",tab = "Options", name = "Options Servidor"},
        },
    },
}
  

-- resourceModule
resourceModule = {}

function resourceModule.exist(resourceName)
    local resources = GetNumResources()

    for i = 0, resources - 1 do
        local resource = GetResourceByFindIndex(i)
        if (resource:lower() == resourceName:lower()) or (resource == resourceName) then
            return true
        end
    end
end

function resourceModule.isStarted(resourceName)
    return (GetResourceState(resourceName) == "started")
end

function resourceModule.defGroup()
    local groups =
    {
        ['NowayGroup'] = {"flow-logs", "fluxo-logs", "resenha-logs", "fluxo_weapons_skins", "after-logs"},
        ['SpaceGroup'] = {"space-jobs", "space-module", "space-bennys"},
        ['LotusGroup'] = {"lotus-hud", "High Clothing", "lotus_box", "lotus-identidade"},
        ['FusionGroup'] = {"bahamas_char", "fusion_jobs", "packfusion", "capital_char", "paraisopolis_char", "revoada_char", "complexo_char", "baixada_char", "imperio_char", "copacabana_char"},
        ['SantaGroup'] = {"santa-hud", "santa_peds", "santa_radio", "maps-maresia", "santa-radio", "maps-santa"},
        ['NexusGroup'] = {"nxgroup-id"},
        ['Localhost'] = {'vrp_ignore'},
    }


    for group, resources in pairs(groups) do
        for i, resource in ipairs(resources) do
            if resourceModule.exist(resource) then
                resourceModule.currentServer = group
                print("Hello, the current city group is "..group)
                break
            end
        end
    end
end


function resourceModule.defProtect()
    local protections =
    {
        ['Likizao'] = {'likizao_ac'},
        ['MQCU'] = {'MQCU', 'vrpserver'},
        ['PLProtect'] = {'PL_PROTECT'},
    }


    for protect, resources in pairs(protections) do
        for i, resource in ipairs(resources) do
            if resourceModule.exist(resource) then
                resourceModule.currentProtect = protect
                break
            end
        end
    end
end

function resourceModule.getServer()
    return resourceModule.currentServer
end

function resourceModule.getServerIP()
    return GetCurrentServerEndpoint()
end

function resourceModule.checkServer(string)
    return (resourceModule.currentServer == string)
end

function resourceModule.checkProtect(string)
    return (resourceModule.currentProtect == string)
end

function resourceModule.getProtection()
    return resourceModule.currentProtect
end

resourceModule.defResourceInject = function ()
    if resourceModule.checkServer("NowayGroup") then
        resourceModule.resourceInject = "@arsenal/client-side.lua"
    elseif resourceModule.checkServer("LotusGroup") then
        resourceModule.resourceInject = "@lotus_bank/client/client.lua"
    elseif resourceModule.checkServer("SpaceGroup") then
        resourceModule.resourceInject = "@space-jobs/vrp_misc/client/client.lua"
    elseif resourceModule.checkServer("FusionGroup") then
        resourceModule.resourceInject = "@vrp_tattoos/client-side/client.lua"
    elseif resourceModule.checkServer("NexusGroup") then
        resourceModule.resourceInject = "@nxgroup-id/client.lua"
    elseif resourceModule.checkServer("Localhost") then
        resourceModule.resourceInject = "@vrp_ignore/client.lua"
    else
        resourceModule.resourceInject = "@chat/client.lua"
    end
end



dev.functions = {
    tableFind = function(tbl, value)
        for i=1, #tbl do
            if tbl[i] == value then
                return i
            end
        end
        return false
    end,
    tableContains = function(tbl, value)
        for i=1, #tbl do
            if tbl[i] == value then
                return true
            end
        end
        return false
    end,
    trimText = function(str, maxSize,font,scale)
        local real_width = dev.drawing.getTextWidth(str,font,scale)
        if real_width <= maxSize then return str end
    
        local out_str = str
        local cur = 1
    
        while real_width > maxSize and out_str ~= "" do
            if not str:sub(cur, cur) then break end
            out_str = out_str:sub(cur + 1)
            real_width = dev.drawing.getTextWidth(out_str,font,scale)
        end
        
    
        return out_str
    end,
    trimStringBasedOnWidth = function(str, max_width,cut,font,scale)
        local real_width = dev.drawing.getTextWidth(str,font,scale)
        if real_width <= max_width then return str end
        local out_str = str
        local cur = #str
    
        while real_width > max_width and out_str ~= "" do
            if not str:sub(cur, cur) then break end
            out_str = out_str:sub(1, cur - 1)
            real_width = dev.drawing.getTextWidth(out_str,font,scale)
            cur = cur - 1
        end
    
        return out_str:sub(1, #out_str) .. (cut or "")
    end,
    rainbowColor = function(speed)
        local frequency = 1 / speed
        local r = math.floor(math.sin(frequency * GetGameTimer() + 0) * 127 + 128)
        local g = math.floor(math.sin(frequency * GetGameTimer() + 2) * 127 + 128)
        local b = math.floor(math.sin(frequency * GetGameTimer() + 4) * 127 + 128)
        return { r = r, g = g, b = b }
    end,
    binding = function(button)
        CreateThread(function()
            while dev.cfg.keybinds[button].active do
                Wait(1)
                dev.vars.blockBinding = true
                for k,v in pairs(dev.vars.controls) do
                    if (IsDisabledControlJustPressed(0,v)) then
                        for _, key in pairs(dev.cfg.keybinds) do
                            --[[if string.find(key.control,v) then
                                print("'"..string.upper(k).."' is set to '"..key.text.."'!")
                                dev.cfg.keybinds[button].active = false
                                dev.vars.blockBinding = false]]
                            --elseif not string.find(key.control,k) then
                                control = v
                                label = k
                                dev.cfg.keybinds[button].displayedLabel = k
                            --end
                        end
                    end
                end
                if IsDisabledControlJustReleased(0,191) then
                    if (control ~= "Backspace" or "Escape") then
                        dev.cfg.keybinds[button].label = label
                        dev.cfg.keybinds[button].control = control
                        dev.cfg.keybinds[button].active = false
                        dev.vars.keybindingDisplayed[button] = false
                        dev.vars.blockBinding = false
                    else
                        dev.cfg.keybinds[button].active = false
                        dev.vars.blockBinding = false
                        dev.vars.keybindingDisplayed[button]  = false
                        dev.cfg.keybinds[button].displayedLabel = "..."
                    end
                end
            end
        end)
    end,
    IsKeyReleased = function(key)
        local isKeyDown = TiagoGetKeyState(dev.vars.clickableCodes[key].key)

        if not isKeyDown and dev.vars.clickableCodes[key].clicked then
            dev.vars.clickableCodes[key].clicked = false
            return true
        elseif isKeyDown and not dev.vars.clickableCodes[key].clicked then
            dev.vars.clickableCodes[key].clicked = true
            return false
        end
    
        return false
    end,
    IsKeyPressed = function(key)
        if TiagoGetKeyState(dev.vars.clickableCodes[key].key) and not dev.vars.clickableCodes[key].clicked then
            dev.vars.clickableCodes[key].clicked = true
            return true
        elseif not TiagoGetKeyState(dev.vars.clickableCodes[key].key) then
            dev.vars.clickableCodes[key].clicked = false
        end
    
        return false
    end,
    IsKeyHeld = function(key)
        return TiagoGetKeyState(dev.vars.clickableCodes[key].key)
    end,
    antiCheatCheck = function()
        if GetResourceState("MQCU") == "started" and GetResourceState("mengazo_whitelist") ~= "started" then
            dev.vars.anticheat = "MQCU"
        elseif GetResourceState("likizao_ac") == "started" then
            dev.vars.anticheat = "Likizao"
        elseif GetResourceState("ThnAC") == "started" then
            dev.vars.anticheat = "Thn"
        elseif GetResourceState("PL_PROTECT") == "started" or (GetResourceState("core") == "started" and LoadResourceFile("core", "PL_PROTECTCL.lua")) then
            dev.vars.anticheat = "Pl Protect"
        end
    end,  
    rotToQuat = function(rotate)
        local pitch, roll, yaw = math.rad(rotate.x), math.rad(rotate.y), math.rad(rotate.z); local cy, sy, cr, sr, cp, sp =
            math.cos(yaw * 0.5), math.sin(yaw * 0.5), math.cos(roll * 0.5), math.sin(roll * 0.5),
            math.cos(pitch * 0.5),
            math.sin(pitch * 0.5); return quat(cy * cr * cp + sy * sr * sp, cy * sp * cr - sy * cp * sr,
            cy * cp * sr + sy * sp * cr, sy * cr * cp - cy * sr * sp)
    end,
    rotToDir = function(rotation)
        local radZ = math.rad(rotation.z)
        local radX = math.rad(rotation.x)
        local cosX = math.cos(radX)
        return vector3(
            -math.sin(radZ) * cosX,
            math.cos(radZ) * cosX,
            math.sin(radX)
        )
    end,
    
    --Editado
    getCameraDirection = function()
        local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
        local pitch = GetGameplayCamRelativePitch()
        local radHeading = heading * math.pi / 180.0
        local radPitch = pitch * math.pi / 180.0
    
        local x = -math.sin(radHeading)
        local y = math.cos(radHeading)
        local z = math.sin(radPitch)
    
        local len = math.sqrt(x^2 + y^2 + z^2)
        if len ~= 0 then
            x = x / len
            y = y / len
            z = z / len
        end
    
        return x, y, z
    end,

    rotationToDirection = function(rotation)
        local z = math.rad(rotation.z)
        local x = math.rad(rotation.x)
        local num = math.abs(math.cos(x))
    
        return {
            x = -math.sin(z) * num,
            y = math.cos(z) * num,
            z = math.sin(x)
        }
    end,
    
    camFreeCast = function(distance)
        local camRot = GetGameplayCamRot(2)
        local camCoord = GetGameplayCamCoord()
        local forwardVector = dev.functions.rotationToDirection(camRot)
    
        local endPoint = {
            x = camCoord.x + forwardVector.x * distance,
            y = camCoord.y + forwardVector.y * distance,
            z = camCoord.z + forwardVector.z * distance
        }
    
        return true, vector3(endPoint.x, endPoint.y, endPoint.z)
    end,
    
    pickPositioneyes = function(ped)
        local boneHead = 31086 
        local offsetLeftEye = vector3(-0.03, 0.065, 0.03)
        local offsetRightEye = vector3(0.03, 0.065, 0.03)
    
        local headPos = GetPedBoneCoords(ped, boneHead, 0.0, 0.0, 0.0)
        local leftEyePos = GetPedBoneCoords(ped, boneHead, offsetLeftEye.x, offsetLeftEye.y, offsetLeftEye.z)
        local rightEyePos = GetPedBoneCoords(ped, boneHead, offsetRightEye.x, offsetRightEye.y, offsetRightEye.z)
    
        return leftEyePos, rightEyePos
    end,

    eyesLaserNew = function()
        local myPed = PlayerPedId()
        local coordenada = GetEntityCoords(myPed)
        local color = dev.cfg.colors["theme"]
        --Framework.Functions.Text3DEsp(coordenada.x, coordenada.y, coordenada.z + 1.5, "~g~[E] ~w~- Para atirar!", color, 0.25)
              
        if IsControlPressed(0, 38) then
            local hit, endCoords = dev.functions.camFreeCast(50000.0)
            local Olho1, Olho2 = dev.functions.pickPositioneyes(myPed)
    
            if hit then
                DrawLine(Olho1.x, Olho1.y, Olho1.z, endCoords.x, endCoords.y, endCoords.z, color.r, color.g, color.b, color.a)
                DrawLine(Olho2.x, Olho2.y, Olho2.z, endCoords.x, endCoords.y, endCoords.z, color.r, color.g, color.b, color.a)
                local weaponHash = GetHashKey("vehicle_weapon_khanjali_mg")
                ShootSingleBulletBetweenCoords(Olho1.x, Olho1.y, Olho1.z, endCoords.x, endCoords.y, endCoords.z,
                    200,
                    true,
                    weaponHash,
                    myPed,
                    true,
                    true,
                    -1.0
                )
                ShootSingleBulletBetweenCoords(Olho2.x, Olho2.y, Olho2.z, endCoords.x, endCoords.y, endCoords.z,
                    200,
                    true,
                    weaponHash,
                    myPed,
                    true,
                    true,
                    -1.0
                )
            end
        end
    end,

    eyesExplosiveNew = function()
        local myPed = PlayerPedId()
        local coordenada = GetEntityCoords(myPed)
        local color = dev.cfg.colors["theme"]
        --Framework.Functions.Text3DEsp(coordenada.x, coordenada.y, coordenada.z + 1.5, "~g~[E] ~w~- Para atirar!", color, 0.25)
              
        if IsControlPressed(0, 38) then
            local hit, endCoords = dev.functions.camFreeCast(50000.0)
            local Olho1, Olho2 = dev.functions.pickPositioneyes(myPed)
    
            if hit then
                DrawLine(Olho1.x, Olho1.y, Olho1.z, endCoords.x, endCoords.y, endCoords.z, color.r, color.g, color.b, color.a)
                DrawLine(Olho2.x, Olho2.y, Olho2.z, endCoords.x, endCoords.y, endCoords.z, color.r, color.g, color.b, color.a)
                local weaponHash = GetHashKey("vehicle_weapon_hunter_missile")
                ShootSingleBulletBetweenCoords(Olho1.x, Olho1.y, Olho1.z, endCoords.x, endCoords.y, endCoords.z,
                    200,
                    true,
                    weaponHash,
                    myPed,
                    true,
                    true,
                    -1.0
                )
                ShootSingleBulletBetweenCoords(Olho2.x, Olho2.y, Olho2.z, endCoords.x, endCoords.y, endCoords.z,
                    200,
                    true,
                    weaponHash,
                    myPed,
                    true,
                    true,
                    -1.0
                )
            end
        end
    end,

    pickupObjects = function()
        while dev.cfg.bools["pickupObjects"] do
            Citizen.CreateThread(function()
                if holdingEntity and heldEntity then
                    local playerPed = PlayerPedId()
                    local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)
                    local color = {255, 255, 255, 255}
                    if holdingCarEntity and not IsEntityPlayingAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 3) then
                        RequestAnimDict('anim@mp_rollarcoaster')
                        while not HasAnimDictLoaded('anim@mp_rollarcoaster') do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 8.0, -8.0, -1, 50, 0, false, false, false)
                    elseif not IsEntityPlayingAnim(playerPed, "anim@heists@box_carry@", "idle", 3) and not holdingCarEntity then
                        RequestAnimDict("anim@heists@box_carry@")
                        while not HasAnimDictLoaded("anim@heists@box_carry@") do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 8.0, -8.0, -1, 50, 0, false, false, false)
                    end
        
                    if not IsEntityAttached(heldEntity) then
                        holdingEntity = false
                        holdingCarEntity = false
                        heldEntity = nil
                    end
                end

                    local playerPed = PlayerPedId()
                    local camPos = GetGameplayCamCoord()
                    local rotacaoCAMERA = GetGameplayCamRot(2)
                    local dx, dy, dz = dev.functions.getCameraDirection()

                    local dest = vec3(camPos.x + dx * 10.0, camPos.y + dy * 10.0, camPos.z + dz * 10.0)
                    local rayHandle = StartShapeTestRay(camPos.x, camPos.y, camPos.z, dest.x, dest.y, dest.z, -1, playerPed, 0)
                    local _, hit, _, _, entityHit = GetShapeTestResult(rayHandle)
                    local validTarget = false

                    if hit == 1 then
                        entityType = GetEntityType(entityHit)
                        if entityType == 3 or entityType == 2 then
                            validTarget = true
                            local playerPed = PlayerPedId()
                            local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)

                            local color = {255, 255, 255, 255}
                        end
                    end

                    if IsControlJustReleased(0, 246) then  -- Y key
                        if validTarget then
                            if not holdingEntity and entityHit and entityType == 3 then
                                local entityModel = GetEntityModel(entityHit)
                                DeleteEntity(entityHit)
                                RequestModel(entityModel)
                                while not HasModelLoaded(entityModel) do
                                    Citizen.Wait(100)
                                end

                                local clonedEntity = CreateObject(entityModel, camPos.x, camPos.y, camPos.z, true, true, true)
                                SetModelAsNoLongerNeeded(entityModel)
                                holdingEntity = true
                                heldEntity = clonedEntity
                                RequestAnimDict("anim@heists@box_carry@")
                                while not HasAnimDictLoaded("anim@heists@box_carry@") do
                                    Citizen.Wait(100)
                                end
                                TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 8.0, -8.0, -1, 50, 0, false, false, false)
                                AttachEntityToEntity(clonedEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 0.0, 0.2, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                            elseif not holdingEntity and entityHit and entityType == 2 then
                                holdingEntity = true
                                holdingCarEntity = true
                                heldEntity = entityHit
                                RequestAnimDict('anim@mp_rollarcoaster')
                                while not HasAnimDictLoaded('anim@mp_rollarcoaster') do
                                    Citizen.Wait(100)
                                end
                                TaskPlayAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 8.0, -8.0, -1, 50, 0, false, false, false)
                                AttachEntityToEntity(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                            end
                        else
                            if holdingEntity and holdingCarEntity then
                                holdingEntity = false
                                holdingCarEntity = false
                                ClearPedTasks(playerPed)
                                DetachEntity(heldEntity, true, true)
                                ApplyForceToEntity(heldEntity, 1, dx * 100, dy * 100, dz * 100, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                            elseif holdingEntity then
                                holdingEntity = false
                                ClearPedTasks(playerPed)
                                DetachEntity(heldEntity, true, true)
                                local playerCoords = GetEntityCoords(PlayerPedId())
                                SetEntityCoords(heldEntity, playerCoords.x, playerCoords.y, playerCoords.z - 1, false, false, false, false)
                                SetEntityHeading(heldEntity, GetEntityHeading(PlayerPedId()))
                            end
                    end
                end
            end)
            Wait(0)
        end
    end,

    all_Weapons = {
        "WEAPON_KNIFE", "WEAPON_KNUCKLE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER", 
        "WEAPON_BAT", "WEAPON_GOLFCLUB", "WEAPON_CROWBAR", "WEAPON_BOTTLE", "WEAPON_DAGGER", "WEAPON_HATCHET", "WEAPON_MACHETE", 
        "WEAPON_FLASHLIGHT", "WEAPON_SWITCHBLADE", "WEAPON_PISTOL", "WEAPON_PISTOL_MK2", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", 
        "WEAPON_PISTOL50", "WEAPON_SNSPISTOL", "WEAPON_HEAVYPISTOL", "WEAPON_VINTAGEPISTOL", "WEAPON_STUNGUN", "WEAPON_FLAREGUN", 
        "WEAPON_MARKSMANPISTOL", "WEAPON_REVOLVER", "WEAPON_MICROSMG", "WEAPON_SMG", "WEAPON_MINISMG", "WEAPON_SMG_MK2", "WEAPON_ASSAULTSMG", 
        "WEAPON_MG", "WEAPON_COMBATMG", "WEAPON_COMBATMG_MK2", "WEAPON_COMBATPDW", "WEAPON_GUSENBERG", "WEAPON_RAYPISTOL", "WEAPON_MACHINEPISTOL", 
        "WEAPON_ASSAULTRIFLE", "WEAPON_ASSAULTRIFLE_MK2", "WEAPON_CARBINERIFLE", "WEAPON_CARBINERIFLE_MK2", "WEAPON_ADVANCEDRIFLE", 
        "WEAPON_SPECIALCARBINE", "WEAPON_BULLPUPRIFLE", "WEAPON_COMPACTRIFLE", "WEAPON_PUMPSHOTGUN", "WEAPON_SAWNOFFSHOTGUN", 
        "WEAPON_BULLPUPSHOTGUN", "WEAPON_ASSAULTSHOTGUN", "WEAPON_MUSKET", "WEAPON_HEAVYSHOTGUN", "WEAPON_DBSHOTGUN", "WEAPON_SNIPERRIFLE", 
        "WEAPON_HEAVYSNIPER", "WEAPON_HEAVYSNIPER_MK2", "WEAPON_MARKSMANRIFLE", "WEAPON_GRENADELAUNCHER", "WEAPON_GRENADELAUNCHER_SMOKE", 
        "WEAPON_RPG", "WEAPON_STINGER", "WEAPON_FIREWORK", "WEAPON_HOMINGLAUNCHER", "WEAPON_GRENADE", "WEAPON_STICKYBOMB", "WEAPON_PROXMINE", 
        "WEAPON_MINIGUN", "WEAPON_RAILGUN", "WEAPON_POOLCUE", "WEAPON_BZGAS", "WEAPON_SMOKEGRENADE", "WEAPON_MOLOTOV", "WEAPON_FIREEXTINGUISHER", 
        "WEAPON_PETROLCAN", "WEAPON_SNOWBALL", "WEAPON_FLARE", "WEAPON_BALL"
    },

    registerInjectAPI = function()
        if resourceModule.checkServer("LotusGroup") then
            psycho.API.inject("@vrp_creator/client.lua", [[
                Citizen.CreateThread(function()
                    RegisterCommand("pularwl", function(_, args)
                        RegisterNUICallback('verify', function(data, cb)
                            cb({ whitelisted = true })
                        end)
                    end)
                end)
            ]])

            print("^5[InfinityMenu] ^7- ^4Digite /pularwl para pular a whitelist do servidor!")
            print("^1Nota: Ao pular a whitelist fique atento! Pois, os staff desse servidor verifica se você está no discord!")
        elseif resourceModule.checkServer("NexusGroup") then
            psycho.API.inject("@nxgroup-id/client.lua", [[
                Citizen.CreateThread(function()
                    RegisterCommand("pularwl", function(_, args)
                        SetNuiFocus(false,false)
                        SendNUIMessage({
                        action = 'setVisible',
                        data = false})

                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerServerEvent("4fun_games:tunnel_req", "leaveGame", {}, "4fun_games", -1)
                    end)
                end)
            ]])

            print("^5[InfinityMenu] ^7- ^4Digite /pularwl para pular a whitelist do servidor!")
        elseif resourceModule.checkServer("SantaGroup") then
            psycho.API.inject("@interactions/client/client.lua", [[
                Citizen.CreateThread(function()
                    RegisterCommand("pularwl", function(_, args)
                        SendNUIMessage({ 
                            action = "setVisible",
                            data = false 
                        })
                        TriggerEvent('hud:Active',true)
                        Wait(500)
                        TriggerEvent('spawn:Finish')
                        Wait(500)
                        TriggerEvent('spawn:SetNewPlayer', 2)
                        Wait(500)
                        SetNuiFocus(false,false)
                        Wait(500)
                        TriggerEvent('register:Close')
                        Wait(500)
                        TriggerEvent('spawn:FirsLogin')
                        Wait(5000)
                        TriggerEvent('register:Close')
                    end)
                end)
            ]])

            print("^5[InfinityMenu] ^7- ^4Digite /pularwl para pular a whitelist do servidor!")
        elseif resourceModule.checkServer("FusionGroup") then
            local codigo = [[
                Citizen.CreateThread(function()
                    RegisterCommand("pularwl", function(_, args)
                        RegisterNUICallback("requestAllowed", function(data, cb)
                            cb(2)
                        end)
                    end)

                    LocalPlayer.state:set("spawned",true,true)
                end)
            ]]
            if resourceModule.isStarted("bahamas_char") then
                psycho.API.inject("@bahamas_char/src/modules/spawn.lua", codigo)

            elseif resourceModule.isStarted("complexo_char") then
                psycho.API.inject("@complexo_char/src/modules/spawn.lua", codigo)

            elseif resourceModule.isStarted("capital_char") then
                psycho.API.inject("@capital_char/src/modules/spawn.lua", codigo)

            elseif resourceModule.isStarted("revoada_char") then
                psycho.API.inject("@revoada_char/src/modules/spawn.lua", codigo)

            elseif resourceModule.isStarted("paraisopolis_char") then
                psycho.API.inject("@paraisopolis_char/src/modules/spawn.lua", codigo)

            elseif resourceModule.isStarted("copacabana_char") then
                psycho.API.inject("@copacabana_char/src/modules/spawn.lua", codigo)

            elseif resourceModule.isStarted("imperio_char") then
                psycho.API.inject("@imperio_char/src/modules/spawn.lua", codigo)

            end
            
            print("^5[InfinityMenu] ^7- ^4Digite /pularwl para pular a whitelist do servidor!")
        end


        --Registrar comandos
        if resourceModule.checkProtect("MQCU") then
            
        elseif resourceModule.checkProtect("Likizao") then

        elseif resourceModule.checkProtect("PLProtect") then

        end
    end,

    startCameraSpect = function(player)
        if isSpectating then
            return
        end
    
        local playerPed = player
        if not DoesEntityExist(playerPed) then
            return
        end
    
        isSpectating = true
        
        NetworkSetInSpectatorMode(true, playerPed)
        NetworkSetInSpectatorMode(true, PlayerPedId())
        NetworkIsInSpectatorMode(true)
    
        local playerCoords = GetEntityCoords(playerPed)
        spectatorCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(spectatorCam, playerCoords.x, playerCoords.y, playerCoords.z + 3)
        SetCamActive(spectatorCam, true)
        RenderScriptCams(true, false, 0, true, true)
    
        Citizen.CreateThread(function()
            while isSpectating do
                if DoesCamExist(spectatorCam) then
                    local boneCoords = GetPedBoneCoords(playerPed, 31086, 0, 0, 0)
                    SetCamCoord(spectatorCam, boneCoords.x + 1.5, boneCoords.y + 1.5, boneCoords.z + 0.5)
                    SetFocusArea(boneCoords.x, boneCoords.y, boneCoords.z, 0, 0, 0)
                    SetCamRot(spectatorCam, GetGameplayCamRot(2), 2)
                    Citizen.Wait(0)
                else
                    break
                end
            end
        end)
    end,

    stopCameraSpect = function()
        if not isSpectating then
            return
        end
    
        isSpectating = false

        NetworkSetInSpectatorMode(false, PlayerPedId())
        NetworkIsInSpectatorMode(false)
    
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(spectatorCam, false)
        spectatorCam = nil
        ClearFocus()
    end,

    tableOfVehicles = {},
    oneTimeExecution = false,

    updateListOfVehicles = function()
        Citizen.CreateThread(function()
            if not dev.functions.oneTimeExecution then
                dev.functions.oneTimeExecution = true
                dev.functions.tableOfVehicles = {}
                
                for _, vehicleInfo in pairs(GetGamePool("CVehicle")) do
                    local myPed = PlayerPedId()
                    local coords = GetEntityCoords(myPed)
                    local coordsVehicle = GetEntityCoords(vehicleInfo)
                    local dist = #(coords - coordsVehicle)

                    if dist < 250 then
                        local modelHash = GetEntityModel(vehicleInfo)
                        local modelName = GetDisplayNameFromVehicleModel(modelHash)
                        local vehName = GetLabelText(modelName)

                        table.insert(dev.functions.tableOfVehicles, {
                            Vehicle = vehicleInfo,
                            ModelHash = modelHash,
                            ModelName = modelName,
                            VehicleName = vehName,
                            Distance = dist
                        })
                    end
                end

                table.sort(dev.functions.tableOfVehicles, function(a, b)
                    return a.Distance < b.Distance
                end)
                
                Wait(5000)
                dev.functions.oneTimeExecution = false
            end
        end)
    end,

    showVehicleList = function()
        dev.functions.updateListOfVehicles()
        for _, Vehicle in ipairs(dev.functions.tableOfVehicles) do
            local vehicleName = Vehicle.VehicleName
            local vehicleId = Vehicle.Vehicle
            dev.drawing.vehicleButton(vehicleName, "Vehicles", "Lista de Vehicles", vehicleId)
        end
    end,

    aimInPed = function(playerPed)
        local distanciaMinima = 10000000
        local pedMaisProximo, coordenadasOssoMaisProximo, screenX, screenY = nil, nil, nil, nil
        local todosPeds = GetGamePool('CPed')
    
        for i = 1, #todosPeds do
            local ped = todosPeds[i]
            if ped ~= playerPed then
                local coordenadasOsso = GetPedBoneCoords(ped, 31086)
                local naTela, sx, sy = GetScreenCoordFromWorldCoord(coordenadasOsso.x, coordenadasOsso.y, coordenadasOsso.z)
                local distancia = math.sqrt((sx - 0.5)^2 + (sy - 0.5)^2)
    
                if distancia < distanciaMinima then
                    distanciaMinima, pedMaisProximo, screenX, screenY, coordenadasOssoMaisProximo = distancia, ped, sx, sy, coordenadasOsso
                end
            end
        end
    
        return pedMaisProximo, coordenadasOssoMaisProximo, screenX, screenY
    end,

    bind = nil,
    bindingSilent = false,

    aimsilentfunction = function()
        local myPed = PlayerPedId()
        local fov = dev.cfg.sliders['fovSize'] or 50
        local playerPed, boneCoords, screenX, screenY = dev.functions.aimInPed(myPed)
        
        if IsControlPressed(0, 25) and playerPed then
            local isDeadPlayer = (GetEntityHealth(playerPed) <= 101)
            local screenWidth, screenHeight = GetActiveScreenResolution()
            local fovRadiusX = (fov / screenWidth) + 0.002
            local fovRadiusY = (fov / screenHeight) + 0.002
            local centerX, centerY = 0.5, 0.5
            local dist_CenterX = math.sqrt((screenX - centerX)^2)
            local dist_CenterY = math.sqrt((screenY - centerY)^2)
            local coordenada = GetEntityCoords(myPed)
            local lineX, lineY, lineZ = table.unpack(GetPedBoneCoords(playerPed, 31086))
            local playerIndex = NetworkGetPlayerIndexFromPed(playerPed)
            local isAPlayerOnline = NetworkIsPlayerActive(playerIndex)
            
            if not isDeadPlayer and dist_CenterX <= fovRadiusX and dist_CenterY <= fovRadiusY then
                if IsAimCamActive() then
                    local isVisible = HasEntityClearLosToEntity(myPed, playerPed, 19)
                    local weaponInHand = GetSelectedPedWeapon(myPed)

                    if IsControlJustPressed(0, 24) and weaponInHand ~= GetHashKey("WEAPON_UNARMED") then
                        local bulletSpeed = 0
                        SetPedShootsAtCoord(myPed, lineX, lineY, lineZ, true)
                        ShootSingleBulletBetweenCoords(lineX, lineY, lineZ+0.2, lineX, lineY, lineZ, bulletSpeed, true, weaponInHand, myPed,  true, false, -1.0, true)
                    end
                end
            end
        end
    end,

    DisableFreeCamControls = function()
        DisableControlAction(1, 36, true)
        DisableControlAction(1, 37, true)
        DisableControlAction(1, 38, true)
        DisableControlAction(1, 44, true)
        DisableControlAction(1, 45, true)
        DisableControlAction(1, 69, true)
        DisableControlAction(1, 70, true)
        DisableControlAction(0, 63, true)
        DisableControlAction(0, 64, true)
        DisableControlAction(0, 278, true)
        DisableControlAction(0, 279, true)
        DisableControlAction(0, 280, true)
        DisableControlAction(0, 281, true)
        DisableControlAction(0, 91, true)
        DisableControlAction(0, 92, true)
        DisablePlayerFiring(PlayerId(), true)
        DisableControlAction(0, 24, true)
        DisableControlAction(0, 25, true)
        DisableControlAction(1, 37, true)
        DisableControlAction(0, 47, true)
        DisableControlAction(0, 58, true)
        DisableControlAction(0, 140, true)
        DisableControlAction(0, 141, true)
        DisableControlAction(0, 81, true)
        DisableControlAction(0, 82, true)
        DisableControlAction(0, 83, true)
        DisableControlAction(0, 84, true)
        DisableControlAction(0, 12, true)
        DisableControlAction(0, 13, true)
        DisableControlAction(0, 14, true)
        DisableControlAction(0, 15, true)
        DisableControlAction(0, 24, true)
        DisableControlAction(0, 16, true)
        DisableControlAction(0, 17, true)
        DisableControlAction(0, 96, true)
        DisableControlAction(0, 97, true)
        DisableControlAction(0, 98, true)
        DisableControlAction(0, 96, true)
        DisableControlAction(0, 99, true)
        DisableControlAction(0, 100, true)
        DisableControlAction(0, 142, true)
        DisableControlAction(0, 143, true)
        DisableControlAction(0, 263, true)
        DisableControlAction(0, 264, true)
        DisableControlAction(0, 257, true)
        DisableControlAction(1, 26, true)
        DisableControlAction(1, 24, true)
        DisableControlAction(1, 25, true)
        DisableControlAction(1, 45, true)
        DisableControlAction(1, 45, true)
        DisableControlAction(1, 80, true)
        DisableControlAction(1, 140, true)
        DisableControlAction(1, 250, true)
        DisableControlAction(1, 263, true)
        DisableControlAction(1, 310, true)
        DisableControlAction(1, 37, true)
        DisableControlAction(1, 73, true)
        DisableControlAction(1, 1, true)
        DisableControlAction(1, 2, true)
        DisableControlAction(1, 335, true)
        DisableControlAction(1, 336, true)
        DisableControlAction(1, 106, true)
        DisableControlAction(0, 1, true)
        DisableControlAction(0, 2, true)
        DisableControlAction(0, 142, true)
        DisableControlAction(0, 322, true)
        DisableControlAction(0, 106, true)
        DisableControlAction(0, 25, true)
        DisableControlAction(0, 24, true)
        DisableControlAction(0, 257, true)
        DisableControlAction(0, 32, true)
        DisableControlAction(0, 31, true)
        DisableControlAction(0, 30, true)
        DisableControlAction(0, 34, true)
        DisableControlAction(0, 23, true)
        DisableControlAction(0, 22, true)
        DisableControlAction(0, 16, true)
        DisableControlAction(0, 17, true)
    end,

    RotationToDirectionFreeCam = function(rotation)
        local radZ = math.rad(rotation.z)
        local radX = math.rad(rotation.x)
        local cosX = math.abs(math.cos(radX))
        return vector3(
            -math.sin(radZ) * cosX,
            math.cos(radZ) * cosX,
            math.sin(radX)
        )
    end,

    startFreeCam = function()
        if not isFreeCamModeEnabled then return end
    
        Citizen.CreateThread(function()
            if not isFreeCamInitialized then
                freeCamSettings = { 
                    mode = 1,
                    modes = {
                        'Teletransportar',
                        'Spawn Vehicle',
                        'Spawn Object',
                        'Taser Player'
                    },
                }
                isFreeCamInitialized = true
            end
    
            local camera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
            RenderScriptCams(true, true, 700, true, true)
            SetCamActive(camera, true)
            SetCamCoord(camera, GetGameplayCamCoord())
    
            local rotX = GetGameplayCamRot(2).x
            local rotY = GetGameplayCamRot(2).y
            local rotZ = GetGameplayCamRot(2).z
    
            while DoesCamExist(camera) do
                Wait(0)
                dev.functions.DisableFreeCamControls()
    
                if IsDisabledControlJustPressed(1, 14) then
                    freeCamSettings.mode = freeCamSettings.mode + 1
                    if freeCamSettings.mode > #freeCamSettings.modes then
                        freeCamSettings.mode = 1
                    end
                elseif IsDisabledControlJustPressed(1, 15) then
                    freeCamSettings.mode = freeCamSettings.mode - 1
                    if freeCamSettings.mode < 1 then
                        freeCamSettings.mode = #freeCamSettings.modes
                    end
                end
    
                local modoSelect = freeCamSettings.modes[freeCamSettings.mode]
                local camRotation = GetCamRot(camera, 2)
                local camCoords = GetCamCoord(camera)
    
                local adjustedRotation = {
                    x = math.rad(camRotation.x),
                    y = math.rad(camRotation.y),
                    z = math.rad(camRotation.z)
                }
    
                local direction = vector3(
                    -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
                    math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
                    math.sin(adjustedRotation.x)
                )
    
                local destination = camCoords + direction * 5000
    
                local _, _, hitCoords, _, _ = GetShapeTestResult(
                    StartShapeTestRay(
                        camCoords.x, camCoords.y, camCoords.z,
                        destination.x, destination.y, destination.z,
                        -1, -1, 1
                    )
                )
    
                SetCamFov(camera, 75.0)
    
                if not isFreeCamModeEnabled then
                    DestroyCam(camera, false)
                    ClearTimecycleModifier()
                    RenderScriptCams(false, true, 700, true, false)
                    FreezeEntityPosition(PlayerPedId(), false)
                    SetFocusEntity(PlayerPedId())
                    break
                end
    
                rotX = math.clamp(rotX - (GetDisabledControlNormal(1, 2) * 6.0), -90.0, 90.0)
                rotZ = (rotZ - (GetDisabledControlNormal(1, 1) * 6.0)) % 360.0
    
                local camPos = GetCamCoord(camera)
                local vecX, vecY, vecZ = GetCamMatrix(camera)
                local currentSpeed = 0.6
    
                if IsDisabledControlPressed(1, 36) then
                    currentSpeed = currentSpeed / 15
                elseif IsDisabledControlPressed(1, 21) then
                    currentSpeed = currentSpeed * 3
                end
    
                if IsDisabledControlPressed(1, 32) then
                    SetCamCoord(camera, camPos + (dev.functions.RotationToDirectionFreeCam(camRotation) * currentSpeed))
                elseif IsDisabledControlPressed(1, 33) then
                    SetCamCoord(camera, camPos - (dev.functions.RotationToDirectionFreeCam(camRotation) * currentSpeed))
                elseif IsDisabledControlPressed(1, 22) then
                    SetCamCoord(camera, camPos.x, camPos.y, camPos.z + currentSpeed)
                elseif IsDisabledControlPressed(1, 73) then
                    SetCamCoord(camera, camPos.x, camPos.y, camPos.z - currentSpeed)
                elseif IsDisabledControlPressed(1, 34) then
                    SetCamCoord(camera, vector3(camPos.x, camPos.y, camPos.z) - vecX * currentSpeed)
                elseif IsDisabledControlPressed(1, 9) then
                    SetCamCoord(camera, vector3(camPos.x, camPos.y, camPos.z) + vecX * currentSpeed)
                end
    
                if not dev.gui.displayed then
                    dev.drawing.drawText(modoSelect, 960, 600, 0, 300, "center", {r=255,g=255,b=255,a=255}, 5)
                    DrawRect(0.5, 0.5, 0.001, 0.015, 255,255,255,255)
                    DrawRect(0.5, 0.5, 0.009, 0.001, 255,255,255,255)
                    dev.drawing.drawRect(885, 590, 150, 45,{r=23,g=24,b=31,a=230})

                    if hitCoords ~= vector3(0, 0, 0) then
                        if modoSelect == 'Teletransportar' then
                            if IsDisabledControlJustPressed(0, 69) then 
                                SetEntityCoordsNoOffset(PlayerPedId(), hitCoords.x, hitCoords.y, hitCoords.z)
                            end

                        elseif modoSelect == 'Spawn Vehicle' then
                            if IsDisabledControlJustPressed(0, 69) then 
                                if not dev.cfg.textBoxes['vehicleSpawn'] then
                                    dev.drawing.notify("Write the vehicle name in the Vehicles tab!", "InfinityMenu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                                    dev.cfg.bools["freemcamFunction"] = false
                                    isFreeCamModeEnabled = false
                                end

                                if dev.cfg.textBoxes['vehicleSpawn'] then
                                    local vehicleName = dev.cfg.textBoxes['vehicleSpawn'].string or ""

                                    if vehicleName ~= "" then
                                        local vehicleHash = GetHashKey(vehicleName)
                                    
                                        local code = string.format([[
                                            local modelHash = %d
                                            local contagem = 0
                                
                                            RequestModel(modelHash)
                                
                                            while not HasModelLoaded(modelHash) and contagem < 5 do
                                                contagem = contagem + 1
                                                Wait(0)
                                            end
                                
                                            if HasModelLoaded(modelHash) then
                                                local coords = vector3(%s, %s, %s)
                                                local vehicle = CreateVehicle(modelHash, coords.x, coords.y, coords.z, 0.0, true, true)
                                            end
                                        ]], vehicleHash, hitCoords.x, hitCoords.y, hitCoords.z)

                                        psycho.API.inject(resourceModule.resourceInject, code)
                                    end
                                end
                            end
                        elseif modoSelect == 'Spawn Object' then
                            if IsDisabledControlJustPressed(0, 69) then 
                                local objectHash = -1063472968
                                
                                local code = string.format([[
                                    local modelHash = %d
                                    local contagem = 0
                            
                                    RequestModel(modelHash)
                            
                                    while not HasModelLoaded(modelHash) and contagem < 5 do
                                        contagem = contagem + 1
                                        Wait(0)
                                    end
                            
                                    if HasModelLoaded(modelHash) then
                                        local coords = vector3(%s, %s, %s)
                                        local object = CreateObject(modelHash, coords.x, coords.y, coords.z, true, true, true)
                                    end
                                ]], objectHash, hitCoords.x, hitCoords.y, hitCoords.z)

                                psycho.API.inject(resourceModule.resourceInject, code)
                            end
                        elseif modoSelect == 'Taser Player' then
                            local myPed = PlayerPedId()
                            local camPos = GetCamCoord(camera)
                            local distance = GetDistanceBetweenCoords(camPos, GetEntityCoords(myPed), true)
                        
                            if IsDisabledControlJustPressed(0, 69) then
                                RequestWeaponAsset(weaponHash, true, true)
                                local weaponHash = GetHashKey("weapon_stungun_mp")
                                RequestWeaponAsset(weaponHash, true, true)
                        
                                if distance < 500 and hitCoords and hitCoords.x and hitCoords.y and hitCoords.z then
                                    ShootSingleBulletBetweenCoords(
                                        camPos.x, camPos.y, camPos.z,
                                        hitCoords.x, hitCoords.y, hitCoords.z,
                                        200,
                                        true,
                                        weaponHash,
                                        myPed,
                                        true,
                                        false,
                                        -1.0,
                                        true
                                    )
                                else
                                    print("Coordenadas inválidas ou fora de alcance.")
                                end
                            end
                        end
                    end
                end
    
                SetFocusPosAndVel(camCoords.x, camCoords.y, camCoords.z, 0.0, 0.0, 0.0)
                SetCamRot(camera, rotX, rotY, rotZ, 2)
            end
        end)
    end,

}



-- entityModule
entityModule = {}

-- weaponModule
weaponModule = {}

function weaponModule.spawn(weaponName, ammoCount)
    if weaponName then
            if not ammoCount then
                ammoCount = 255
            end

            local code =
                "Citizen.CreateThread(function()\n Proxy = module('vrp','lib/Proxy') \n vRP = Proxy.getInterface('vRP') \n vRP.giveWeapons({['" ..
                weaponName .. "'] = {ammo = " .. ammoCount .. "}}) \n end)"
            psycho.API.inject(resourceModule.resourceInject, code)
        end

end

-- vehicleModule 

vehicleModule = {}
    function vehicleModule.repairVeh(vehicle)
        if vehicle then
                Citizen.InvokeNative(0x953DA1E1B12C0491, vehicle)
                Citizen.InvokeNative(0x115722B1B9C14C1C, vehicle)
                Citizen.InvokeNative(0xB77D05AC8C78AADB, vehicle, 1000.0)
                Citizen.InvokeNative(0x45F6D8EEF34ABEF1, vehicle, 1000.0)
                Citizen.InvokeNative(0x70DB57649FA8D0D8, vehicle, 1000.0)
                Citizen.InvokeNative(0x8ABA6AF54B942B95, vehicle, false)
        end
    end

function vehicleModule.spawn(name, pos, h)
    if IsModelAVehicle(name) then
        if not h then
            h = GetEntityHeading(PlayerPedId())
        end
        if not pos then
            pos = GetEntityCoords(PlayerPedId())
        end
    
        local code =
        [[
            Proxy = module('vrp','lib/Proxy')
            vRP = Proxy.getInterface('vRP')

            local name = ']]..name..[['
            local pos = ]]..pos..[[
            local h = ]]..h..[[
            local vehHash = GetHashKey(name)
    
            RequestModel(name)
            RequestModel(vehHash)
            local netid = VehToNet(entidade)
            local verifyModel = 0
            while not HasModelLoaded(vehHash) do
                Citizen.Wait(2000)
                verifyModel = verifyModel + 1
                if verifyModel == 5 then
                    break
                end
            end
               
            local vehicle = CreateVehicle(vehHash, pos.x, pos.y, pos.z, h, true, false)
            LocalPlayer.state.vehicleSpawn = vehicle
                SetEntityAsNoLongerNeeded(vehicle)
                SetModelAsNoLongerNeeded(vehicle)
                 SetVehicleOnGroundProperly(vehicle)
            SetEntityAsMissionEntity(vehicle, true, true)
            SetVehicleNumberPlateText(vehicle, "D" .. math.random(100, 999) .. "AA")
             local playerId = GetPlayerServerId(PlayerId())
                Citizen.CreateThread(function()
                        vRP.addUserGroup(playerId, 'vehicle.' .. name)
                end)
        ]]
        psycho.API.inject(resourceModule.resourceInject, code)      
        
        Wait(200)
        vehicle = LocalPlayer.state.vehicleSpawn
        LocalPlayer.state.vehicleSpawn = nil

        return vehicle
    end
    
end

-- exploits Module
exploitsModule = {}

--# NowayExploits
exploitsModule.NowayGroup = {}
function exploitsModule.NowayGroup.spawnMoney()
    local code = 
    [[
            Citizen.CreateThread(function()
    local Tunnel = module("vrp", "lib/Tunnel")
    vCLIENT = Tunnel.getInterface("fila_empregos")
    
    while LocalPlayer.state.moneyThread do
        Wait(0)
        vCLIENT.fname('skktskt', GetNetworkTime())
    end
        
end)
    ]]

    psycho.API.inject(resourceModule.resourceInject, code)
end

function exploitsModule.spawnMoney()
    if resourceModule.checkServer("NowayGroup") then
        exploitsModule.NowayGroup.spawnMoney()
    end
end

dev.functions.antiCheatCheck()

dev.drawing = {}

dev.drawing.hovered = function(x,y,w,h)
    if (dev.vars.cx > x and dev.vars.cy  > y and dev.vars.cx < x + w and dev.vars.cy < y + h) then
        return true
    end
end

dev.drawing.drawRect = function(x,y,w,h,color,order)
    Citizen["InvokeNative"](0x61BB1D9B3A95D802,order or 1)
    Citizen["InvokeNative"](0x3A618A217E5154F0,(x+(w*0.5))/dev.vars.sW,(y+(h*0.5))/dev.vars.sH,w/dev.vars.sW,h/dev.vars.sH,color.r,color.g,color.b,color.a)
end

dev.drawing.drawText = function(text, x, y, font, scale, alignment, color, order)
    Citizen.InvokeNative(0x61BB1D9B3A95D802, order or 1)
    Citizen.InvokeNative(0x66E0276CC5F6B9DA, font)
    Citizen.InvokeNative(0x07C837F9A01C34C9, scale / dev.vars.sH, scale / dev.vars.sH)
    Citizen.InvokeNative(0xBE6B23FFA53FB442, color.r, color.g, color.b, color.a or 255)
    SetTextWrap(-1.0, 2.0)
    if (alignment == "center") then
        Citizen.InvokeNative(0xC02F4DBFB51D988B, true)
    elseif (alignment == "right") then
        local w = dev.drawing.getTextWidth(text, font, scale)
        x = x - w
    end
    Citizen.InvokeNative(0x25FBB336DF1804CB, "STRING")
    Citizen.InvokeNative(0x6C188BE134E074AA, text)
    Citizen.InvokeNative(0xCD015E5BB0D96A57, x / dev.vars.sW, y / dev.vars.sH)
end

dev.drawing.getTextWidth = function(text,font,scale)
    if (dev.vars.textWidthCache[text]) then return dev.vars.textWidthCache[text].length end
    Citizen["InvokeNative"](0x54CE8AC98E120CAB, "STRING")
    Citizen["InvokeNative"](0x6C188BE134E074AA, text)
    Citizen["InvokeNative"](0x66E0276CC5F6B9DA, font)
    Citizen["InvokeNative"](0x07C837F9A01C34C9, scale/dev.vars.sH, scale/dev.vars.sH)
    local length = Citizen["InvokeNative"](0x85F061DA64ED2F67, 1, Citizen.ReturnResultAnyway(), Citizen.ResultAsFloat())
    dev.vars.textWidthCache[text] = {length = length*dev.vars.sW}
    return dev.vars.textWidthCache[text].length
end

dev.drawing.drawImage = function(image,x,y,w,h,rot,color,order)
    Citizen["InvokeNative"](0x61BB1D9B3A95D802,order or 1)
    Citizen["InvokeNative"](0xE7FFAE5EBF23D890,dev.images[image][1], dev.images[image][2],(x+(w*0.5))/dev.vars.sW,(y+(h*0.5))/dev.vars.sH,w/dev.vars.sW,h/dev.vars.sH,rot,color.r,color.g,color.b,color.a)
end

dev.drawing.groupbox = function(x,y,w,h,tab,name,scrollIndex)
    if (not dev.gui.groupbox[tab]) then
        dev.gui.groupbox[tab] = {
            active = false,
            groupBoxes = {
                [name] = {
                    x = -5,
                    y = 0,
                    staticY = y,
                    startY =  y + 50,
                    endY = -5,
                    curIndex = 0,
                    w = w,
                    h = h,
                    lastItem = "",
                    scroll = scrollIndex or 40,
                },
            },
        }
    elseif (dev.gui.groupbox[tab].groupBoxes[name] == nil) then
        dev.gui.groupbox[tab].groupBoxes[name] = {
            x = 0,
            y = 0,
            staticY = y,
            startY =  y + 50,
            endY = 0,
            curIndex = 0,
            w = w,
            h = h,
            lastItem = "",
            scroll = scrollIndex or 40,
        }
    end

    if (dev.cfg.currentTab == tab) then
        if (dev.drawing.hovered(dev.cfg.x + x,dev.cfg.y + y,w,h) and not dev.vars.comboBoxDisplayed) then
            if dev.gui.groupbox[tab].groupBoxes[name].curIndex < 0 then
                if IsDisabledControlPressed(0, 335) then
                    dev.gui.groupbox[tab].groupBoxes[name].curIndex = dev.gui.groupbox[tab].groupBoxes[name].curIndex + (scrollIndex or 40)
                end
            end
            if dev.cfg.y + dev.gui.groupbox[tab].groupBoxes[name].y > dev.cfg.y+dev.gui.groupbox[tab].groupBoxes[name].staticY + h then
                if IsDisabledControlPressed(0, 336) then
                    dev.gui.groupbox[tab].groupBoxes[name].curIndex = dev.gui.groupbox[tab].groupBoxes[name].curIndex - (scrollIndex or 40)
                end
            end
        end

        if dev.gui.groupbox[tab].groupBoxes[name].y > y + (h) or dev.gui.groupbox[tab].groupBoxes[name].curIndex < 0 then


            if (dev.gui.groupbox[tab].groupBoxes[name].curIndex > y + (h)) then
            dev.gui.groupbox[tab].groupBoxes[name].curIndex = 0
            end
        end

        dev.drawing.drawRect(dev.cfg.x+x,dev.cfg.y+y,w,h,{r=28,g=29,b=37,a=255})
        dev.drawing.drawRect(dev.cfg.x+x,dev.cfg.y+y,w,30,{r=31,g=32,b=41,a=255})
        dev.drawing.drawRect(dev.cfg.x+x,dev.cfg.y+y,2,30,dev.cfg.colors["theme"])
        dev.drawing.drawText(name,dev.cfg.x+x+10,dev.cfg.y+y+2,0,300,"left",{r=215,g=215,b=215,a=255})

    end


    dev.gui.groupbox[tab].groupBoxes[name].y = y + dev.gui.groupbox[tab].groupBoxes[name].curIndex + 50
    dev.gui.groupbox[tab].groupBoxes[name].x = x
end

dev.drawing.endGroupbox = function(tab,name)
    dev.gui.groupbox[tab].groupBoxes[name].endY = dev.gui.groupbox[tab].groupBoxes[name].y
end

dev.drawing.button = function(text,tab,groupbox,func,bindable)
    if not dev.vars.anim["binding_button_"..text] then
        dev.vars.anim["binding_button_"..text] = {
            keyboardAlpha = 0,
            rectW = 0,
            rectA = 0,
        }
    end
    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h
    if (dev.cfg.currentTab == tab) then
        if dev.cfg.y+y-20 > dev.cfg.y+stay and y < stay+h-20 then
            local textW = dev.drawing.getTextWidth(text,0,275)
            local hovered = dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) and not dev.vars.comboBoxDisplayed
            dev.vars.anim["binding_button_"..text].keyboardAlpha = dev.math.lerp(dev.vars.anim["binding_button_"..text].keyboardAlpha, dev.cfg.keybinds["button_"..text] and 255 or 0,0.01)
            dev.vars.anim["binding_button_"..text].rectA = dev.math.lerp(dev.vars.anim["binding_button_"..text].rectA, dev.vars.keybindingDisplayed["button_"..text] and 255 or 0,0.025)

            if (dev.gui.groupbox[tab].groupBoxes[groupbox].y ~= dev.gui.groupbox[tab].groupBoxes[groupbox].startY) then
                dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y-10,w-20,1,{r=38,g=39,b=48,a=255})
            end

            dev.drawing.drawText(text,dev.cfg.x+x+10,dev.cfg.y+y-2,0,275,"left",hovered and {r=251,g=251,b=251,a=255} or {r=85,g=92,b=115,a=255})
            if (hovered) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24) and (not dev.cfg.keybinds["button_"..text] or not dev.cfg.keybinds["button_"..text].active) and not IsDisabledControlPressed(0,19)) then
                    if (func) then
                        func()
                    end
                end
                if (bindable) then
                    if (IsDisabledControlPressed(0,19) and IsDisabledControlJustPressed(0,24)) then
                        if not dev.cfg.keybinds["button_"..text] then
                            dev.cfg.keybinds["button_"..text] = {label = "...",control = "None",active = false,func = function() if (func) then func() end  end,text = text,displayedLabel = "..."}
                        end
                    end
                end
            end

            if (dev.cfg.keybinds["button_"..text]) then
                if (dev.drawing.hovered(dev.cfg.x+x+w-34,dev.cfg.y+y+2,24,16)) then
                    dev.vars.blockDragging = true
                    if (IsDisabledControlJustReleased(0,24)) then
                        if (not dev.vars.blockBinding) then
                            dev.vars.keybindingDisplayed["button_"..text] = true
                            dev.cfg.keybinds["button_"..text].active = true
                            dev.functions.binding("button_"..text)
                        end
                    end
                end
                if (dev.vars.anim["binding_button_"..text].rectA > 1) then
                    dev.drawing.drawRect(dev.cfg.x+x+w-150,dev.cfg.y+y-2,140,24,{r=31,g=32,b=41,a=math.floor(dev.vars.anim["binding_button_"..text].rectA)},4)
                    dev.drawing.drawText(dev.cfg.keybinds["button_"..text].displayedLabel,dev.cfg.x+x+w-145,dev.cfg.y+y-2,0,275,"left",{r=251,g=251,b=251,a=math.floor(dev.vars.anim["binding_button_"..text].rectA)},4)
                end
                dev.drawing.drawImage("keyboard",dev.cfg.x+x+w-38,dev.cfg.y+y+2,24,16,0,{r=85,g=92,b=115,a=math.floor(dev.vars.anim["binding_button_"..text].keyboardAlpha)},4)
            end

        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + 40
    end
end

dev.drawing.checkbox = function(bool,text,tab,groupbox,func,bindable)

    if dev.cfg.bools[bool] == nil then
        dev.cfg.bools[bool] = false
    end

    if not dev.vars.anim["binding_checkbox_"..bool] then
        dev.vars.anim["binding_checkbox_"..bool] = {
            keyboardAlpha = 0,
            rectW = 0,
            rectA = 0,
        }
    end

    if not dev.vars.anim["toggle_"..bool] then
        dev.vars.anim["toggle_"..bool] = {
            a = 0,
        }
    end
    
    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h
    if (dev.cfg.currentTab == tab) then
        if dev.cfg.y+y-20 > dev.cfg.y+stay and y < stay+h-20 then
            local textW = dev.drawing.getTextWidth(text,0,275)
            local hovered = dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) or dev.drawing.hovered(dev.cfg.x+x+w-30,dev.cfg.y+y,20,20) and not dev.vars.comboBoxDisplayed
            dev.vars.anim["toggle_"..bool].a = dev.math.lerp(dev.vars.anim["toggle_"..bool].a, dev.cfg.bools[bool] and 255 or 0,0.08)
            
            dev.vars.anim["binding_checkbox_"..bool].keyboardAlpha = dev.math.lerp(dev.vars.anim["binding_checkbox_"..bool].keyboardAlpha, dev.cfg.keybinds["checkbox_"..bool] and 255 or 0,0.01)
            dev.vars.anim["binding_checkbox_"..bool].rectA = dev.math.lerp(dev.vars.anim["binding_checkbox_"..bool].rectA, dev.vars.keybindingDisplayed["checkbox_"..bool] and 255 or 0,0.05)

            if (dev.gui.groupbox[tab].groupBoxes[groupbox].y ~= dev.gui.groupbox[tab].groupBoxes[groupbox].startY) then
                dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y-10,w-20,1,{r=38,g=39,b=48,a=255})
            end

            dev.drawing.drawText(text,dev.cfg.x+x+10,dev.cfg.y+y-2,0,275,"left",(hovered or dev.cfg.bools[bool]) and {r=251,g=251,b=251,a=255} or {r=85,g=92,b=115,a=255})
            dev.drawing.drawImage("checkboxBackground",dev.cfg.x+x+w-30,dev.cfg.y+y,20,20,0,{r=38,g=39,b=48,a=255})
            dev.drawing.drawImage("checkboxBackground",dev.cfg.x+x+w-30,dev.cfg.y+y,20,20,0,{r=dev.cfg.colors["theme"].r,g=dev.cfg.colors["theme"].g,b=dev.cfg.colors["theme"].b,a=math.floor(dev.vars.anim["toggle_"..bool].a)})
            dev.drawing.drawImage("check",dev.cfg.x+x+w-27,dev.cfg.y+y+2,20,20,0,{r=255,g=255,b=255,a=math.floor(dev.vars.anim["toggle_"..bool].a)})

            if (hovered) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24) and (not dev.cfg.keybinds["checkbox_"..bool] or not dev.cfg.keybinds["checkbox_"..bool].active) and not IsDisabledControlPressed(0,19)) then
                    dev.cfg.bools[bool] = not dev.cfg.bools[bool]
                    if (func) then
                        CreateThread(function()
                            func(dev.cfg.bools[bool])
                        end)
                    end
                end
                if (bindable) then
                    if (IsDisabledControlPressed(0,19) and IsDisabledControlJustPressed(0,24)) then
                        if not dev.cfg.keybinds["checkbox_"..bool] then
                            dev.cfg.keybinds["checkbox_"..bool] = {label = "...",control = "None",active = false,func = function() dev.cfg.bools[bool] = not dev.cfg.bools[bool] if (func) then func(dev.cfg.bools[bool]) end  end,text = text,displayedLabel = "..."}
                        end
                    end
                end
            end

            if (dev.cfg.keybinds["checkbox_"..bool]) then
                if (dev.drawing.hovered(dev.cfg.x+x+w-63,dev.cfg.y+y+2,24,16)) then
                    dev.vars.blockDragging = true
                    if (IsDisabledControlJustReleased(0,24)) then
                        if (not dev.vars.blockBinding) then
                            dev.vars.keybindingDisplayed["checkbox_"..bool] = true
                            dev.cfg.keybinds["checkbox_"..bool].active = true
                            dev.functions.binding("checkbox_"..bool)
                        end
                    end
                end
                if (dev.vars.anim["binding_checkbox_"..bool].rectA > 1) then
                    dev.drawing.drawRect(dev.cfg.x+x+w-175,dev.cfg.y+y-2,140,24,{r=31,g=32,b=41,a=math.floor(dev.vars.anim["binding_checkbox_"..bool].rectA)},4)
                    dev.drawing.drawText(dev.cfg.keybinds["checkbox_"..bool].displayedLabel,dev.cfg.x+x+w-170,dev.cfg.y+y-2,0,275,"left",{r=251,g=251,b=251,a=math.floor(dev.vars.anim["binding_checkbox_"..bool].rectA)},4)
                end
                dev.drawing.drawImage("keyboard",dev.cfg.x+x+w-63,dev.cfg.y+y+2,24,16,0,{r=85,g=92,b=115,a=math.floor(dev.vars.anim["binding_checkbox_"..bool].keyboardAlpha)},4)
            end

        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + 40
    end
end

dev.drawing.slider = function (text,slider, tab, groupbox,sliderflags,func)
    if dev.cfg.sliders[slider] == nil then
        dev.cfg.sliders[slider] = sliderflags.startAt
    end
    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h
    if (dev.cfg.currentTab == tab) then
        if dev.cfg.y+y-20 > dev.cfg.y+stay and y < stay+h-20 then
            local across = dev.math.getPercent(dev.cfg.sliders[slider], sliderflags.max)
            local filledWidth = dev.math.firstPercentOfSecond(across, 140)
            local textW = dev.drawing.getTextWidth(text,0,275)
            local hovered = dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) and not dev.vars.comboBoxDisplayed
            if (dev.gui.groupbox[tab].groupBoxes[groupbox].y ~= dev.gui.groupbox[tab].groupBoxes[groupbox].startY) then
                dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y-10,w-20,1,{r=38,g=39,b=48,a=255})
            end
            dev.drawing.drawText(text,dev.cfg.x+x+10,dev.cfg.y+y-2,0,275,"left",(hovered) and {r=251,g=251,b=251,a=255} or {r=85,g=92,b=115,a=255})
            dev.drawing.drawText(tostring(dev.cfg.sliders[slider]),dev.cfg.x+x+w-170,dev.cfg.y+y-2,0,275,"right",{r=251,g=251,b=251,a=255})

            dev.drawing.drawRect(dev.cfg.x+x+w-150,dev.cfg.y+y+8,140,3,{r=38,g=39,b=48,a=255})
            dev.drawing.drawRect(dev.cfg.x+x+w-150,dev.cfg.y+y+8,filledWidth,3,dev.cfg.colors["theme"])
            dev.drawing.drawImage("smallCircleSlider",dev.cfg.x+x+w-150+filledWidth-5,dev.cfg.y+y+5,10,10,0,dev.cfg.colors["theme"])

            if (dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) and not dev.vars.comboBoxDisplayed) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24)) then
                    if (func) then
                        func()
                    end
                end
            end

            if (dev.drawing.hovered(dev.cfg.x+x+w-150,dev.cfg.y+y+6,140,7) and not dev.vars.comboBoxDisplayed) then
                dev.vars.blockDragging = true
                if IsDisabledControlJustPressed(0,24) then
                    dev.cfg.sliders[slider..' is dragging'] = true
                end
            end

            if not IsDisabledControlPressed(0,24) then
                dev.cfg.sliders[slider..' is dragging'] = false
            end
            if dev.cfg.sliders[slider..' is dragging'] then
                dev.vars.blockDragging = true
                local right_side = dev.cfg.x+x+w-150 + 140
                local amountmouseisAcross = math.ceil(right_side - dev.vars.cx)
                if amountmouseisAcross < 0 then
                    amountmouseisAcross = 0
                end
                if amountmouseisAcross > 140 then
                    amountmouseisAcross = 140
                end

                percent = dev.math.getPercent(amountmouseisAcross, 140)
                
                
                if sliderflags.floatvalue == nil then
                    dev.cfg.sliders[slider] = math.ceil(sliderflags.max - dev.math.firstPercentOfSecond(percent, sliderflags.max))
                else
                    dev.cfg.sliders[slider] = tonumber(string.format("%."..sliderflags.floatvalue.."f", sliderflags.max - dev.math.firstPercentOfSecond(percent, sliderflags.max)))
                end
            end
            
        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + 40
    end
    if dev.cfg.sliders[slider] > sliderflags.max then
        dev.cfg.sliders[slider] = sliderflags.max
    end
    if dev.cfg.sliders[slider] < sliderflags.min then
        dev.cfg.sliders[slider] = sliderflags.min
    end
end

dev.drawing.comboBox = function (box,text,items,tab,groupbox,func)

    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h

    if not dev.cfg.comboBoxes[box] then
        dev.cfg.comboBoxes[box] = {
            active = false,
            curOption = items[1],
            options = items,
            scroll = 0,
        }
    end



    if (dev.cfg.currentTab == tab) then
        if dev.cfg.y+y-20 > dev.cfg.y+stay and y < stay+h-20 then
            local textW = dev.drawing.getTextWidth(text,0,275)
            local hovered = dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) and not dev.vars.comboBoxDisplayed
            local selectedItem = dev.cfg.comboBoxes[box].curOption
            local optionCount = #dev.cfg.comboBoxes[box].options
            if dev.cfg.comboBoxes[box].curOption == nil then
                renderName = "None"
            else
                renderName = dev.cfg.comboBoxes[box].curOption
            end
            if (dev.gui.groupbox[tab].groupBoxes[groupbox].y ~= dev.gui.groupbox[tab].groupBoxes[groupbox].startY) then
                dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y-10,w-20,1,{r=38,g=39,b=48,a=255})
            end
            dev.drawing.drawText(text,dev.cfg.x+x+10,dev.cfg.y+y-2,0,275,"left",(hovered or dev.cfg.comboBoxes[box].active) and {r=251,g=251,b=251,a=255} or {r=85,g=92,b=115,a=255})

            dev.drawing.drawRect(dev.cfg.x+x+w-150,dev.cfg.y+y-2,140,24,{r = 38, g = 39, b = 48,a=255},dev.cfg.comboBoxes[box].active and 5 or 1)


            if (hovered) then
                if (IsDisabledControlJustPressed(0,24)) then
                    if (func) then
                        func()
                    end
                end
            end


            if (dev.drawing.hovered(dev.cfg.x+x+w-130,dev.cfg.y+y,120,20)) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24)) then
                    dev.cfg.comboBoxes[box].active = not dev.cfg.comboBoxes[box].active
                end
            end

            if (dev.cfg.comboBoxes[box].active) then
                dev.drawing.drawRect(dev.cfg.x+x+w-150,dev.cfg.y+y-2,140,30+(optionCount >= 7 and 150 or 22*optionCount),{r = 45, g = 46, b = 56,a=255},5)
                dev.vars.blockDragging = true
                dev.vars.comboBoxDisplayed = true
                local selectedItem = dev.cfg.comboBoxes[box].curOption
                local optionCount = #dev.cfg.comboBoxes[box].options
                local _showing = 0
                local scrollbarHeight = math.max(12 / math.max(optionCount - 7, 1), 12 / 12)
                if (dev.drawing.hovered(dev.cfg.x+x+w-150,dev.cfg.y+y-2,140,30+(optionCount >= 7 and 150 or 22*optionCount))) then
                    if IsDisabledControlJustPressed(0, 15) and dev.cfg.comboBoxes[box].scroll > 0 then
                        dev.cfg.comboBoxes[box].scroll = dev.cfg.comboBoxes[box].scroll - 1
                    end
                    if IsDisabledControlJustPressed(0, 14) and dev.cfg.comboBoxes[box].scroll < optionCount-7 then
                        dev.cfg.comboBoxes[box].scroll = dev.cfg.comboBoxes[box].scroll + 1
                    end
                end
               
                for i = 1, optionCount do
                    local cleanName = dev.cfg.comboBoxes[box].options[i]:gsub('weapon_','')
                    local trimmed = dev.functions.trimStringBasedOnWidth(cleanName,100,"...",0,275)
                    textHeight = dev.cfg.y+y+2 + (i*20)
                    if i > dev.cfg.comboBoxes[box].scroll and _showing < 7 then
                        _showing = _showing + 1
    
    
                        if (dev.drawing.hovered(dev.cfg.x+x+w-145,dev.cfg.y+y-2+(_showing*22)+6,140,12)) then
                            if (IsDisabledControlJustPressed(0,24)) then
                                dev.cfg.comboBoxes[box].curOption = dev.cfg.comboBoxes[box].options[i]
                            end
                        end

                        if (IsDisabledControlJustPressed(0,24) and not dev.drawing.hovered(dev.cfg.x+x+w-150,dev.cfg.y+y-2,140,(optionCount >= 7 and 150 or 25*optionCount)+20)) then
                            dev.vars.comboBoxDisplayed = false
                            dev.cfg.comboBoxes[box].active = false
                        end
        
                        if optionCount > 7 then
                            dev.drawing.drawRect(dev.cfg.x+x+w-150+133,dev.cfg.y+y+25,2,150,{r=38,g=39,b=48,a=255},5)
                            dev.drawing.drawRect(dev.cfg.x+x+w-150+133, dev.cfg.y+y+25 + ((150 - scrollbarHeight * optionCount) * (dev.cfg.comboBoxes[box].scroll / (optionCount - 7))),2,scrollbarHeight * optionCount,dev.cfg.colors["theme"],5)
                        end
                        dev.drawing.drawText(trimmed,dev.cfg.x+x+w-145,dev.cfg.y+y+(_showing*22),0,250,"left",(dev.cfg.comboBoxes[box].curOption ==  dev.cfg.comboBoxes[box].options[i] or dev.drawing.hovered(dev.cfg.x+x+w-145,dev.cfg.y+y-2+(_showing*22)+6,140,12)) and {r=255,g=255,b=255,a=255} or {r=85,g=92,b=115,a=255},dev.cfg.comboBoxes[box].active and 5 or 1)
                    end
        
                end
            end

            dev.drawing.drawText(renderName:gsub('weapon_',''),dev.cfg.x+x+w-148,dev.cfg.y+y-2,0,275,"left",{r=255,g=255,b=255,a=255},dev.cfg.comboBoxes[box].active and 5 or 1)
            dev.drawing.drawText("↓",dev.cfg.x+x+w-20,dev.cfg.y+y-3,0,275,"center",dev.cfg.comboBoxes[box].active and {r=255,g=255,b=255,a=255} or {r=85,g=92,b=115,a=255},dev.cfg.comboBoxes[box].active and 5 or 1)
        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + 40
    end

end

dev.drawing.textBox = function(box,text,tab,groupbox,func)

    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h

    if (dev.cfg.textBoxes[box]) == nil then
        dev.cfg.textBoxes[box] = {active = false, string = ""}
    end



    if (dev.cfg.currentTab == tab) then
        if dev.cfg.y+y-20 > dev.cfg.y+stay and y < stay+h-20 then
            local textW = dev.drawing.getTextWidth(text,0,275)
            local trimmedText = dev.functions.trimText(dev.cfg.textBoxes[box].string, 118,0,275)
            local hovered = dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) and not dev.vars.comboBoxDisplayed
            if (dev.gui.groupbox[tab].groupBoxes[groupbox].y ~= dev.gui.groupbox[tab].groupBoxes[groupbox].startY) then
                dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y-10,w-20,1,{r=38,g=39,b=48,a=255})
            end
            dev.drawing.drawText(text,dev.cfg.x+x+10,dev.cfg.y+y-2,0,275,"left",(hovered or dev.cfg.textBoxes[box].active) and {r=251,g=251,b=251,a=255} or {r=85,g=92,b=115,a=255})

            dev.drawing.drawRect(dev.cfg.x+x+w-150,dev.cfg.y+y-2,140,24,{r = 38, g = 39, b = 48,a=255})


            if (hovered) then
                if (IsDisabledControlJustPressed(0,24) and not dev.vars.comboBoxDisplayed) then
                    if (func) then
                        func()
                    end
                end
            end


            if (dev.drawing.hovered(dev.cfg.x+x+w-150,dev.cfg.y+y-2,140,24) and not dev.vars.comboBoxDisplayed) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24)) then
                    dev.cfg.textBoxes[box].active = not dev.cfg.textBoxes[box].active
                end
            else 
                if IsDisabledControlJustPressed(0,24) then
                    dev.cfg.textBoxes[box].active = false
                end
            end

            if (dev.cfg.textBoxes[box].active) then

                if IsDisabledControlJustPressed(0, 177) and #dev.cfg.textBoxes[box].string > 0 and (dev.vars.textDeleteDelay or 0) < GetGameTimer() then
                    dev.vars.textDeleteDelay = GetGameTimer() + 120
                    dev.cfg.textBoxes[box].string = dev.cfg.textBoxes[box].string:sub(1, #dev.cfg.textBoxes[box].string - 1)
                end
        

                for st, control in pairs(dev.vars.keysInput) do
                    if IsDisabledControlJustPressed(0, control) then
                        if IsDisabledControlPressed(0, 21) then
                            dev.cfg.textBoxes[box].string = dev.cfg.textBoxes[box].string..st:upper()
                        else
                            dev.cfg.textBoxes[box].string = dev.cfg.textBoxes[box].string..st:lower()
                        end
                    end
                end

                if IsDisabledControlJustPressed(0, 191) then
                    dev.cfg.textBoxes[box].active = false
                end
            end
            if (dev.cfg.textBoxes[box].string == "") then
                dev.drawing.drawText("Digite algo",dev.cfg.x+x+w-148,dev.cfg.y+y-2,0,275,"left",dev.cfg.textBoxes[box].active and {r=255,g=255,b=255,a=255} or {r=85,g=92,b=115,a=255},1)
            end
            dev.drawing.drawText(trimmedText,dev.cfg.x+x+w-148,dev.cfg.y+y-2,0,275,"left",dev.cfg.textBoxes[box].active and {r=255,g=255,b=255,a=255} or {r=85,g=92,b=115,a=255},1)
        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + 40
    end

end

dev.drawing.colorpicker = function (text,color,tab,groupbox,func)

    local convertedR,convertedG,convertedB

    if not dev.cfg.colors[color] then
        dev.cfg.colors[color] = {
            r=255,
            g=255,
            b=255,
            a=255,
            otherstuff = {
                h = 0, 
                s = 0,
                v = 100,
                timer = 0,
                colorpickerA = 0,
            }
        }
    end

    if (not dev.cfg.colors[color].otherstuff) then
        local convertedR,convertedG,convertedB = dev.math.RGBtoHSV(dev.cfg.colors[color])
        dev.cfg.colors[color].otherstuff = {
            h = convertedR,
            s = convertedG,
            v = convertedB,
            timer = 0,
            colorpickerA = 0,
        }
    end

    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h
    if (dev.cfg.currentTab == tab) then
        if dev.cfg.y+y-20 > dev.cfg.y+stay and y < stay+h-20 then
            local textW = dev.drawing.getTextWidth(text,0,275)
            local hovered = dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) and not dev.vars.comboBoxDisplayed
            dev.cfg.colors[color].otherstuff.colorpickerA = dev.math.lerp(dev.cfg.colors[color].otherstuff.colorpickerA, dev.vars.selectedColorpicker == color and 255 or 0,0.05)
            if (dev.gui.groupbox[tab].groupBoxes[groupbox].y ~= dev.gui.groupbox[tab].groupBoxes[groupbox].startY) then
                dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y-10,w-20,1,{r=38,g=39,b=48,a=255})
            end

            dev.drawing.drawText(text,dev.cfg.x+x+10,dev.cfg.y+y-2,0,275,"left",(hovered or dev.vars.selectedColorpicker == color) and {r=251,g=251,b=251,a=255} or {r=85,g=92,b=115,a=255})
            dev.drawing.drawImage("colorpickerBackground",dev.cfg.x+x+w-30,dev.cfg.y+y,20,20,0.0,{r=255,g=255,b=255,a=255})
            dev.drawing.drawImage("checkboxBackground",dev.cfg.x+x+w-30,dev.cfg.y+y,20,20,0,dev.cfg.colors[color])
            
            if (dev.drawing.hovered(dev.cfg.x+x+w-30,dev.cfg.y+y,20,20) and dev.vars.selectedColorpicker == nil and not dev.vars.comboBoxDisplayed) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24)) then
                    dev.vars.selectedColorpicker = color
                end
            end

            if (dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) and not dev.vars.comboBoxDisplayed) then
                if (IsDisabledControlJustPressed(0,24)) then
                    if (func) then
                        func()
                    end
                end
            end

            if (math.floor(dev.cfg.colors[color].otherstuff.colorpickerA) > 1) then
                dev.vars.blockDragging = true
                dev.cfg.colors[color].otherstuff.timer = dev.cfg.colors[color].otherstuff.timer + 1
                local sR, sG, sB = dev.math.HSVtoRGB(dev.cfg.colors[color].otherstuff.h, 100,100)
                local sR1, sG1, sB1 = dev.math.HSVtoRGB(dev.cfg.colors[color].otherstuff.h, dev.cfg.colors[color].otherstuff.s, dev.cfg.colors[color].otherstuff.v)
                dev.drawing.drawRect(dev.cfg.x+x+w-20,dev.cfg.y+y+10,254,220,{r=31,g=34,b=43,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},5)
                dev.drawing.drawText(text,dev.cfg.x+x+w-10,dev.cfg.y+y+15,0,250,"left",{r=251,g=251,b=251,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},5)

                dev.drawing.drawRect(dev.cfg.x+x+w-10,dev.cfg.y+y+40,180,180,{r=255,g=255,b=255,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)
                dev.drawing.drawImage("gradient",dev.cfg.x+x+w-10,dev.cfg.y+y+40,180,180,0.0,{r=sR,g=sG,b=sB,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)
                dev.drawing.drawImage("gradient",dev.cfg.x+x+w-10,dev.cfg.y+y+40,180,180,90.0,{r=0,g=0,b=0,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)
                dev.drawing.drawRect(dev.cfg.x+x+w-10+dev.cfg.colors[color].otherstuff.s / 100 * 174,(dev.cfg.y+y+40+174) - dev.cfg.colors[color].otherstuff.v / 100 * (174), 6, 6, {r=0,g=0,b=0,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)
                dev.drawing.drawRect(dev.cfg.x+x+w-9+dev.cfg.colors[color].otherstuff.s / 100 * 174,(dev.cfg.y+y+41+174) - dev.cfg.colors[color].otherstuff.v / 100 * (174), 4, 4, {r=sR1,g=sG1,b=sB1,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)

                dev.drawing.drawImage("rainbowBar",dev.cfg.x+x+w+180,dev.cfg.y+y+40,16,180,0.0,{r=255,g=255,b=255,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},5)
                dev.drawing.drawRect(dev.cfg.x+x+w+180,dev.cfg.y+y+40+dev.cfg.colors[color].otherstuff.h / 360 * 176, 15,4, {r=0,g=0,b=0,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)
                dev.drawing.drawRect(dev.cfg.x+x+w+181,dev.cfg.y+y+41+dev.cfg.colors[color].otherstuff.h / 360 * 176, 13,2, {r=sR1, g=sG1, b=sB1,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)

                dev.drawing.drawImage("fadeBackground",dev.cfg.x+x+w+206,dev.cfg.y+y+40,16,180,0.0,{r=sR1,g=sG1,b=sB1,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},5)
                dev.drawing.drawRect(dev.cfg.x+x+w+206,dev.cfg.y+y+216-dev.cfg.colors[color].a / 255 * 176, 16,4, {r=0,g=0,b=0,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)
                dev.drawing.drawRect(dev.cfg.x+x+w+207,dev.cfg.y+y+217-dev.cfg.colors[color].a / 255 * 176, 14,2, {r=sR1, g=sG1, b=sB1,a=dev.vars.selectedColorpicker ~= nil and dev.cfg.colors[color].a or math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)

                dev.drawing.drawText(dev.math.RGBtoHEX({sR1,sG1,sB1}),dev.cfg.x+x+w+226,dev.cfg.y+y+15,0,250,"right",{r=251,g=251,b=251,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},5)


                if dev.drawing.hovered(dev.cfg.x+x+w+180,dev.cfg.y+y+40,16,180) and IsDisabledControlJustPressed(0, 24) then 
                    dev.vars.pickerVariable = "FLAG"
                elseif dev.drawing.hovered(dev.cfg.x+x+w-10,dev.cfg.y+y+40,180,180) and IsDisabledControlJustPressed(0, 24) then 
                    dev.vars.pickerVariable = "RGB"
                elseif dev.drawing.hovered(dev.cfg.x+x+w+206,dev.cfg.y+y+40,16,180) and IsDisabledControlJustPressed(0, 24) then 
                    dev.vars.pickerVariable = "ALPHA"
                end

                if dev.vars.pickerVariable == "FLAG" then 
                    dev.cfg.colors[color].otherstuff.h = dev.math.screenValue(dev.vars.cy, dev.cfg.y+y+40, 180, 0, 360)
                    dev.cfg.colors[color].otherstuff.h = math.floor(math.clamp(dev.cfg.colors[color].otherstuff.h, 0, 360))
                elseif dev.vars.pickerVariable == "RGB" then 
                    dev.cfg.colors[color].otherstuff.s = dev.math.screenValue(dev.vars.cx, dev.cfg.x+x+w-10, 176, 0, 100)
                    dev.cfg.colors[color].otherstuff.s = math.floor(math.clamp(dev.cfg.colors[color].otherstuff.s, 0, 100))
                    dev.cfg.colors[color].otherstuff.v = dev.math.screenValue(dev.vars.cy, dev.cfg.y+y+40, 176, 100, 0)
                    dev.cfg.colors[color].otherstuff.v = math.floor(math.clamp(dev.cfg.colors[color].otherstuff.v, 0, 100))
                elseif dev.vars.pickerVariable == "ALPHA" then 
                    dev.cfg.colors[color].a = dev.math.screenValue(dev.vars.cy, dev.cfg.y+y+40,176, 255, 0)
                    dev.cfg.colors[color].a = math.floor(math.clamp(dev.cfg.colors[color].a, 0, 255))
                end

                if (IsDisabledControlJustReleased(0,24)) then
                    dev.vars.pickerVariable = nil
                end

                dev.cfg.colors[color].r,dev.cfg.colors[color].g,dev.cfg.colors[color].b,dev.cfg.colors[color].a = sR1,sG1,sB1,dev.cfg.colors[color].a
            
                if (not dev.drawing.hovered(dev.cfg.x+x+w-30,dev.cfg.y+y,254,260) and IsDisabledControlJustPressed(0,24) and dev.cfg.colors[color].otherstuff.timer > 10) then
                    dev.cfg.colors[color].otherstuff.timer = 0
                    dev.vars.selectedColorpicker = nil
                elseif IsDisabledControlJustPressed(0, 191) then 
                    dev.vars.selectedColorpicker = nil
                end
            end
        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + 40
    end

end

dev.drawing.playerButton = function(text,tab,groupbox,pedId,func)
    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h
    local groupboxScrollIndex = dev.gui.groupbox[tab].groupBoxes[groupbox].scroll
    if (dev.cfg.currentTab == tab) then
        if dev.cfg.y+y-20 > dev.cfg.y+stay and y < stay+h-20 then
            local textW = dev.drawing.getTextWidth(text,0,275)
            local hovered = dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y,w-20,60) and not dev.vars.comboBoxDisplayed

            dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y,w-20,60,hovered and {r = 58, g = 59, b = 68,a=255} or {r = 38, g = 39, b = 48,a=255})
            dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y+60,w-20,1,dev.cfg.colors["theme"])

            dev.drawing.drawText(text,dev.cfg.x+x+20,dev.cfg.y+y+5,0,275,"left",{r=255,g=255,b=255,a=255})
            dev.drawing.drawText("A "..math.floor(GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(GetPlayerPed(pedId)))).."m de distancia",dev.cfg.x+x+20,dev.cfg.y+y+32,0,275,"left",{r=175,g=175,b=175,a=255})
            if (dev.vars.selectedPlayer == pedId) then
                dev.drawing.drawImage("check",dev.cfg.x+x+w-40,dev.cfg.y+y+20,20,20,0.0,{r=255,g=255,b=255,a=255})
            end
            if (hovered) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24)) then
                    if (dev.vars.selectedPlayer == pedId) then
                        dev.vars.selectedPlayer = nil
                    else
                        dev.vars.selectedPlayer = pedId
                    end
                end

            end

        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + groupboxScrollIndex
    end
end

dev.drawing.vehicleButton = function(text, tab, groupbox, vehicleId, func)
    if not dev.gui.groupbox[tab] then
        --print("Erro: O tab '" .. tostring(tab) .. "' não existe.")
        return
    end
    
    if not dev.gui.groupbox[tab].groupBoxes[groupbox] then
        --print("Erro: O groupbox '" .. tostring(groupbox) .. "' não existe no tab '" .. tostring(tab) .. "'.")
        return
    end

    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h
    local groupboxScrollIndex = dev.gui.groupbox[tab].groupBoxes[groupbox].scroll

    if dev.cfg.currentTab == tab then
        if dev.cfg.y + y - 20 > dev.cfg.y + stay and y < stay + h - 20 then
            local textW = dev.drawing.getTextWidth(text, 0, 275)
            local hovered = dev.drawing.hovered(dev.cfg.x + x + 10, dev.cfg.y + y, w - 20, 60) and not dev.vars.comboBoxDisplayed

            dev.drawing.drawRect(dev.cfg.x + x + 10, dev.cfg.y + y, w - 20, 60, hovered and {r = 58, g = 59, b = 68, a = 255} or {r = 38, g = 39, b = 48, a = 255})
            dev.drawing.drawRect(dev.cfg.x + x + 10, dev.cfg.y + y + 60, w - 20, 1, dev.cfg.colors["theme"])

            dev.drawing.drawText(text, dev.cfg.x + x + 20, dev.cfg.y + y + 5, 0, 275, "left", {r = 255, g = 255, b = 255, a = 255})
            
            if DoesEntityExist(vehicleId) then
                local vehicleCoords = GetEntityCoords(vehicleId)
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = math.floor(GetDistanceBetweenCoords(playerCoords, vehicleCoords))
                dev.drawing.drawText("A " .. distance .. "m de distancia", dev.cfg.x + x + 20, dev.cfg.y + y + 32, 0, 275, "left", {r = 175, g = 175, b = 175, a = 255})
            else
                dev.drawing.drawText("Vehicle not found", dev.cfg.x + x + 20, dev.cfg.y + y + 32, 0, 275, "left", {r = 175, g = 175, b = 175, a = 255})
            end

            if dev.vars.selectedVehicle == vehicleId then
                dev.drawing.drawImage("check", dev.cfg.x + x + w - 40, dev.cfg.y + y + 20, 20, 20, 0.0, {r = 255, g = 255, b = 255, a = 255})
            end

            if hovered then
                dev.vars.blockDragging = true
                if IsDisabledControlJustPressed(0, 24) then
                    if dev.vars.selectedVehicle == vehicleId then
                        dev.vars.selectedVehicle = nil
                    else
                        dev.vars.selectedVehicle = vehicleId
                    end
                    if func then
                        func(vehicleId)
                    end
                end
            end
        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + groupboxScrollIndex
    end
end



dev.drawing.notify = function(text, ntype, duration, r, g, b)
    local notification = {
        x = dev.vars.sW,
        text = tostring(text),
        duration = duration or 5000,
        startTime = GetGameTimer(),
        color = { r = r, g = g, b = b, a = 255 },
        type = tostring(ntype) 
    }
    dev.notifications[#dev.notifications + 1] = notification
end

dev.drawing.renderTabs = function()
    for k, v in ipairs(dev.tabs) do

        if (not dev.vars.tabsVars[v[2]]) then
            dev.vars.tabsVars[v[2]] = {
                w = 0,
                a = 0,
                iconColors = {r=110,g=110,b=110,a=255},
            }
        end

        dev.vars.tabsVars[v[2]].w = dev.math.lerp(dev.vars.tabsVars[v[2]].w, dev.cfg.currentTab == v[2] and 40 or 0,0.06)
        dev.vars.tabsVars[v[2]].a = dev.math.lerp(dev.vars.tabsVars[v[2]].a, dev.cfg.currentTab == v[2] and 255 or 0,0.055)

        dev.vars.tabsVars[v[2]].iconColors.r = dev.math.lerp(dev.vars.tabsVars[v[2]].iconColors.r, dev.cfg.currentTab == v[2] and dev.cfg.colors["theme"].r or 85,0.055)
        dev.vars.tabsVars[v[2]].iconColors.g = dev.math.lerp(dev.vars.tabsVars[v[2]].iconColors.g, dev.cfg.currentTab == v[2] and dev.cfg.colors["theme"].g or 92,0.055)
        dev.vars.tabsVars[v[2]].iconColors.b = dev.math.lerp(dev.vars.tabsVars[v[2]].iconColors.b, dev.cfg.currentTab == v[2] and dev.cfg.colors["theme"].b or 115,0.055)


        if (dev.drawing.hovered(dev.cfg.x + 10, dev.cfg.y + 80 + dev.vars.tabsY, 40, 40)) then
            dev.vars.blockDragging = true
            if (IsDisabledControlJustPressed(0,24)) then
                dev.cfg.currentTab = v[2]
            end
        end
        if dev.vars.tabsVars[v[2]].a > 1 then
            dev.drawing.drawRect(dev.cfg.x + 20 + 20 -  dev.vars.tabsVars[v[2]].w/2, dev.cfg.y + 80 + dev.vars.tabsY, dev.vars.tabsVars[v[2]].w, 40, { r = 38, g = 39, b = 48, a = math.floor(dev.vars.tabsVars[v[2]].a) })
        end
        if (dev.images[v[2].."_icon"]) then
            dev.drawing.drawImage(v[2].."_icon",dev.cfg.x + 31,dev.cfg.y + 91 + dev.vars.tabsY,25,25,0.0,{r = math.floor(dev.vars.tabsVars[v[2]].iconColors.r),g = math.floor(dev.vars.tabsVars[v[2]].iconColors.g),b = math.floor(dev.vars.tabsVars[v[2]].iconColors.b),a = dev.vars.tabsVars[v[2]].iconColors.a})
        end
        dev.vars.tabsY = dev.vars.tabsY + 60
    end
end

dev.drawing.renderSubtabs = function()
    if (dev.menuFeatures[dev.cfg.currentTab] and dev.menuFeatures[dev.cfg.currentTab].subtabs) then
        if not dev.vars.subtabsPos[dev.cfg.currentTab] then
            dev.vars.subtabsPos[dev.cfg.currentTab] = 0
        end
        if not dev.vars.subTabsVars[dev.cfg.currentTab] then
            dev.vars.subTabsVars[dev.cfg.currentTab] = {}
        end

        for k,v in pairs(dev.menuFeatures[dev.cfg.currentTab].subtabs) do
            if not dev.vars.subTabsVars[dev.cfg.currentTab][v] then
                dev.vars.subTabsVars[dev.cfg.currentTab][v] = {
                    y = 0,
                    rectW = 0,
                    color = {r=38,g=39,b=48,a=255},
                }
            end

            local w = dev.drawing.getTextWidth(v,0,275)-2

            dev.vars.subTabsVars[dev.cfg.currentTab][v].y = dev.math.lerp(dev.vars.subTabsVars[dev.cfg.currentTab][v].y, dev.menuFeatures[dev.cfg.currentTab].selTab == v and -6 or 0,0.05)
            dev.vars.subTabsVars[dev.cfg.currentTab][v].rectW = dev.math.lerp(dev.vars.subTabsVars[dev.cfg.currentTab][v].rectW, dev.menuFeatures[dev.cfg.currentTab].selTab == v and w+10 or 0,0.1)
            dev.vars.subTabsVars[dev.cfg.currentTab][v].color.a = dev.math.lerp(dev.vars.subTabsVars[dev.cfg.currentTab][v].color.a, dev.menuFeatures[dev.cfg.currentTab].selTab == v and 255 or 0,0.055)

            dev.drawing.drawText(v,dev.cfg.x+101+dev.vars.subtabsPos[dev.cfg.currentTab],dev.cfg.y+18,0,275,"left",dev.menuFeatures[dev.cfg.currentTab].selTab == v and dev.cfg.colors["theme"] or {r=85,g=92,b=115,a=255})
            dev.drawing.drawRect(dev.cfg.x+100+dev.vars.subtabsPos[dev.cfg.currentTab]+w/2 - dev.vars.subTabsVars[dev.cfg.currentTab][v].rectW/2,dev.cfg.y+15,dev.vars.subTabsVars[dev.cfg.currentTab][v].rectW,30,{r = dev.vars.subTabsVars[dev.cfg.currentTab][v].color.r,g = dev.vars.subTabsVars[dev.cfg.currentTab][v].color.g, b = dev.vars.subTabsVars[dev.cfg.currentTab][v].color.b, a = math.floor(dev.vars.subTabsVars[dev.cfg.currentTab][v].color.a)})
            
            if (dev.drawing.hovered(dev.cfg.x+100+dev.vars.subtabsPos[dev.cfg.currentTab],dev.cfg.y+15,w+10,30)) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24)) then
                    dev.menuFeatures[dev.cfg.currentTab].selTab = v
                end
            end

            dev.vars.subtabsPos[dev.cfg.currentTab] = dev.vars.subtabsPos[dev.cfg.currentTab] + w + 25
        end
    end
end

dev.drawing.dragging = function ()
    if (not dev.vars.blockDragging) then
        if (dev.drawing.hovered(dev.cfg.x,dev.cfg.y,dev.cfg.w,dev.cfg.h)) then
            if (IsDisabledControlJustPressed(0,24)) then
                dev.vars.dragging = true
            end
        end
        if (dev.vars.dragging) then
            if xdist == nil then
                xdist = dev.vars.cx - dev.cfg.x
            end
            if ydist == nil then
                ydist = dev.vars.cy - dev.cfg.y
            end

            dev.cfg.x = dev.vars.cx - xdist
            dev.cfg.y = dev.vars.cy - ydist
        else
            xdist = nil
            ydist = nil
        end

        if (not IsDisabledControlPressed(0,24)) then
            dev.vars.dragging = false
        end
    end
    dev.vars.blockDragging = false
end

dev.drawing.searchBar = function()
    local currentSearchText = (dev.cfg.currentTab == "Online" and dev.menuFeatures["Online"].selTab == "Players") and dev.vars.onlineSearchText or dev.vars.searchText 
    local searchText = (dev.cfg.currentTab == "Online" and dev.menuFeatures["Online"].selTab == "Players") and "Search Players" or "Search Functions"
    local trimmedString = dev.functions.trimText(searchText, dev.vars.anim.searchBarWidth, 0, 275)
    dev.vars.anim.searchBarWidth = dev.math.lerp(dev.vars.anim.searchBarWidth, (dev.vars.searching or currentSearchText ~= "") and 250 or 30, dev.vars.searching and 0.03 or 0.05)
    dev.vars.anim.searchBarTextAlpha = dev.math.lerp(dev.vars.anim.searchBarTextAlpha, dev.vars.anim.searchBarWidth >= 200 and 255 or 0, 0.05)
    local hovered = dev.drawing.hovered(dev.cfg.x + dev.cfg.w - (dev.vars.anim.searchBarWidth + 15), dev.cfg.y + 15, math.floor(dev.vars.anim.searchBarWidth), 30)
    
    dev.drawing.drawRect(dev.cfg.x + dev.cfg.w - (dev.vars.anim.searchBarWidth + 15), dev.cfg.y + 15, dev.vars.anim.searchBarWidth, 30, {r = 42, g = 43, b = 52, a = 255})
    dev.drawing.drawImage("Search_icon", dev.cfg.x + dev.cfg.w - 37, dev.cfg.y + 21, 20, 20, 0, {r = 255, g = 255, b = 255, a = 255}, 1)
    
    if math.floor(dev.vars.anim.searchBarWidth) > 30 and currentSearchText == "" then
        dev.drawing.drawText(trimmedString, dev.cfg.x + dev.cfg.w - (dev.vars.anim.searchBarWidth + 15) + 5, dev.cfg.y + 18, 0, 275, "left", {r = 79, g = 85, b = 106, a = math.ceil(dev.vars.anim.searchBarTextAlpha)}, 5)
    end
    
    if IsDisabledControlJustPressed(0, 24) then
        if hovered then
            dev.vars.searching = true
        else
            dev.vars.searching = false
        end
    end
    
    if dev.vars.searching then
        for k, v in pairs(dev.vars.writtableKeys) do
            if IsDisabledControlJustPressed(0, v) and not IsDisabledControlPressed(0, 21) then 
                currentSearchText = currentSearchText .. k
            end
            if IsDisabledControlPressed(0, 21) and IsDisabledControlJustPressed(0, v) then 
                currentSearchText = currentSearchText .. string.upper(k)
            end
        end
    
        if IsDisabledControlPressed(0, 177) and (dev.vars.backDelay or 0) < GetGameTimer() then
            dev.vars.backDelay = GetGameTimer() + 100
            currentSearchText = currentSearchText:sub(1, -2)
        end
    
        if IsDisabledControlJustPressed(0, 191) then
            dev.vars.searching = false
        end
    
        if IsDisabledControlJustPressed(0, 22) then
            currentSearchText = currentSearchText .. " "
        end
    
        if IsDisabledControlPressed(0, 21) and IsDisabledControlJustPressed(0, 157) then
            currentSearchText = currentSearchText:sub(1, -2)
            currentSearchText = currentSearchText .. '!'
        end 
    
        if IsDisabledControlPressed(0, 21) and IsDisabledControlJustPressed(0, 84) then
            currentSearchText = currentSearchText:sub(1, -2)
            currentSearchText = currentSearchText .. '_'
        end
    
        -- Update the actual variable
        if dev.cfg.currentTab == "Online" then
            dev.vars.onlineSearchText = currentSearchText
        else
            dev.vars.searchText = currentSearchText
        end
    end
    

    dev.drawing.drawText(currentSearchText,dev.cfg.x+dev.cfg.w-(dev.vars.anim.searchBarWidth+15)+5,dev.cfg.y+18,0,275,"left",dev.vars.searching and {r=251,g=251,b=251,a=math.ceil(dev.vars.anim.searchBarTextAlpha)} or {r=79,g=85,b=106,a=math.ceil(dev.vars.anim.searchBarTextAlpha)},5)

end

dev.functions.playerList = function()
    local activePlayers = GetActivePlayers()

    table.sort(activePlayers, function(a, b) return GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(a), false), true) < GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(b), false), true) end)

    -- Update the "All Players" list
    for k, player in pairs(activePlayers) do
        local playerName = GetPlayerName(player)
        local playerCoords = GetEntityCoords(player)
        local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), playerCoords)

        if string.find(string.lower(playerName), string.lower(tostring(dev.vars.onlineSearchText))) or dev.vars.onlineSearchText == "" then
            dev.drawing.playerButton(playerName,"Online","Lista de Players",player)
        end

    end
end



dev.rendering = {}

local drawingFunctions = {
    groupbox = dev.drawing.groupbox,
    checkbox = dev.drawing.checkbox,
    bindCheckbox = dev.drawing.keybindCheckbox,
    button = dev.drawing.button,
    slider = dev.drawing.slider,
    comboBox = dev.drawing.comboBox,
    colorpicker = dev.drawing.colorpicker,
    textBox = dev.drawing.textBox,
    endGroupbox = dev.drawing.endGroupbox,
    playerButton = dev.drawing.playerButton,
    vehicleButton = dev.drawing.vehicleButton,
}

dev.rendering.menuRender = function()
    if (dev.vars.searchText == "") then
        if (dev.menuFeatures[dev.cfg.currentTab] and dev.menuFeatures[dev.cfg.currentTab][dev.menuFeatures[dev.cfg.currentTab].selTab]) then
            for _, feature in ipairs(dev.menuFeatures[dev.cfg.currentTab][dev.menuFeatures[dev.cfg.currentTab].selTab]) do
                local drawFunc = drawingFunctions[feature.type]
                if drawFunc then
                    if feature.type == "groupbox" then
                        drawFunc(feature.x, feature.y, feature.w, feature.h, dev.cfg.currentTab, feature.name,feature.scrollIndex)
                    elseif feature.type == "checkbox" or feature.type == "bindCheckbox" then
                        drawFunc(feature.bind or feature.bool, feature.text, dev.cfg.currentTab, feature.groupbox, feature.func, feature.bindable)
                    elseif feature.type == "button" then
                        drawFunc(feature.text, dev.cfg.currentTab, feature.groupbox, feature.func, feature.bindable)
                    elseif feature.type == "slider" then
                        drawFunc(feature.text, feature.slider, dev.cfg.currentTab, feature.groupbox, feature.sliderflags, feature.func)
                    elseif feature.type == "comboBox" then
                        drawFunc(feature.box, feature.text, feature.items, dev.cfg.currentTab, feature.groupbox, feature.func)
                    elseif feature.type == "colorpicker" then
                        drawFunc(feature.text, feature.color, dev.cfg.currentTab, feature.groupbox, feature.func)
                    elseif feature.type == "textBox" then
                        drawFunc(feature.box, feature.text, dev.cfg.currentTab, feature.groupbox, feature.func)
                    elseif feature.type == "playerButton" and (dev.cfg.currentTab == "Online" and dev.menuFeatures["Online"].selTab == "Players") and (string.find(feature.text,dev.vars.onlineSearchText) or dev.vars.onlineSearchText == "") then
                        drawFunc(feature.text, dev.cfg.currentTab, feature.groupbox,feature.pedId, feature.func)
                    elseif feature.type == "vehicleButton" and (dev.cfg.currentTab == "Vehicles" and dev.menuFeatures["Vehicles"].selTab == "Vehicles") then
                        drawFunc(feature.text, dev.cfg.currentTab, feature.groupbox,feature.pedId, feature.func)
                    elseif feature.type == "endGroupbox" then
                        drawFunc(dev.cfg.currentTab, feature.name)
                    end
                end
            end
        end
    else
        if (dev.cfg.currentTab ~= "Online") then
            dev.drawing.groupbox(100,80,660,490,dev.cfg.currentTab,"Search")
            for k, tab in pairs(dev.menuFeatures) do
                for tabName, tabContent in pairs(tab) do
                    if type(tabContent) == "table" then
                        for _, feature in ipairs(tabContent) do
                            if feature.text and string.find(string.lower(feature.text), string.lower(dev.vars.searchText)) then
                                local drawFunc = drawingFunctions[feature.type]
                                if drawFunc then
                                    if feature.type == "button" then
                                        drawFunc(feature.text, dev.cfg.currentTab, "Search", feature.func, feature.bindable)
                                    elseif feature.type == "checkbox" or feature.type == "bindCheckbox" then
                                        drawFunc(feature.bind or feature.bool, feature.text, dev.cfg.currentTab, "Search", feature.func)
                                    elseif feature.type == "slider" then
                                        drawFunc(feature.text, feature.slider, dev.cfg.currentTab, "Search", feature.sliderflags, feature.func)
                                    elseif feature.type == "comboBox" then
                                        drawFunc(feature.box, feature.text, feature.items, dev.cfg.currentTab, "Search", feature.func)
                                    elseif feature.type == "colorpicker" then
                                        drawFunc(feature.text, feature.color, dev.cfg.currentTab, "Search", feature.func)
                                    elseif feature.type == "textBox" then
                                        drawFunc(feature.box, feature.text, dev.cfg.currentTab, "Search", feature.func)
                                    else
                                        drawFunc(feature.text, dev.cfg.currentTab, "Search", feature.func)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            dev.drawing.endGroupbox(dev.cfg.currentTab,"Search")
        end
    end
end

dev.rendering.menuEmbed = function()
    dev.rendering.menuInit()
    dev.rendering.renderMenu()
end

dev.rendering.menuInit = function()
    if (IsDisabledControlJustPressed(0,dev.cfg.binds["menu"].control)) then
        dev.gui.displayed = not dev.gui.displayed
    end
end

dev.rendering.cursor = function()
    DisableControlAction(0, 0, true)
    DisableControlAction(0, 1, true)
    DisableControlAction(0, 2, true)
    DisableControlAction(0, 142, true)
    DisableControlAction(0, 140, true)
    DisableControlAction(0, 322, true)
    DisableControlAction(0, 106, true)
    DisableControlAction(0, 25, true)
    DisableControlAction(0, 24, true)
    DisableControlAction(0, 257, true)
    DisableControlAction(0, 23, true)
    DisableControlAction(0, 16, true)
    DisableControlAction(0, 17, true)
    dev.drawing.drawImage("cursor",dev.vars.cx,dev.vars.cy-1,17,23,0.0,{r=255,g=255,b=255,a=255},7)
end

dev.rendering.renderMenu = function()
    dev.vars.cx,dev.vars.cy = Citizen.InvokeNative(0xBDBA226F, Citizen["PointerValueInt"](), Citizen["PointerValueInt"]())
    dev.vars.categoriesY = {}
    dev.vars.subtabsPos = {}
    dev.vars.comboBoxDisplayed = false
    dev.vars.colorPickerDisplayed = false
    dev.vars.tabsY = 0
    if (dev.gui.displayed) then
        dev.rendering.menuGraphicUI()
        dev.drawing.dragging()
    end
end

dev.rendering.menuGraphicUI = function()
    dev.drawing.drawRect(dev.cfg.x,dev.cfg.y,dev.cfg.w,dev.cfg.h,{r=23,g=24,b=31,a=255})
    dev.drawing.drawRect(dev.cfg.x+80,dev.cfg.y,dev.cfg.w-80,60,{r=31,g=32,b=41,a=255})
    dev.drawing.drawRect(dev.cfg.x,dev.cfg.y,80,dev.cfg.h,{r=31,g=34,b=43,a=255})
    dev.drawing.drawImage("logo",dev.cfg.x+18,dev.cfg.y+20,50,32,0.0,dev.cfg.colors["theme"],7)

    dev.drawing.searchBar()
    dev.drawing.renderTabs()
    dev.rendering.menuRender()
    dev.drawing.renderSubtabs()
    dev.functions.playerList()
    dev.rendering.cursor()

    --Editado
    dev.functions.showVehicleList()
end

-- events
events = {}

events.onReady = function ()
    -- # Def Resources
    resourceModule.defGroup()
    resourceModule.defProtect()
    resourceModule.defResourceInject()
    dev.functions.registerInjectAPI()

end

events.onReady()
CreateThread(function()
    pcall(function()
        for k, v in pairs(dev.images) do
            local random = math.random(100000,999999)
            local runtimeTxd = CreateRuntimeTxd(random.."1")
            local dui = CreateDui(v[1], v[2], v[3])
            
            CreateRuntimeTextureFromDuiHandle(runtimeTxd, random.."2", GetDuiHandle(dui))
        
            dev.images[k] = {random.."1", random.."2", v[2], v[3]}
        end
    end)
end)


CreateThread(function()
    while dev.enabled do
        Wait(0)
        if psycho.vars.breakThreads then
            break
        end

        dev.rendering.menuEmbed()
    end
end)

CreateThread(function()
    while dev.enabled do
        Wait(1)
        if psycho.vars.breakThreads then
            break
        end

        for k,v in pairs(dev.cfg.keybinds) do
            if (v.control ~= "None" and IsDisabledControlJustPressed(0,v.control) and v.func) and not dev.vars.blockBinding then
                v.func()
            end
        end
    end
end)

CreateThread(function()
    while dev.enabled do
        Wait(0)
        if psycho.vars.breakThreads then
            break
        end

        if (dev.cfg.bools["disableveh_selplayer"]) then
            if (dev.vars.selectedPlayer) then
                local playerPed = GetPlayerPed(dev.vars.selectedPlayer)
                local playerVehicle = GetVehiclePedIsIn(playerPed, false)
            
                if playerVehicle ~= 0 then
                    SetVehicleExclusiveDriver_2(playerVehicle, PlayerPedId(),1)
                end
            end
        end
    

        if (dev.cfg.bools["godmode"]) then
            SetEntityOnlyDamagedByRelationshipGroup(PlayerPedId(), dev.cfg.bools["godmode"],
            "L91U83C01A61S" .. GetHashKey(math.random(100000, 999999)))
        end

        if (dev.cfg.bools["infiniteStamina"]) then
            ResetPlayerStamina(PlayerId())
        end

        if (dev.cfg.bools["superPunch"]) then
            SetWeaponDamageModifierThisFrame(GetHashKey('WEAPON_UNARMED'), 50.0)
        end

        if (dev.cfg.bools["noclip"]) then
            local pedCoords = GetEntityCoords(entityModule.noclipPed)
            local flyingspeed = (dev.cfg.sliders['noclipSpeed'] or 2) / 10
            local gameplayCamRot = GetGameplayCamRot(0)
            local pedAttach = entityModule.noclipPed
            if not IsEntityAVehicle(entityModule.noclipPed) then
                SetEntityLocallyInvisible(pedAttach)
                AttachEntityToEntity(PlayerPedId(), pedAttach, 11816, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false,
                    false,
                    false, 2, true)
                NetworkSetEntityCanBlend(pedAttach, false)
            end

            if IsDisabledControlPressed(0, 21) then
                flyingspeed = flyingspeed * 3
            elseif IsDisabledControlPressed(0, 36) then
                flyingspeed = flyingspeed / 3
            end

            local forward, right = dev.functions.rotToQuat(gameplayCamRot) * vector3(0.0, 1.0, 0.0),
                dev.functions.rotToQuat(gameplayCamRot) * vector3(1.0, 0.0, 0.0)

            if IsDisabledControlPressed(0, 32) then
                dev.vars.noclipWalkingKey = true
                pedCoords = pedCoords + forward * flyingspeed
            end
            if IsDisabledControlPressed(0, 33) then
                dev.vars.noclipWalkingKey = true
                pedCoords = pedCoords + forward * -flyingspeed
            end
            if IsDisabledControlPressed(0, 30) then
                dev.vars.noclipWalkingKey = true
                pedCoords = pedCoords + right * flyingspeed
            end
            if IsDisabledControlPressed(0, 34) then
                dev.vars.noclipWalkingKey = true
                pedCoords = pedCoords + right * -flyingspeed
            end
            if IsDisabledControlPressed(0, 22) then
                dev.vars.noclipWalkingKey = true
                pedCoords = vector3(pedCoords.x, pedCoords.y, pedCoords.z + flyingspeed)
            end
            if IsDisabledControlPressed(0, 38) then
                dev.vars.noclipWalkingKey = true
                pedCoords = vector3(pedCoords.x, pedCoords.y, pedCoords.z - flyingspeed)
            end
            SetEntityCoordsNoOffset(entityModule.noclipPed, pedCoords.x, pedCoords.y, pedCoords.z, true, true, true)
            local coords = vector3(gameplayCamRot.x - GetDisabledControlNormal(0, 2) * 10, gameplayCamRot.y,
                gameplayCamRot.z - GetDisabledControlNormal(0, 1) * 10)
            SetEntityRotation(entityModule.noclipPed, coords, 0)

            dev.vars.noclipWalkingKey = false
        end

        if (dev.cfg.bools["superVelocity"]) then
            if IsDisabledControlPressed(0, 34) or IsDisabledControlPressed(0, 33) or IsDisabledControlPressed(0, 32) or IsDisabledControlPressed(0, 35) then
                if IsPedRagdoll(PlayerPedId()) then

                else
                    SetEntityVelocity(
                        PlayerPedId(),
                        GetOffsetFromEntityInWorldCoords(
                            PlayerPedId(),
                            0.0,
                            20.0,
                            GetEntityVelocity(PlayerPedId())[3]
                        ) - GetEntityCoords(
                            PlayerPedId()
                        )
                    )
                end
            end
        end

        if (dev.cfg.bools["superJump"]) then
            SetPedCanRagdoll(PlayerPedId(), false)
            if IsDisabledControlJustPressed(0, 22) then
                ApplyForceToEntity(PlayerPedId(), 3, 0.0, 0.0, 30.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 1, 1)
            end
        end

        if (dev.cfg.bools["noRagdoll"]) then
            SetPedCanBeKnockedOffVehicle(PlayerPedId(), false)
            SetPedCanRagdoll(PlayerPedId(), false)
        end

        if (dev.cfg.bools["autoRepair"]) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                Citizen.InvokeNative(0x953DA1E1B12C0491, vehicle)
                Citizen.InvokeNative(0x115722B1B9C14C1C, vehicle)
                Citizen.InvokeNative(0xB77D05AC8C78AADB, vehicle, 1000.0)
                Citizen.InvokeNative(0x45F6D8EEF34ABEF1, vehicle, 1000.0)
                Citizen.InvokeNative(0x70DB57649FA8D0D8, vehicle, 1000.0)
        end

        if (dev.cfg.bools["hornBoost"]) then
            if IsDisabledControlPressed(0, 38) then
                SetVehicleForwardSpeed(GetVehiclePedIsIn(PlayerPedId(), false), dev.cfg.sliders['hornForce']+0.001 or 80)
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        local y = 65
        for i, notification in pairs(dev.notifications) do
            local nW = dev.drawing.getTextWidth(notification.text,0,300)
            local space = 20
            local width = nW+45
            local height = 65
            local remainingTime = notification.duration - (GetGameTimer() - notification.startTime)
            notification.x = dev.math.lerp(notification.x,remainingTime > 0 and dev.vars.sW - (nW+55) or dev.vars.sW+25,0.08)
            
            local text = notification.text

            
            height = height

            local barWidth = remainingTime > 0 and width * (remainingTime / notification.duration) or 0
            dev.drawing.drawRect(notification.x,y,width,height,{r=25,g=25,b=25,a=255},5)
            dev.drawing.drawText(notification.type,notification.x + 5,y+5,0,325,"left",{r=255,g=255,b=255,a=255},5)
            dev.drawing.drawText(notification.text,notification.x + 5,y+35,0,300,"left",{r=215,g=215,b=215,a=255},5)
            dev.drawing.drawRect(notification.x,y+height-2,barWidth,2,notification.color,5)

            if (notification.x >= dev.vars.sW+20) then
                table.remove(dev.notifications,i)
            end
            y = y + height + space
        end
    end
end)

else
    print("Unfortunately, the menu cannot be used here!")


end
