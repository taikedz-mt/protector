-- Add protection owners to ShadowNinja's areas hud

local get_protector_area = function(pos,res)

	local radius = (tonumber(minetest.setting_get("protector_radius")) or 5)
	local protectors = minetest.find_nodes_in_area(
		{x=pos.x -radius , y=pos.y -radius , z=pos.z -radius},
		{x=pos.x +radius , y=pos.y +radius , z=pos.z +radius},
		{"protector:protect","protector:protect2"}
	)

	if #protectors > 0 then
		local npos = protectors[1] -- conflicting nodes cannot overlap, the first is the only one needed
		local node = minetest.get_node(npos)
		local meta = minetest.get_meta(npos)
		local nodeowner = meta:get_string("owner")

		res[node.name] = {owner=nodeowner}
	end

	return res
end

areas:registerHudHandler(get_protector_area)
