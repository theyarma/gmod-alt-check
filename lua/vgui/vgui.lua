local function AltCheckGui()
    local frame = vgui.Create("DFrame")
    frame:SetSize(300, 300)
    frame:SetTitle("Alt Checker 1.0")
    frame:Center()
    frame:MakePopup()

    local button = vgui.Create("DButton", frame)
    button:SendText("Send To Server")
    button:SendSize(200, 50)
    button:SetPos(50, 100)

    button.DoClick = function()
        net.Start("CheckerButtonEvent")
        net.WriteString("Client Side connection established.")
        net.SendToServer()
    end
end

concommand.Add("!altcheck", AltCheckGui)