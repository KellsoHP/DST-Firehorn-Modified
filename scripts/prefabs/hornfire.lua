local assets =
{
    Asset("ANIM", "anim/hornfire.zip"),
	Asset("ATLAS", "images/hornfire.xml"),
}

local prefabs =
{
    "boneshard",
	"fireflies",
	"rocks",		
}

local function dig_up(inst, worker)
	inst.Light:Enable(false)
    
	local hornloot = inst.components.lootdropper:SpawnLootPrefab("horn")
	hornloot.components.finiteuses:SetUses(1)
	
    inst.components.lootdropper:SpawnLootPrefab("rocks")	
    inst:Remove()
end


local function updatelight(inst)
    if TheWorld.state.isnight then		
		
		local maxradius = 0.4
		local fadeperiod = 2
		local tick = 0.1
		
		if inst.radius ~= maxradius then
			inst.fadein = inst:DoPeriodicTask(tick, function()
				inst.Light:SetRadius(inst.radius)					
				inst.radius = math.max(0, inst.radius + maxradius/(fadeperiod/tick))					
			end)
		else			
			inst.AnimState:PlayAnimation("lit")
		end
		
		inst:DoTaskInTime(fadeperiod, function()
			if inst.fadein ~= nil then
				inst.fadein:Cancel()
				inst.fadein = nil
				inst.radius = maxradius
				inst.Light:SetRadius(inst.radius)
				inst.AnimState:PlayAnimation("lit")
			end
		end)
	
        inst.Light:Enable(true)
		
	else

		local maxradius = 0.4
		local fadeperiod = 2
		local tick = 0.1
		if inst.radius ~= 0 then
			inst.fadeout = inst:DoPeriodicTask(tick, function()
				inst.Light:SetRadius(inst.radius)
				inst.radius = math.max(0, inst.radius - maxradius/(fadeperiod/tick))
			end)
		end

		inst:DoTaskInTime(fadeperiod, function()
			if inst.fadeout ~= nil then
				inst.fadeout:Cancel()
				inst.fadeout = nil
				inst.radius = 0
				inst.Light:SetRadius(inst.radius)
				inst.AnimState:PlayAnimation("idle")
				inst.Light:Enable(false)
			end
		end)				
    end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("lit")
	inst.radius = 0.4
	inst.Light:Enable(true)
	inst:DoTaskInTime(2 + math.random(), updatelight)   
end

local function OnIsNight(inst)
    inst:DoTaskInTime(2 + math.random(), updatelight)
end

local function fn()
    local inst = CreateEntity()
	inst:AddTag("structure")
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddLight()
	inst.entity:AddNetwork()


    inst.AnimState:SetBank("hornfire")
    inst.AnimState:SetBuild("hornfire")
    inst.AnimState:PlayAnimation("idle")
    
	inst.radius = 0
    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(0.6)
    inst.Light:SetRadius(inst.radius) -- max 0.4
    inst.Light:SetColour(250 / 255, 165 / 255, 40 / 255)
    inst.Light:Enable(false)
	
	

	inst:AddComponent("lootdropper")
	
	
    inst.entity:SetPristine()

	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetOnFinishCallback(dig_up)
    inst.components.workable:SetWorkLeft(1)
	
    
    inst:AddComponent("inspectable")
		
	inst:WatchWorldState("isnight", OnIsNight)
	inst:ListenForEvent("onbuilt", onbuilt)
	
    updatelight(inst)
	
    return inst
end

return Prefab("hornfire", fn, assets, prefabs),
	MakePlacer("hornfire_placer", "hornfire", "hornfire", "idle")
