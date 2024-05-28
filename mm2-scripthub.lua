local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
--------------------------------------------------------------------------------------------------------------------------------------------
local Window = Fluent:CreateWindow({
    --ai skid thì nhớ đổi tên =)
    --táo hub , aniee hub :>
    Title = "Came Hub",
    SubTitle = "Version 2",
    TabWidth = 160,
    Size = UDim2.fromOffset(530, 350),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.End -- Used when theres no MinimizeKeybind
})
local Tabs = {
    Main = Window:AddTab({ Title = "Main Farm", Icon = "home" }),
}
local Options = Fluent.Options
do
--------------------------------------------------------------------------------------------------------------------------------------------
function AntiBan()
    for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
        if v:IsA("LocalScript") then
            if v.Name == "General" or v.Name == "Shiftlock"  or v.Name == "FallDamage" or v.Name == "4444" or v.Name == "CamBob" or v.Name == "JumpCD" or v.Name == "Looking" or v.Name == "Run" then
                v:Destroy()
            end
        end
     end
     for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerScripts:GetDescendants()) do
        if v:IsA("LocalScript") then
            if v.Name == "RobloxMotor6DBugFix" or v.Name == "Clans"  or v.Name == "Codes" or v.Name == "CustomForceField" or v.Name == "MenuBloodSp"  or v.Name == "PlayerList" then
                v:Destroy()
            end
        end
     end
    end
    AntiBan()
-------------------------------------------------------------------------------------------------------------------------------------------
------// MURDER MYSTERY 2

-------Main
--Click ESP
function FindPlayer(Txt)
	local ps = { }
	for _, v in next, Plrs:GetPlayers() do
		if string.lower(string.sub(v.Name, 1, string.len(Txt))) == string.lower(Txt) then
			table.insert(ps, v)
		end
	end

	if #ps == 1 then
		if ps[1] ~= MyPlr then
			return ps[1]
		else
			return nil
		end
	else
		return nil
	end
end

function UpdateESP(Plr)
	if Plr ~= nil then
		local Find = PlayerESP:FindFirstChild("ESP Crap_" .. Plr.Name)
		if Find then
			local PickColor = GetTeamColor(Plr)
			Find.Frame.Names.TextColor3 = PickColor
			Find.Frame.Dist.TextColor3 = PickColor
			Find.Frame.Health.TextColor3 = PickColor
			--Find.Frame.Pos.TextColor3 = PickColor
			local GetChar = Plr.Character
			if MyChar and GetChar then
				local Find2 = MyChar:FindFirstChild("HumanoidRootPart")
				local Find3 = GetChar:FindFirstChild("HumanoidRootPart")
				local Find4 = GetChar:FindFirstChildOfClass("Humanoid")
				if Find2 and Find3 then
					local pos = Find3.Position
					local Dist = (Find2.Position - pos).magnitude
					if Dist > Bullshit.ESPLength or Bullshit.Blacklist[Plr.Name] then
						Find.Frame.Names.Visible = false
						Find.Frame.Dist.Visible = false
						Find.Frame.Health.Visible = false
						return
					else
						Find.Frame.Names.Visible = true
						Find.Frame.Dist.Visible = true
						Find.Frame.Health.Visible = true
					end
					Find.Frame.Dist.Text = "Distance: " .. string.format("%.0f", Dist)
					--Find.Frame.Pos.Text = "(X: " .. string.format("%.0f", pos.X) .. ", Y: " .. string.format("%.0f", pos.Y) .. ", Z: " .. string.format("%.0f", pos.Z) .. ")"
					if Find4 then
						Find.Frame.Health.Text = "Health: " .. string.format("%.0f", Find4.Health)
					else
						Find.Frame.Health.Text = ""
					end
				end
			end
		end
	end
end

function RemoveESP(Obj)
	if Obj ~= nil then
		local IsPlr = Obj:IsA("Player")
		local UseFolder = ItemESP
		if IsPlr then UseFolder = PlayerESP end

		local FindESP = ((IsPlr) and UseFolder:FindFirstChild("ESP Crap_" .. Obj.Name)) or FindESP(Obj)
		if FindESP then
			FindESP:Destroy()
		end
	end
end

function CreateESP(Obj)
	if Obj ~= nil then
		local IsPlr = Obj:IsA("Player")
		local UseFolder = ItemESP
		local GetChar = ((IsPlr) and Obj.Character) or Obj
		local Head = GetChar:FindFirstChild("Head")
		local t = tick()
		if IsPlr then UseFolder = PlayerESP end
		if Head == nil then
			repeat
				Head = GetChar:FindFirstChild("Head")
				wait()
			until Head ~= nil or (tick() - t) >= 10
		end
		if Head == nil then return end
		
		local bb = Instance.new("BillboardGui")
		bb.Adornee = Head
		bb.ExtentsOffset = Vector3.new(0, 1, 0)
		bb.AlwaysOnTop = true
		bb.Size = UDim2.new(0, 5, 0, 5)
		bb.StudsOffset = Vector3.new(0, 3, 0)
		bb.Name = "ESP Crap_" .. Obj.Name
		bb.Parent = UseFolder
		
		local frame = Instance.new("Frame", bb)
		frame.ZIndex = 10
		frame.BackgroundTransparency = 1
		frame.Size = UDim2.new(1, 0, 1, 0)
		
		local TxtName = Instance.new("TextLabel", frame)
		TxtName.Name = "Names"
		TxtName.ZIndex = 10
		TxtName.Text = Obj.Name
		TxtName.BackgroundTransparency = 1
		TxtName.Position = UDim2.new(0, 0, 0, -45)
		TxtName.Size = UDim2.new(1, 0, 10, 0)
		TxtName.Font = "SourceSansBold"
		TxtName.TextSize = 13
		TxtName.TextStrokeTransparency = 0.5

		local TxtDist = nil
		local TxtHealth = nil
		if IsPlr then
			TxtDist = Instance.new("TextLabel", frame)
			TxtDist.Name = "Dist"
			TxtDist.ZIndex = 10
			TxtDist.Text = ""
			TxtDist.BackgroundTransparency = 1
			TxtDist.Position = UDim2.new(0, 0, 0, -35)
			TxtDist.Size = UDim2.new(1, 0, 10, 0)
			TxtDist.Font = "SourceSansBold"
			TxtDist.TextSize = 13
			TxtDist.TextStrokeTransparency = 0.5

			TxtHealth = Instance.new("TextLabel", frame)
			TxtHealth.Name = "Health"
			TxtHealth.ZIndex = 10
			TxtHealth.Text = ""
			TxtHealth.BackgroundTransparency = 1
			TxtHealth.Position = UDim2.new(0, 0, 0, -25)
			TxtHealth.Size = UDim2.new(1, 0, 10, 0)
			TxtHealth.Font = "SourceSansBold"
			TxtHealth.TextSize = 13
			TxtHealth.TextStrokeTransparency = 0.5
		else
			local ObjVal = Instance.new("ObjectValue", bb)
			ObjVal.Value = Obj
		end
		
		local PickColor = GetTeamColor(Obj) or Bullshit.Colors.Neutral
		TxtName.TextColor3 = PickColor

		if IsPlr then
			TxtDist.TextColor3 = PickColor
			TxtHealth.TextColor3 = PickColor
		end
	end
end
--Click Player
local Players = { }
	local CurrentClosePlayer = nil
	local SelectedPlr = nil

	for _, v in next, Plrs:GetPlayers() do
		if v ~= MyPlr and not Bullshit.Blacklist[v.Name] then
			local IsAlly = GetTeamColor(v)
			if IsAlly ~= Bullshit.Colors.Ally and IsAlly ~= Bullshit.Colors.Friend and IsAlly ~= Bullshit.Colors.Neutral then
				local GetChar = v.Character
				if MyChar and GetChar then
					local MyHead, MyTor = MyChar:FindFirstChild("Head"), MyChar:FindFirstChild("HumanoidRootPart")
					local GetHead, GetTor, GetHum = GetChar:FindFirstChild("Head"), GetChar:FindFirstChild("HumanoidRootPart"), GetChar:FindFirstChild("Humanoid")

					if MyHead and MyTor and GetHead and GetTor and GetHum then
						if game.PlaceId == 455366377 then
							if not GetChar:FindFirstChild("KO") and GetHum.Health > 1 then
								local Ray = Ray.new(MyCam.CFrame.p, (GetHead.Position - MyCam.CFrame.p).unit * 2048)
								local part = workspace:FindPartOnRayWithIgnoreList(Ray, {MyChar})
								if part ~= nil then
									if part:IsDescendantOf(GetChar) then
										local Dist = (MyTor.Position - GetTor.Position).magnitude
										Players[v] = Dist
									end
								end
							end
						elseif game.PlaceId == 746820961 then
							if GetHum.Health > 1 then
								local Ray = Ray.new(MyCam.CFrame.p, (GetHead.Position - MyCam.CFrame.p).unit * 2048)
								local part = workspace:FindPartOnRayWithIgnoreList(Ray, {MyChar, MyCam})
								if part ~= nil then
									if part:IsDescendantOf(GetChar) then
										local Dist = (MyTor.Position - GetTor.Position).magnitude
										Players[v] = Dist
									end
								end
							end
						else
							if GetHum.Health > 1 then
								local Ray = Ray.new(MyCam.CFrame.p, (GetHead.Position - MyCam.CFrame.p).unit * 2048)
								local part = workspace:FindPartOnRayWithIgnoreList(Ray, {MyChar})
								if part ~= nil then
									if part:IsDescendantOf(GetChar) then
										local Dist = (MyTor.Position - GetTor.Position).magnitude
										Players[v] = Dist
									end
								end
							end
						end
					end
				end
			end
		end
	end

	for i, v in next, Players do
		if CurrentClosePlayer ~= nil then
			if v <= CurrentClosePlayer then
				CurrentClosePlayer = v
				SelectedPlr = i
			end
		else
			CurrentClosePlayer = v
			SelectedPlr = i
		end
	end
	
	return SelectedPlr
end

function GetClosestPlayer()
	local Players = { }
	local CurrentClosePlayer = nil
	local SelectedPlr = nil
	
	for _, v in next, Plrs:GetPlayers() do
		if v ~= MyPlr then
			local IsAlly = GetTeamColor(v)
			if IsAlly ~= Bullshit.Colors.Ally and IsAlly ~= Bullshit.Colors.Friend and IsAlly ~= Bullshit.Colors.Neutral then
				local GetChar = v.Character
				if MyChar and GetChar then
					local MyTor = MyChar:FindFirstChild("HumanoidRootPart")
					local GetTor = GetChar:FindFirstChild("HumanoidRootPart")
					local GetHum = GetChar:FindFirstChild("Humanoid")
					if MyTor and GetTor and GetHum then
						if game.PlaceId == 455366377 then
							if not GetChar:FindFirstChild("KO") and GetHum.Health > 1 then
								local Dist = (MyTor.Position - GetTor.Position).magnitude
								Players[v] = Dist
							end
						else
							if GetHum.Health > 1 then
								local Dist = (MyTor.Position - GetTor.Position).magnitude
								Players[v] = Dist
							end
						end
					end
				end
			end
		end
	end
	
	for i, v in next, Players do
		if CurrentClosePlayer ~= nil then
			if v <= CurrentClosePlayer then
				CurrentClosePlayer = v
				SelectedPlr = i
			end
		else
			CurrentClosePlayer = v
			SelectedPlr = i
		end
	end
	
	return SelectedPlr
end

function FindPlayer(Txt)
	local ps = { }
	for _, v in next, Plrs:GetPlayers() do
		if string.lower(string.sub(v.Name, 1, string.len(Txt))) == string.lower(Txt) then
			table.insert(ps, v)
		end
	end

	if #ps == 1 then
		if ps[1] ~= MyPlr then
			return ps[1]
		else
			return nil
		end
	else
		return nil
	end
end
--Click EPS2
function UpdateESP(Plr)
	if Plr ~= nil then
		local Find = PlayerESP:FindFirstChild("ESP Crap_" .. Plr.Name)
		if Find then
			local PickColor = GetTeamColor(Plr)
			Find.Frame.Names.TextColor3 = PickColor
			Find.Frame.Dist.TextColor3 = PickColor
			Find.Frame.Health.TextColor3 = PickColor
			--Find.Frame.Pos.TextColor3 = PickColor
			local GetChar = Plr.Character
			if MyChar and GetChar then
				local Find2 = MyChar:FindFirstChild("HumanoidRootPart")
				local Find3 = GetChar:FindFirstChild("HumanoidRootPart")
				local Find4 = GetChar:FindFirstChildOfClass("Humanoid")
				if Find2 and Find3 then
					local pos = Find3.Position
					local Dist = (Find2.Position - pos).magnitude
					if Dist > Bullshit.ESPLength or Bullshit.Blacklist[Plr.Name] then
						Find.Frame.Names.Visible = false
						Find.Frame.Dist.Visible = false
						Find.Frame.Health.Visible = false
						return
					else
						Find.Frame.Names.Visible = true
						Find.Frame.Dist.Visible = true
						Find.Frame.Health.Visible = true
					end
					Find.Frame.Dist.Text = "Distance: " .. string.format("%.0f", Dist)
					--Find.Frame.Pos.Text = "(X: " .. string.format("%.0f", pos.X) .. ", Y: " .. string.format("%.0f", pos.Y) .. ", Z: " .. string.format("%.0f", pos.Z) .. ")"
					if Find4 then
						Find.Frame.Health.Text = "Health: " .. string.format("%.0f", Find4.Health)
					else
						Find.Frame.Health.Text = ""
					end
				end
			end
		end
	end
end

function RemoveESP(Obj)
	if Obj ~= nil then
		local IsPlr = Obj:IsA("Player")
		local UseFolder = ItemESP
		if IsPlr then UseFolder = PlayerESP end

		local FindESP = ((IsPlr) and UseFolder:FindFirstChild("ESP Crap_" .. Obj.Name)) or FindESP(Obj)
		if FindESP then
			FindESP:Destroy()
		end
	end
end

function CreateESP(Obj)
	if Obj ~= nil then
		local IsPlr = Obj:IsA("Player")
		local UseFolder = ItemESP
		local GetChar = ((IsPlr) and Obj.Character) or Obj
		local Head = GetChar:FindFirstChild("Head")
		local t = tick()
		if IsPlr then UseFolder = PlayerESP end
		if Head == nil then
			repeat
				Head = GetChar:FindFirstChild("Head")
				wait()
			until Head ~= nil or (tick() - t) >= 10
		end
		if Head == nil then return end
		
		local bb = Instance.new("BillboardGui")
		bb.Adornee = Head
		bb.ExtentsOffset = Vector3.new(0, 1, 0)
		bb.AlwaysOnTop = true
		bb.Size = UDim2.new(0, 5, 0, 5)
		bb.StudsOffset = Vector3.new(0, 3, 0)
		bb.Name = "ESP Crap_" .. Obj.Name
		bb.Parent = UseFolder
		
		local frame = Instance.new("Frame", bb)
		frame.ZIndex = 10
		frame.BackgroundTransparency = 1
		frame.Size = UDim2.new(1, 0, 1, 0)
		
		local TxtName = Instance.new("TextLabel", frame)
		TxtName.Name = "Names"
		TxtName.ZIndex = 10
		TxtName.Text = Obj.Name
		TxtName.BackgroundTransparency = 1
		TxtName.Position = UDim2.new(0, 0, 0, -45)
		TxtName.Size = UDim2.new(1, 0, 10, 0)
		TxtName.Font = "SourceSansBold"
		TxtName.TextSize = 13
		TxtName.TextStrokeTransparency = 0.5

		local TxtDist = nil
		local TxtHealth = nil
		if IsPlr then
			TxtDist = Instance.new("TextLabel", frame)
			TxtDist.Name = "Dist"
			TxtDist.ZIndex = 10
			TxtDist.Text = ""
			TxtDist.BackgroundTransparency = 1
			TxtDist.Position = UDim2.new(0, 0, 0, -35)
			TxtDist.Size = UDim2.new(1, 0, 10, 0)
			TxtDist.Font = "SourceSansBold"
			TxtDist.TextSize = 13
			TxtDist.TextStrokeTransparency = 0.5

			TxtHealth = Instance.new("TextLabel", frame)
			TxtHealth.Name = "Health"
			TxtHealth.ZIndex = 10
			TxtHealth.Text = ""
			TxtHealth.BackgroundTransparency = 1
			TxtHealth.Position = UDim2.new(0, 0, 0, -25)
			TxtHealth.Size = UDim2.new(1, 0, 10, 0)
			TxtHealth.Font = "SourceSansBold"
			TxtHealth.TextSize = 13
			TxtHealth.TextStrokeTransparency = 0.5
		else
			local ObjVal = Instance.new("ObjectValue", bb)
			ObjVal.Value = Obj
		end
		
		local PickColor = GetTeamColor(Obj) or Bullshit.Colors.Neutral
		TxtName.TextColor3 = PickColor

		if IsPlr then
			TxtDist.TextColor3 = PickColor
			TxtHealth.TextColor3 = PickColor
		end
	end
end
--Click NAME PLAYER
function GetClosestPlayerNotBehindWall()
	local Players = { }
	local CurrentClosePlayer = nil
	local SelectedPlr = nil

	for _, v in next, Plrs:GetPlayers() do
		if v ~= MyPlr and not Bullshit.Blacklist[v.Name] then
			local IsAlly = GetTeamColor(v)
			if IsAlly ~= Bullshit.Colors.Ally and IsAlly ~= Bullshit.Colors.Friend and IsAlly ~= Bullshit.Colors.Neutral then
				local GetChar = v.Character
				if MyChar and GetChar then
					local MyHead, MyTor = MyChar:FindFirstChild("Head"), MyChar:FindFirstChild("HumanoidRootPart")
					local GetHead, GetTor, GetHum = GetChar:FindFirstChild("Head"), GetChar:FindFirstChild("HumanoidRootPart"), GetChar:FindFirstChild("Humanoid")

					if MyHead and MyTor and GetHead and GetTor and GetHum then
						if game.PlaceId == 455366377 then
							if not GetChar:FindFirstChild("KO") and GetHum.Health > 1 then
								local Ray = Ray.new(MyCam.CFrame.p, (GetHead.Position - MyCam.CFrame.p).unit * 2048)
								local part = workspace:FindPartOnRayWithIgnoreList(Ray, {MyChar})
								if part ~= nil then
									if part:IsDescendantOf(GetChar) then
										local Dist = (MyTor.Position - GetTor.Position).magnitude
										Players[v] = Dist
									end
								end
							end
						elseif game.PlaceId == 746820961 then
							if GetHum.Health > 1 then
								local Ray = Ray.new(MyCam.CFrame.p, (GetHead.Position - MyCam.CFrame.p).unit * 2048)
								local part = workspace:FindPartOnRayWithIgnoreList(Ray, {MyChar, MyCam})
								if part ~= nil then
									if part:IsDescendantOf(GetChar) then
										local Dist = (MyTor.Position - GetTor.Position).magnitude
										Players[v] = Dist
									end
								end
							end
						else
							if GetHum.Health > 1 then
								local Ray = Ray.new(MyCam.CFrame.p, (GetHead.Position - MyCam.CFrame.p).unit * 2048)
								local part = workspace:FindPartOnRayWithIgnoreList(Ray, {MyChar})
								if part ~= nil then
									if part:IsDescendantOf(GetChar) then
										local Dist = (MyTor.Position - GetTor.Position).magnitude
										Players[v] = Dist
									end
								end
							end
						end
					end
				end
			end
		end
	end

	for i, v in next, Players do
		if CurrentClosePlayer ~= nil then
			if v <= CurrentClosePlayer then
				CurrentClosePlayer = v
				SelectedPlr = i
			end
		else
			CurrentClosePlayer = v
			SelectedPlr = i
		end
	end
	
	return SelectedPlr
end

function GetClosestPlayer()
	local Players = { }
	local CurrentClosePlayer = nil
	local SelectedPlr = nil
	
	for _, v in next, Plrs:GetPlayers() do
		if v ~= MyPlr then
			local IsAlly = GetTeamColor(v)
			if IsAlly ~= Bullshit.Colors.Ally and IsAlly ~= Bullshit.Colors.Friend and IsAlly ~= Bullshit.Colors.Neutral then
				local GetChar = v.Character
				if MyChar and GetChar then
					local MyTor = MyChar:FindFirstChild("HumanoidRootPart")
					local GetTor = GetChar:FindFirstChild("HumanoidRootPart")
					local GetHum = GetChar:FindFirstChild("Humanoid")
					if MyTor and GetTor and GetHum then
						if game.PlaceId == 455366377 then
							if not GetChar:FindFirstChild("KO") and GetHum.Health > 1 then
								local Dist = (MyTor.Position - GetTor.Position).magnitude
								Players[v] = Dist
							end
						else
							if GetHum.Health > 1 then
								local Dist = (MyTor.Position - GetTor.Position).magnitude
								Players[v] = Dist
							end
						end
					end
				end
			end
		end
	end
	
	for i, v in next, Players do
		if CurrentClosePlayer ~= nil then
			if v <= CurrentClosePlayer then
				CurrentClosePlayer = v
				SelectedPlr = i
			end
		else
			CurrentClosePlayer = v
			SelectedPlr = i
		end
	end
	
	return SelectedPlr
end

function FindPlayer(Txt)
	local ps = { }
	for _, v in next, Plrs:GetPlayers() do
		if string.lower(string.sub(v.Name, 1, string.len(Txt))) == string.lower(Txt) then
			table.insert(ps, v)
		end
	end

	if #ps == 1 then
		if ps[1] ~= MyPlr then
			return ps[1]
		else
			return nil
		end
	else
		return nil
	end
end

function UpdateESP(Plr)
	if Plr ~= nil then
		local Find = PlayerESP:FindFirstChild("ESP Crap_" .. Plr.Name)
		if Find then
			local PickColor = GetTeamColor(Plr)
			Find.Frame.Names.TextColor3 = PickColor
			Find.Frame.Dist.TextColor3 = PickColor
			Find.Frame.Health.TextColor3 = PickColor
			--Find.Frame.Pos.TextColor3 = PickColor
			local GetChar = Plr.Character
			if MyChar and GetChar then
				local Find2 = MyChar:FindFirstChild("HumanoidRootPart")
				local Find3 = GetChar:FindFirstChild("HumanoidRootPart")
				local Find4 = GetChar:FindFirstChildOfClass("Humanoid")
				if Find2 and Find3 then
					local pos = Find3.Position
					local Dist = (Find2.Position - pos).magnitude
					if Dist > Bullshit.ESPLength or Bullshit.Blacklist[Plr.Name] then
						Find.Frame.Names.Visible = false
						Find.Frame.Dist.Visible = false
						Find.Frame.Health.Visible = false
						return
					else
						Find.Frame.Names.Visible = true
						Find.Frame.Dist.Visible = true
						Find.Frame.Health.Visible = true
					end
					Find.Frame.Dist.Text = "Distance: " .. string.format("%.0f", Dist)
					--Find.Frame.Pos.Text = "(X: " .. string.format("%.0f", pos.X) .. ", Y: " .. string.format("%.0f", pos.Y) .. ", Z: " .. string.format("%.0f", pos.Z) .. ")"
					if Find4 then
						Find.Frame.Health.Text = "Health: " .. string.format("%.0f", Find4.Health)
					else
						Find.Frame.Health.Text = ""
					end
				end
			end
		end
	end
end

function RemoveESP(Obj)
	if Obj ~= nil then
		local IsPlr = Obj:IsA("Player")
		local UseFolder = ItemESP
		if IsPlr then UseFolder = PlayerESP end

		local FindESP = ((IsPlr) and UseFolder:FindFirstChild("ESP Crap_" .. Obj.Name)) or FindESP(Obj)
		if FindESP then
			FindESP:Destroy()
		end
	end
end

function CreateESP(Obj)
	if Obj ~= nil then
		local IsPlr = Obj:IsA("Player")
		local UseFolder = ItemESP
		local GetChar = ((IsPlr) and Obj.Character) or Obj
		local Head = GetChar:FindFirstChild("Head")
		local t = tick()
		if IsPlr then UseFolder = PlayerESP end
		if Head == nil then
			repeat
				Head = GetChar:FindFirstChild("Head")
				wait()
			until Head ~= nil or (tick() - t) >= 10
		end
		if Head == nil then return end
		
		local bb = Instance.new("BillboardGui")
		bb.Adornee = Head
		bb.ExtentsOffset = Vector3.new(0, 1, 0)
		bb.AlwaysOnTop = true
		bb.Size = UDim2.new(0, 5, 0, 5)
		bb.StudsOffset = Vector3.new(0, 3, 0)
		bb.Name = "ESP Crap_" .. Obj.Name
		bb.Parent = UseFolder
		
		local frame = Instance.new("Frame", bb)
		frame.ZIndex = 10
		frame.BackgroundTransparency = 1
		frame.Size = UDim2.new(1, 0, 1, 0)
		
		local TxtName = Instance.new("TextLabel", frame)
		TxtName.Name = "Names"
		TxtName.ZIndex = 10
		TxtName.Text = Obj.Name
		TxtName.BackgroundTransparency = 1
		TxtName.Position = UDim2.new(0, 0, 0, -45)
		TxtName.Size = UDim2.new(1, 0, 10, 0)
		TxtName.Font = "SourceSansBold"
		TxtName.TextSize = 13
		TxtName.TextStrokeTransparency = 0.5

		local TxtDist = nil
		local TxtHealth = nil
		if IsPlr then
			TxtDist = Instance.new("TextLabel", frame)
			TxtDist.Name = "Dist"
			TxtDist.ZIndex = 10
			TxtDist.Text = ""
			TxtDist.BackgroundTransparency = 1
			TxtDist.Position = UDim2.new(0, 0, 0, -35)
			TxtDist.Size = UDim2.new(1, 0, 10, 0)
			TxtDist.Font = "SourceSansBold"
			TxtDist.TextSize = 13
			TxtDist.TextStrokeTransparency = 0.5

			TxtHealth = Instance.new("TextLabel", frame)
			TxtHealth.Name = "Health"
			TxtHealth.ZIndex = 10
			TxtHealth.Text = ""
			TxtHealth.BackgroundTransparency = 1
			TxtHealth.Position = UDim2.new(0, 0, 0, -25)
			TxtHealth.Size = UDim2.new(1, 0, 10, 0)
			TxtHealth.Font = "SourceSansBold"
			TxtHealth.TextSize = 13
			TxtHealth.TextStrokeTransparency = 0.5
		else
			local ObjVal = Instance.new("ObjectValue", bb)
			ObjVal.Value = Obj
		end
		
		local PickColor = GetTeamColor(Obj) or Bullshit.Colors.Neutral
		TxtName.TextColor3 = PickColor

		if IsPlr then
			TxtDist.TextColor3 = PickColor
			TxtHealth.TextColor3 = PickColor
		end
	end
end
--Click NAME PLAYER 2
function GetClosestPlayerNotBehindWall()
	local Players = { }
	local CurrentClosePlayer = nil
	local SelectedPlr = nil

	for _, v in next, Plrs:GetPlayers() do
		if v ~= MyPlr and not Bullshit.Blacklist[v.Name] then
			local IsAlly = GetTeamColor(v)
			if IsAlly ~= Bullshit.Colors.Ally and IsAlly ~= Bullshit.Colors.Friend and IsAlly ~= Bullshit.Colors.Neutral then
				local GetChar = v.Character
				if MyChar and GetChar then
					local MyHead, MyTor = MyChar:FindFirstChild("Head"), MyChar:FindFirstChild("HumanoidRootPart")
					local GetHead, GetTor, GetHum = GetChar:FindFirstChild("Head"), GetChar:FindFirstChild("HumanoidRootPart"), GetChar:FindFirstChild("Humanoid")

					if MyHead and MyTor and GetHead and GetTor and GetHum then
						if game.PlaceId == 455366377 then
							if not GetChar:FindFirstChild("KO") and GetHum.Health > 1 then
								local Ray = Ray.new(MyCam.CFrame.p, (GetHead.Position - MyCam.CFrame.p).unit * 2048)
								local part = workspace:FindPartOnRayWithIgnoreList(Ray, {MyChar})
								if part ~= nil then
									if part:IsDescendantOf(GetChar) then
										local Dist = (MyTor.Position - GetTor.Position).magnitude
										Players[v] = Dist
									end
								end
							end
						elseif game.PlaceId == 746820961 then
							if GetHum.Health > 1 then
								local Ray = Ray.new(MyCam.CFrame.p, (GetHead.Position - MyCam.CFrame.p).unit * 2048)
								local part = workspace:FindPartOnRayWithIgnoreList(Ray, {MyChar, MyCam})
								if part ~= nil then
									if part:IsDescendantOf(GetChar) then
										local Dist = (MyTor.Position - GetTor.Position).magnitude
										Players[v] = Dist
									end
								end
							end
						else
							if GetHum.Health > 1 then
								local Ray = Ray.new(MyCam.CFrame.p, (GetHead.Position - MyCam.CFrame.p).unit * 2048)
								local part = workspace:FindPartOnRayWithIgnoreList(Ray, {MyChar})
								if part ~= nil then
									if part:IsDescendantOf(GetChar) then
										local Dist = (MyTor.Position - GetTor.Position).magnitude
										Players[v] = Dist
									end
								end
							end
						end
					end
				end
			end
		end
	end

	for i, v in next, Players do
		if CurrentClosePlayer ~= nil then
			if v <= CurrentClosePlayer then
				CurrentClosePlayer = v
				SelectedPlr = i
			end
		else
			CurrentClosePlayer = v
			SelectedPlr = i
		end
	end
	
	return SelectedPlr
end

function GetClosestPlayer()
	local Players = { }
	local CurrentClosePlayer = nil
	local SelectedPlr = nil
	
	for _, v in next, Plrs:GetPlayers() do
		if v ~= MyPlr then
			local IsAlly = GetTeamColor(v)
			if IsAlly ~= Bullshit.Colors.Ally and IsAlly ~= Bullshit.Colors.Friend and IsAlly ~= Bullshit.Colors.Neutral then
				local GetChar = v.Character
				if MyChar and GetChar then
					local MyTor = MyChar:FindFirstChild("HumanoidRootPart")
					local GetTor = GetChar:FindFirstChild("HumanoidRootPart")
					local GetHum = GetChar:FindFirstChild("Humanoid")
					if MyTor and GetTor and GetHum then
						if game.PlaceId == 455366377 then
							if not GetChar:FindFirstChild("KO") and GetHum.Health > 1 then
								local Dist = (MyTor.Position - GetTor.Position).magnitude
								Players[v] = Dist
							end
						else
							if GetHum.Health > 1 then
								local Dist = (MyTor.Position - GetTor.Position).magnitude
								Players[v] = Dist
							end
						end
					end
				end
			end
		end
	end
	
	for i, v in next, Players do
		if CurrentClosePlayer ~= nil then
			if v <= CurrentClosePlayer then
				CurrentClosePlayer = v
				SelectedPlr = i
			end
		else
			CurrentClosePlayer = v
			SelectedPlr = i
		end
	end
	
	return SelectedPlr
end

function FindPlayer(Txt)
	local ps = { }
	for _, v in next, Plrs:GetPlayers() do
		if string.lower(string.sub(v.Name, 1, string.len(Txt))) == string.lower(Txt) then
			table.insert(ps, v)
		end
	end

	if #ps == 1 then
		if ps[1] ~= MyPlr then
			return ps[1]
		else
			return nil
		end
	else
		return nil
	end
end
--Click AIMBOT
_G.HeadSize = 5
_G.Disabled = true
 
game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.HumanoidRootPart.Transparency = 0.7
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really white")
v.Character.HumanoidRootPart.Material = "Neon"
v.Character.HumanoidRootPart.CanCollide = false
end)
end
end
end
end)


---Close gui
local ScreenGui = Instance.new("ScreenGui")
local ImageButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")


ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ImageButton.Parent = ScreenGui
ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageButton.Position = UDim2.new(0.10615778, 0, 0.16217947, 0)
ImageButton.Size = UDim2.new(0.0627121851, 0, 0.107579626, 0)
ImageButton.Image = "rbxassetid://15597057735"

UICorner.CornerRadius = UDim.new(0, 30)
UICorner.Parent = ImageButton

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(244, 0, 0)), ColorSequenceKeypoint.new(0.32, Color3.fromRGB(146, 255, 251)), ColorSequenceKeypoint.new(0.65, Color3.fromRGB(180, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(96, 255, 231))}
UIGradient.Parent = ImageButton

UIAspectRatioConstraint.Parent = ImageButton
UIAspectRatioConstraint.AspectRatio = 0.988


local function HCEGY_fake_script()
	local script = Instance.new('LocalScript', UIGradient)

	local TweenService = game:GetService("TweenService")
	local tweeninfo = TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
	local tween = TweenService:Create(script.Parent, tweeninfo, {Rotation = 360})
	tween:Play()
end
coroutine.wrap(HCEGY_fake_script)()
local function YTZCAJC_fake_script()
	local script = Instance.new('LocalScript', ImageButton)

	local UIS = game:GetService('UserInputService')
	local frame = script.Parent
	local dragToggle = nil
	local dragSpeed = 0.25
	local dragStart = nil
	local startPos = nil
	
	local function updateInput(input)
		local delta = input.Position - dragStart
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
	end
	
	frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			dragToggle = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)
	
	UIS.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle then
				updateInput(input)
			end
		end
	end)
	script.Parent.MouseButton1Click:Connect(function()
		game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.End,false,game)
	end)
end
coroutine.wrap(YTZCAJC_fake_script)()