--[[LMMGS]]--
surface.CreateFont( "LMMGSTitleFont", {
	font = "Arial",
	size = 20,
	weight = 5000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

surface.CreateFont( "LMMGSDescFont", {
	font = "Arial",
	size = 15,
	weight = 5000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

surface.CreateFont( "LMMGSLabelSmall", {
	font = "Arial",
	size = 25,
	weight = 2000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

surface.CreateFont( "LMMGSNoFont", {
	font = "Lato Light",
	size = 30,
	weight = 250,
	antialias = true,
	strikeout = false,
	additive = true,
} )

surface.CreateFont( "LMMGSSellLabel", {
	font = "Lato Light",
	size = 20,
	weight = 250,
	antialias = true,
	strikeout = false,
	additive = true,
} )

surface.CreateFont( "LMMGSfontclose", {
	font = "Arial",
	size = 18,
	weight = 5000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

local function LMMGSCreateGang()
	local DFrame = vgui.Create( "DFrame" )
	DFrame:SetSize( 500, 260 )
	DFrame:Center()
	DFrame:SetDraggable( true )
	DFrame:MakePopup()
	DFrame:SetTitle( "" )
	DFrame:ShowCloseButton( false )
	DFrame.Paint = function( self, w, h )
		draw.RoundedBox(2, 0, 0, DFrame:GetWide(), DFrame:GetTall(), Color(35, 35, 35, 250))
		draw.RoundedBox(2, 0, 0, DFrame:GetWide(), 30, Color(40, 40, 40, 255))
		draw.SimpleText( "Create a gang", "LMMGSTitleFont", DFrame:GetWide() / 2, 15, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local frameclose = vgui.Create("DButton", DFrame)
	frameclose:SetSize(20, 20)
	frameclose:SetPos(DFrame:GetWide() - frameclose:GetWide() - 3, 3)
	frameclose:SetText("X");
	frameclose:SetTextColor(Color(0,0,0,255))
	frameclose:SetFont("LMMGSfontclose")
	frameclose.hover = false
	frameclose.DoClick = function()
		DFrame:Close()
	end
	frameclose.OnCursorEntered = function(self)
		self.hover = true
	end
	frameclose.OnCursorExited = function(self)
		self.hover = false
	end
	function frameclose:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(255,15,15,250)) or Color(255,255,255,255)) -- Paints on hover
		frameclose:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
		notification.Kill( "LMMGSBuildGang_"..LocalPlayer():SteamID64() )
	end

	notification.AddProgress( "LMMGSBuildGang_"..LocalPlayer():SteamID64(), "Building Gang!" )

	local DProgress = vgui.Create( "DProgress", DFrame )
	DProgress:SetPos( 10, 40 )
	DProgress:SetSize( DFrame:GetWide() - 20, 20 )
	DProgress:SetFraction( 0 )

	local InfoLabel = vgui.Create("DLabel", DFrame)
	InfoLabel:SetPos(10, 20)
	InfoLabel:SetSize(350, 300)
	InfoLabel:SetText("Welcome to the gang creator!\nHere you will pick your gangs...\n1.)Name\n2.)Description\n3.)Color\n4.)Settings\n\n")
	InfoLabel:SetFont("LMMGSLabelSmall")

	local NextB = vgui.Create( "DButton", DFrame )
	NextB:SetPos( 10, 230 )
	NextB:SetSize( DFrame:GetWide() - 20,20 )
	NextB:SetText( "Next page" )
	NextB.OnCursorEntered = function(self)
		self.hover = true
	end
	NextB.OnCursorExited = function(self)
		self.hover = false
	end
	NextB.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		NextB:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	NextB.DoClick = function()
		DFrame:Close()
		PickGangName()
	end

	function PickGangName()
		local DFrame = vgui.Create( "DFrame" )
		DFrame:SetSize( 500, 120 )
		DFrame:Center()
		DFrame:SetDraggable( true )
		DFrame:MakePopup()
		DFrame:SetTitle( "" )
		DFrame:ShowCloseButton( false )
		DFrame.Paint = function( self, w, h )
			draw.RoundedBox(2, 0, 0, DFrame:GetWide(), DFrame:GetTall(), Color(35, 35, 35, 250))
			draw.RoundedBox(2, 0, 0, DFrame:GetWide(), 30, Color(40, 40, 40, 255))
			draw.SimpleText( "Create a gang", "LMMGSTitleFont", DFrame:GetWide() / 2, 15, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		local frameclose = vgui.Create("DButton", DFrame)
		frameclose:SetSize(20, 20)
		frameclose:SetPos(DFrame:GetWide() - frameclose:GetWide() - 3, 3)
		frameclose:SetText("X");
		frameclose:SetTextColor(Color(0,0,0,255))
		frameclose:SetFont("LMMGSfontclose")
		frameclose.hover = false
		frameclose.DoClick = function()
			DFrame:Close()
		end
		frameclose.OnCursorEntered = function(self)
			self.hover = true
		end
		frameclose.OnCursorExited = function(self)
			self.hover = false
		end
		function frameclose:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(255,15,15,250)) or Color(255,255,255,255)) -- Paints on hover
			frameclose:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
			notification.Kill( "LMMGSBuildGang_"..LocalPlayer():SteamID64() )
		end

		local DProgress = vgui.Create( "DProgress", DFrame )
		DProgress:SetPos( 10, 40 )
		DProgress:SetSize( DFrame:GetWide() - 20, 20 )
		DProgress:SetFraction( .25 )

		local GangName = vgui.Create( "DTextEntry", DFrame )
		GangName:SetPos( 10, 65 )
		GangName:SetSize( DFrame:GetWide() - 20, 20 )
		GangName:SetText( "Gang Name" )
		GangName.OnEnter = function( self )
			chat.AddText( Color(255,0,0), "Finish entering everything then click submit!" )
		end

		local NextB = vgui.Create( "DButton", DFrame )
		NextB:SetPos( 10, 90 )
		NextB:SetSize( DFrame:GetWide() - 20,20 )
		NextB:SetText( "Next page" )
		NextB.OnCursorEntered = function(self)
			self.hover = true
		end
		NextB.OnCursorExited = function(self)
			self.hover = false
		end
		NextB.Paint = function( self, w, h )
			draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
			NextB:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
		end
		NextB.DoClick = function()
			DFrame:Close()
			PickGangDescription(GangName:GetValue())
		end
	end

	function PickGangDescription(name)
		local DFrame = vgui.Create( "DFrame" )
		DFrame:SetSize( 500, 120 )
		DFrame:Center()
		DFrame:SetDraggable( true )
		DFrame:MakePopup()
		DFrame:SetTitle( "" )
		DFrame:ShowCloseButton( false )
		DFrame.Paint = function( self, w, h )
			draw.RoundedBox(2, 0, 0, DFrame:GetWide(), DFrame:GetTall(), Color(35, 35, 35, 250))
			draw.RoundedBox(2, 0, 0, DFrame:GetWide(), 30, Color(40, 40, 40, 255))
			draw.SimpleText( "Create a gang", "LMMGSTitleFont", DFrame:GetWide() / 2, 15, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		local frameclose = vgui.Create("DButton", DFrame)
		frameclose:SetSize(20, 20)
		frameclose:SetPos(DFrame:GetWide() - frameclose:GetWide() - 3, 3)
		frameclose:SetText("X");
		frameclose:SetTextColor(Color(0,0,0,255))
		frameclose:SetFont("LMMGSfontclose")
		frameclose.hover = false
		frameclose.DoClick = function()
			DFrame:Close()
		end
		frameclose.OnCursorEntered = function(self)
			self.hover = true
		end
		frameclose.OnCursorExited = function(self)
			self.hover = false
		end
		function frameclose:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(255,15,15,250)) or Color(255,255,255,255)) -- Paints on hover
			frameclose:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
			notification.Kill( "LMMGSBuildGang_"..LocalPlayer():SteamID64() )
		end

		local DProgress = vgui.Create( "DProgress", DFrame )
		DProgress:SetPos( 10, 40 )
		DProgress:SetSize( DFrame:GetWide() - 20, 20 )
		DProgress:SetFraction( .50 )

		local GangDesc = vgui.Create( "DTextEntry", DFrame )
		GangDesc:SetPos( 10, 65 )
		GangDesc:SetSize( DFrame:GetWide() - 20, 20 )
		GangDesc:SetText( "Gang Description" )
		GangDesc.OnEnter = function( self )
			chat.AddText( Color(255,0,0), "Finish entering everything then click submit!" )
		end

		local NextB = vgui.Create( "DButton", DFrame )
		NextB:SetPos( 10, 90 )
		NextB:SetSize( DFrame:GetWide() - 20,20 )
		NextB:SetText( "Next page" )
		NextB.OnCursorEntered = function(self)
			self.hover = true
		end
		NextB.OnCursorExited = function(self)
			self.hover = false
		end
		NextB.Paint = function( self, w, h )
			draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
			NextB:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
		end
		NextB.DoClick = function()
			DFrame:Close()
			PickGangColor(name, GangDesc:GetValue())
		end
	end

	function PickGangColor(name, description)
		local DFrame = vgui.Create( "DFrame" )
		DFrame:SetSize( 500, 200 )
		DFrame:Center()
		DFrame:SetDraggable( true )
		DFrame:MakePopup()
		DFrame:SetTitle( "" )
		DFrame:ShowCloseButton( false )
		DFrame.Paint = function( self, w, h )
			draw.RoundedBox(2, 0, 0, DFrame:GetWide(), DFrame:GetTall(), Color(35, 35, 35, 250))
			draw.RoundedBox(2, 0, 0, DFrame:GetWide(), 30, Color(40, 40, 40, 255))
			draw.SimpleText( "Create a gang", "LMMGSTitleFont", DFrame:GetWide() / 2, 15, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		local frameclose = vgui.Create("DButton", DFrame)
		frameclose:SetSize(20, 20)
		frameclose:SetPos(DFrame:GetWide() - frameclose:GetWide() - 3, 3)
		frameclose:SetText("X");
		frameclose:SetTextColor(Color(0,0,0,255))
		frameclose:SetFont("LMMGSfontclose")
		frameclose.hover = false
		frameclose.DoClick = function()
			DFrame:Close()
		end
		frameclose.OnCursorEntered = function(self)
			self.hover = true
		end
		frameclose.OnCursorExited = function(self)
			self.hover = false
		end
		function frameclose:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(255,15,15,250)) or Color(255,255,255,255)) -- Paints on hover
			frameclose:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
			notification.Kill( "LMMGSBuildGang_"..LocalPlayer():SteamID64() )
		end

		local DProgress = vgui.Create( "DProgress", DFrame )
		DProgress:SetPos( 10, 40 )
		DProgress:SetSize( DFrame:GetWide() - 20, 20 )
		DProgress:SetFraction( .75 )

		local GangColor = vgui.Create( "DColorMixer", DFrame )
		GangColor:SetPos(10, 65)
		GangColor:SetSize(DFrame:GetWide() - 20, 100)
		GangColor:SetPalette( false )
		GangColor:SetAlphaBar( true )
		GangColor:SetWangs( true )
		GangColor:SetColor( Color( 255, 0, 0 ) )

		local NextB = vgui.Create( "DButton", DFrame )
		NextB:SetPos( 10, 170 )
		NextB:SetSize( DFrame:GetWide() - 20,20 )
		NextB:SetText( "Next page" )
		NextB.OnCursorEntered = function(self)
			self.hover = true
		end
		NextB.OnCursorExited = function(self)
			self.hover = false
		end
		NextB.Paint = function( self, w, h )
			draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
			NextB:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
		end
		NextB.DoClick = function()
			DFrame:Close()
			PickGangSettings(name, description, GangColor:GetColor())
		end
	end

	function PickGangSettings(name, description, color)
		local DFrame = vgui.Create( "DFrame" )
		DFrame:SetSize( 500, 150 )
		DFrame:Center()
		DFrame:SetDraggable( true )
		DFrame:MakePopup()
		DFrame:SetTitle( "" )
		DFrame:ShowCloseButton( false )
		DFrame.Paint = function( self, w, h )
			draw.RoundedBox(2, 0, 0, DFrame:GetWide(), DFrame:GetTall(), Color(35, 35, 35, 250))
			draw.RoundedBox(2, 0, 0, DFrame:GetWide(), 30, Color(40, 40, 40, 255))
			draw.SimpleText( "Create a gang", "LMMGSTitleFont", DFrame:GetWide() / 2, 15, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		local frameclose = vgui.Create("DButton", DFrame)
		frameclose:SetSize(20, 20)
		frameclose:SetPos(DFrame:GetWide() - frameclose:GetWide() - 3, 3)
		frameclose:SetText("X");
		frameclose:SetTextColor(Color(0,0,0,255))
		frameclose:SetFont("LMMGSfontclose")
		frameclose.hover = false
		frameclose.DoClick = function()
			DFrame:Close()
		end
		frameclose.OnCursorEntered = function(self)
			self.hover = true
		end
		frameclose.OnCursorExited = function(self)
			self.hover = false
		end
		function frameclose:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(255,15,15,250)) or Color(255,255,255,255)) -- Paints on hover
			frameclose:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
			notification.Kill( "LMMGSBuildGang_"..LocalPlayer():SteamID64() )
		end

		local DProgress = vgui.Create( "DProgress", DFrame )
		DProgress:SetPos( 10, 40 )
		DProgress:SetSize( DFrame:GetWide() - 20, 20 )
		DProgress:SetFraction( 1 )

		local Request = vgui.Create( "DComboBox", DFrame )
		Request:SetPos( 10, 65 )
		Request:SetSize( DFrame:GetWide() - 20, 20 )
		Request:SetValue( "Should players need to request to enter your gang (you can edit later)" )
		Request:AddChoice( "No" )
		Request:AddChoice( "Yes" )
		Request.OnSelect = function( panel, index, value )
		end

		local Friendly = vgui.Create( "DComboBox", DFrame )
		Friendly:SetPos( 10, 90 )
		Friendly:SetSize( DFrame:GetWide() - 20, 20 )
		Friendly:SetValue( "Should friendly fire be a thing (you can edit later)" )
		Friendly:AddChoice( "No" )
		Friendly:AddChoice( "Yes" )
		Friendly.OnSelect = function( panel, index, value )
		end

		local NextB = vgui.Create( "DButton", DFrame )
		NextB:SetPos( 10, 115 )
		NextB:SetSize( DFrame:GetWide() - 20,20 )
		NextB:SetText( "Create Gang (Cost $"..LMMGSConfig.PriceToBuyGang..")" )
		NextB.OnCursorEntered = function(self)
			self.hover = true
		end
		NextB.OnCursorExited = function(self)
			self.hover = false
		end
		NextB.Paint = function( self, w, h )
			draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
			NextB:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
		end
		NextB.DoClick = function()
			notification.Kill( "LMMGSBuildGang_"..LocalPlayer():SteamID64() )
			DFrame:Close()
			net.Start("LMMGSCreateGangDone")
				net.WriteString(name)
				net.WriteString(description)
				net.WriteTable(color)
				net.WriteString(Request:GetValue())
				net.WriteString(Friendly:GetValue())
			net.SendToServer()
		end
	end
end

net.Receive("LMMGSCreateJoinGang", function()

	notification.Kill("LMMGSLoading_"..LocalPlayer():SteamID64())
	
	local thegangtable = net.ReadTable()

	local DFrame = vgui.Create( "DFrame" )
	DFrame:SetSize( 500, 500 )
	DFrame:Center()
	DFrame:SetDraggable( true )
	DFrame:MakePopup()
	DFrame:SetTitle( "" )
	DFrame:ShowCloseButton( false )
	DFrame.Paint = function( self, w, h )
		draw.RoundedBox(2, 0, 0, DFrame:GetWide(), DFrame:GetTall(), Color(35, 35, 35, 250))
		draw.RoundedBox(2, 0, 0, DFrame:GetWide(), 30, Color(40, 40, 40, 255))
		draw.SimpleText( "Join or Create a gang", "LMMGSTitleFont", DFrame:GetWide() / 2, 15, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local frameclose = vgui.Create("DButton", DFrame)
	frameclose:SetSize(20, 20)
	frameclose:SetPos(DFrame:GetWide() - frameclose:GetWide() - 3, 3)
	frameclose:SetText("X");
	frameclose:SetTextColor(Color(0,0,0,255))
	frameclose:SetFont("LMMGSfontclose")
	frameclose.hover = false
	frameclose.DoClick = function()
		DFrame:Close()
	end
	frameclose.OnCursorEntered = function(self)
		self.hover = true
	end
	frameclose.OnCursorExited = function(self)
		self.hover = false
	end
	function frameclose:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(255,15,15,250)) or Color(255,255,255,255)) -- Paints on hover
		frameclose:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end

	instl = vgui.Create("DLabel", DFrame)
	instl:SetText("Click on the gang you would like to join!")
	instl:SetPos(15, 30)
	instl:SetSize(500, 30)
	instl:SetTextColor(Color(255,0,0))

	local function NoItems()
		local NoItems = vgui.Create( "DLabel", DFrame )
		NoItems:SetText( "There are no gangs! Create one now!" )
		NoItems:SetFont( "LMMGSNoFont" )
		NoItems:SetTextColor( Color( 200, 200, 200 ) )
		NoItems:SizeToContents()
		NoItems:Center()
	end

	local DPanelList = vgui.Create( "DPanelList", DFrame )
	DPanelList:SetPos( 10, 60 )
	DPanelList:SetSize( DFrame:GetWide() - 20, DFrame:GetTall() - 100 )
	DPanelList:SetSpacing( 2 )
	DPanelList:EnableVerticalScrollbar( true )
	DPanelList.VBar.Paint = function( s, w, h )
		draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70))
	end
	DPanelList.VBar.btnUp.Paint = function( s, w, h ) end
	DPanelList.VBar.btnDown.Paint = function( s, w, h ) end
	DPanelList.VBar.btnGrip.Paint = function( s, w, h )
		draw.RoundedBox(4, 3, 3, DFrame:GetWide(), DFrame:GetTall(), Color(255, 255, 255, 255))
	end


	if #thegangtable <= 0 then
		NoItems()
	else
		for k, v in pairs(thegangtable) do
			local players = 0
			for i=1, 10 do
				if v[8 + i] != tostring(i) then
					players = players + 1
				end
			end

			local ItemMain = vgui.Create( "DButton", DPanelList )
			ItemMain:SetSize( DPanelList:GetWide(), 120 )
		--	ItemMain:ShowCloseButton( false )
			ItemMain:SetText( "" )
			ItemMain.Paint = function( self, w, h )
				draw.RoundedBox(2, 0, 0, DFrame:GetWide(), DFrame:GetTall(), Color(40, 40, 40, 255))
				draw.SimpleText( v[2].." ("..v[1]..")", "LMMGSTitleFont", ItemMain:GetWide() / 2, 15, Color(v[4],v[5],v[6],v[7]), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				if v[19] then
					draw.SimpleText( "Leader: "..v[3]:Nick(), "LMMGSTitleFont", ItemMain:GetWide() / 2, 35, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				else
					draw.SimpleText( "Leader: "..v[3], "LMMGSTitleFont", ItemMain:GetWide() / 2, 35, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				draw.SimpleText( v[8], "LMMGSDescFont", ItemMain:GetWide() / 2, 60, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText( "Players: "..players.."/10", "LMMGSDescFont", ItemMain:GetWide() / 2, 85, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			ItemMain.DoClick = function()
				DFrame:Close()
				local DFrame2 = vgui.Create( "DFrame" )
				DFrame2:SetSize( 300, 130 )
				DFrame2:Center()
				DFrame2:SetDraggable( true )
				DFrame2:MakePopup()
				DFrame2:SetTitle( "" )
				DFrame2:ShowCloseButton( false )
				DFrame2.Paint = function( self, w, h )
					draw.RoundedBox(2, 0, 0, DFrame2:GetWide(), DFrame2:GetTall(), Color(35, 35, 35, 250))
					draw.RoundedBox(2, 0, 0, DFrame2:GetWide(), 30, Color(40, 40, 40, 255))
					draw.SimpleText( "Gang Confirmation", "LMMGSTitleFont", DFrame2:GetWide() / 2, 15, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					draw.SimpleText( "Are you sure you would like to join this gang?", "LMMGSDescFont", DFrame2:GetWide() / 2, 50, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end

				local frameclose = vgui.Create("DButton", DFrame2)
				frameclose:SetSize(20, 20)
				frameclose:SetPos(DFrame2:GetWide() - frameclose:GetWide() - 3, 3)
				frameclose:SetText("X");
				frameclose:SetTextColor(Color(0,0,0,255))
				frameclose:SetFont("LMMGSfontclose")
				frameclose.hover = false
				frameclose.DoClick = function()
					DFrame2:Close()
				end
				frameclose.OnCursorEntered = function(self)
					self.hover = true
				end
				frameclose.OnCursorExited = function(self)
					self.hover = false
				end
				function frameclose:Paint(w, h)
					draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(255,15,15,250)) or Color(255,255,255,255)) -- Paints on hover
					frameclose:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
				end

				local YesB = vgui.Create( "DButton", DFrame2 )
				YesB:SetPos( 10, 65 )
				YesB:SetSize( DFrame2:GetWide() - 20,20 )
				YesB:SetText( "Yes" )
				YesB.OnCursorEntered = function(self)
					self.hover = true
				end
				YesB.OnCursorExited = function(self)
					self.hover = false
				end
				YesB.Paint = function( self, w, h )
					draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
					YesB:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
				end
				YesB.DoClick = function()
					DFrame2:Close()
					if v[20] == 1 then
						if v[19] == true then
							net.Start("LMMGSRequestGangEntry")
								net.WriteString(v[1])
							net.SendToServer()
						else
							chat.AddText(Color(0,0,0), "[Gang System]", Color(255,255,255), ": Please wait until the leader of this gang is online!")
						end
					else
						net.Start("LMMGSJoinGangNoRequest")
							net.WriteString(v[1])
						net.SendToServer()
					end
				end

				local NoB = vgui.Create( "DButton", DFrame2 )
				NoB:SetPos( 10, 90 )
				NoB:SetSize( DFrame2:GetWide() - 20,20 )
				NoB:SetText( "No" )
				NoB.OnCursorEntered = function(self)
					self.hover = true
				end
				NoB.OnCursorExited = function(self)
					self.hover = false
				end
				NoB.Paint = function( self, w, h )
					draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
					NoB:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
				end
				NoB.DoClick = function()
					LocalPlayer():ConCommand("say /gang")
					DFrame2:Close()
				end
			end

			DPanelList:AddItem(ItemMain)
		end
	end

	local CreateB = vgui.Create( "DButton", DFrame )
	CreateB:SetPos( 10, 470 )
	CreateB:SetSize( DFrame:GetWide() - 20,20 )
	CreateB:SetText( "Create Gang" )
	CreateB.OnCursorEntered = function(self)
		self.hover = true
	end
	CreateB.OnCursorExited = function(self)
		self.hover = false
	end
	CreateB.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		CreateB:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	CreateB.DoClick = function()
		DFrame:Close()
		LMMGSCreateGang()
	end
end)

net.Receive("LMMGSGangLoading",function()
	notification.AddProgress("LMMGSLoading_"..LocalPlayer():SteamID64(),"Gang system loading...")
end)

net.Receive("LMMGSRequestGangEntryLeader", function()
    local _, chatY = chat.GetChatBoxPos()
	local PanelNum = 0
	local ply = net.ReadEntity()
    local question = ply:Nick().." want's to join your gang!"
    local timeleft = 15
    local OldTime = CurTime()
    if not IsValid(LocalPlayer()) then return end -- Sent right before player initialisation

    LocalPlayer():EmitSound("Town.d1_town_02_elevbell1", 100, 100)
    local panel = vgui.Create("DFrame")
    panel:SetPos(3 + PanelNum, chatY - 145)
    panel:SetTitle(DarkRP.getPhrase("vote"))
    panel:SetSize(300, 100)
    panel:SetSizable(false)
    panel.btnClose:SetVisible(false)
    panel.btnMaxim:SetVisible(false)
    panel.btnMinim:SetVisible(false)
    panel:SetDraggable(false)
	panel.Paint = function()
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(35, 35, 35, 250))
		draw.RoundedBox(2, 0, 0, panel:GetWide(), 30, Color(40, 40, 40, 255))
		draw.SimpleText( "Gang Confirmation", "LMMGSDescFont", panel:GetWide() / 2, 15, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
--		draw.SimpleText( "Are you sure you would like to join this gang?", "LMMGSDescFont", panel:GetWide() / 2, 50, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
    function panel:Close()
        self:Remove()
    end

    function panel:Think()
        self:SetTitle("Time: " .. tostring(math.Clamp(math.ceil(timeleft - (CurTime() - OldTime)), 0, 9999)))
        if timeleft - (CurTime() - OldTime) <= 0 then
            panel:Close()
        end
    end

    panel:SetKeyboardInputEnabled(false)
    panel:SetMouseInputEnabled(true)
    panel:SetVisible(true)

    local label = vgui.Create("DLabel", panel)
    label:SetPos(5, 40)
	label:SetSize(300, 20)
    label:SetText(question)
    label:SetFont("LMMGSDescFont")
    label:SetVisible(true)

    local nextHeight = label:GetTall() > 78 and label:GetTall() - 78 or 0 -- make panel taller for divider and buttons
    panel:SetTall(panel:GetTall() + nextHeight)

    local divider = vgui.Create("Divider")
    divider:SetParent(panel)
    divider:SetPos(2, panel:GetTall() - 30)
    divider:SetSize(180, 2)
    divider:SetVisible(true)

    local ybutton = vgui.Create("Button")
    ybutton:SetParent(panel)
    ybutton:SetPos(15, panel:GetTall() - 25)
    ybutton:SetSize(125, 20)
    ybutton:SetCommand("!")
    ybutton:SetText(DarkRP.getPhrase("yes"))
    ybutton:SetVisible(true)
	ybutton.OnCursorEntered = function(self)
		self.hover = true
	end
	ybutton.OnCursorExited = function(self)
		self.hover = false
	end
	ybutton.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		ybutton:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
    ybutton.DoClick = function()
		net.Start("LMMGSAcceptedIntoGang")
			net.WriteEntity(ply)
		net.SendToServer()
        panel:Close()
    end

    local nbutton = vgui.Create("Button")
    nbutton:SetParent(panel)
    nbutton:SetPos(panel:GetWide() - 140, panel:GetTall() - 25)
    nbutton:SetSize(125, 20)
    nbutton:SetCommand("!")
    nbutton:SetText(DarkRP.getPhrase("no"))
    nbutton:SetVisible(true)
	nbutton.OnCursorEntered = function(self)
		self.hover = true
	end
	nbutton.OnCursorExited = function(self)
		self.hover = false
	end
	nbutton.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		nbutton:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
    nbutton.DoClick = function()
        panel:Close()
    end
end)

net.Receive("LMMGSOpenGangViewer", function()
	local thetable = net.ReadTable()[1][1]
	local thetable2 = net.ReadString()

	local colortbl = string.Explode("|", thetable.color)
	local thegangschat = string.Explode("|", thetable2)

	local DFrame = vgui.Create( "DFrame" )
	DFrame:SetTitle("")
	DFrame:ShowCloseButton(false)
	DFrame:SetSize( 500, 300 )
	DFrame:Center()
	DFrame:MakePopup()
	DFrame.Paint = function()
		draw.RoundedBox(2, 0, 0, DFrame:GetWide(), DFrame:GetTall(), Color(35, 35, 35, 250))
		draw.RoundedBox(2, 0, 0, DFrame:GetWide(), 30, Color(40, 40, 40, 255))
		draw.SimpleText( "Gang Viewer", "LMMGSDescFont", DFrame:GetWide() / 2, 15, Color(colortbl[1], colortbl[2], colortbl[3], colortbl[4]), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local frameclose = vgui.Create("DButton", DFrame)
	frameclose:SetSize(20, 20)
	frameclose:SetPos(DFrame:GetWide() - frameclose:GetWide() - 3, 3)
	frameclose:SetText("X");
	frameclose:SetTextColor(Color(0,0,0,255))
	frameclose:SetFont("LMMGSfontclose")
	frameclose.hover = false
	frameclose.DoClick = function()
		DFrame:Close()
	end
	frameclose.OnCursorEntered = function(self)
		self.hover = true
	end
	frameclose.OnCursorExited = function(self)
		self.hover = false
	end
	function frameclose:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(255,15,15,250)) or Color(255,255,255,255)) -- Paints on hover
		frameclose:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end

	local sheet = vgui.Create( "DColumnSheet", DFrame )
	sheet:Dock( FILL )

	local panel1 = vgui.Create( "DPanel", sheet )
	panel1:Dock( FILL )
	panel1.Paint = function()
		draw.RoundedBox(2, 0, 0, panel1:GetWide(), panel1:GetTall(), Color(35, 35, 35, 250))
	end
	sheet:AddSheet( "Settings", panel1 )

	local leavegang = vgui.Create("DButton", panel1)
	leavegang:SetText("Leave Gang")
	leavegang:SetPos( 10, 10 )
	leavegang:SetSize( 360, 20 )
	leavegang.OnCursorEntered = function(self)
		self.hover = true
	end
	leavegang.OnCursorExited = function(self)
		self.hover = false
	end
	leavegang.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		leavegang:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	leavegang.DoClick = function()
		DFrame:Close()
			local DFrame2 = vgui.Create( "DFrame" )
			DFrame2:SetTitle("")
			DFrame2:ShowCloseButton(false)
			DFrame2:SetSize( 300, 120 )
			DFrame2:Center()
			DFrame2:MakePopup()
			DFrame2.Paint = function()
				draw.RoundedBox(2, 0, 0, DFrame2:GetWide(), DFrame2:GetTall(), Color(35, 35, 35, 250))
				draw.RoundedBox(2, 0, 0, DFrame2:GetWide(), 30, Color(40, 40, 40, 255))
				draw.SimpleText( "Gang Viewer (Leave Gang?)", "LMMGSDescFont", DFrame2:GetWide() / 2, 15, Color(colortbl[1], colortbl[2], colortbl[3], colortbl[4]), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			local frameclose = vgui.Create("DButton", DFrame2)
			frameclose:SetSize(20, 20)
			frameclose:SetPos(DFrame2:GetWide() - frameclose:GetWide() - 3, 3)
			frameclose:SetText("X");
			frameclose:SetTextColor(Color(0,0,0,255))
			frameclose:SetFont("LMMGSfontclose")
			frameclose.hover = false
			frameclose.DoClick = function()
				DFrame2:Close()
			end
			frameclose.OnCursorEntered = function(self)
				self.hover = true
			end
			frameclose.OnCursorExited = function(self)
				self.hover = false
			end
			function frameclose:Paint(w, h)
				draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(255,15,15,250)) or Color(255,255,255,255)) -- Paints on hover
				frameclose:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
			end

			local AYSL = vgui.Create("DLabel",DFrame2)
			AYSL:SetText("Are you sure you wanna leave?")
			AYSL:SetPos(10, 30)
			AYSL:SetSize(300, 20)
			AYSL:SetFont("LMMGSDescFont")

			local YesB = vgui.Create("DButton", DFrame2)
			YesB:SetText("Yes")
			YesB:SetPos( 10, 60 )
			YesB:SetSize( DFrame2:GetWide() - 20, 20 )
			YesB.OnCursorEntered = function(self)
				self.hover = true
			end
			YesB.OnCursorExited = function(self)
				self.hover = false
			end
			YesB.Paint = function( self, w, h )
				draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
				YesB:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
			end
			YesB.DoClick = function()
				net.Start("LMMGSLeaveGangN")
				net.SendToServer()
				DFrame2:Close()
			end

			local NoB = vgui.Create("DButton", DFrame2)
			NoB:SetText("No")
			NoB:SetPos( 10, 85 )
			NoB:SetSize( DFrame2:GetWide() - 20, 20 )
			NoB.OnCursorEntered = function(self)
				self.hover = true
			end
			NoB.OnCursorExited = function(self)
				self.hover = false
			end
			NoB.Paint = function( self, w, h )
				draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
				NoB:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
			end
			NoB.DoClick = function()
				DFrame2:Close()
				LocalPlayer():ConCommand("say /gang")
			end
	end

	local panel2 = vgui.Create( "DPanel", sheet )
	panel2:Dock( FILL )
	panel2.Paint = function()
		draw.RoundedBox(2, 0, 0, panel2:GetWide(), panel2:GetTall(), Color(35, 35, 35, 250))
	end
	sheet:AddSheet( "Players", panel2 )

	local players1 = vgui.Create("DButton", panel2)
	players1:SetText(thetable.player1)
	players1:SetPos( 10, 10 )
	players1:SetSize( 360, 20 )
	players1.OnCursorEntered = function(self)
		self.hover = true
	end
	players1.OnCursorExited = function(self)
		self.hover = false
	end
	players1.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players1:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players1.DoClick = function()
	end

	local players2 = vgui.Create("DButton", panel2)
	players2:SetText(thetable.player2)
	players2:SetPos( 10, 35 )
	players2:SetSize( 360, 20 )
	players2.OnCursorEntered = function(self)
		self.hover = true
	end
	players2.OnCursorExited = function(self)
		self.hover = false
	end
	players2.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players2:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players2.DoClick = function()
	end

	local players3 = vgui.Create("DButton", panel2)
	players3:SetText(thetable.player3)
	players3:SetPos( 10, 60 )
	players3:SetSize( 360, 20 )
	players3.OnCursorEntered = function(self)
		self.hover = true
	end
	players3.OnCursorExited = function(self)
		self.hover = false
	end
	players3.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players3:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players3.DoClick = function()
	end

	local players4 = vgui.Create("DButton", panel2)
	players4:SetText(thetable.player4)
	players4:SetPos( 10, 85 )
	players4:SetSize( 360, 20 )
	players4.OnCursorEntered = function(self)
		self.hover = true
	end
	players4.OnCursorExited = function(self)
		self.hover = false
	end
	players4.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players4:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players4.DoClick = function()
	end

	local players5 = vgui.Create("DButton", panel2)
	players5:SetText(thetable.player5)
	players5:SetPos( 10, 110 )
	players5:SetSize( 360, 20 )
	players5.OnCursorEntered = function(self)
		self.hover = true
	end
	players5.OnCursorExited = function(self)
		self.hover = false
	end
	players5.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players5:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players5.DoClick = function()
	end

	local players6 = vgui.Create("DButton", panel2)
	players6:SetText(thetable.player6)
	players6:SetPos( 10, 135 )
	players6:SetSize( 360, 20 )
	players6.OnCursorEntered = function(self)
		self.hover = true
	end
	players6.OnCursorExited = function(self)
		self.hover = false
	end
	players6.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players6:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players6.DoClick = function()
	end

	local players7 = vgui.Create("DButton", panel2)
	players7:SetText(thetable.player7)
	players7:SetPos( 10, 160 )
	players7:SetSize( 360, 20 )
	players7.OnCursorEntered = function(self)
		self.hover = true
	end
	players7.OnCursorExited = function(self)
		self.hover = false
	end
	players7.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players7:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players7.DoClick = function()
	end

	local players8 = vgui.Create("DButton", panel2)
	players8:SetText(thetable.player8)
	players8:SetPos( 10, 185 )
	players8:SetSize( 360, 20 )
	players8.OnCursorEntered = function(self)
		self.hover = true
	end
	players8.OnCursorExited = function(self)
		self.hover = false
	end
	players8.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players8:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players8.DoClick = function()
	end

	local players9 = vgui.Create("DButton", panel2)
	players9:SetText(thetable.player9)
	players9:SetPos( 10, 210 )
	players9:SetSize( 360, 20 )
	players9.OnCursorEntered = function(self)
		self.hover = true
	end
	players9.OnCursorExited = function(self)
		self.hover = false
	end
	players9.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players9:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players9.DoClick = function()
	end

	local players10 = vgui.Create("DButton", panel2)
	players10:SetText(thetable.player10)
	players10:SetPos( 10, 235 )
	players10:SetSize( 360, 20 )
	players10.OnCursorEntered = function(self)
		self.hover = true
	end
	players10.OnCursorExited = function(self)
		self.hover = false
	end
	players10.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players10:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players10.DoClick = function()
	end

	local panel3 = vgui.Create( "DPanel", sheet )
	panel3:Dock( FILL )
	panel3.Paint = function()
		draw.RoundedBox(2, 0, 0, panel3:GetWide(), panel3:GetTall(), Color(35, 35, 35, 250))
	end
	sheet:AddSheet( "Gang Chat", panel3 )

	local richtext = vgui.Create( "RichText", panel3 )
	richtext:SetPos(10, 10)
	richtext:SetSize(360, 210)

	richtext:InsertColorChange( 110, 110, 110, 255 )
	for k, v in pairs(thegangschat) do
		richtext:AppendText( v.."\n" )
	end

	richtext:InsertColorChange( 192, 192, 192, 255 )

	net.Receive("LMMGSReceiveMessage", function()
		local message = net.ReadString()
		local ply = net.ReadEntity()

		if IsValid(richtext) then
			richtext:InsertColorChange(192,192,192,255)
			richtext:AppendText( os.date("%I:%M:%S %p") )
			richtext:InsertColorChange(255,255,255,255)
			richtext:AppendText(" - ")
			local plycolor = team.GetColor(ply:Team())
			richtext:InsertColorChange(plycolor.r, plycolor.g, plycolor.b, plycolor.a)
			richtext:AppendText(ply:Nick())
			richtext:InsertColorChange(255,255,255,255)
			richtext:AppendText(": "..message.."\n")
		end
	end)

	local entrybox = vgui.Create( 'DTextEntry', panel3 )
	entrybox:SetPos( 10, 235 )
	entrybox:SetSize( 360, 20 )
	entrybox:SetText("Enter chat message...")
	entrybox.OnEnter = function( self )
		net.Start( "LMMGSSendMessage" )
			net.WriteString( self:GetText() )
		net.SendToServer()
		self:SetText("Enter chat message...")
	end
end)

net.Receive("LMMGSOpenGangManager", function()
	local thetable = net.ReadTable()[1][1]
	local thetable2 = net.ReadString()

	local colortbl = string.Explode("|", thetable.color)
	local thegangschat = string.Explode("|", thetable2)

	local DFrame = vgui.Create( "DFrame" )
	DFrame:SetTitle("")
	DFrame:ShowCloseButton(false)
	DFrame:SetSize( 500, 300 )
	DFrame:Center()
	DFrame:MakePopup()
	DFrame.Paint = function()
		draw.RoundedBox(2, 0, 0, DFrame:GetWide(), DFrame:GetTall(), Color(35, 35, 35, 250))
		draw.RoundedBox(2, 0, 0, DFrame:GetWide(), 30, Color(40, 40, 40, 255))
		draw.SimpleText( "Gang Manager", "LMMGSDescFont", DFrame:GetWide() / 2, 15, Color(colortbl[1], colortbl[2], colortbl[3], colortbl[4]), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local frameclose = vgui.Create("DButton", DFrame)
	frameclose:SetSize(20, 20)
	frameclose:SetPos(DFrame:GetWide() - frameclose:GetWide() - 3, 3)
	frameclose:SetText("X");
	frameclose:SetTextColor(Color(0,0,0,255))
	frameclose:SetFont("LMMGSfontclose")
	frameclose.hover = false
	frameclose.DoClick = function()
		DFrame:Close()
	end
	frameclose.OnCursorEntered = function(self)
		self.hover = true
	end
	frameclose.OnCursorExited = function(self)
		self.hover = false
	end
	function frameclose:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(255,15,15,250)) or Color(255,255,255,255)) -- Paints on hover
		frameclose:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end

	local sheet = vgui.Create( "DColumnSheet", DFrame )
	sheet:Dock( FILL )

	local panel1 = vgui.Create( "DPanel", sheet )
	panel1:Dock( FILL )
	panel1.Paint = function()
		draw.RoundedBox(2, 0, 0, panel1:GetWide(), panel1:GetTall(), Color(35, 35, 35, 250))
	end
	sheet:AddSheet( "Settings", panel1 )

	local Request = vgui.Create( "DComboBox", panel1 )
	Request:SetPos( 10, 10 )
	Request:SetSize( 360, 20 )
	Request:SetValue( "Should players need to request to enter your gang" )
	Request:AddChoice( "No" )
	Request:AddChoice( "Yes" )
	Request.OnSelect = function( panel, index, value )
	end

	local Friendly = vgui.Create( "DComboBox", panel1 )
	Friendly:SetPos( 10, 35 )
	Friendly:SetSize( 360, 20 )
	Friendly:SetValue( "Should friendly fire be a thing" )
	Friendly:AddChoice( "No" )
	Friendly:AddChoice( "Yes" )
	Friendly.OnSelect = function( panel, index, value )
	end

	local GangColor = vgui.Create( "DColorMixer", panel1 )
	GangColor:SetPos(10, 65)
	GangColor:SetSize(360, 100)
	GangColor:SetPalette( false )
	GangColor:SetAlphaBar( true )
	GangColor:SetWangs( true )
	GangColor:SetColor( Color( colortbl[1], colortbl[2], colortbl[3], colortbl[4] ) )

	local GangName = vgui.Create( "DTextEntry", panel1 )
	GangName:SetPos( 10, 175 )
	GangName:SetSize( 360, 20 )
	GangName:SetText( thetable.gangname )
	GangName.OnEnter = function( self )
		chat.AddText( Color(255,0,0), "Finish entering everything then click submit!" )
	end

	local GangDesc = vgui.Create( "DTextEntry", panel1 )
	GangDesc:SetPos( 10, 200 )
	GangDesc:SetSize( 360, 20 )
	GangDesc:SetText( thetable.description )
	GangDesc.OnEnter = function( self )
		chat.AddText( Color(255,0,0), "Finish entering everything then click submit!" )
	end

	local SaveB = vgui.Create( "DButton", panel1 )
	SaveB:SetPos( 10, 240 )
	SaveB:SetSize( 360,20 )
	SaveB:SetText( "Save Settings" )
	SaveB.OnCursorEntered = function(self)
		self.hover = true
	end
	SaveB.OnCursorExited = function(self)
		self.hover = false
	end
	SaveB.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		SaveB:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	SaveB.DoClick = function()
		net.Start("LMMGSUpdateGang")
			net.WriteString(Request:GetValue())
			net.WriteString(Friendly:GetValue())
			net.WriteTable(GangColor:GetColor())
			net.WriteString(GangName:GetValue())
			net.WriteString(GangDesc:GetValue())
		net.SendToServer()
		DFrame:Close()
	end

	local dsettings = vgui.Create( "DPanel", sheet )
	dsettings:Dock( FILL )
	dsettings.Paint = function()
		draw.RoundedBox(2, 0, 0, dsettings:GetWide(), dsettings:GetTall(), Color(35, 35, 35, 250))
	end
	sheet:AddSheet( "Dangerous Settings", dsettings )

	local leavegang = vgui.Create("DButton", dsettings)
	leavegang:SetText("Delete Gang")
	leavegang:SetPos( 10, 10 )
	leavegang:SetSize( 360, 20 )
	leavegang.OnCursorEntered = function(self)
		self.hover = true
	end
	leavegang.OnCursorExited = function(self)
		self.hover = false
	end
	leavegang.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		leavegang:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	leavegang.DoClick = function()
		DFrame:Close()
			local DFrame2 = vgui.Create( "DFrame" )
			DFrame2:SetTitle("")
			DFrame2:ShowCloseButton(false)
			DFrame2:SetSize( 300, 120 )
			DFrame2:Center()
			DFrame2:MakePopup()
			DFrame2.Paint = function()
				draw.RoundedBox(2, 0, 0, DFrame2:GetWide(), DFrame2:GetTall(), Color(35, 35, 35, 250))
				draw.RoundedBox(2, 0, 0, DFrame2:GetWide(), 30, Color(40, 40, 40, 255))
				draw.SimpleText( "Gang Viewer (Delete Gang?)", "LMMGSDescFont", DFrame2:GetWide() / 2, 15, Color(colortbl[1], colortbl[2], colortbl[3], colortbl[4]), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			local frameclose = vgui.Create("DButton", DFrame2)
			frameclose:SetSize(20, 20)
			frameclose:SetPos(DFrame2:GetWide() - frameclose:GetWide() - 3, 3)
			frameclose:SetText("X");
			frameclose:SetTextColor(Color(0,0,0,255))
			frameclose:SetFont("LMMGSfontclose")
			frameclose.hover = false
			frameclose.DoClick = function()
				DFrame2:Close()
			end
			frameclose.OnCursorEntered = function(self)
				self.hover = true
			end
			frameclose.OnCursorExited = function(self)
				self.hover = false
			end
			function frameclose:Paint(w, h)
				draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(255,15,15,250)) or Color(255,255,255,255)) -- Paints on hover
				frameclose:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
			end

			local AYSL = vgui.Create("DLabel",DFrame2)
			AYSL:SetText("Are you sure you wanna delete?")
			AYSL:SetPos(10, 30)
			AYSL:SetSize(300, 20)
			AYSL:SetFont("LMMGSDescFont")

			local YesB = vgui.Create("DButton", DFrame2)
			YesB:SetText("Yes")
			YesB:SetPos( 10, 60 )
			YesB:SetSize( DFrame2:GetWide() - 20, 20 )
			YesB.OnCursorEntered = function(self)
				self.hover = true
			end
			YesB.OnCursorExited = function(self)
				self.hover = false
			end
			YesB.Paint = function( self, w, h )
				draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
				YesB:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
			end
			YesB.DoClick = function()
				net.Start("LMMGSDeleteGangN")
				net.SendToServer()
				DFrame2:Close()
			end

			local NoB = vgui.Create("DButton", DFrame2)
			NoB:SetText("No")
			NoB:SetPos( 10, 85 )
			NoB:SetSize( DFrame2:GetWide() - 20, 20 )
			NoB.OnCursorEntered = function(self)
				self.hover = true
			end
			NoB.OnCursorExited = function(self)
				self.hover = false
			end
			NoB.Paint = function( self, w, h )
				draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
				NoB:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
			end
			NoB.DoClick = function()
				DFrame2:Close()
				LocalPlayer():ConCommand("say /gang")
			end
	end

	local panel2 = vgui.Create( "DPanel", sheet )
	panel2:Dock( FILL )
	panel2.Paint = function()
		draw.RoundedBox(2, 0, 0, panel2:GetWide(), panel2:GetTall(), Color(35, 35, 35, 250))
	end
	sheet:AddSheet( "Players", panel2 )

	local players1 = vgui.Create("DButton", panel2)
	players1:SetText(thetable.player1)
	players1:SetPos( 10, 10 )
	players1:SetSize( 360, 20 )
	players1.OnCursorEntered = function(self)
		self.hover = true
	end
	players1.OnCursorExited = function(self)
		self.hover = false
	end
	players1.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players1:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players1.DoClick = function()
		local menu = DermaMenu()
		menu:AddOption( "Kick from gang", function()
			net.Start("LMMGSKickFromGang")
				net.WriteFloat(1)
				net.WriteString(players1:GetText())
			net.SendToServer()
			DFrame:Close()
		end )
		menu:Open()
	end

	local players2 = vgui.Create("DButton", panel2)
	players2:SetText(thetable.player2)
	players2:SetPos( 10, 35 )
	players2:SetSize( 360, 20 )
	players2.OnCursorEntered = function(self)
		self.hover = true
	end
	players2.OnCursorExited = function(self)
		self.hover = false
	end
	players2.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players2:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players2.DoClick = function()
		local menu = DermaMenu()
		menu:AddOption( "Kick from gang", function()
			net.Start("LMMGSKickFromGang")
				net.WriteFloat(2)
				net.WriteString(players2:GetText())
			net.SendToServer()
			DFrame:Close()
		end )
		menu:Open()
	end

	local players3 = vgui.Create("DButton", panel2)
	players3:SetText(thetable.player3)
	players3:SetPos( 10, 60 )
	players3:SetSize( 360, 20 )
	players3.OnCursorEntered = function(self)
		self.hover = true
	end
	players3.OnCursorExited = function(self)
		self.hover = false
	end
	players3.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players3:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players3.DoClick = function()
		local menu = DermaMenu()
		menu:AddOption( "Kick from gang", function()
			net.Start("LMMGSKickFromGang")
				net.WriteFloat(3)
				net.WriteString(players3:GetText())
			net.SendToServer()
			DFrame:Close()
		end )
		menu:Open()
	end

	local players4 = vgui.Create("DButton", panel2)
	players4:SetText(thetable.player4)
	players4:SetPos( 10, 85 )
	players4:SetSize( 360, 20 )
	players4.OnCursorEntered = function(self)
		self.hover = true
	end
	players4.OnCursorExited = function(self)
		self.hover = false
	end
	players4.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players4:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players4.DoClick = function()
		local menu = DermaMenu()
		menu:AddOption( "Kick from gang", function()
			net.Start("LMMGSKickFromGang")
				net.WriteFloat(4)
				net.WriteString(players4:GetText())
			net.SendToServer()
			DFrame:Close()
		end )
		menu:Open()
	end

	local players5 = vgui.Create("DButton", panel2)
	players5:SetText(thetable.player5)
	players5:SetPos( 10, 110 )
	players5:SetSize( 360, 20 )
	players5.OnCursorEntered = function(self)
		self.hover = true
	end
	players5.OnCursorExited = function(self)
		self.hover = false
	end
	players5.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players5:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players5.DoClick = function()
		local menu = DermaMenu()
		menu:AddOption( "Kick from gang", function()
			net.Start("LMMGSKickFromGang")
				net.WriteFloat(5)
				net.WriteString(players5:GetText())
			net.SendToServer()
			DFrame:Close()
		end )
		menu:Open()
	end

	local players6 = vgui.Create("DButton", panel2)
	players6:SetText(thetable.player6)
	players6:SetPos( 10, 135 )
	players6:SetSize( 360, 20 )
	players6.OnCursorEntered = function(self)
		self.hover = true
	end
	players6.OnCursorExited = function(self)
		self.hover = false
	end
	players6.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players6:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players6.DoClick = function()
		local menu = DermaMenu()
		menu:AddOption( "Kick from gang", function()
			net.Start("LMMGSKickFromGang")
				net.WriteFloat(6)
				net.WriteString(players6:GetText())
			net.SendToServer()
			DFrame:Close()
		end )
		menu:Open()
	end

	local players7 = vgui.Create("DButton", panel2)
	players7:SetText(thetable.player7)
	players7:SetPos( 10, 160 )
	players7:SetSize( 360, 20 )
	players7.OnCursorEntered = function(self)
		self.hover = true
	end
	players7.OnCursorExited = function(self)
		self.hover = false
	end
	players7.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players7:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players7.DoClick = function()
		local menu = DermaMenu()
		menu:AddOption( "Kick from gang", function()
			net.Start("LMMGSKickFromGang")
				net.WriteFloat(7)
				net.WriteString(players7:GetText())
			net.SendToServer()
			DFrame:Close()
		end )
		menu:Open()
	end

	local players8 = vgui.Create("DButton", panel2)
	players8:SetText(thetable.player8)
	players8:SetPos( 10, 185 )
	players8:SetSize( 360, 20 )
	players8.OnCursorEntered = function(self)
		self.hover = true
	end
	players8.OnCursorExited = function(self)
		self.hover = false
	end
	players8.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players8:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players8.DoClick = function()
		local menu = DermaMenu()
		menu:AddOption( "Kick from gang", function()
			net.Start("LMMGSKickFromGang")
				net.WriteFloat(8)
				net.WriteString(players8:GetText())
			net.SendToServer()
			DFrame:Close()
		end )
		menu:Open()
	end

	local players9 = vgui.Create("DButton", panel2)
	players9:SetText(thetable.player9)
	players9:SetPos( 10, 210 )
	players9:SetSize( 360, 20 )
	players9.OnCursorEntered = function(self)
		self.hover = true
	end
	players9.OnCursorExited = function(self)
		self.hover = false
	end
	players9.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players9:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players9.DoClick = function()
		local menu = DermaMenu()
		menu:AddOption( "Kick from gang", function()
			net.Start("LMMGSKickFromGang")
				net.WriteFloat(9)
				net.WriteString(players9:GetText())
			net.SendToServer()
			DFrame:Close()
		end )
		menu:Open()
	end

	local players10 = vgui.Create("DButton", panel2)
	players10:SetText(thetable.player10)
	players10:SetPos( 10, 235 )
	players10:SetSize( 360, 20 )
	players10.OnCursorEntered = function(self)
		self.hover = true
	end
	players10.OnCursorExited = function(self)
		self.hover = false
	end
	players10.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, (self.hover and Color(0,160,255,250)) or Color(255,255,255,255)) -- Paints on hover
		players10:SetTextColor(self.hover and Color(255,255,255,250) or Color(0,0,0,255))
	end
	players10.DoClick = function()
		local menu = DermaMenu()
		menu:AddOption( "Kick from gang", function()
			net.Start("LMMGSKickFromGang")
				net.WriteFloat(10)
				net.WriteString(players10:GetText())
			net.SendToServer()
			DFrame:Close()
		end )
		menu:Open()
	end

	local panel3 = vgui.Create( "DPanel", sheet )
	panel3:Dock( FILL )
	panel3.Paint = function()
		draw.RoundedBox(2, 0, 0, panel3:GetWide(), panel3:GetTall(), Color(35, 35, 35, 250))
	end
	sheet:AddSheet( "Gang Chat", panel3 )

	local richtext = vgui.Create( "RichText", panel3 )
	richtext:SetPos(10, 10)
	richtext:SetSize(360, 210)

	richtext:InsertColorChange( 110, 110, 110, 255 )
	for k, v in pairs(thegangschat) do
		richtext:AppendText( v.."\n" )
	end

	richtext:InsertColorChange( 192, 192, 192, 255 )

	net.Receive("LMMGSReceiveMessage", function()
		local message = net.ReadString()
		local ply = net.ReadEntity()

		if IsValid(richtext) then
			richtext:InsertColorChange(192,192,192,255)
			richtext:AppendText( os.date("%I:%M:%S %p") )
			richtext:InsertColorChange(255,255,255,255)
			richtext:AppendText(" - ")
			local plycolor = team.GetColor(ply:Team())
			richtext:InsertColorChange(plycolor.r, plycolor.g, plycolor.b, plycolor.a)
			richtext:AppendText(ply:Nick())
			richtext:InsertColorChange(255,255,255,255)
			richtext:AppendText(": "..message.."\n")
		end
	end)

	local entrybox = vgui.Create( 'DTextEntry', panel3 )
	entrybox:SetPos( 10, 235 )
	entrybox:SetSize( 360, 20 )
	entrybox:SetText("Enter chat message...")
	entrybox.OnEnter = function( self )
		net.Start( "LMMGSSendMessage" )
			net.WriteString( self:GetText() )
		net.SendToServer()
		self:SetText("Enter chat message...")
	end
end)

net.Receive("LMMGSNotifyN", function()
	local message = net.ReadString()
	chat.AddText(Color(0,0,0), "[Gang System]", Color(255,255,255), ": "..message)
end)

net.Receive("LMMGSDrawColorForGang",function()
	local color = net.ReadTable()
	local v = net.ReadEntity()
	local mat = Material("pp/morph/brush_outline")
	hook.Add("PostDrawTranslucentRenderables", "Party Player Mark", function()
				cam.Start3D2D( v:GetPos() + Vector(0,0,0),Angle(0,0,0), 0.25 )
					local Size = 100
					surface.SetMaterial(mat)
					surface.SetDrawColor(color)
					surface.DrawTexturedRect( -Size,-Size,Size*2, Size*2 )
				cam.End3D2D()
	end)
end)
