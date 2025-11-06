-- media/lua/client/GunshotTrait.lua

-- Register the trait



TraitFactory.addTrait("GunshotSurvivor", getText("UI_trait_GunshotSurvivor"), -8, getText("UI_trait_GunshotSurvivorDesc"), false)
TraitFactory.addTrait("FreshHeadshot", getText("UI_trait_FreshHeadshot"), -10, getText("UI_trait_FreshHeadshotDesc"), false)


 local GunshotSurvivor = "media/textures/GunshotSurvivor.png"
 local FreshHeadshot = "media/textures/FreshHeadshot.png"

 local GunshotSurvivor = "media\textures\GunshotSurvivor.PNG"
 local FreshHeadshot = "media\textures\FreshHeadshot.PNG"


-- Make traits mutually exclusive
local GunshotSurvivor = TraitFactory.getTrait("GunshotSurvivor")
local FreshHeadshot = TraitFactory.getTrait("FreshHeadshot")
TraitFactory.setMutualExclusive("GunshotSurvivor", "FreshHeadshot") -- Can't have both




-- Function to apply the gunshot wound
local function applyGunshotWound(player, square)
    if player:HasTrait("GunshotSurvivor") then
        local bodyDamage = player:getBodyDamage()
        local head = bodyDamage:getBodyPart(BodyPartType.Head)
        
        -- Apply a deep wound with a lodged bullet
        head:setHaveBullet(true, 0) -- Bullet lodged, 0 depth (surface wound for survivability)
        head:AddDamage(20) -- Simulate gunshot damage
        head:setBleeding(true) -- Active bleeding
        head:setBleedingTime(15) -- Moderate bleeding duration
        head:setDeepWounded(true) -- Mark as a deep wound
        head:setDeepWoundTime(100) -- Severe deep wound requiring treatment
        head:setBandaged(true, 50) -- Bandaged, but dirty (0 health, needs replacement)
		
        -- Apply pain and health reduction
        bodyDamage:setOverallBodyHealth(bodyDamage:getOverallBodyHealth() - 30) -- Significant health loss


		player:getInventory():AddItem("Base.Bandage")
		
		 elseif player:HasTrait("FreshHeadshot") then
        -- Unbandaged, more dangerous headshot wound
		
		        local bodyDamage = player:getBodyDamage()
        local head = bodyDamage:getBodyPart(BodyPartType.Head)
		
		
		
		head:setHaveBullet(true, 0) -- Bullet lodged, 0 depth (surface wound for survivability)
        head:AddDamage(20) -- Simulate gunshot damage
        head:setBleeding(true) -- Active bleeding
        head:setBleedingTime(15) -- Moderate bleeding duration
        head:setDeepWounded(true) -- Mark as a deep wound
        head:setDeepWoundTime(100) -- Severe deep wound requiring treatment
        head:setBandaged(false, 0) -- Bandaged, but dirty (0 health, needs replacement)
		
        -- Apply pain and health reduction
        bodyDamage:setOverallBodyHealth(bodyDamage:getOverallBodyHealth() - 30) -- Significant health loss
        
		
		
		
    end
end

-- Hook into the OnNewGame event
Events.OnNewGame.Add(applyGunshotWound)