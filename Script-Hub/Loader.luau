local HubName = "AHST HUB"
local Invite = "https://discord.gg/rTGF5xhe3h"
local LogoURL = "https://antihambreadoscriptteam.github.io/Script-Hub/4feec9d1-30a9-475f-b557-a5020d537615.png"
local Bio = "Proyecto sin fines de lucro"
local Verified = utf8.char(0xE000)
local Premium = utf8.char(0xE001)
local LibraryURL = "https://antihambreadoscriptteam.github.io/Script-Hub/Librer%C3%ADa.lua"

local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local function LoadLogo()
    local getasset = getcustomasset or getsynasset
    if not (writefile and getasset) then
        return ""
    end
    local ok, result = pcall(function()
        local folder = "AHST-Hub"
        local path = folder .. "/logo.png"
        if isfolder and makefolder and not isfolder(folder) then
            makefolder(folder)
        end
        if not (isfile and isfile(path)) then
            writefile(path, game:HttpGet(LogoURL))
        end
        return getasset(path)
    end)
    if ok and type(result) == "string" then
        return result
    end
    return ""
end

local Logo = LoadLogo()

local function Notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Icon = Logo,
            Duration = duration or 5
        })
    end)
end

local function CopyInvite()
    local clip = setclipboard or toclipboard or (syn and syn.write_clipboard)
    if clip then
        pcall(clip, Invite)
        return true
    end
    return false
end

local function GetGuiParent()
    local ok, hui = pcall(function()
        return gethui and gethui()
    end)
    if ok and hui then
        return hui
    end
    return CoreGui
end

local Games = {
    {
        Name = "99 NOCHES EN EL BOSQUE",
        Emoji = "🌲",
        Scripts = {
            {
                Name = "BONK HUB",
                Source = [=[
getgenv().ScriptMode = "Kaitan"
loadstring(game:HttpGet('https://bonkhubloader.netlify.app/', true))()
]=]
            },
            {
                Name = "BONK HUB NORMAL",
                Source = [=[
loadstring(game:HttpGet("https://bonkhub.online/loader.lua",true))()
]=]
            },
            {
                Name = "FOXNAME",
                Source = [=[
getgenv().hop = "old"
getgenv().reducelag = true
getgenv().blackscreen = false
getgenv().AutoFarm = false
getgenv().autoexecuter = true
getgenv().WebhookURL = ""
loadstring(game:HttpGet("https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FoxnameFarmdiamond.lua"))()
]=]
            },
            {
                Name = "FOXNAME V2",
                Source = [=[
loadstring(game:HttpGet('https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FNDayFarm.lua'))()
]=]
            },
            {
                Name = "H4X HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/H4xScripts/Loader/refs/heads/main/loader.lua", true))()
]=]
            },
            {
                Name = "NUEVO SCRIPT",
                Source = [=[
loadstring(game:HttpGet("https://soluna-script.vercel.app/99-Nights-in-the-Forest.lua",true))()
]=]
            },
            {
                Name = "SERIOUSLY",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Seriously56/99-Nights/refs/heads/main/99%20nights", true))()
]=]
            },
            {
                Name = "VOID WARE",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))()
]=]
            },
            {
                Name = "VORTEX HUB",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/80aed6b06a7e38e8260a1b82638ff65b.lua"))()
]=]
            },
            {
                Name = "INF CANDY",
                Source = [=[
_G.Auto = true

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Event = ReplicatedStorage.RemoteEvents.CarnivalCompleteShootingGallery

local function findTargets(parent, depth)
    if depth > 3 then return {} end

    local targets = {}

    for _, child in ipairs(parent:GetChildren()) do
        if child:IsA("BasePart") then
            table.insert(targets, child)
        end

        for _, subTarget in ipairs(findTargets(child, depth + 1)) do
            table.insert(targets, subTarget)
        end
    end

    return targets
end

spawn(function()
    while task.wait(3) do

        local targets = {}
        local areas = {
            workspace.Map,
            workspace.Items,
            workspace.Characters
        }

        for _, area in ipairs(areas) do
            for _, target in ipairs(findTargets(area, 0)) do
                table.insert(targets, target)
            end
        end

        for index, target in ipairs(targets) do
            if not _G.Auto then break end

            local success = pcall(function()
                Event:FireServer(target)
            end)
            task.wait(0.05)
        end
    end
end)
]=]
            },
            {
                Name = "FOXNAME HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FoxnameHub.lua"))()
]=]
            },
            {
                Name = "FOXNAME FARM DAYS Y GEMS",
                Source = [=[
getgenv().maxday = 100
getgenv().webhook = "Url Here"
loadstring(game:HttpGet('https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FNDayFarm.lua'))()
]=]
            },
        }
    },
    {
        Name = "ARISE CROSSOVER",
        Emoji = "👊",
        Scripts = {
            {
                Name = "GOOMBA HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/JustLevel/goombahub/main/AriseCrossover.lua"))()
]=]
            },
        }
    },
    {
        Name = "ATTACK ON TITAN REVOLUTION",
        Emoji = "🗿",
        Scripts = {
            {
                Name = "TITANIC HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/TITANIC-HUB/THUB/main/Loader.lua"))()
]=]
            },
            {
                Name = "LUNARZ",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/LunarZR/bomba/refs/heads/main/AOTR1"))()
]=]
            },
            {
                Name = "TEKKIT HUB",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/705e7fe7aa288f0fe86900cedb1119b1.lua"))()
]=]
            },
            {
                Name = "ECLIPSE HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/nocturnalxen/EclipseHubAotr/refs/heads/main/eclipsemain", true))()
]=]
            },
            {
                Name = "LINUX HUB",
                Source = [=[
loadstring(game:HttpGet("https://pastefy.app/pDcs7hGN/raw"))()
]=]
            },
            {
                Name = "MIST HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/xytuu/MistHub/refs/heads/main/aotr", true))()
]=]
            },
            {
                Name = "SYMBIOTE HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/ssssssssss21/Symbiote/refs/heads/main/symbiote-loader.lua"))()
]=]
            },
            {
                Name = "AXON HUB",
                Source = [=[
loadstring(game:HttpGet("https://xenith-auth.online/v1/loader/5b193fc732db5c93"))()
]=]
            },
            {
                Name = "LIX HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Lixtron/Hub/refs/heads/main/loader"))()
]=]
            },
        }
    },
    {
        Name = "ANIME WEAPONS",
        Emoji = "🔪",
        Scripts = {
            {
                Name = "NEW OMG HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
        }
    },
    {
        Name = "ANIME WARRIORS",
        Emoji = "👊",
        Scripts = {
            {
                Name = "YUTO HUB V3",
                Source = [=[
repeat wait() until game:IsLoaded()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/Binintrozza/yutv2e/main/Yutohub')))()
]=]
            },
        }
    },
    {
        Name = "ANIME FIGHTING SIMULADOR",
        Emoji = "👊",
        Scripts = {
            {
                Name = "SHADOW HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/ShadowXScript/Shadow-Hub/refs/heads/main/AFSE/loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "ARSENAL",
        Emoji = "🎯",
        Scripts = {
            {
                Name = "FELICIA SCRIPT",
                Source = [=[
loadstring(game:HttpGet("https://antihambreadoscriptteam.github.io/Scripts/Arsenal.lua"))()
]=]
            },
        }
    },
    {
        Name = "ABYSS",
        Emoji = "🌊",
        Scripts = {
            {
                Name = "IMP HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Hub/refs/heads/main/ImpHub.lua"))()
]=]
            },
            {
                Name = "JUMANTARA HUB",
                Source = [=[
loadstring(game:HttpGet("https://hub.jumanexus.net/main.lua"))()
]=]
            },
        }
    },
    {
        Name = "ANIMAL HOSPITAL",
        Emoji = "🏥",
        Scripts = {
            {
                Name = "AXON HUB",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/97c3f6db55a2cf72141537a85458e5a7.lua"))()
]=]
            },
            {
                Name = "MINI HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/MinityD/roblox-utils/main/animal%20hospital.lua"))()
]=]
            },
            {
                Name = "FOXNAME HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/caomod2077/Script/main/FN_AnimalHospital.lua"))()
]=]
            },
            {
                Name = "AJJAN HUB",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/359e97f8618e9008afe5f496184ebb7c.lua"))()
]=]
            },
            {
                Name = "STE HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/SteWasHere/Hub/main/loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "ANIME FINAL QUESTS",
        Emoji = "📜",
        Scripts = {
            {
                Name = "NEW OMG HUB 2025",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
            {
                Name = "BIGFROOT HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))()
]=]
            },
        }
    },
    {
        Name = "ANIME GHOST",
        Emoji = "👻",
        Scripts = {
            {
                Name = "MAI HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/LunaS3ven/Script/Games/Loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "ANIME PIECE",
        Emoji = "⚓",
        Scripts = {
            {
                Name = "OMG HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
        }
    },
    {
        Name = "ANIME VANGUARD",
        Emoji = "🏰",
        Scripts = {
            {
                Name = "GOOMBA HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/JustLevel/goombahub/main/goombahub.lua"))()
]=]
            },
        }
    },
    {
        Name = "BLADE BALL",
        Emoji = "👊",
        Scripts = {
            {
                Name = "RISE HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/joshhhie/rise/refs/heads/main/loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "BASICALLY FNF: REMIX",
        Emoji = "🎤",
        Scripts = {
            {
                Name = "AUTO PLAYER",
                Source = [=[
loadstring(game:HttpGet("https://rawscripts.net/raw/Basically-FNF:-Remix-AutoPlayer-Lite-9989"))()
]=]
            },
        }
    },
    {
        Name = "BLOCK SPIN",
        Emoji = "🌃",
        Scripts = {
            {
                Name = "HERMANOS-DEV",
                Source = [=[
local loader = loadstring
local url = "https://raw.githubusercontent.com/hermanos-dev/hermanos-hub/refs/heads/main/BlockSpin/blockspin-pvp.lua"
local response = game:HttpGet(url)
loader(response)()
]=]
            },
            {
                Name = "QUARTY",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/xQuartyx/QuartyzScript/main/Loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "BLOODMONEY",
        Emoji = "💉",
        Scripts = {
            {
                Name = "ANTI-HAMBREADO TEAM SCRIPT | BLOODMONEY",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/FloppHub-Team/Scripts-idk/refs/heads/main/BloodMoney%20Script.txt"))()
]=]
            },
        }
    },
    {
        Name = "BLOX FRUITS",
        Emoji = "🍈",
        Scripts = {
            {
                Name = "PVP SCRIPT",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/cc815ef92aaf3ed41a37aa4d87cd93ff.lua"))()
]=]
            },
            {
                Name = "OMG HUB KAITUN",
                Source = [=[
getgenv().SettingFarm ={
    ["Team"] = "Pirates",
    ["Configuration"] = {
        ["HopWhenIdle"] = true,
        ["AutoHop"] = true,
        ["AutoHopDelay"] = 60 * 60,
        ["FpsBoost"] = false,
        ["AutoExecute"] = true,
    },
    ["Settings"] = {
        ["StayInSea2UntilHaveDarkFragments"] = true,
    },
    ["Race"] = {
        ["Select Race"] = {"Mink"},
        ["Reroll Race"] = true,
    },
    ["Lock Fps"] = {
        ["Enabled"] = false,
        ["FPS"] = 10,
    },
    ["Get Items"] = {
        ["Saber"] = true,
        ["All Melees"] =  true,
        ["Skull Guitar"] = true,
        ["Cursed Dual Katana"] = true,
        ["RaceV2"] = true,
    },
    ["Select Hop"] = {
        ["Hop Find Don Swan [Trevor]"] = true,
    },
    ["Buy Items"] = {
        ["Abilitys"] = true,
        ["Base Swords"] = true,
        ["Legendary Swords"] = true,
        ["Haki Scrolls"] = true,
    },
    ["Sniper Fruit Shop"] = {
        ["Enabled"] = true,
        ["Fruit"] = {"Leopard-Leopard","Kitsune-Kitsune","Dragon-Dragon","Yeti-Yeti","Gas-Gas"},
    },
    ["Webhook"] = {
        ["Enabled"] = false,
        ["WebhookUrl"] = "",
    }
}
getgenv().Mode = "Kaitun"
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
            {
                Name = "ANDEPZAIHUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/h6hbii/AnDepZaiHub/refs/heads/main/AndepzaiHub.lua"))()
]=]
            },
            {
                Name = "ASTRAL HUB",
                Source = [=[
loadstring(game:HttpGet('https://cdn.robloxscripts.gg/public/furky/furky-astral-source.lua'))()
]=]
            },
            {
                Name = "BLUE X HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua"))()
]=]
            },
            {
                Name = "DAT THG",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/DatThg/refs/heads/main/DatThgV2"))()
]=]
            },
            {
                Name = "GRAVITY HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua"))()
]=]
            },
            {
                Name = "HOHO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
]=]
            },
            {
                Name = "NEW OMG HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
            {
                Name = "SCRIPT SERVER HOP",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/noguchihyuga/script/refs/heads/main/hopserver.lua"))()
]=]
            },
            {
                Name = "TEDDY HUB",
                Source = [=[
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"))()
]=]
            },
            {
                Name = "TEDDY SERVER BOSS HUB",
                Source = [=[
repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TEDDYHUB-FREEMIUM"))()
]=]
            },
            {
                Name = "TEDDY MAIN 2026",
                Source = [=[
repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")
loadstring(game:HttpGet("https://raw.githubusercontent.com/teddyhubdev/diepvy/refs/heads/main/TeddyHub.lua"))()
]=]
            },
            {
                Name = "TEDDY HUB KAITUN",
                Source = [=[
getgenv()["Config"] = {
    ["Fps Boost"] = true,
    ["FPS Cap"] = 30,
    ["Quests"] = {
        ["Pull Level"] = true,
        ["Upgrading Race"] = true,
    },
    ["Hopping"] = {
        ["Auto Hop"] = true,
        ["Hop Idle"] = true,
        ["High Ping Hop"] = true,
        ["Player Nearing Hop"] = true,
    },
    ["Sniper Fruit Shop"] = {
        ["Enabled"] = true,
        ["Fruit"] = {
            "Kitsune-Kitsune",
            "Dragon-Dragon",
            "Yeti-Yeti",
            "Gas-Gas"
        },
    },
    ["Oneclick"] = {
        ["Auto Fully Fighting Style"] = true,
        ["Rainbow Haki"] = true,
        ["Skull Guitar"] = true,
        ["Cursed Dual Katana"] = true,
        ["Saber"] = true,
        ["Get Ghoul"] = false,
        ["Collect Berries"] = false,
        ["Haki Legendery"] = false,
        ["TTK"] = false,
    },
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/teddyhubdev/diepvy/refs/heads/main/TeddyHub-kaitunBF.lua"))()
]=]
            },
            {
                Name = "TEDDY SECRETS QUESTS",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/teddyhubdev/diepvy/refs/heads/main/SecretQuest.lua"))()
]=]
            },
            {
                Name = "ESMERALD HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/bloxfruitsnokey/Redz/refs/heads/main/Emerald/script.luau"))()
]=]
            },
            {
                Name = "ARC HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/bloxfruitsnokey/Arcylic/refs/heads/main/ARC/script.luau"))()
]=]
            },
            {
                Name = "TSUO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"))()
]=]
            },
            {
                Name = "W-AZURE",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/85e904ae1ff30824c1aa007fc7324f8f.lua"))()
]=]
            },
            {
                Name = "ARYA KAITUN",
                Source = [=[
Config = {
Team = "Pirates",
Configuration = {
HopWhenIdle = true,
AutoHop = true,
AutoHopDelay = 60 * 60,
FpsBoost = false,
BlackScreen = true
},
Items = {
AutoFullyMelees = true,
Saber = true,
CursedDualKatana = false,
SoulGuitar = false,
RaceV2 = true
},
Settings = {
StayInSea2UntilHaveDarkFragments = false
}
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/hhl29042008-ops/script/refs/heads/main/cac"))()
]=]
            },
            {
                Name = "REDZ HUB FAKE",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/20f318386e3fbf069ee3fa797cfc9f34.lua"))()
]=]
            },
            {
                Name = "XETER HUB",
                Source = [=[
getgenv().Version = "V3"
getgenv().Team = "Marines"
loadstring(game:HttpGet("https://raw.githubusercontent.com/TlDinhKhoi/Xeter/refs/heads/main/Main.lua"))()
]=]
            },
            {
                Name = "HIRU HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/HiruKiddo/Source/main/HiruHubFree.lua"))()
]=]
            },
            {
                Name = "KING RUA HUB",
                Source = [=[
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer loadstring(game:HttpGet("https://raw.githubusercontent.com/shinichi-dz/phucshinyeuem/refs/heads/main/KingRuaHub.lua"))()
]=]
            },
            {
                Name = "BACON HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/Bloxfruits.lua"))()
]=]
            },
            {
                Name = "FLOPPBLOX",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/FloppHub-Team/BloxFruits-Script/refs/heads/main/FloppHubX.lua"))()
]=]
            },
            {
                Name = "HOP BOSS SCRIPT",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/HopScript.luau"))()
]=]
            },
            {
                Name = "FLOW BLOXFRUITS",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/5946add9ab91f1e04cb005346a8b1968.lua"))()
]=]
            },
            {
                Name = "SOLIX HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
]=]
            },
            {
                Name = "RELZ HUB 2026",
                Source = [=[
loadstring(game:HttpGet("https://relzhub.farrelghibran.com/loader.lua"))()
]=]
            },
            {
                Name = "REDZ HUB (REMAKE)",
                Source = [=[
local Settings = {
  JoinTeam = "Pirates";
  Translator = true;
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/PlockScripts/newredz/refs/heads/main/Remake-version.luau"))(Settings)
]=]
            },
            {
                Name = "MIDNIGHT X",
                Source = [=[
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
getgenv().Team = "Pirates"
loadstring(game:HttpGet("https://raw.githubusercontent.com/Ohofo2279/Midnight/refs/heads/main/MidnightX-BloxFruits.lua"))()
]=]
            },
            {
                Name = "QUANTUM ONYX",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))()
]=]
            },
            {
                Name = "POLE HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/bloxfruitsnokey/Banana/refs/heads/main/Pole/script.luau"))()
]=]
            },
            {
                Name = "AURORA HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/bloxfruitsnokey/Stellar/refs/heads/main/Aurora/script.luau"))()
]=]
            },
            {
                Name = "H4X SCRIPT",
                Source = [=[
loadstring(game:HttpGet("https://H4xScripts.xyz/loader"))()
]=]
            },
        }
    },
    {
        Name = "BLUE LOCK RIVALS",
        Emoji = "⚽",
        Scripts = {
            {
                Name = "OMG HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
        }
    },
    {
        Name = "BOB ESPONJA TOWER DEFENSE",
        Emoji = "🍍",
        Scripts = {
            {
                Name = "IMP HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Hub/refs/heads/main/ImpHub.lua"))()
]=]
            },
        }
    },
    {
        Name = "BROKEN BLADE",
        Emoji = "🔪",
        Scripts = {
            {
                Name = "AXON HUB",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/97c3f6db55a2cf72141537a85458e5a7.lua"))()
]=]
            },
        }
    },
    {
        Name = "BUILD A BOAT",
        Emoji = "⛵",
        Scripts = {
            {
                Name = "BABFT",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/example-prog/Build-A-Boat-For-Treasure/refs/heads/main/BABFT"))()
]=]
            },
        }
    },
    {
        Name = "BUILD A RING FARM",
        Emoji = "💍",
        Scripts = {
            {
                Name = "LUXY HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omnie7/Luxy-Hub/refs/heads/main/main.lua"))()
]=]
            },
        }
    },
    {
        Name = "BEE SWARM SIMULATOR",
        Emoji = "🐝",
        Scripts = {
            {
                Name = "MACROWARE",
                Source = [=[
loadstring(game:HttpGet("https://macroware.cc/loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "BRAINROT SEA",
        Emoji = "🌊",
        Scripts = {
            {
                Name = "STATS OP",
                Source = [=[
loadstring(game:HttpGet("https://antihambreadoscriptteam.github.io/Scripts/Brainrot%20Sea.lua"))()
]=]
            },
        }
    },
    {
        Name = "BIZARRE LINEAGE",
        Emoji = "⭐",
        Scripts = {
            {
                Name = "BLACK HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Skibidiking123/Fisch1/refs/heads/main/FischMain"))()
]=]
            },
            {
                Name = "NEW OMG HUB 2025",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
        }
    },
    {
        Name = "BITE BY NIGHT",
        Emoji = "🌙",
        Scripts = {
            {
                Name = "CELERON'S BITE BY NIGHT",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Celeron/refs/heads/main/Celeron's%20Loader"))()
]=]
            },
        }
    },
    {
        Name = "CATCH 1 BILLION DUCKS",
        Emoji = "🐤",
        Scripts = {
            {
                Name = "OUROBOROS HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "CATCH A BRAINROT",
        Emoji = "👾",
        Scripts = {
            {
                Name = "CHIYO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua"))()
]=]
            },
        }
    },
    {
        Name = "CLOVER TIME",
        Emoji = "🍀",
        Scripts = {
            {
                Name = "OUROBOROS HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "CREATURE OF SONARÍA",
        Emoji = "🐉",
        Scripts = {
            {
                Name = "IMP HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Hub/refs/heads/main/ImpHub.lua"))()
]=]
            },
        }
    },
    {
        Name = "DANDY'S WORLD",
        Emoji = "🌼",
        Scripts = {
            {
                Name = "DANDY'S WORLD HUB",
                Source = [=[
loadstring(game:HttpGet("https://pastebin.com/raw/H3u62n7D"))()
]=]
            },
        }
    },
    {
        Name = "DEAD DEFENSE",
        Emoji = "💀",
        Scripts = {
            {
                Name = "GUMANBA",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DeadDefense"))()
]=]
            },
        }
    },
    {
        Name = "DEAD RAILS",
        Emoji = "🚂",
        Scripts = {
            {
                Name = "NAT HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/ArdyBotzz/NatHub/refs/heads/master/NatHub.lua"))()
]=]
            },
            {
                Name = "SKULL HUB",
                Source = [=[
loadstring(game:HttpGet('https://raw.githubusercontent.com/hungquan99/SkullHub/main/loader.lua'))()
]=]
            },
            {
                Name = "GRAMPYSIM V7 AUTOBONOS",
                Source = [=[
loadstring(game:HttpGet("https://pastebin.com/raw/0JVAwPp8"))()
]=]
            },
            {
                Name = "XUAN AUTOBONDS",
                Source = [=[
_G.TzuanWebhook = "linkwebhook"
loadstring(game:HttpGet("https://raw.githubusercontent.com/tzuanyeuban/TzuanHub/refs/heads/main/autobondnew.lua"))()
]=]
            },
            {
                Name = "FOXNAME AUTO-BOND",
                Source = [=[
loadstring(game:HttpGet('https://raw.githubusercontent.com/afkar-gg/sc/refs/heads/main/auto-bond'))()
]=]
            },
        }
    },
    {
        Name = "DEMON BLADE",
        Emoji = "👊",
        Scripts = {
            {
                Name = "DEMON BLADE SCRIPT",
                Source = [=[
loadstring(game:HttpGet('https://raw.githubusercontent.com/shakaUnlocked/IiI/refs/heads/main/dbrw.lua'))()
]=]
            },
        }
    },
    {
        Name = "DEMON FALL",
        Emoji = "👹",
        Scripts = {
            {
                Name = "NOOB HUB",
                Source = [=[
loadstring(game:HttpGet(('https://raw.githubusercontent.com/NOOBHUBX/DemonFall/main/NOOB%20HUB.Lua'),true))()
]=]
            },
        }
    },
    {
        Name = "DIG",
        Emoji = "🔨",
        Scripts = {
            {
                Name = "FROSTBYTE",
                Source = [=[
loadstring(game:HttpGet("https://init.frostbyte.lol"))()
]=]
            },
        }
    },
    {
        Name = "DOORS",
        Emoji = "🚪",
        Scripts = {
            {
                Name = "AHST Script",
                Source = [=[
loadstring(game:HttpGet("http://antihambreadoscriptteam.github.io/Scripts/NewEra/Doors.luau"))()
]=]
            },
            {
                Name = "DOORS SCRIPT",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/TheHunterSolo1/Scripts/refs/heads/main/Protected_2809220311826785.lua.txt"))()
]=]
            },
        }
    },
    {
        Name = "DRAGON BALL RAGE",
        Emoji = "🐉",
        Scripts = {
            {
                Name = "IMP HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Hub/refs/heads/main/ImpHub.lua"))()
]=]
            },
        }
    },
    {
        Name = "DRAGON BLOX",
        Emoji = "🐲",
        Scripts = {
            {
                Name = "DEMONIC HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Prosexy/Demonic-HUB-V2/main/DemonicHub_V2.lua", true))()
]=]
            },
        }
    },
    {
        Name = "DEATH BALL",
        Emoji = "🔴",
        Scripts = {
            {
                Name = "NATIVE HUB",
                Source = [=[
script_key="PasteKeyHere";
(loadstring or load)(game:HttpGet("https://getnative.cc/script/loader"))()
]=]
            },
        }
    },
    {
        Name = "DUNGEON LOOTR",
        Emoji = "💰",
        Scripts = {
            {
                Name = "OUROBOROS HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "DUNGEON QUEST REBORN",
        Emoji = "🏰",
        Scripts = {
            {
                Name = "APEL HUB 2026",
                Source = [=[
loadstring(game:HttpGet("https://apelhub.com/loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "EVADE",
        Emoji = "🏃",
        Scripts = {
            {
                Name = "SPEEDHAX",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/thesigmacorex/RobloxScripts/main/speedhax"))()
]=]
            },
            {
                Name = "TORAISME",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EvadeEvent"))()
]=]
            },
            {
                Name = "FELICIA SCRIPT",
                Source = [=[
loadstring(game:HttpGet("https://antihambreadoscriptteam.github.io/Scripts/Evade.lua"))()
]=]
            },
            {
                Name = "EVADE EVENT SCRIPT",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EvadeEvent"))()
]=]
            },
        }
    },
    {
        Name = "EVOMON",
        Emoji = "🐾",
        Scripts = {
            {
                Name = "RENDANG",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/JualNasiRendang/nasirendang-evomon/main/nasirendang-evomon.lua"))()
]=]
            },
        }
    },
    {
        Name = "FISCH",
        Emoji = "🎣",
        Scripts = {
            {
                Name = "ALCHEMY HUB",
                Source = [=[
loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
]=]
            },
            {
                Name = "NATIVE HUB",
                Source = [=[
script_key="PasteKeyHere";
(loadstring or load)(game:HttpGet("https://getnative.cc/script/loader"))()
]=]
            },
            {
                Name = "NATIVE HUB NEW",
                Source = [=[
script_key="PasteKeyHere";
(loadstring or load)(game:HttpGet("https://getnative.cc/script/loader"))()
]=]
            },
            {
                Name = "RIFT HUB",
                Source = [=[
loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
]=]
            },
            {
                Name = "ZENITH HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/rxito/ZenithHub/refs/heads/main/Loader"))()
]=]
            },
            {
                Name = "LUNOR HUB",
                Note = "Key: https://ads.luarmor.net/get_key?for=LinkvertiseAD12_Hours-HhMMjfiZOeFt",
                Source = [=[
script_key = 'Insert Lunor Key Here';
loadstring(game:HttpGet('https://raw.githubusercontent.com/Catto-YFCN/Lunor_Dependencies/refs/heads/main/Loader'))()
]=]
            },
            {
                Name = "MENG HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/GrexXMeng/Mengs/refs/heads/main/library"))()
]=]
            },
        }
    },
    {
        Name = "FISH IT",
        Emoji = "🐟",
        Scripts = {
            {
                Name = "BLESSED HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/mynamewendel-ctrl/Blessed-Hub-X-/refs/heads/main/Fish%20it"))()
]=]
            },
            {
                Name = "NAT HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/ArdyBotzz/NatHub/refs/heads/master/NatHub.lua"))()
]=]
            },
        }
    },
    {
        Name = "FORSAKEN",
        Emoji = "💀",
        Scripts = {
            {
                Name = "LOLNOTAKID",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/LolnotaKid/project/refs/heads/main/obfuscated_script-1758536932336.lua.txt"))()
print("V1")
]=]
            },
            {
                Name = "TSUO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"))()
]=]
            },
            {
                Name = "VOIDWARE",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/refs/heads/main/newforsaken.lua"))()
]=]
            },
            {
                Name = "FORGE HUB",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/d5ed1fbd4301b1d18d75153c5b47181d.lua"))()
]=]
            },
            {
                Name = "FORSAKEN HELPER",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/zxcursedsocute/Forsaken-Script/refs/heads/main/lua"))()
]=]
            },
        }
    },
    {
        Name = "FRUIT BATTLEGROUNDS",
        Emoji = "🍉",
        Scripts = {
            {
                Name = "DEVSEHUB",
                Note = "Key: https://ads.luarmor.net/get_key?for=DevseHUB_KEY-LpxFTiZSpAVU",
                Source = [=[
script_key="replacekey";
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/d92ae761864b636f15e5214d8b9e1b57.lua"))()
]=]
            },
            {
                Name = "IMP HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Hub/refs/heads/main/ImpHub.lua"))()
]=]
            },
        }
    },
    {
        Name = "GRAND PIECE ONLINE",
        Emoji = "⚓",
        Scripts = {
            {
                Name = "SWITCH HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/cloneref/SwitchHubRecode/refs/heads/main/Loader/SwitchHubLoaderAlotGame.lua"))()
]=]
            },
        }
    },
    {
        Name = "GROW A CHICKEN FIGHTER",
        Emoji = "🐔",
        Scripts = {
            {
                Name = "CHIYO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua"))()
]=]
            },
        }
    },
    {
        Name = "GROW A GARDEN",
        Emoji = "🌱",
        Scripts = {
            {
                Name = "BONK HUB",
                Source = [=[
loadstring(game:HttpGet("https://bonkhub.online/loader.lua",true))()
]=]
            },
            {
                Name = "DUPLICAR DINERO",
                Source = [=[
loadstring(game:HttpGet('https://lunor.dev/loader'))()
]=]
            },
            {
                Name = "GUMANBA",
                Source = [=[
loadstring(game:HttpGet('https://lunor.dev/loader'))()
]=]
            },
            {
                Name = "KICIAHOOK",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/kiciahook/kiciahook/refs/heads/main/loader.luau"))()
]=]
            },
            {
                Name = "LUNOR HUB",
                Note = "Key: https://ads.luarmor.net/get_key?for=LinkvertiseAD12_Hours-HhMMjfiZOeFt",
                Source = [=[
script_key = 'Insert Lunor Key Here';
loadstring(game:HttpGet('https://raw.githubusercontent.com/Catto-YFCN/Lunor_Dependencies/refs/heads/main/Loader'))()
]=]
            },
            {
                Name = "NAT HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/ArdyBotzz/NatHub/refs/heads/master/NatHub.lua"))()
]=]
            },
            {
                Name = "NO LAG HUB",
                Source = [=[
loadstring(game:HttpGet("https://rawscripts.net/raw/Grow-a-Garden-NoLag-Hub-no-key-38699"))()
]=]
            },
            {
                Name = "SPEED HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
]=]
            },
            {
                Name = "THUNDAR Z",
                Source = [=[
loadstring(game:HttpGet('https://raw.githubusercontent.com/ThundarZ/Welcome/refs/heads/main/Main/GaG/Main.lua'))()
]=]
            },
            {
                Name = "SOLIX HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
]=]
            },
        }
    },
    {
        Name = "GROW A GARDEN 2",
        Emoji = "🌿",
        Scripts = {
            {
                Name = "CHIYO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua"))()
]=]
            },
            {
                Name = "SPEED HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
]=]
            },
            {
                Name = "GAG2 SPAWNER",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/scripteredwinter/scripts/main/gag2spawner"))()
]=]
            },
            {
                Name = "LUMIN HUB",
                Source = [=[
loadstring(game:HttpGet("http://luminon.top/loader.lua"))()
]=]
            },
            {
                Name = "OMG HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
        }
    },
    {
        Name = "GARDEN TOWER DEFENSE",
        Emoji = "🌻",
        Scripts = {
            {
                Name = "THUNDER HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/NAVAAI098/Thunder-Hub/main/Loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "HAZE SEAS",
        Emoji = "🌁",
        Scripts = {
            {
                Name = "AXEL HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/lostinnowheres/Loader/refs/heads/main/Loader.Lua"))()
]=]
            },
            {
                Name = "OMG HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
        }
    },
    {
        Name = "HUNTY ZOMBIE",
        Emoji = "💀",
        Scripts = {
            {
                Name = "ALCHEMY HUB",
                Source = [=[
loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
]=]
            },
            {
                Name = "CHIYO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua"))()
]=]
            },
            {
                Name = "HUNTY ZOMBIE SCRIPT",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/HuntyZombie"))()
]=]
            },
            {
                Name = "MIRAGE HUB",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/7fde878980fdf87c0e522274f0d1ac3c.lua"))()
]=]
            },
            {
                Name = "SOLIX HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
]=]
            },
            {
                Name = "TYPE HUB",
                Source = [=[
script_key = ""
loadstring(game:HttpGet("https://raw.githubusercontent.com/meobeo8/type/main/Loader"))()
]=]
            },
            {
                Name = "ZEE HUB",
                Source = [=[
loadstring(game:HttpGet("https://zuwz.me/Ls-Zee-Hub-HZ"))()
]=]
            },
        }
    },
    {
        Name = "INK GAME",
        Emoji = "🐙",
        Scripts = {
            {
                Name = "VOID WARE",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/inkgame.lua", true))()
]=]
            },
            {
                Name = "AX SCRIPTS",
                Source = [=[
loadstring(game:HttpGet("https://officialaxscripts.vercel.app/scripts/AX-Loader.lua"))()
]=]
            },
            {
                Name = "RINGTA HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/wefwef34/inkgames.github.io/refs/heads/main/ringta.lua"))()
]=]
            },
        }
    },
    {
        Name = "IRON SOUL",
        Emoji = "🔧",
        Scripts = {
            {
                Name = "NEMESIS HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/loader/main/freeloader.lua", true))()
]=]
            },
            {
                Name = "BIGFROOT",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))()
]=]
            },
        }
    },
    {
        Name = "JAILBREAK",
        Emoji = "🚓",
        Scripts = {
            {
                Name = "SOLIX",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/solixloader/refs/heads/main/solix%20v2%20new%20loader.lua"))()
]=]
            },
            {
                Name = "AUTO ARREST",
                Source = [=[
loadstring(game:HttpGet('http://scripts.projectauto.xyz/AutoArrestV4'))()
]=]
            },
            {
                Name = "AUTOROB",
                Source = [=[
loadstring(game:HttpGet('http://scripts.projectauto.xyz/AutoRobV6'))()
]=]
            },
        }
    },
    {
        Name = "JUJUTSU INFINITE",
        Emoji = "🌀",
        Scripts = {
            {
                Name = "SOLIX HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
]=]
            },
        }
    },
    {
        Name = "JUJUTSU ZERO",
        Emoji = "🔮",
        Scripts = {
            {
                Name = "SIMCA HUB",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3186a4f30fcd853ae613dcbee2534612.lua"))()
]=]
            },
        }
    },
    {
        Name = "KING LEGACY",
        Emoji = "👑",
        Scripts = {
            {
                Name = "ARC HUB",
                Source = [=[
getgenv().RaidUI = false
getgenv().CustomDistance = 10
getgenv().ResetFirstLoad = true
loadstring(game:HttpGet("https://raw.githubusercontent.com/ChopLoris/ArcHub/main/main.lua"))()
]=]
            },
            {
                Name = "OMG HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
            {
                Name = "WUKONG HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/duymanhm6-cyber/wukonghud/refs/heads/main/wukonghud"))()
]=]
            },
            {
                Name = "WUKONG HUD",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/duymanhm6-cyber/wukonghud/refs/heads/main/wukonghud"))()
]=]
            },
            {
                Name = "ZEE HUB",
                Source = [=[
loadstring(game:HttpGet("https://zuwz.me/Ls-Zee-Hub-KL"))()
]=]
            },
        }
    },
    {
        Name = "KICK A LUCKY BLOCK",
        Emoji = "🍀",
        Scripts = {
            {
                Name = "FARTEZ HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/fartez127-design/FARTEZHUB/refs/heads/main/FARTEZHUBXKickaLuckyBlock"))()
]=]
            },
            {
                Name = "CHIYO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua"))()
]=]
            },
        }
    },
    {
        Name = "KAISEN",
        Emoji = "✨",
        Scripts = {
            {
                Name = "NEW OMG HUB 2025",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
        }
    },
    {
        Name = "MINE A MOUNTAIN",
        Emoji = "🗻",
        Scripts = {
            {
                Name = "CHIYO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua"))()
]=]
            },
        }
    },
    {
        Name = "MUSCLE LEGENDS",
        Emoji = "💪",
        Scripts = {
            {
                Name = "AHST Script",
                Source = [=[
loadstring(game:HttpGet("http://antihambreadoscriptteam.github.io/Scripts/NewEra/MuscleLegends.luau"))()
]=]
            },
            {
                Name = "ECLIPSE HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/nocturnalxen/EclipseHubAotr/refs/heads/main/eclipsemain", true))()
]=]
            },
            {
                Name = "SPEED HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
]=]
            },
            {
                Name = "MUSCLE LEGENDS",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/ikzzz1444/Script/main/moonveil2.lua"))()
]=]
            },
        }
    },
    {
        Name = "MURDER MYSTERY",
        Emoji = "🔍",
        Scripts = {
            {
                Name = "AHST Script",
                Source = [=[
loadstring(game:HttpGet("http://antihambreadoscriptteam.github.io/Scripts/NewEra/MM2.luau"))()
]=]
            },
            {
                Name = "MM2 NAVIDAD",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/mm2"))()
]=]
            },
            {
                Name = "FOXNAME MURDER MYSTERY 2",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/xv3gasx/Murder-Mystery-2/refs/heads/main/Release.lua"))()
]=]
            },
            {
                Name = "HONEY LUA",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/ThatSick/HoneyLua/refs/heads/main/Loader.luau"))()
]=]
            },
            {
                Name = "PULSE HUB",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/5857a6cfae3b902eb3c2dff7cdbf173b.lua"))()
]=]
            },
        }
    },
    {
        Name = "NINJA TIMES",
        Emoji = "👺",
        Scripts = {
            {
                Name = "SCYLLA",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/acezqqq/Scylla/refs/heads/main/Loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "NOTORIETY PAYDAY",
        Emoji = "💰",
        Scripts = {
            {
                Name = "XXMZ HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/XScommunity/XXMZ/refs/heads/main/Notoriety"))()
]=]
            },
        }
    },
    {
        Name = "PIGGY",
        Emoji = "🐷",
        Scripts = {
            {
                Name = "STARHACK HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/StarHackScripts/StarHack-Hub-Deepstar-Hub/refs/heads/main/StarHack%20Hub%20-%20Piggy%20Pro%20Hub.txt"))()
]=]
            },
        }
    },
    {
        Name = "PLANTAS VS BRAINROT",
        Emoji = "🌱",
        Scripts = {
            {
                Name = "BLESSED HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/mynamewendel-ctrl/Blessed-Hub-X-/refs/heads/main/Plants-Vs-Brainrots.lua"))()
]=]
            },
            {
                Name = "CHIYO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua"))()
]=]
            },
            {
                Name = "RIFT HUB",
                Source = [=[
loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
]=]
            },
            {
                Name = "SPEED HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
]=]
            },
        }
    },
    {
        Name = "PREHISTORIC FARM",
        Emoji = "🐉",
        Scripts = {
            {
                Name = "OUROBOROS HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "PROJECT SLAYERS 2",
        Emoji = "👊",
        Scripts = {
            {
                Name = "AIRFLOW HUB",
                Source = [=[
loadstring(game:HttpGet("https://airflowscript.com/loader"))()
]=]
            },
            {
                Name = "BIGFROOT HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))()
]=]
            },
        }
    },
    {
        Name = "PROSPECTING",
        Emoji = "💎",
        Scripts = {
            {
                Name = "NUEVO SCRIPT",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/loader/main/games/Prospecting.lua"))()
]=]
            },
        }
    },
    {
        Name = "RAISE A FLOPPA",
        Emoji = "🐈",
        Scripts = {
            {
                Name = "RAISE A FLOPPA SCRIPT",
                Source = [=[
loadstring(game:HttpGet("https://pastebin.com/raw/Fif1YVVR"))()
]=]
            },
        }
    },
    {
        Name = "RAISE ANIMALS",
        Emoji = "🐮",
        Scripts = {
            {
                Name = "TBAO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/refs/heads/main/TbaoHub"))()
]=]
            },
            {
                Name = "JINKX HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/stormskmonkey/JinkX/main/Loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "RIDE A PET",
        Emoji = "🐎",
        Scripts = {
            {
                Name = "OUROBOROS HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "RIVALS",
        Emoji = "🎯",
        Scripts = {
            {
                Name = "SOLIX HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
]=]
            },
        }
    },
    {
        Name = "RNG SLIME",
        Emoji = "💧",
        Scripts = {
            {
                Name = "CHIYO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua"))()
]=]
            },
        }
    },
    {
        Name = "SCRIPTS UNIVERSALES",
        Emoji = "🌐",
        Scripts = {
            {
                Name = "FloppHub",
                Source = [=[
loadstring(game:HttpGet("https://is.gd/JwNMnE"))()
]=]
            },
            {
                Name = "FLYLING SCRIPT",
                Source = [=[
pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/hellohellohell012321/KAWAII-FREAKY-FLING/main/kawaii_freaky_fling.lua",true))()
end)
]=]
            },
        }
    },
    {
        Name = "SMASH PROJECT",
        Emoji = "💥",
        Scripts = {
            {
                Name = "NEXOR HUB",
                Source = [=[
loadstring(game:HttpGet('https://raw.githubusercontent.com/NexorHub/Games/refs/heads/main/Universal/Scripts.lua'))();
]=]
            },
        }
    },
    {
        Name = "STEAL A BRAINROT",
        Emoji = "👾",
        Scripts = {
            {
                Name = "AJJAN",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/onliengamerop/Steal-a-brainrot/refs/heads/main/Protected_3771863424757750.lua.txt"))()
]=]
            },
            {
                Name = "ARBIX TP NUEVO",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Youifpg/Steal-a-Brianrot/refs/heads/main/original_script-obfuscated.lua"))()
]=]
            },
            {
                Name = "CHILLI HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
]=]
            },
            {
                Name = "HOHO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
]=]
            },
            {
                Name = "KENGER HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/iw929wiwiw/KenGerHub/refs/heads/main/Anti%20Hit"))()
]=]
            },
            {
                Name = "LEGENDS BRAINROT",
                Note = "Key: ayam",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Akbar123s/Script-Roblox-/refs/heads/main/nabaruBrainrot"))()
]=]
            },
            {
                Name = "LEMON HUB",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/ffdfeadf0af798741806ea404682a938.lua"))()
]=]
            },
            {
                Name = "LENNON V3",
                Source = [=[
loadstring(game:HttpGet("https://pastefy.app/J3oDjwQ5/raw"))()
]=]
            },
            {
                Name = "LURK HACK V4",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/egor2078f/lurkhackv4/refs/heads/main/main.lua", true))()
]=]
            },
            {
                Name = "MAKAL HUB",
                Source = [=[
local a,b,c=loadstring,(syn and syn.request)or(http and http.request)or(request)or(http_request),assert;c(a and b,"Executor not Supported")a(b({Url="https://makalhub.vercel.app/api/script/loader",Method="GET"}).Body)()
]=]
            },
            {
                Name = "MIRANDAN HUB",
                Source = [=[
loadstring(game:HttpGet("https://pastefy.app/mTbfVy0H/raw", true))()
]=]
            },
            {
                Name = "PUSARX",
                Source = [=[
script_key = ""
loadstring(game:HttpGet("https://raw.githubusercontent.com/Estevansit0/KJJK/refs/heads/main/PusarX-loader.lua"))()
]=]
            },
            {
                Name = "TELEGUIADOS HUB",
                Source = [=[
local Players = game:GetService("Players")
local player = Players.LocalPlayer or Players.PlayerAdded:Wait()

local scriptExecuted = false
local loadedScripts = {}
local function loadScript(url)
    if loadedScripts[url] then return end
    loadedScripts[url] = true
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url, true))()
    end)
    if not success then
        warn("[Failed to load]:", url, result)
    end
end

local pid = game.PlaceId
local specialPlaceIds = {
    [109983668079237] = true,
    [128762245270197] = true,
    [96342491571673] = true
}

if specialPlaceIds[pid] then
    local success1, result1 = pcall(function()
        loadScript("https://gist.githubusercontent.com/UCT-hub/0fd2f8d2fd66882d0f81bd02af9bbdc3/raw/2cdb639b53b455d0192eef961e81d1c4f0a29620/UCTHUB")
    end)
    local success2, result2 = pcall(function()
        loadScript("https://gist.githubusercontent.com/UCT-hub/e2cc5514ebf4f97e8e3bf3ac08b8d862/raw/3c5d4203f927c3ea16215e2c9479eba5fe19fdbc/gistfile1.txt")
    end)

    if not success1 then
        warn("Failed to load Stel script:", result1)
    end
    if not success2 then
        warn("Failed to load Warger script:", result2)
    end
    return
end
]=]
            },
            {
                Name = "TP ARBIX",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Youifpg/Steal-a-Brainrot-op/refs/heads/main/THXZ1N.lua"))()
]=]
            },
            {
                Name = "AUTO BUY DEALER",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/AutoBuyBrainrotDealer/Auto-Buy/refs/heads/main/AutoBuyDealer"))()
]=]
            },
            {
                Name = "UGLYS FISHING",
                Source = [=[
getgenv().SELL_ONLY = {
    ["Trippi Troppi"] = true,
    ["Trulimero Trulicina"] = true,
    ["Bananita Dolphinita"] = true,
    ["Blueberrinni Octopusini"] = true,
    ["Tralalero Tralala"] = true,
    ["Orcalero Orcala"] = true,
    ["Tralalita Tralala"] = true,
    ["Trippi Troppi Troppa Trippa"] = true,
    ["Crabbo Limonetta"] = true,
    ["Los Orcalitos"] = true,
    ["Orcalita Orcala"] = true,
    ["Squalanana"] = true,
    ["Belula Beluga"] = true,
    ["Tentacolo Tecnico"] = true,
    ["Extinct Tralalero"] = true,
    ["Las Tralaleritos"] = true,
    ["Zombie Tralala"] = true,
    ["Boatito Auratito"] = true,
    ["Las Tralaleritas"] = true,
    ["Graipuss Medussi"] = true,
}

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/6de00c2d8f740f73e4ea721a5e533cf6.lua"))()
]=]
            },
            {
                Name = "NAMELESS HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr"))()
]=]
            },
        }
    },
    {
        Name = "BREAK AND STEAL AN EGG",
        Emoji = "🐣",
        Scripts = {
            {
                Name = "SERENITY HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/MUshihara/Serenity-hub/main/loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "STEAL AN EGG",
        Emoji = "🐣",
        Scripts = {
            {
                Name = "CHIYO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua"))()
]=]
            },
            {
                Name = "SOLIX HUB KAITUN",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
]=]
            },
            {
                Name = "BIGFROOT",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))()
]=]
            },
            {
                Name = "OMGHUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
            {
                Name = "CHILLI HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
]=]
            },
        }
    },
    {
        Name = "SHINDO LIFE 2",
        Emoji = "👺",
        Scripts = {
            {
                Name = "IMP HUB",
                Source = [=[
script_key = "";
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/34824c86db1eba5e5e39c7c2d6d7fdfe.lua"))()
]=]
            },
            {
                Name = "SOLIX HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
]=]
            },
            {
                Name = "DZ HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Dexz00/DzHub/refs/heads/main/loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "SOLO HUNTER",
        Emoji = "🎯",
        Scripts = {
            {
                Name = "IMP HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Hub/refs/heads/main/ImpHub.lua"))()
]=]
            },
            {
                Name = "AEONIC HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/mazino45/main/refs/heads/main/MainScript.lua"))()
]=]
            },
            {
                Name = "6FOOT SOLO HUNTER",
                Source = [=[
loadstring(game:HttpGet('https://raw.githubusercontent.com/SlamminPig/6FootScripts/refs/heads/main/Scripts/SoloHunters.lua'))();
]=]
            },
        }
    },
    {
        Name = "SURVIVE LAVA BRAINROT",
        Emoji = "🌋",
        Scripts = {
            {
                Name = "SURVIVE LAVA BRAINROT",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SurviveLAVAforBrainrots"))()
]=]
            },
        }
    },
    {
        Name = "SURVIVE THE APOCALYPSE",
        Emoji = "💀",
        Scripts = {
            {
                Name = "PINAT HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/xploitforceofficial-stack/pinatpublicloader/refs/heads/main/pinatloader.lua"))()
]=]
            },
        }
    },
    {
        Name = "SAILOR PIECE",
        Emoji = "⚓",
        Scripts = {
            {
                Name = "NEW OMG HUB 2025",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
            {
                Name = "SOLIX HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
]=]
            },
            {
                Name = "TAOLAO",
                Source = [=[
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/52d7bb3829a25a2f9b476d1eb84c8d1d4271fda532b61574b926dd7cd2e9d3e9/download"))()
]=]
            },
            {
                Name = "TWVZ",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/ZhangJunZ84/twvzyyds/refs/heads/main/sailorpiece.lua"))()
]=]
            },
            {
                Name = "SPECTRUM HUB",
                Source = [=[
loadstring(game:HttpGet('https://raw.githubusercontent.com/xZPUHigh/Spectrum-Cloud/main/Loader.lua'))()
]=]
            },
            {
                Name = "WUKONG HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/duymanhm6-cyber/wukonghud/refs/heads/main/wukonghud"))()
]=]
            },
            {
                Name = "CHIYO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua"))()
]=]
            },
            {
                Name = "SPEED HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
]=]
            },
        }
    },
    {
        Name = "THE STRONGEST BATTLEGROUNDS",
        Emoji = "👊",
        Scripts = {
            {
                Name = "MINHNHAT HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/minhnhatdepzai8-cloud/MinhNhat-HUB-V5/refs/heads/main/MinhNhatDZ.lua.txt"))()
]=]
            },
            {
                Name = "SANS MOVESET",
                Source = [=[
loadstring(game:HttpGet("https://paste.ee/r/rF9d3"))()
]=]
            },
        }
    },
    {
        Name = "THE FORGE",
        Emoji = "🔨",
        Scripts = {
            {
                Name = "CHIYO HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua"))()
]=]
            },
            {
                Name = "LUNOR HUB",
                Source = [=[
loadstring(game:HttpGet('https://lunor.dev/loader'))()
]=]
            },
            {
                Name = "MIRAGE HUB",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/2075c39b9a5a2e4414c59c93fe8a5f06.lua"))()
]=]
            },
            {
                Name = "BALLA HUB",
                Source = [=[
loadstring(game:HttpGet("https://rblx.gaballa.cc/loader"))()
]=]
            },
            {
                Name = "VOID64BIT (V0ID64BIT)",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/280c3c5ae0ed18010fea0d86c424fdb5.lua"))()
]=]
            },
        }
    },
    {
        Name = "TSUNAMI BRAINROT",
        Emoji = "🌊",
        Scripts = {
            {
                Name = "SPEED HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
]=]
            },
            {
                Name = "EKUVE HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/ekuve/ekuvehub/main/main.lua"))()
]=]
            },
            {
                Name = "TORA IS ME",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"))()
]=]
            },
            {
                Name = "SOLIX HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
]=]
            },
            {
                Name = "LUMIN",
                Source = [=[
loadstring(game:HttpGet("http://luminon.top/loader.lua"))()
]=]
            },
            {
                Name = "AJJAN HUB",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/832af29a13a41951e31129a974a1e8cc.lua"))()
]=]
            },
        }
    },
    {
        Name = "TOWER DEFENSE SIMULATOR",
        Emoji = "🏰",
        Scripts = {
            {
                Name = "IMP HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Hub/refs/heads/main/ImpHub.lua"))()
]=]
            },
        }
    },
    {
        Name = "UNIVERSAL TOWER DEFENSE",
        Emoji = "🏰",
        Scripts = {
            {
                Name = "NOUSIGI HUB",
                Source = [=[
loadstring(game:HttpGet("https://nousigi.com/loader.lua"))()
]=]
            },
        }
    },
    {
        Name = "VOX SEAS",
        Emoji = "🌊",
        Scripts = {
            {
                Name = "FARM DINERO",
                Source = [=[
loadstring(game:HttpGet('https://raw.githubusercontent.com/shakaUnlocked/IiI/refs/heads/main/AutoVoxSeas.lua'))()
]=]
            },
            {
                Name = "LEGEND HUB",
                Source = [=[
loadstring(game:HttpGet("https://pastefy.app/ULaWpxKm/raw"))()
]=]
            },
            {
                Name = "NEXUS HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/CrazyHub123/NexusHubRevival/refs/heads/main/NewLoader.lua"))()
]=]
            },
            {
                Name = "OMG HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
            {
                Name = "SPARKX SCRIPT",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/FloppHub-Team/Scripts-idk/refs/heads/main/Main/Vox%20Seas%20Open%20Source%20Cracked"))()
]=]
            },
            {
                Name = "TYPE HUB",
                Source = [=[
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
script_key = "";
loadstring(game:HttpGet("https://raw.githubusercontent.com/meobeo8/type/main/Loader"))()
]=]
            },
        }
    },
    {
        Name = "WEAK LEGACY",
        Emoji = "🔪",
        Scripts = {
            {
                Name = "L4BIB HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/L4BIBKAZI/L4BIB-HUB/refs/heads/main/Weak%20Legacy%202"))()
]=]
            },
            {
                Name = "NEW OMG HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
]=]
            },
            {
                Name = "WEAK LEGACY SCRIPT",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/OhhMyGehlee/sh/refs/heads/main/a"))()
]=]
            },
        }
    },
    {
        Name = "ANIME APOCALIPSIS",
        Emoji = "🌠",
        Scripts = {
            {
                Name = "AEONIC HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/mazino45/main/refs/heads/main/MainScript.lua"))()
]=]
            },
            {
                Name = "SOLIX HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
]=]
            },
        }
    },
    {
        Name = "WIZARD ARCHEMY",
        Emoji = "🔮",
        Scripts = {
            {
                Name = "AXON HUB",
                Source = [=[
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/97c3f6db55a2cf72141537a85458e5a7.lua"))()
]=]
            },
        }
    },
    {
        Name = "+1 LOOT TO FORGE",
        Emoji = "🔨",
        Scripts = {
            {
                Name = "SELUX HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/seltonmt012/sel01-rbx/main/loader.lua"))()
]=]
            },
            {
                Name = "BIGFROOT HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))()
]=]
            },
        }
    },
    {
        Name = "+1 SPEED KEYBOARD ESCAPE",
        Emoji = "💻",
        Scripts = {
            {
                Name = "1+ SPEED KEYBOARD",
                Source = [=[
loadstring(game:HttpGet("https://antihambreadoscriptteam.github.io/Scripts/KeyboardChocolate.lua"))()
]=]
            },
            {
                Name = "HOSHI HUB",
                Source = [=[
loadstring(game:HttpGet("https://antihambreadoscriptteam.github.io/Scripts/HoshiOnTheShit.html"))()
]=]
            },
            {
                Name = "LUXY HUB",
                Source = [=[
loadstring(game:HttpGet("https://www.luxyhub.space/api/loader/luxyhub"))()
]=]
            },
            {
                Name = "SPEED HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
]=]
            },
        }
    },
    {
        Name = "+1 SPEED MONKEY ESCAPE",
        Emoji = "🐒",
        Scripts = {
            {
                Name = "SPEED HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
]=]
            },
        }
    },
    {
        Name = "ANIME ASTRAL",
        Emoji = "🌌",
        Scripts = {
            {
                Name = "YUTO HUB V3",
                Source = [=[
repeat wait() until game:IsLoaded()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/Binintrozza/yutv2e/main/Yutohub')))()
]=]
            },
        }
    },
    {
        Name = "ANIME DIMENSIONS SIMULATOR",
        Emoji = "🌀",
        Scripts = {
            {
                Name = "SLH HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Yanwanlnwza/SmellLikeHacker/main/Animedimensions.lua"))()
]=]
            },
        }
    },
    {
        Name = "ANIME EXPEDITIONS",
        Emoji = "🌍",
        Scripts = {
            {
                Name = "BIGFROOT HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))()
]=]
            },
        }
    },
    {
        Name = "ANIME ZERO",
        Emoji = "✨",
        Scripts = {
            {
                Name = "BIGFROOT HUB",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))()
]=]
            },
        }
    },
    {
        Name = "MEDVED",
        Emoji = "🐻",
        Scripts = {
            {
                Name = "AHST Script",
                Source = [=[
loadstring(game:HttpGet("https://antihambreadoscriptteam.github.io/Scripts/NewEra/Medved.luau"))()
]=]
            },
        }
    },
    {
        Name = "SURVIVE A MILLION MONKEYS",
        Emoji = "🐒",
        Scripts = {
            {
                Name = "AHST Script",
                Source = [=[
loadstring(game:HttpGet("https://antihambreadoscriptteam.github.io/Scripts/NewEra/Survive-a-Million-Monkeys.luau"))()
]=]
            },
        }
    },
    {
        Name = "ITEM ASYLUM",
        Emoji = "⚔️",
        Scripts = {
            {
                Name = "AHST Script",
                Source = [=[
loadstring(game:HttpGet("http://antihambreadoscriptteam.github.io/Scripts/NewEra/ItemAsylum.luau"))()
]=]
            },
        }
    },
    {
        Name = "SLAP BATTLES",
        Emoji = "👋",
        Scripts = {
            {
                Name = "AHST Script",
                Source = [=[
loadstring(game:HttpGet("http://antihambreadoscriptteam.github.io/Scripts/NewEra/SlapBattles.luau"))()
]=]
            },
        }
    },
    {
        Name = "CRIMINAL TYCOON",
        Emoji = "💰",
        Scripts = {
            {
                Name = "AHST Script",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/FloppHub-Team/Scripts-idk/refs/heads/main/Main/CriminalTycoon.lua"))()
]=]
            },
        }
    },
    {
        Name = "BREAK A LUCKY BLOCK",
        Emoji = "🍀",
        Scripts = {
            {
                Name = "AHST Script",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/FloppHub-Team/Scripts-idk/refs/heads/main/Main/LuckyBrainrot.lua"))()
]=]
            },
        }
    },
    {
        Name = "TOWER OF HELL",
        Emoji = "🗼",
        Scripts = {
            {
                Name = "AHST Script",
                Source = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/FloppHub-Team/Scripts-idk/refs/heads/main/Main/TowerHell.lua"))()
]=]
            },
        }
    },
}

local function RunScript(name, source)
    task.spawn(function()
        local fn, err = loadstring(source)
        if not fn then
            Notify(HubName, "Error al cargar " .. name, 8)
            warn(HubName .. " | " .. name .. " | " .. tostring(err))
            return
        end
        Notify(HubName, "Cargando " .. name, 4)
        local ok, result = pcall(fn)
        if not ok then
            Notify(HubName, "Error al ejecutar " .. name, 8)
            warn(HubName .. " | " .. name .. " | " .. tostring(result))
        end
    end)
end

local HubLoaded = false

local SearchAccents = {
    ["Á"] = "a", ["á"] = "a", ["É"] = "e", ["é"] = "e",
    ["Í"] = "i", ["í"] = "i", ["Ó"] = "o", ["ó"] = "o",
    ["Ú"] = "u", ["ú"] = "u", ["Ü"] = "u", ["ü"] = "u",
    ["Ñ"] = "n", ["ñ"] = "n"
}

local function NormalizeSearch(Text)
    return (Text:gsub("[\194-\244][\128-\191]*", SearchAccents):lower():match("^%s*(.-)%s*$"))
end

local function AddCatalogSearch(DiscordTab, SearchEntries)
    local SearchBox = DiscordTab:AddTextBox({
        Title = "Buscar",
        Placeholder = "Juego o script",
        ClearTextOnFocus = false
    }).TEXTBOX
    local Status = DiscordTab:AddParagraph("")
    Status:SetVisible(false)

    local Matches = {}
    local ResultButtons = {}
    local PendingSearch
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        if PendingSearch then
            task.cancel(PendingSearch)
        end

        PendingSearch = task.delay(0.2, function()
            PendingSearch = nil
            if not SearchBox.Parent then
                return
            end

            local Query = NormalizeSearch(SearchBox.Text)
            table.clear(Matches)
            if Query ~= "" then
                for _, Entry in ipairs(SearchEntries) do
                    if Entry.SearchName:find(Query, 1, true) then
                        table.insert(Matches, Entry)
                    end
                end
            end

            for Index, Entry in ipairs(Matches) do
                local Button = ResultButtons[Index]
                if Button then
                    Button:SetTitle(Entry.Title)
                    Button:SetDescription(Entry.Description)
                    Button:SetVisible(true)
                else
                    ResultButtons[Index] = DiscordTab:AddButton({
                        Title = Entry.Title,
                        Description = Entry.Description,
                        Callback = function()
                            local Match = Matches[Index]
                            if Match then
                                Match.Tab:Select()
                            end
                        end
                    })
                end
            end

            for Index = #Matches + 1, #ResultButtons do
                ResultButtons[Index]:SetVisible(false)
            end

            Status:SetTitle(#Matches > 0 and ("Resultados (%d)"):format(#Matches) or "Sin resultados")
            Status:SetVisible(Query ~= "")
        end)
    end)
end

local function LoadHub()
    if HubLoaded then
        return
    end
    HubLoaded = true

    local ok, Library = pcall(function()
        return loadstring(game:HttpGet(LibraryURL))()
    end)
    if not ok or type(Library) ~= "table" then
        Notify(HubName, "Error al cargar la librería", 10)
        warn(HubName .. " | " .. tostring(Library))
        return
    end

    local Window = Library:MakeWindow({
        Title = Verified .. "┃" .. HubName,
        SubTitle = "Script Hub",
        ScriptFolder = "AHST-Hub"
    })

    Window:Notify({
        Title = HubName,
        Content = Invite,
        Image = "",
        Duration = 10
    })

    local Minimizer = Window:NewMinimizer({
        KeyCode = Enum.KeyCode.LeftControl
    })

    Minimizer:CreateMobileMinimizer({
        Image = Logo,
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Corner = UDim.new(0.5, 0)
    })

    local DiscordTab = Window:MakeTab({Premium .. "┃DISCORD"})
    DiscordTab:AddDiscordInvite({
        Title = HubName,
        Description = Bio,
        Banner = Color3.fromRGB(220, 38, 38),
        Logo = Logo,
        Invite = Invite
    })

    local MainFrame = Window:GetElements().MainFrame
    local ResizeHandle = MainFrame.ControlWindowSize
    local SizeOptions = {"Pequeño", "Mediano", "Grande"}
    local WindowSizes = {
        ["Pequeño"] = UDim2.fromOffset(460, 280),
        Mediano = UDim2.fromOffset(550, 380),
        Grande = UDim2.fromOffset(680, 440)
    }
    local CurrentSize
    for _, Option in ipairs(SizeOptions) do
        if WindowSizes[Option] == MainFrame.Size then
            CurrentSize = Option
            break
        end
    end

    DiscordTab:AddDropdown({
        Title = "Tamaño de la ventana",
        Options = SizeOptions,
        Default = CurrentSize,
        Callback = function(Option)
            local Size = WindowSizes[Option]
            if not Size or Size == MainFrame.Size then
                return
            end

            local PreviousSize = MainFrame.Size
            MainFrame.Position = MainFrame.Position + UDim2.fromOffset(
                (PreviousSize.X.Offset - Size.X.Offset) / 2,
                (PreviousSize.Y.Offset - Size.Y.Offset) / 2
            )
            MainFrame.Size = Size
            ResizeHandle.Position = Size
        end
    })

    table.sort(Games, function(FirstGame, SecondGame)
        return FirstGame.Name < SecondGame.Name
    end)

    local SearchEntries = {}
    for _, Game in ipairs(Games) do
        local TabTitle = Game.Emoji .. "┃" .. Game.Name
        local GameTab = Window:MakeTab({TabTitle})
        GameTab:AddSection(Game.Name)
        table.insert(SearchEntries, {
            Title = TabTitle,
            Description = "Pestaña del juego",
            SearchName = NormalizeSearch(Game.Name),
            Tab = GameTab
        })

        for _, Item in ipairs(Game.Scripts) do
            GameTab:AddButton({
                Title = Item.Name,
                Description = Item.Note,
                Callback = function()
                    RunScript(Item.Name, Item.Source)
                end
            })
            table.insert(SearchEntries, {
                Title = Item.Name,
                Description = Game.Name,
                SearchName = NormalizeSearch(Item.Name),
                Tab = GameTab
            })
        end
    end

    AddCatalogSearch(DiscordTab, SearchEntries)
end

local function ShowDiscordPrompt()
    local Gui = Instance.new("ScreenGui")
    Gui.Name = "AHSTDiscordInvite"
    Gui.ResetOnSpawn = false
    Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Gui.DisplayOrder = 999
    Gui.Parent = GetGuiParent()

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 420, 0, 130)
    Frame.Position = UDim2.new(0.5, -210, 0, -200)
    Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    Frame.BorderSizePixel = 0
    Frame.Parent = Gui

    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 8)
    FrameCorner.Parent = Frame

    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, -50, 0, 25)
    Header.Position = UDim2.new(0, 10, 0, 10)
    Header.Text = "TE HAN INVITADO A UNIRTE A UN SERVIDOR"
    Header.Font = Enum.Font.GothamMedium
    Header.TextSize = 14
    Header.TextColor3 = Color3.fromRGB(178, 129, 255)
    Header.BackgroundTransparency = 1
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Parent = Frame

    local Icon = Instance.new("ImageLabel")
    Icon.Size = UDim2.new(0, 50, 0, 50)
    Icon.Position = UDim2.new(0, 10, 0, 56)
    Icon.AnchorPoint = Vector2.new(0, 0.5)
    Icon.Image = Logo
    Icon.BackgroundTransparency = 1
    Icon.Parent = Frame

    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(1, 0)
    IconCorner.Parent = Icon

    local ServerLabel = Instance.new("TextLabel")
    ServerLabel.Size = UDim2.new(1, -80, 0, 20)
    ServerLabel.Position = UDim2.new(0, 70, 0, 45)
    ServerLabel.Text = HubName
    ServerLabel.Font = Enum.Font.GothamBold
    ServerLabel.TextSize = 18
    ServerLabel.TextColor3 = Color3.fromRGB(228, 222, 255)
    ServerLabel.BackgroundTransparency = 1
    ServerLabel.TextXAlignment = Enum.TextXAlignment.Left
    ServerLabel.Parent = Frame

    local InviteLabel = Instance.new("TextLabel")
    InviteLabel.Size = UDim2.new(1, -80, 0, 20)
    InviteLabel.Position = UDim2.new(0, 70, 0, 65)
    InviteLabel.Text = Bio
    InviteLabel.Font = Enum.Font.Gotham
    InviteLabel.TextSize = 14
    InviteLabel.TextColor3 = Color3.fromRGB(178, 129, 255)
    InviteLabel.BackgroundTransparency = 1
    InviteLabel.TextXAlignment = Enum.TextXAlignment.Left
    InviteLabel.Parent = Frame

    local JoinButton = Instance.new("TextButton")
    JoinButton.Size = UDim2.new(1, -20, 0, 32)
    JoinButton.Position = UDim2.new(0, 10, 1, -42)
    JoinButton.Text = "Unirse (copiar invitación)"
    JoinButton.Font = Enum.Font.GothamMedium
    JoinButton.TextSize = 16
    JoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    JoinButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    JoinButton.AutoButtonColor = false
    JoinButton.Parent = Frame

    local JoinCorner = Instance.new("UICorner")
    JoinCorner.CornerRadius = UDim.new(0, 6)
    JoinCorner.Parent = JoinButton

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Position = UDim2.new(1, -30, 0, 5)
    CloseButton.Text = "X"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 16
    CloseButton.TextColor3 = Color3.fromRGB(228, 228, 228)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseButton.AutoButtonColor = false
    CloseButton.Parent = Frame

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton

    local Info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(Frame, Info, {Position = UDim2.new(0.5, -210, 0.5, -65)}):Play()

    local Closing = false

    local function Close()
        if Closing then
            return
        end
        Closing = true
        local Out = TweenService:Create(Frame, Info, {Position = UDim2.new(0.5, -210, 1.5, 0)})
        Out:Play()
        Out.Completed:Wait()
        Gui:Destroy()
        LoadHub()
    end

    CloseButton.MouseButton1Click:Connect(function()
        task.spawn(Close)
    end)

    JoinButton.MouseButton1Click:Connect(function()
        if Closing then
            return
        end
        if CopyInvite() then
            JoinButton.Text = "¡Invitación copiada!"
            Notify(HubName, "Invitación copiada al portapapeles", 5)
        else
            JoinButton.Text = Invite
        end
        JoinButton.BackgroundColor3 = Color3.fromRGB(31, 31, 39)
        JoinButton.TextColor3 = Color3.fromRGB(178, 129, 255)
        task.wait(1)
        Close()
    end)

    task.delay(30, function()
        if Gui.Parent then
            Close()
        end
    end)
end

Notify(HubName, Invite, 10)
task.wait(1)
ShowDiscordPrompt()
