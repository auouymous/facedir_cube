facedir_cube = {}
local MP = minetest.get_modpath("facedir_cube").."/"

-- yaw = 0-3 = NESW = minetest.dir_to_facedir(vector.subtract(pointed_thing.above, placer:get_pos()))

-- 0*4 (+Y: U) - rotate cw around U face: green -> NESW
-- 1*4 (+X: U -> N) - rotate cw around N face: green -> DEUW
-- 2*4 (-X: U -> S) - rotate cw around S face: green -> UEDW
-- 3*4 (+Z: U -> E) - rotate cw around E face: green -> NDSU
-- 4*4 (-Z: U -> W) - rotate cw around W face: green -> DNUS
-- 5*4 (-Y: U -> D) - rotate cw around D face: green -> SENW

minetest.register_node("facedir_cube:cube", {
	description = "FaceDir Cube",
	groups = {dig_immediate = 2},
	tiles = {
		"facedir-cube.png^[multiply:#FF0", -- yellow
		"facedir-cube.png^[multiply:#FFF", -- white
		"facedir-cube.png^[multiply:#F00", -- red
		"facedir-cube.png^[multiply:#F80", -- orange
		"facedir-cube.png^[multiply:#0F0", -- green
		"facedir-cube.png^[multiply:#00F", -- blue
	},
	paramtype2 = "facedir",
	is_ground_content = false,
	drop = "facedir_cube:cube",

	-- next axis
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local p = node.param2 + 4
		if p > 23 then p = p - 6*4 end
		minetest.set_node(pos, { name = "facedir_cube:cube", param2 = p })
	end,
	-- rotate face
	on_punch = function(pos, node, puncher)
		local r = node.param2 % 4
		local a = node.param2 - r
		r = r + 1 ; if r > 3 then r = 0 end
		minetest.set_node(pos, { name = "facedir_cube:cube", param2 = a + r })
	end,
})

print("[MOD] Facedir-Cube loaded")
