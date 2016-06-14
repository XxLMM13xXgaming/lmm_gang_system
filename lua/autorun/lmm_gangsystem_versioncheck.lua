--[[You really should not edit this!]]--
local version = "betaV1" -- DO NOT EDIT THIS!
local version_url = "https://raw.githubusercontent.com/XxLMM13xXgaming/lmm_gang_system/master/version.txt" -- DO NOT EDIT THIS!
local update_url = "https://github.com/XxLMM13xXgaming/lmm_gang_system" -- DO NOT EDIT THIS!
local update_ur = "https://raw.githubusercontent.com/XxLMM13xXgaming/lmm_gang_system/master/versionur.txt" -- DO NOT EDIT THIS!
local msg_outdated = "You are using a outdated/un-supported version. You are on version "..version.."! Please download the new version here: " .. update_url -- DO NOT EDIT THIS!
local ranksthatgetnotify = { "superadmin", "owner", "admin" } -- DO NOT EDIT THIS!
local addon_id = "LMMGS" -- DO NOT EDIT THIS
local addon_name = "Gang System" -- DO NOT EDIT THIS

if (SERVER) then
	require( "tmysql4" )
	AddCSLuaFile("lmmgs_config.lua")
	include("lmmgs_config.lua")
	AddCSLuaFile("lmmgs_config_mysql.lua")
	include("lmmgs_config_mysql.lua")
	if !file.Exists("lmm_gangsystem_data", "DATA") then
		file.CreateDir("lmm_gangsystem_data", "DATA")
	end

	local message = [[

-------------------------------
| Gang System                 |
| Made By: XxLMM13xXgaming    |
| Project started: 5/10/2016  |
| Version: ]]..version..[[                |
-------------------------------

]]
	MsgC(Color(140,0,255), message)

	----------------------------------------------------------------------------
	-- Connect to database
	----------------------------------------------------------------------------
	LMMGSdb, LMMGSerr = tmysql.initialize(LMMGSMYSQLConfig.host, LMMGSMYSQLConfig.username, LMMGSMYSQLConfig.password, LMMGSMYSQLConfig.database, LMMGSMYSQLConfig.port, nil, CLIENT_MULTI_STATEMENTS )

	if LMMGSerr != nil or tostring( type( LMMGSdb ) ) == "boolean" then
		MsgC( Color(255,0,0), "[Gang System] Error connecting to the database!\n" )
		MsgC( Color(255,0,0), "[Gang System] MySQL Error: " .. LMMGSerr.."\n")
	else
		MsgC(Color(0,255,0), "[Gang System] Connected to the database!\n")
	end
	----------------------------------------------------------------------------
	-- Connect to database
	----------------------------------------------------------------------------

	----------------------------------------------------------------------------
	-- Create tables
	----------------------------------------------------------------------------
	LMMGSSQLCreateTables = [[CREATE TABLE IF NOT EXISTS `gangs` (
  `id` int(11) NOT NULL,
  `gangname` varchar(255) NOT NULL,
  `leaderid` varchar(255) NOT NULL,
  `leader` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `player1` varchar(255) NOT NULL,
  `player2` varchar(255) NOT NULL,
  `player3` varchar(255) NOT NULL,
  `player4` varchar(255) NOT NULL,
  `player5` varchar(255) NOT NULL,
  `player6` varchar(255) NOT NULL,
  `player7` varchar(255) NOT NULL,
  `player8` varchar(255) NOT NULL,
  `player9` varchar(255) NOT NULL,
  `player10` varchar(255) NOT NULL,
  `players` varchar(255) NOT NULL,
  `request` varchar(255) NOT NULL,
  `friendlyfire` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL,
  `playerid` varchar(255) NOT NULL,
  `playername` varchar(255) NOT NULL,
  `gangid` varchar(255) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

ALTER TABLE `gangs`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `players`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `gangs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
]]

	LMMGSdb:Query( LMMGSSQLCreateTables, function(result)
		if result[1].status == false then
			MsgC(Color(255,0,0), "[Gang System] Error setting up the MySQL tables!\n")
			PrintTable(result)
		else
			MsgC(Color(0,255,0), "[Gang System] MySQL tables have been setup!\n")
		end
	end	)

	util.AddNetworkString(addon_id.."VersionCheckCL")
	util.AddNetworkString(addon_id.."VersionCheckCLUR")

	http.Fetch(version_url, function(body, len, headers, code, ply)
		if (string.Trim(body) ~= version) then
			MsgC( Color(255,0,0), "["..addon_name.." ("..version..")] You are NOT using the latest version! (version: "..string.Trim(body)..")\n" )
		else
			MsgC( Color(255,0,0), "["..addon_name.." ("..version..")] You are using the latest version!\n" )
		end
	end )
	timer.Create(addon_id.."VersionCheckServerTimer", 600, 0, function()
		http.Fetch(version_url, function(body, len, headers, code, ply)
			if (string.Trim(body) ~= version) then
				MsgC( Color(255,0,0), "["..addon_name.." ("..version..")] You are NOT using the latest version! ("..string.Trim(body)..")\n" )
			end
		end )
	end )

	for k, v in pairs(player.GetAll()) do
		if (table.HasValue( ranksthatgetnotify, v:GetUserGroup() ) ~= true) then return end

		http.Fetch(version_url, function(body, len, headers, code, ply)
			if (string.Trim(body) ~= version) then
				net.Start(addon_id.."VersionCheckCL")
					net.WriteString(string.Trim(body))
				net.Send(v)
				timer.Create( addon_id.."VersionCheckTimer", 600, 6, function()
					net.Start(addon_id.."VersionCheckCL")
						net.WriteString(string.Trim(body))
					net.Send(v)
				end )

				http.Fetch(update_ur, function(body, len, headers, code, ply)
					net.Start(addon_id.."VersionCheckCLUR")
						net.WriteString(body)
					net.Send(v)
				end)
			else

			end

		end, function(error)

			-- Silently fail

		end)
	end

	hook.Add("PlayerInitialSpawn", addon_id.."VersionCheck", function(theply)
		if (table.HasValue( ranksthatgetnotify, theply:GetUserGroup() ) ~= true) then return end

		http.Fetch(version_url, function(body, len, headers, code, ply)
			if (string.Trim(body) ~= version) then
				net.Start(addon_id.."VersionCheckCL")
					net.WriteString(string.Trim(body))
				net.Send(theply)
				timer.Create( addon_id.."VersionCheckTimer", 600, 6, function()
					net.Start(addon_id.."VersionCheckCL")
						net.WriteString(string.Trim(body))
					net.Send(theply)
				end )
				http.Fetch(update_ur, function(body, len, headers, code, ply)
					net.Start(addon_id.."VersionCheckCLUR")
						net.WriteString(body)
					net.Send(theply)
				end)
			else

			end

		end, function(error)

			-- Silently fail

		end)
	end)
end

if (CLIENT) then
	include("lmmgs_config.lua")

	local message = [[

-------------------------------
| Gang System                 |
| Made By: XxLMM13xXgaming    |
| Project started: 5/10/2016  |
| Version: 1.0                |
-------------------------------

]]
	MsgC(Color(140,0,255), message)

	net.Receive(addon_id.."VersionCheckCL", function()
		local nversion = net.ReadString()
		MsgC(Color(0,0,0), "-----------------------------------------------------------------------------------\n")
		chat.AddText(Color(255,0,0), "["..addon_name.."]: ", Color(255,255,255), addon_name.." is outdated! You are on version "..version.." and version "..nversion.." is out! Check console for more info!")
		MsgC(Color(0,255,0), msg_outdated.."\n\n")
	end)

	net.Receive(addon_id.."VersionCheckCLUR", function()
		local reason = net.ReadString()

		MsgC(Color(0,255,0), "Whats new: "..reason.."\n")
		MsgC(Color(0,0,0), "-----------------------------------------------------------------------------------\n")
	end)
end
