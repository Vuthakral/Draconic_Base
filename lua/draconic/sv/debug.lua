util.AddNetworkString("DRC_RenderTrace")

function DRC:RenderTrace(tr, colour, thyme)
	if !game.SinglePlayer() then return end
	
	local tbl = {tr, colour, thyme}
	net.Start("DRC_RenderTrace")
	net.WriteTable(tbl)
	net.Broadcast()
end