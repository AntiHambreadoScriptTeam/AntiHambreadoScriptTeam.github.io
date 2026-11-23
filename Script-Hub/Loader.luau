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

local HttpService = game:GetService("HttpService")
local ScriptsURL = "https://antihambreadoscriptteam.github.io/Script-Hub/scripts.json"
local DefaultEmoji = "🎮"

local GameEmojis = {
    ["+1 LOOT TO FORGE"] = "🔨",
    ["+1 SPEED KEYBOARD ESCAPE"] = "💻",
    ["+1 SPEED MONKEY ESCAPE"] = "🐒",
    ["99 NOCHES EN EL BOSQUE"] = "🌲",
    ["ABYSS"] = "🌊",
    ["ANIMAL HOSPITAL"] = "🏥",
    ["ANIME APOCALIPSIS"] = "🌠",
    ["ANIME ASTRAL"] = "🌌",
    ["ANIME DIMENSIONS SIMULATOR"] = "🌀",
    ["ANIME EXPEDITIONS"] = "🌍",
    ["ANIME FIGHTING SIMULADOR"] = "👊",
    ["ANIME FINAL QUESTS"] = "📜",
    ["ANIME GHOST"] = "👻",
    ["ANIME PIECE"] = "⚓",
    ["ANIME VANGUARD"] = "🏰",
    ["ANIME WARRIORS"] = "👊",
    ["ANIME WEAPONS"] = "🔪",
    ["ANIME ZERO"] = "✨",
    ["ARISE CROSSOVER"] = "👊",
    ["ARSENAL"] = "🎯",
    ["ATTACK ON TITAN REVOLUTION"] = "🗿",
    ["BASICALLY FNF: REMIX"] = "🎤",
    ["BEE SWARM SIMULATOR"] = "🐝",
    ["BITE BY NIGHT"] = "🌙",
    ["BIZARRE LINEAGE"] = "⭐",
    ["BLADE BALL"] = "👊",
    ["BLOCK SPIN"] = "🌃",
    ["BLOODMONEY"] = "💉",
    ["BLOX FRUITS"] = "🍈",
    ["BLUE LOCK RIVALS"] = "⚽",
    ["BOB ESPONJA TOWER DEFENSE"] = "🍍",
    ["BRAINROT SEA"] = "🌊",
    ["BREAK A LUCKY BLOCK"] = "🍀",
    ["BREAK AND STEAL AN EGG"] = "🐣",
    ["BROKEN BLADE"] = "🔪",
    ["BUILD A BOAT"] = "⛵",
    ["BUILD A RING FARM"] = "💍",
    ["CATCH 1 BILLION DUCKS"] = "🐤",
    ["CATCH A BRAINROT"] = "👾",
    ["CLOVER TIME"] = "🍀",
    ["CREATURE OF SONARÍA"] = "🐉",
    ["CRIMINAL TYCOON"] = "💰",
    ["DANDY'S WORLD"] = "🌼",
    ["DEAD DEFENSE"] = "💀",
    ["DEAD RAILS"] = "🚂",
    ["DEATH BALL"] = "🔴",
    ["DEMON BLADE"] = "👊",
    ["DEMON FALL"] = "👹",
    ["DIG"] = "🔨",
    ["DOORS"] = "🚪",
    ["DRAGON BALL RAGE"] = "🐉",
    ["DRAGON BLOX"] = "🐲",
    ["DUNGEON LOOTR"] = "💰",
    ["DUNGEON QUEST REBORN"] = "🏰",
    ["EVADE"] = "🏃",
    ["EVOMON"] = "🐾",
    ["FISCH"] = "🎣",
    ["FISH IT"] = "🐟",
    ["FORSAKEN"] = "💀",
    ["FRUIT BATTLEGROUNDS"] = "🍉",
    ["GARDEN TOWER DEFENSE"] = "🌻",
    ["GRAND PIECE ONLINE"] = "⚓",
    ["GROW A CHICKEN FIGHTER"] = "🐔",
    ["GROW A GARDEN"] = "🌱",
    ["GROW A GARDEN 2"] = "🌿",
    ["HAZE SEAS"] = "🌁",
    ["HUNTY ZOMBIE"] = "💀",
    ["INK GAME"] = "🐙",
    ["IRON SOUL"] = "🔧",
    ["ITEM ASYLUM"] = "⚔️",
    ["JAILBREAK"] = "🚓",
    ["JUJUTSU INFINITE"] = "🌀",
    ["JUJUTSU ZERO"] = "🔮",
    ["KAISEN"] = "✨",
    ["KICK A LUCKY BLOCK"] = "🍀",
    ["KING LEGACY"] = "👑",
    ["MEDVED"] = "🐻",
    ["MINE A MOUNTAIN"] = "🗻",
    ["MURDER MYSTERY"] = "🔍",
    ["MUSCLE LEGENDS"] = "💪",
    ["NINJA TIMES"] = "👺",
    ["NOTORIETY PAYDAY"] = "💰",
    ["PIGGY"] = "🐷",
    ["PLANTAS VS BRAINROT"] = "🌱",
    ["PREHISTORIC FARM"] = "🐉",
    ["PROJECT SLAYERS 2"] = "👊",
    ["PROSPECTING"] = "💎",
    ["RAISE A FLOPPA"] = "🐈",
    ["RAISE ANIMALS"] = "🐮",
    ["RIDE A PET"] = "🐎",
    ["RIVALS"] = "🎯",
    ["RNG SLIME"] = "💧",
    ["SAILOR PIECE"] = "⚓",
    ["SCRIPTS UNIVERSALES"] = "🌐",
    ["SHINDO LIFE 2"] = "👺",
    ["SLAP BATTLES"] = "👋",
    ["SMASH PROJECT"] = "💥",
    ["SOLO HUNTER"] = "🎯",
    ["STEAL A BRAINROT"] = "👾",
    ["STEAL AN EGG"] = "🐣",
    ["SURVIVE A MILLION MONKEYS"] = "🐒",
    ["SURVIVE LAVA BRAINROT"] = "🌋",
    ["SURVIVE THE APOCALYPSE"] = "💀",
    ["THE FORGE"] = "🔨",
    ["THE STRONGEST BATTLEGROUNDS"] = "👊",
    ["TOWER DEFENSE SIMULATOR"] = "🏰",
    ["TOWER OF HELL"] = "🗼",
    ["TSUNAMI BRAINROT"] = "🌊",
    ["UNIVERSAL TOWER DEFENSE"] = "🏰",
    ["VOX SEAS"] = "🌊",
    ["WEAK LEGACY"] = "🔪",
    ["WIZARD ARCHEMY"] = "🔮",
}

local function SortByName(First, Second)
    local A, B = string.lower(First.Name), string.lower(Second.Name)
    if A == B then
        return First.Name < Second.Name
    end
    return A < B
end

local function LoadGames()
    local Result = {}
    local ok, data = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(ScriptsURL .. "?t=" .. tostring(os.time())))
    end)
    if not ok or type(data) ~= "table" or type(data.games) ~= "table" then
        Notify(HubName, "No se pudo cargar la lista de scripts", 8)
        warn(HubName .. " | scripts.json | " .. tostring(data))
        return Result
    end
    for GameName, List in pairs(data.games) do
        local Scripts = {}
        if type(List) == "table" then
            for _, Item in ipairs(List) do
                if type(Item) == "table" and type(Item.name) == "string" and type(Item.script) == "string" then
                    table.insert(Scripts, {
                        Name = Item.name,
                        Source = Item.script,
                        Note = type(Item.note) == "string" and Item.note or nil
                    })
                end
            end
        end
        if #Scripts > 0 then
            table.sort(Scripts, SortByName)
            table.insert(Result, {
                Name = GameName,
                Emoji = GameEmojis[GameName] or DefaultEmoji,
                Scripts = Scripts
            })
        end
    end
    table.sort(Result, SortByName)
    return Result
end

local Games = LoadGames()

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

    table.sort(Games, SortByName)

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
