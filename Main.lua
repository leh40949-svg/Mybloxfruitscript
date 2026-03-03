-- CẤU HÌNH THÔNG TIN SCRIPT
getgenv().ScriptTitle = "DEPZAI HUB"
getgenv().ScriptSubTitle = "V1.00 - ESP & FULL FUNCTION"
getgenv().ScriptImage = "https://i.ibb.co"
getgenv().ScriptAuthorName = "vanhoang"
getgenv().ScriptAuthorSubTitle = "Developer"

-- TẢI THƯ VIỆN GIAO DIỆN
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com"))()
local Window = Library:CreateWindow()

-- ==========================================
-- HÀM HỖ TRỢ ESP (VẼ KHUNG/CHỮ)
-- ==========================================
local function CreateESP(parent, name, color)
    if parent:FindFirstChild("ESP_Tag") then parent.ESP_Tag:Destroy() end
    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "ESP_Tag"
    Billboard.Adornee = parent
    Billboard.Size = UDim2.new(0, 100, 0, 50)
    Billboard.AlwaysOnTop = true
    Billboard.ExtentsOffset = Vector3.new(0, 3, 0)
    Billboard.Parent = parent

    local TextLabel = Instance.new("TextLabel")
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Text = name
    TextLabel.TextColor3 = color
    TextLabel.TextScaled = true
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.Parent = Billboard
end

-- ==========================================
-- TAB 4: VISUALS (ESP - NHÌN XUYÊN TƯỜNG)
-- ==========================================
local VisualsTab = Window:CreateTab("Visuals")

-- 1. ESP Người chơi (Player ESP)
VisualsTab:CreateToggle("Player ESP", function(state)
    getgenv().PlayerESP = state
    spawn(function()
        while getgenv().PlayerESP do
            task.wait(1)
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v ~= game.Players.LocalPlayer then
                    CreateESP(v.Character.HumanoidRootPart, v.Name, Color3.fromRGB(255, 0, 0))
                end
            end
        end
        -- Xóa ESP khi tắt
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character.HumanoidRootPart:FindFirstChild("ESP_Tag") then
                v.Character.HumanoidRootPart.ESP_Tag:Destroy()
            end
        end
    end)
end)

-- 2. ESP Trái ác quỷ (Fruit ESP)
VisualsTab:CreateToggle("Fruit ESP", function(state)
    getgenv().FruitESP = state
    spawn(function()
        while getgenv().FruitESP do
            task.wait(1)
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("Tool") or (v:IsA("Model") and string.find(v.Name, "Fruit")) then
                    CreateESP(v, "🍎 " .. v.Name, Color3.fromRGB(255, 255, 0))
                end
            end
        end
    end)
end)

-- 3. ESP Quái vật (Island/Chest ESP)
VisualsTab:CreateToggle("Chest ESP", function(state)
    getgenv().ChestESP = state
    spawn(function()
        while getgenv().ChestESP do
            task.wait(1)
            for _, v in pairs(game.Workspace:GetChildren()) do
                if string.find(v.Name, "Chest") then
                    CreateESP(v, "💰 Chest", Color3.fromRGB(0, 255, 0))
                end
            end
        end
    end)
end)

-- ==========================================
-- CÁC TAB KHÁC (GIỮ NGUYÊN NHƯ CŨ)
-- ==========================================
local FarmTab = Window:CreateTab("Auto Farm")
-- (Thêm các nút Farm của bạn vào đây như hướng dẫn trước)

local MiscTab = Window:CreateTab("Misc")
MiscTab:CreateButton("Redeem Codes", function()
    -- Code nhập mã ở đây
end)

print("DEPZAI HUB ESP Loaded!")

