loadstring(game:HttpGet("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua"))()

local Window = MakeWindow({
  Hub = {
    Title = "Aoyama x Nhật Anh",
    Animation = "Sủa Cái Chó Gì"
  },
  Key = {
    KeySystem = false,
    Title = "Key System",
    Description = "",
    KeyLink = "",
    Keys = {"1234"},
    Notifi = {
      Notifications = true,
      CorrectKey = "Running the Script...",
      Incorrectkey = "The key is incorrect",
      CopyKeyLink = "Copied to Clipboard"
    }
  }
})

MinimizeButton({
  Image = "http://www.roblox.com/asset/?id=128933802535491",
  Size = {60, 60},
  Color = Color3.fromRGB(10, 10, 10),
  Corner = true,
  Stroke = false,
  StrokeColor = Color3.fromRGB(255, 0, 0)
})

-- Tab Gacha
local Tab1 = MakeTab({Name = "Gacha"})
local autoRoll = false

AddToggle(Tab1, {
  Name = "Auto Roll Gacha",
  Default = false,
  Callback = function(state)
    autoRoll = state
    if state then
      task.spawn(function()
        while autoRoll do
          pcall(function()
            game:GetService("ReplicatedStorage").Remotes.Roll:InvokeServer()
          end)
          wait(1)
        end
      end)
    end
  end
})

-- Tab Combat
local CombatTab = MakeTab({Name = "Combat"})
local autoCombat = false
local autoDungeon = false
local killMobs = false
local flyOnTop = false -- biến cho chức năng đứng trên không

-- Auto Combat Max Speed
AddToggle(CombatTab, {
  Name = "Auto Combat MAX SPEED",
  Default = false,
  Callback = function(state)
    autoCombat = state
    if state then
      task.spawn(function()
        while autoCombat do
          pcall(function()
            for _ = 1, 20 do
              game:GetService("ReplicatedStorage").Remotes.Combat:FireServer({})
            end
          end)
          task.wait()
        end
      end)
    end
  end
})

-- Auto Start Dungeon
AddToggle(CombatTab, {
  Name = "Auto Start Dungeon",
  Default = false,
  Callback = function(state)
    autoDungeon = state
    if state then
      task.spawn(function()
        while autoDungeon do
          pcall(function()
            game:GetService("ReplicatedStorage").Remotes.DungeonStart:FireServer({})
          end)
          wait(5)
        end
      end)
    end
  end
})

-- Quái Tự Chết
AddToggle(CombatTab, {
  Name = "Quái Tự Chết",
  Default = false,
  Callback = function(state)
    killMobs = state
    if state then
      task.spawn(function()
        while killMobs do
          pcall(function()
            for _, mob in pairs(workspace.Mobs:GetChildren()) do
              if mob:FindFirstChild("Humanoid") then
                mob.Humanoid.Health = 0
              elseif mob:FindFirstChild("AI") then
                mob.AI:Destroy()
              end
            end
          end)
          wait(0.2)
        end
      end)
    end
  end
})

-- Đứng Trên Không (thêm vào Combat tab)
AddToggle(CombatTab, {
  Name = "Đứng Trên Không",
  Default = false,
  Callback = function(state)
    flyOnTop = state
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local spawn = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("DoubleDungeonD") and workspace.Map.DoubleDungeonD:FindFirstChild("SpawnLocation")

    if state then
      if spawn then
        hrp.CFrame = spawn.CFrame + Vector3.new(0, 35, 0)
        if char:FindFirstChild("Humanoid") then
          char.Humanoid.PlatformStand = true
        end
        hrp.Anchored = true
      end
    else
      if hrp then
        hrp.Anchored = false
        if char:FindFirstChild("Humanoid") then
          char.Humanoid.PlatformStand = false
        end
      end
    end
  end
})

-- Anti AFK (tự bật)
task.spawn(function()
  local vu = game:GetService("VirtualUser")
  game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
  end)
end)