-- 1. Configuration
local loaiHatGiong = "Apple" 

-- 2. Find Garden
local vuan = game.Workspace:FindFirstChild("Gardens") 

-- 3. Auto Plant Function
local function autoplant()
    for _, oDat in pairs(vuan:GetChildren()) do
        if oDat:FindFirstChild("Owner") and oDat.Owner.Value == game.Players.LocalPlayer.Name then
            if not oDat:FindFirstChild("Plant") then 
                game:GetService("ReplicatedStorage").Events.PlantSeed:FireServer(oDat, seed)
                task.wait(0.1) 
            end
        end
    end
end

-- 4. Run
autopalnt()
