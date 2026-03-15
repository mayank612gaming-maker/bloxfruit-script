-- Moonlight Hub 🌙

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

_G.AutoFarm = false
_G.EnemyMagnet = false
_G.AutoSkill = false

------------------------------------------------
-- GUI
------------------------------------------------

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,250,0,200)
Frame.Position = UDim2.new(0.4,0,0.3,0)
Frame.BackgroundColor3 = Color3.fromRGB(20,30,70)

local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "Moonlight Hub 🌙"
Title.TextColor3 = Color3.fromRGB(150,200,255)
Title.BackgroundTransparency = 1

------------------------------------------------
-- Buttons
------------------------------------------------

local AutoFarmBtn = Instance.new("TextButton")
AutoFarmBtn.Parent = Frame
AutoFarmBtn.Size = UDim2.new(0,200,0,30)
AutoFarmBtn.Position = UDim2.new(0,25,0,50)
AutoFarmBtn.Text = "Auto Farm"

local MagnetBtn = Instance.new("TextButton")
MagnetBtn.Parent = Frame
MagnetBtn.Size = UDim2.new(0,200,0,30)
MagnetBtn.Position = UDim2.new(0,25,0,90)
MagnetBtn.Text = "Enemy Magnet"

local SkillBtn = Instance.new("TextButton")
SkillBtn.Parent = Frame
SkillBtn.Size = UDim2.new(0,200,0,30)
SkillBtn.Position = UDim2.new(0,25,0,130)
SkillBtn.Text = "Auto Skill"

------------------------------------------------
-- Toggle System
------------------------------------------------

AutoFarmBtn.MouseButton1Click:Connect(function()
_G.AutoFarm = not _G.AutoFarm
end)

MagnetBtn.MouseButton1Click:Connect(function()
_G.EnemyMagnet = not _G.EnemyMagnet
end)

SkillBtn.MouseButton1Click:Connect(function()
_G.AutoSkill = not _G.AutoSkill
end)

------------------------------------------------
-- Level Detect
------------------------------------------------

function GetLevel()
return player.Data.Level.Value
end

------------------------------------------------
-- Quest Table (1-700)
------------------------------------------------

local QuestTable = {

{Min=1,Max=10,Quest="BanditQuest1",Enemy="Bandit",Level=1},
{Min=10,Max=15,Quest="JungleQuest",Enemy="Monkey",Level=1},
{Min=15,Max=30,Quest="JungleQuest",Enemy="Gorilla",Level=2},
{Min=30,Max=40,Quest="BuggyQuest1",Enemy="Pirate",Level=1},
{Min=40,Max=60,Quest="BuggyQuest1",Enemy="Brute",Level=2},
{Min=60,Max=75,Quest="DesertQuest",Enemy="Desert Bandit",Level=1},
{Min=75,Max=90,Quest="DesertQuest",Enemy="Desert Officer",Level=2},
{Min=90,Max=120,Quest="SnowQuest",Enemy="Snow Bandit",Level=1},
{Min=120,Max=150,Quest="MarineQuest2",Enemy="Chief Petty Officer",Level=1},
{Min=150,Max=190,Quest="SkyQuest",Enemy="Sky Bandit",Level=1},
{Min=190,Max=250,Quest="PrisonerQuest",Enemy="Prisoner",Level=1},
{Min=250,Max=300,Quest="ColosseumQuest",Enemy="Toga Warrior",Level=1},
{Min=300,Max=375,Quest="MagmaQuest",Enemy="Military Soldier",Level=1},
{Min=375,Max=450,Quest="FishmanQuest",Enemy="Fishman Warrior",Level=1},
{Min=450,Max=525,Quest="SkyExp1Quest",Enemy="God's Guard",Level=1},
{Min=525,Max=625,Quest="SkyExp2Quest",Enemy="Royal Squad",Level=1},
{Min=625,Max=700,Quest="FountainQuest",Enemy="Galley Pirate",Level=1}

}

------------------------------------------------
-- Get Quest
------------------------------------------------

function GetQuest()

local level = GetLevel()

for i,v in pairs(QuestTable) do
if level >= v.Min and level <= v.Max then
return v
end
end

end

------------------------------------------------
-- Auto Quest
------------------------------------------------

function StartQuest()

local quest = GetQuest()

game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
"StartQuest",
quest.Quest,
quest.Level
)

end

------------------------------------------------
-- Enemy Magnet
------------------------------------------------

spawn(function()

while task.wait() do

if _G.EnemyMagnet then

for i,v in pairs(game.Workspace.Enemies:GetChildren()) do

if v:FindFirstChild("HumanoidRootPart") then

v.HumanoidRootPart.CFrame =
character.HumanoidRootPart.CFrame * CFrame.new(0,0,5)

end
end

end
end

end)

------------------------------------------------
-- Auto Skill
------------------------------------------------

spawn(function()

while task.wait() do

if _G.AutoSkill then

game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game)
game:GetService("VirtualInputManager"):SendKeyEvent(true,"X",false,game)
game:GetService("VirtualInputManager"):SendKeyEvent(true,"C",false,game)
game:GetService("VirtualInputManager"):SendKeyEvent(true,"V",false,game)

end
end

end)

------------------------------------------------
-- Auto Farm
------------------------------------------------

spawn(function()

while task.wait() do

if _G.AutoFarm then

StartQuest()

for i,v in pairs(game.Workspace.Enemies:GetChildren()) do

if v:FindFirstChild("HumanoidRootPart") then

character.HumanoidRootPart.CFrame =
v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)

end
end

end
end

end)