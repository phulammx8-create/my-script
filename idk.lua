-- 1. Configuration
local seedName = "Bamboo" -- Change to "Apple", "Corn", etc.
local plantDistance = 25 -- Maximum range to plant from your character

-- 2. Services
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer

-- 3. Get All Garden Plots
-- We dynamic scan Workspace to find where the game stores the dirt plots
local plotsFolder = workspace:FindFirstChild("Plots") or workspace:FindFirstChild("Gardens") or workspace:FindFirstChild("PlotsFolder")

-- 4. Main Auto Plant Function
local function plantLeftGardenOnly()
    local character = localPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local myPos = character.HumanoidRootPart.Position

    if plotsFolder then
        for _, plot in pairs(plotsFolder:GetChildren()) do
            -- Step A: Check if the plot is empty and has a Position
            if plot:IsA("BasePart") and not plot:FindFirstChild("Plant") then
                
                -- Step B: Distance Check (Ensure you are standing nearby)
                local distance = (plot.Position - myPos).Magnitude
                if distance <= plantDistance then
                    
                    -- Step C: LEFT SIDE FILTER (Crucial Step!)
                    -- In Roblox, we check the relative X axis. 
                    -- If the plot's X position is smaller than your position, it is on your LEFT.
                    if plot.Position.X < myPos.X then
                        
                        -- Step D: Fire the RemoteEvent to plant the seed
                        -- Based on standard Grow a Garden 2 network remotes
                        local plantEvent = replicatedStorage:FindFirstChild("PlantSeed", true) or replicatedStorage:FindFirstChild("Plant", true)
                        
                        if plantEvent then
                            plantEvent:FireServer(plot, seedName)
                            task.wait(0.1) -- Anti-kick delay
                        end
                    end
                end
            end
        end
    end
end

-- 5. Loop Execution
-- This will run continuously every 1 second
while task.wait(1) do
    plantLeftGardenOnly()
end
