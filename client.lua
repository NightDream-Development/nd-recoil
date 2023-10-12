local recoilEnabled = true   

CreateThread(function()
	while true do
		if recoilEnabled then
			if IsPedArmed(cache.ped, 4) then
				if IsPedShooting(cache.ped) and not IsPedDoingDriveby(cache.ped) then
					local _, wep = GetCurrentPedWeapon(cache.ped)
					local _, cAmmo = GetAmmoInClip(cache.ped, wep)
					
					if Config.recoils[wep] and Config.recoils[wep] ~= 0 then
						local tv = 0
						local mode = GetFollowPedCamViewMode()
						local p, step
						
						if mode ~= 4 then
							step = 0.1
							p = GetGameplayCamRelativePitch()
						else
							step = Config.recoils[wep] > 0.1 and 0.6 or 0.016
							p = GetGameplayCamRelativePitch()
						end
						
						repeat
							Wait(0)
							SetGameplayCamRelativePitch(p + step, mode ~= 4 and 0.2 or 1.2)
							tv = tv + step
						until tv >= Config.recoils[wep]
					end
				end
			else
				Wait(5000)
			end
		end
		Wait(10)
	end
end)

-- Spread system
CreateThread(function()
	while true do
		if recoilEnabled then
			if IsPedArmed(cache.ped, 4) then
				if IsPedShooting(cache.ped) and not IsPedDoingDriveby(cache.ped) then
					local _, wep = GetCurrentPedWeapon(cache.ped)
					local _, cAmmo = GetAmmoInClip(cache.ped, wep)
					
					if Config.recoils[wep] and Config.recoils[wep] ~= 0 then
						local tv = 0
						local spread = math.random() * 2 * math.pi
						local radius = math.sqrt(math.random()) * Config.maxspread
						local xSpread = radius * math.cos(spread)
						local ySpread = radius * math.sin(spread)
						
						local mode = GetFollowPedCamViewMode()
						local p, step
						
						if mode ~= 4 then
							step = 0.1
							p = GetGameplayCamRelativePitch()
						else
							step = Config.recoils[wep] > 0.1 and 0.6 or 0.016
							p = GetGameplayCamRelativePitch()
						end
						
						repeat
							Wait(0)
							SetGameplayCamRelativePitch(p + step, mode ~= 4 and 0.2 or 1.2)
							tv = tv + step
						until tv >= Config.recoils[wep]
						
						SetGameplayCamRelativeHeading(GetGameplayCamRelativeHeading() + xSpread)
						SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + ySpread, 1.0)
					end
				end
			else
				Wait(1000)
			end
		end
		Wait(10)
	end
end)
