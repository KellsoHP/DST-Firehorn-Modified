name = "Hornfire"
description = "Traps a firefly to give endless light"
author = "Parusoid"
version = "1.3" 
forumthread = ""
api_version_dst = 10
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"


server_filter_tags = {"light"}

configuration_options = 
{
	{
		name = "HORNFIRE_LANGUAGE",
		label = "Language",
		hover = "Text language",
		options =	
		{
			{description = "English", data = "english"},
			{description = "Russian", data = "russian"},
		},
		default = "english",
	},
}

--[[
Version 1.0
-Default

Version 1.1
-Added fade effect for light when turning off and on

Version 1.2
-The bug with having all recipes aviable but not able to craft them (affecting whole server) should be gone now
]]
