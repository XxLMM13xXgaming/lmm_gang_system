--LMMGS

--[[Networking]]--
util.AddNetworkString("LMMGSCreateJoinGang")
util.AddNetworkString("LMMGSRequestGangEntry")
util.AddNetworkString("LMMGSRequestGangEntryLeader")
util.AddNetworkString("LMMGSAcceptedIntoGang")
util.AddNetworkString("LMMGSJoinGangNoRequest")
util.AddNetworkString("LMMGSCreateGangDone")
util.AddNetworkString("LMMGSOpenGangViewer")
util.AddNetworkString("LMMGSOpenGangManager")
util.AddNetworkString("LMMGSUpdateGang")
util.AddNetworkString("LMMGSKickFromGang")
util.AddNetworkString("LMMGSSendMessage")
util.AddNetworkString("LMMGSReceiveMessage")
util.AddNetworkString("LMMGSLeaveGangN")
util.AddNetworkString("LMMGSDeleteGangN")
util.AddNetworkString("LMMGSDrawColorForGang")
util.AddNetworkString("LMMGSGangLoading")
util.AddNetworkString("LMMGSNotifyN")
--[[Networking]]--

--[[Functions]]--
function LMMGSIsInGang(ply)
	return ply.LMMGSInGang
end

function LMMGSGetGangName(ply)
	return ply.LMMGSGangName
end

function LMMGSGetGangID(ply)
	return ply.LMMGSGangID
end

function LMMGSGetGangColor(ply)
	local color = string.Explode("|", ply.LMMGSGangColor)
	return Color(color[1], color[2], color[3], color[4])
end

function LMMGSGetGangFF(ply)
	return ply.LMMGSFFSetting
end

function LMMGSIsOwner(ply)
	if ply.LMMGSIsTheLeader == true then
		return true
	else
		return false
	end
end

function LMMGSGetEscapedString(string)
	return LMMGSdb:Escape(string)
end

function LMMGSDebug(funct, string)
	if LMMGSConfig.DevMode == true then
		for k, v in pairs(player.GetAll()) do
				v:ChatPrint("Gang System debug printed to your console from the function: "..funct)
				MsgAll("\n\nGANG SYSTEM DEBUG\n\nFunction: "..funct.."\n\nError: "..string.."\n\nDebug Done!\n\n")
		end
	end
end

function LMMGSUpdatePlayersStatus(ply)
	LMMGSdb:Query("SELECT * FROM players WHERE playerid = " .. ply:SteamID64(), function(result)
		if result[1].affected > 0 then
			ply.LMMGSInGang = true
			LMMGSdb:Query("SELECT * FROM gangs WHERE id = " .. result[1].data[1].gangid, function(result)
				if result[1].affected > 0 then
					ply.LMMGSGangName = result[1].data[1].gangname
					ply.LMMGSGangID = result[1].data[1].id
					ply.LMMGSGangColor = result[1].data[1].color
					if result[1].data[1].leaderid == ply:SteamID64() then
						ply.LMMGSIsTheLeader = true
						ply.LMMGSIsTheLeaderID = result[1].data[1].id
						ply.LMMGSGangColor = result[1].data[1].color
						ply.LMMGSFFSetting = result[1].data[1].friendlyfire
					end
				else
					ply.LMMGSInGang = false
					ply.LMMGSGangName = false
					ply.LMMGSGangID = false
					ply.LMMGSGangColor = false
					ply.LMMGSFFSetting = false
				end
			end)
		else
			ply.LMMGSInGang = false
			ply.LMMGSGangName = false
			ply.LMMGSGangID = false
			ply.LMMGSGangColor = false
			ply.LMMGSFFSetting = false
			ply.LMMGSIsTheLeader = false
			ply.LMMGSIsTheLeaderID = false
			ply.LMMGSGangColor = false
			ply.LMMGSFFSetting = false
		end
	end)
end

function LMMGSDeleteGang(ply)
	if LMMGSIsInGang(ply) then
		local id = LMMGSGetGangID(ply)
		LMMGSdb:Query("DELETE FROM gangs WHERE id = "..id, function(result)
			if result[1].affected > 0 then
				LMMGSNotify(ply, "You have deleted the gang! This may take up to 10 seconds to change!")
				LMMGSdb:Query("DELETE FROM players WHERE playerid = "..ply:SteamID64(), function(result)

				end)
			end
		end)
	end
end


function LMMGSLeaveGang(ply)
	if LMMGSIsInGang(ply) then
		local id = LMMGSGetGangID(ply)
		LMMGSdb:Query("SELECT * FROM gangs WHERE id = "..id, function(result)
			LMMGSdb:Query("SELECT * FROM players WHERE playerid = "..ply:SteamID64(), function(result2)
				if result[1].affected > 0 then
					if result2[1].affected > 0 then
						if result[1].data[1].player1 == result2[1].data[1].playername then
							LMMGSNotify(ply, "You have left the gang! This may take up to 10 seconds to change!")
							LMMGSdb:Query("UPDATE gangs SET player1 = '1', players = "..tonumber(result[1].data[1].players) - 1 .." WHERE id = "..id, function(resultR)
								if resultR[1].affected < 0 then

								end
								LMMGSdb:Query("DELETE FROM players WHERE playerid = "..ply:SteamID64(), function(resultD)

								end)
							end)
						elseif result[1].data[1].player2 == result2[1].data[1].playername then
							LMMGSNotify(ply, "You have left the gang! This may take up to 10 seconds to change!")
							LMMGSdb:Query("UPDATE gangs SET player2 = '2', players = "..tonumber(result[1].data[1].players) - 1 .." WHERE id = "..id, function(resultR)
								if resultR[1].affected < 0 then

								end
								LMMGSdb:Query("DELETE FROM players WHERE playerid = "..ply:SteamID64(), function(resultD)

								end)
							end)
						elseif result[1].data[1].player3 == result2[1].data[1].playername then
							LMMGSNotify(ply, "You have left the gang! This may take up to 10 seconds to change!")
							LMMGSdb:Query("UPDATE gangs SET player3 = '3', players = "..tonumber(result[1].data[1].players) - 1 .." WHERE id = "..id, function(resultR)
								if resultR[1].affected < 0 then

								end
								LMMGSdb:Query("DELETE FROM players WHERE playerid = "..ply:SteamID64(), function(resultD)

								end)
							end)
						elseif result[1].data[1].player4 == result2[1].data[1].playername then
							LMMGSNotify(ply, "You have left the gang! This may take up to 10 seconds to change!")
							LMMGSdb:Query("UPDATE gangs SET player4 = '4', players = "..tonumber(result[1].data[1].players) - 1 .." WHERE id = "..id, function(resultR)
								if resultR[1].affected < 0 then

								end
								LMMGSdb:Query("DELETE FROM players WHERE playerid = "..ply:SteamID64(), function(resultD)

								end)
							end)
						elseif result[1].data[1].player5 == result2[1].data[1].playername then
							LMMGSNotify(ply, "You have left the gang! This may take up to 10 seconds to change!")
							LMMGSdb:Query("UPDATE gangs SET player5 = '5', players = "..tonumber(result[1].data[1].players) - 1 .." WHERE id = "..id, function(resultR)
								if resultR[1].affected < 0 then

								end
								LMMGSdb:Query("DELETE FROM players WHERE playerid = "..ply:SteamID64(), function(resultD)

								end)
							end)
						elseif result[1].data[1].player6 == result2[1].data[1].playername then
							LMMGSNotify(ply, "You have left the gang! This may take up to 10 seconds to change!")
							LMMGSdb:Query("UPDATE gangs SET player6 = '6', players = "..tonumber(result[1].data[1].players) - 1 .." WHERE id = "..id, function(resultR)
								if resultR[1].affected < 0 then

								end
								LMMGSdb:Query("DELETE FROM players WHERE playerid = "..ply:SteamID64(), function(resultD)

								end)
							end)
						elseif result[1].data[1].player7 == result2[1].data[1].playername then
							LMMGSNotify(ply, "You have left the gang! This may take up to 10 seconds to change!")
							LMMGSdb:Query("UPDATE gangs SET player7 = '7', players = "..tonumber(result[1].data[1].players) - 1 .." WHERE id = "..id, function(resultR)
								if resultR[1].affected < 0 then

								end
								LMMGSdb:Query("DELETE FROM players WHERE playerid = "..ply:SteamID64(), function(resultD)

								end)
							end)
						elseif result[1].data[1].player8 == result2[1].data[1].playername then
							LMMGSNotify(ply, "You have left the gang! This may take up to 10 seconds to change!")
							LMMGSdb:Query("UPDATE gangs SET player8 = '8', players = "..tonumber(result[1].data[1].players) - 1 .." WHERE id = "..id, function(resultR)
								if resultR[1].affected < 0 then

								end
								LMMGSdb:Query("DELETE FROM players WHERE playerid = "..ply:SteamID64(), function(resultD)

								end)
							end)
						elseif result[1].data[1].player9 == result2[1].data[1].playername then
							LMMGSNotify(ply, "You have left the gang! This may take up to 10 seconds to change!")
							LMMGSdb:Query("UPDATE gangs SET player9 = '9', players = "..tonumber(result[1].data[1].players) - 1 .." WHERE id = "..id, function(resultR)
								if resultR[1].affected < 0 then

								end
								LMMGSdb:Query("DELETE FROM players WHERE playerid = "..ply:SteamID64(), function(resultD)

								end)
							end)
						elseif result[1].data[1].player10 == result2[1].data[1].playername then
							LMMGSNotify(ply, "You have left the gang! This may take up to 10 seconds to change!")
							LMMGSdb:Query("UPDATE gangs SET player10 = '10', players = "..tonumber(result[1].data[1].players) - 1 .." WHERE id = "..id, function(resultR)
								if resultR[1].affected < 0 then

								end
								LMMGSdb:Query("DELETE FROM players WHERE playerid = "..ply:SteamID64(), function(resultD)

								end)
							end)
						end
					end
				end
			end)
		end)
	end
end

function LMMGSJoinGang(ply, id)
	LMMGSdb:Query("SELECT * FROM gangs WHERE id = "..id, function(result)
		if result[1].affected > 0 then
			if result[1].data[1].players == "1" then
				playerstoswitch = "player2"
			elseif result[1].data[1].players == "2" then
				playerstoswitch = "player3"
			elseif result[1].data[1].players == "3" then
				playerstoswitch = "player4"
			elseif result[1].data[1].players == "4" then
				playerstoswitch = "player5"
			elseif result[1].data[1].players == "5" then
				playerstoswitch = "player6"
			elseif result[1].data[1].players == "6" then
				playerstoswitch = "player7"
			elseif result[1].data[1].players == "7" then
				playerstoswitch = "player8"
			elseif result[1].data[1].players == "8" then
				playerstoswitch = "player9"
			elseif result[1].data[1].players == "9" then
				playerstoswitch = "player10"
			elseif result[1].data[1].players == "10" then
				LMMGSNotify(ply, "This gang is full!")
				return
			end

			LMMGSdb:Query("UPDATE gangs SET "..playerstoswitch.." = '"..ply:Nick().."', players = '"..tonumber(result[1].data[1].players) + 1 .."' WHERE id = "..id, function(result)
				PrintTable(result)
				local query = ("INSERT players ( playerid, playername, gangid ) VALUES ( %q, %q, %q )"):format( ply:SteamID64(), ply:Nick(), id)
				LMMGSdb:Query(query, function(result)
					LMMGSdb:Query("SELECT * FROM gangs WHERE id = "..id, function(result)
						LMMGSUpdatePlayersStatus(ply)
					end)
				end)
				LMMGSNotify(ply, "You have joined the gang! Make sure to be a good member!")
			end)
		end
	end)
end

function LMMGSNotify(ply, string)
	net.Start("LMMGSNotifyN")
		net.WriteString(string)
	net.Send(ply)
end

local function LMMGSGetPlayerBySteamID64E(string)
	tbl = string.Explode("|", string)
	for k, v in pairs(player.GetAll()) do
		if tbl[1] == v:SteamID64() then
			return v
		end
	end
	PrintTable(tbl)
	return "offline("..tbl[2]..")"
end

function LMMGSOpenGangMenu(ply)
	if LMMGSIsInGang(ply) then
		local thetable = {}
		LMMGSdb:Query("SELECT * FROM gangs WHERE id = "..LMMGSGetGangID(ply), function(result)
			table.insert(thetable, {result[1].data[1]})
			timer.Simple(.5, function()
				if LMMGSIsOwner(ply) then
					net.Start("LMMGSOpenGangManager")
						net.WriteTable(thetable)
						net.WriteString(file.Read("lmm_gangsystem_data/"..result[1].data[1].id..".txt", "DATA"))
					net.Send(ply)
				else
					net.Start("LMMGSOpenGangViewer")
						net.WriteTable(thetable)
						net.WriteString(file.Read("lmm_gangsystem_data/"..result[1].data[1].id..".txt", "DATA"))
					net.Send(ply)
				end
			end)
		end)
	else
		local thegangtable = {}

		LMMGSdb:Query("SELECT * FROM gangs", function(result)
			for i=1, #result[1].data do
				local leader = LMMGSGetPlayerBySteamID64E(result[1].data[i].leader)
				local player1 = result[1].data[i].player1
				local player2 = result[1].data[i].player2
				local player3 = result[1].data[i].player3
				local player4 = result[1].data[i].player4
				local player5 = result[1].data[i].player5
				local player6 = result[1].data[i].player6
				local player7 = result[1].data[i].player7
				local player8 = result[1].data[i].player8
				local player9 = result[1].data[i].player9
				local player10 = result[1].data[i].player10
				local colortbl = string.Explode("|", result[1].data[i].color)
				if isentity(leader) then
					leaderhere = true
				else
					leaderhere = false
				end
				table.insert(thegangtable, {result[1].data[i].id, result[1].data[i].gangname, leader, colortbl[1], colortbl[2], colortbl[3], colortbl[4], result[1].data[i].description, player1, player2, player3, player4, player5, player6, player7, player8, player9, player10, leaderhere, tonumber(result[1].data[i].request)})
			end
		end)
		net.Start("LMMGSGangLoading")
		net.Send(ply)
		timer.Simple(2, function()
			net.Start("LMMGSCreateJoinGang")
				net.WriteTable(thegangtable)
			net.Send(ply)
		end)
	end
end


local function LMMGSChatCommand(ply, text)
	local text = string.lower(text)
	if text == "!gang" or text == "/gang" then
		LMMGSOpenGangMenu(ply)
		return ''
	end
end
hook.Add("PlayerSay", "LMMGSChatCommand", LMMGSChatCommand)
--[[Functions]]--

--[[Hooks]]--
hook.Add( "PlayerShouldTakeDamage", "LMMGSplayershouldtakedamage", function(victim, attacker)
	if LMMGSIsInGang(victim) then
		if LMMGSGetGangID(victim) == LMMGSGetGangID(attacker) then
			if LMMGSGetGangFF(victim) then
				return false
			else
				return true
			end
		end
	end
	return true
end)

hook.Add("PlayerInitialSpawn", "LMMGSGetPlayerInfo", function(ply)
	LMMGSUpdatePlayersStatus(ply)
end)
--[[Hooks]]--

--[[Timers]]--
timer.Create("LMMGSUpdatePlayersStatusTimer", 5, 0, function()
	for k, v in pairs(player.GetAll()) do
		LMMGSUpdatePlayersStatus(v)
	end
end)
--[[Timers]]--

--[[Net Receives]]--
net.Receive("LMMGSRequestGangEntry", function(len, ply)
	local id = LMMGSGetEscapedString(net.ReadString())

	LMMGSdb:Query("SELECT * FROM gangs WHERE id = "..id, function(result)
		if result[1].affected > 0 then
			local leader = LMMGSGetPlayerBySteamID64E(result[1].data[1].leader)
			if isentity(leader) then
				leaderhere = true
			else
				leaderhere = false
			end
			if result[1].data[1].players >= "10" then
				LMMGSNotify(ply, "This gang already has max players!")
			else
				if tonumber(result[1].data[1].request) == 1 then
					if leaderhere == true then
						LMMGSNotify(ply, "A request has been sent to the leader!")
						net.Start("LMMGSRequestGangEntryLeader")
							net.WriteEntity(ply)
						net.Send(leader)
					else
						LMMGSNotify(ply, "Leader has not been found! Please try again later when leader is online!")
					end
				else
					LMMGSNotify(ply, "You have joined the gang!")
					LMMGSJoinGang(ply, id)
				end
			end
		end
	end)
end)

net.Receive("LMMGSJoinGangNoRequest", function(len, ply)
	local id = LMMGSGetEscapedString(net.ReadString())
	LMMGSdb:Query("SELECT * FROM gangs WHERE id = "..id, function(result)
		if result[1].affected > 0 then
			if tonumber(result[1].data[1].request) == 0 then
				LMMGSJoinGang(ply, id)
			end
		end
	end)
end)

net.Receive("LMMGSAcceptedIntoGang", function(len, ply)
	local newbie = net.ReadEntity()
	if !LMMGSIsInGang(newbie) then
--		if LMMGSIsInGang(ply) then
			LMMGSdb:Query("SELECT * FROM gangs WHERE leaderid = "..ply:SteamID64(), function(result)
				PrintTable(result)
				if result[1].affected > 0 then
					LMMGSJoinGang(newbie, LMMGSGetEscapedString(tostring(result[1].data[1].id)))
					LMMGSNotify(newbie, "You have been accepted into the gang")
				end
			end)
--		end
	end
end)

net.Receive("LMMGSCreateGangDone", function(len, ply)
	if !LMMGSIsInGang(ply) then
		if ply:getDarkRPVar("money") < LMMGSConfig.PriceToBuyGang then
			LMMGSNotify(ply, "You do not have enough money!")
			return
		end
		local name = LMMGSGetEscapedString(net.ReadString())
		local description = LMMGSGetEscapedString(net.ReadString())
		local color = net.ReadTable()
		local colorr = LMMGSGetEscapedString(tostring(color.r))
		local colorg = LMMGSGetEscapedString(tostring(color.g))
		local colorb = LMMGSGetEscapedString(tostring(color.b))
		local colora = LMMGSGetEscapedString(tostring(color.a))
		local request = LMMGSGetEscapedString(net.ReadString())
		local friendlyfire = LMMGSGetEscapedString(net.ReadString())
		local nameallowed = true

		LMMGSdb:Query("SELECT * FROM gangs", function(result)
			if result[1].affected > 0 then
				for i=1, #result[1].data do
					if result[1].data[i].gangname == name then
						nameallowed = false
					end
				end
			end
		end)

		if nameallowed == true then
			for i=1, #LMMGSConfig.BlackListNames do
				if string.find( string.lower(name), LMMGSConfig.BlackListNames[i]) != nil then
					nameallowed = false
				end
			end
		end

		if string.len(description) > 75 then
			description = string.Left(description, 75).."..."
		end
		if string.len(name) > 75 then
			name = string.Left(name, 75).."..."
		end
		if request == "Yes" then
			request10 = "1"
		else
			request10 = "0"
		end
		if friendlyfire == "Yes" then
			friendlyfire10 = "1"
		else
			friendlyfire10 = "0"
		end
		if nameallowed == true then
			local query = ("INSERT gangs ( id, gangname, leaderid, leader, color, description, player1, player2, player3, player4, player5, player6, player7, player8, player9, player10, players, request, friendlyfire) VALUES ( NULL, %q, %q, %q, %q, %q, %q, %q, %q, %q, %q, %q, %q, %q, %q, %q, %q, %q, %q )"):format( name, ply:SteamID64(), ply:SteamID64().."|"..ply:Nick(), colorr.."|"..colorg.."|"..colorb.."|"..colora, description, ply:Nick(), "2", "3", "4", "5", "6", "7", "8", "9", "10", "1", request10, friendlyfire10 )
			LMMGSdb:Query(query, function(result)
				PrintTable(result)
				LMMGSNotify(ply, "Your gang has been created! It may take up to 10 seconds to appear!")
				ply:addMoney(-LMMGSConfig.PriceToBuyGang)
				if result[1].affected > 0 then
					LMMGSdb:Query(("INSERT players (playerid, playername, gangid) VALUES (%q, %q, %q)"):format(ply:SteamID64(), ply:Nick(), result[1].lastid), function(result)
						PrintTable()
						timer.Simple(2, function()
							LMMGSUpdatePlayersStatus(ply)
							ply.LMMGSIsTheLeader = true
							ply.LMMGSIsTheLeaderID = result[1].lastid
						end)
					end)
				end
				file.Write("lmm_gangsystem_data/"..result[1].lastid..".txt", "Gang Created "..os.date("%m/%d/%Y").." by: "..ply:Nick().."|" )
			end)
		else
			LMMGSNotify(ply, "The name you used is not allowed!")
		end
	end
end)

net.Receive("LMMGSUpdateGang", function(len, ply)
	if LMMGSIsOwner(ply) then
		local request = LMMGSGetEscapedString(net.ReadString())
		local friendlyfire = LMMGSGetEscapedString(net.ReadString())
		local color = net.ReadTable()
		local colorr = LMMGSGetEscapedString(tostring(color.r))
		local colorg = LMMGSGetEscapedString(tostring(color.g))
		local colorb = LMMGSGetEscapedString(tostring(color.b))
		local colora = LMMGSGetEscapedString(tostring(color.a))
		local name = LMMGSGetEscapedString(net.ReadString())
		local description = LMMGSGetEscapedString(net.ReadString())
		local nameallowed = true

		LMMGSdb:Query("SELECT * FROM gangs", function(result)
			if result[1].affected > 0 then
				for i=1, #result[1].data do
					if result[1].data[i].gangname == name then
						nameallowed = false
					end
				end
			end
		end)

		if nameallowed == true then
			for i=1, #LMMGSConfig.BlackListNames do
				if string.find( name, LMMGSConfig.BlackListNames[i]) != nil then
					nameallowed = false
				end
			end
		end

		if string.len(description) > 75 then
			description = string.Left(description, 75).."..."
		end
		if string.len(name) > 75 then
			name = string.Left(name, 75).."..."
		end
		if request == "Yes" then
			request10 = "1"
		else
			request10 = "0"
		end
		if friendlyfire == "Yes" then
			friendlyfire10 = "1"
		else
			friendlyfire10 = "0"
		end

		if nameallowed == true then
			LMMGSdb:Query("UPDATE gangs SET gangname = '"..name.."', color = '"..colorr.."|"..colorg.."|"..colorb.."|"..colora.."', description = '"..description.."', request = '"..request10.."', friendlyfire = '"..friendlyfire10.."' WHERE leaderid = "..ply:SteamID64(), function(result)
				PrintTable(result)
				LMMGSNotify(ply, "Your gang has been updated!")
			end)
		end
	end
end)

net.Receive("LMMGSKickFromGang", function(len, ply)
	local playernum = LMMGSGetEscapedString(tostring(net.ReadFloat()))
	local playername = LMMGSGetEscapedString(net.ReadString())
	if LMMGSIsOwner(ply) then
		if playernum != "1" then
			LMMGSdb:Query("UPDATE gangs SET player"..playernum.." = '"..playernum.."'", function(result)
				LMMGSdb:Query("DELETE FROM players WHERE playername = '"..playername, function(result)

				end)
			end)
		end
	end
end)

net.Receive("LMMGSSendMessage", function(len, ply)
	local message = string.gsub( net.ReadString(), "|", "/" )
	if LMMGSIsInGang(ply) then
		file.Write("lmm_gangsystem_data/"..LMMGSGetGangID(ply)..".txt", file.Read("lmm_gangsystem_data/"..LMMGSGetGangID(ply)..".txt", "DATA")..os.date("%H:%M:%S - %d/%m/%Y").." - "..ply:Nick()..": "..message.."|")
	end
	for k, v in pairs(player.GetAll()) do
		if LMMGSGetGangID(v) == LMMGSGetGangID(ply) then
			net.Start("LMMGSReceiveMessage")
				net.WriteString(message)
				net.WriteEntity(ply)
			net.Send(v)
		end
	end
end)

net.Receive("LMMGSLeaveGangN",function(len, ply)
	if LMMGSIsInGang(ply) then
		LMMGSLeaveGang(ply)
	end
end)

net.Receive("LMMGSDeleteGangN",function(len, ply)
	if LMMGSIsInGang(ply) then
		LMMGSDeleteGang(ply)
	end
end)
--[[Net Receives]]--
