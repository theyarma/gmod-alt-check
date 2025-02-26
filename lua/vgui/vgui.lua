local function AltCheckGui()
    local frame = vgui.Create("DFrame")
    frame:SetSize(1000, 1000)
    frame:SetTitle("Alt Checker 1.0")
    frame:Center()
    frame:MakePopup()

    local button = vgui.Create("DButton", frame)
    button:SetText("Send To Server")
    button:SetSize(200, 50)
    button:Center()

    button.DoClick = function()
        net.Start("CheckerButtonEvent")
        net.WriteString("Client Side connection established.")
        net.SendToServer()
    end

end

concommand.Add("alt_check", AltCheckGui)