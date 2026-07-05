-- 1. Cấu hình loại hạt giống bạn muốn trồng
local loaiHatGiong = "Apple" -- Thay bằng tên hạt giống bạn có (ví dụ: Carrot, Tomato...)

-- 2. Xác định vị trí khu vườn của bạn
-- (Game thường lưu các ô đất trong Workspace dưới tên của bạn hoặc một folder chung)
local vuan = game.Workspace:FindFirstChild("Gardens") -- Hoặc Workspace.Plots tùy theo cấu trúc game

-- 3. Hàm tự động trồng cây
local function tuDongTrongCay()
    -- Vòng lặp quét qua tất cả các ô đất (Plot) trong vườn
    for _, oDat in pairs(vuan:GetChildren()) do
        -- Kiểm tra xem ô đất đó có phải của bạn không (hoặc ô đất trống)
        -- Và kiểm tra xem ô đất đó đã trồng cây chưa
        if oDat:FindFirstChild("Owner") and oDat.Owner.Value == game.Players.LocalPlayer.Name then
            if not oDat:FindFirstChild("Plant") then 
                
                -- Kích hoạt lệnh trồng cây của game (RemoteEvent)
                -- Lưu ý: Đường dẫn ReplicatedStorage này có thể thay đổi tùy theo cách nhà phát triển đặt tên
                game:GetService("ReplicatedStorage").Events.PlantSeed:FireServer(oDat, loaiHatGiong)
                
                -- Nghỉ một chút để tránh bị game kích do gửi lệnh quá nhanh (Anti-cheat)
                task.wait(0.1) 
            end
        end
    end
end

-- 4. Chạy hàm trồng cây
tuDongTrongCay()
