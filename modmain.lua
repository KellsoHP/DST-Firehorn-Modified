Assets = 
{
	Asset("ANIM", "anim/hornfire.zip"),
	Asset("IMAGE", "images/hornfire.tex"),
	Asset("ATLAS", "images/hornfire.xml"),
}

PrefabFiles = 
{
	"horn",
	"fireflies",
	"hornfire",
}

local hornfire = Recipe("hornfire", {Ingredient("horn", 1),Ingredient("fireflies", 1),Ingredient("rocks", 3)}, GLOBAL.RECIPETABS.LIGHT, GLOBAL.TECH.SCIENCE_ONE,"hornfire_placer",1)
hornfire.atlas = "images/hornfire.xml"
hornfire.image = "hornfire.tex"