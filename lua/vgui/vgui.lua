local function AltCheckGui()
    local frame = vgui.Create("DFrame")
    frame:SetSize(1000, 1000) -- Teacher: Consider using a more dynamic or relative sizing so the GUI fits different screen resolutions.
    frame:SetTitle("Alt Checker 1.0")
    frame:Center()
    frame:MakePopup()

    local button = vgui.Create("DButton", frame)
    button:SetText("Send To Server")
    button:SetSize(200, 50)
    button:Center()

    button.DoClick = function()
        -- Teacher: Good job using net messages to communicate with the server. 
        -- Consider adding error handling or confirmation feedback to the user.
        net.Start("CheckerButtonEvent")
        net.WriteString("Client Side connection established.")
        net.SendToServer()
    end

end

concommand.Add("alt_check", AltCheckGui) -- Teacher: Nice use of a console command to trigger the GUI. Ensure that this command is documented for end-users.
