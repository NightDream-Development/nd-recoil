CreateThread(function()
	while true do
		if IsPedArmed(cache.ped, 4) ~= false then
			local ped = cache.ped
			if IsPedShooting(ped) and not IsPedDoingDriveby(ped) then
				local _, wep = GetCurrentPedWeapon(ped)
				_, cAmmo = GetAmmoInClip(ped, wep)
				if recoils[wep] and recoils[wep] ~= 0 then
					-- luacheck: ignore
					local tv = 0
					if GetFollowPedCamViewMode() ~= 4 then
						repeat
							Wait(0)
							local p = GetGameplayCamRelativePitch()
							SetGameplayCamRelativePitch(p + 0.1, 0.2)
							tv += 0.1
						until tv >= recoils[wep]
					else
						repeat
							Wait(0)
							local p = GetGameplayCamRelativePitch()
							if recoils[wep] > 0.1 then
								SetGameplayCamRelativePitch(p + 0.6, 1.2)
								tv += 0.6
							else
								SetGameplayCamRelativePitch(p + 0.016, 0.333)
								tv += 0.1
							end
						until tv >= recoils[wep]
					end
				end
			end
		else
			Wait(5000)
		end
		Wait(10)
	end
end)


local maxSpread = Config.maxspread

CreateThread(function()
	while true do
		if IsPedArmed(cache.ped, 4) ~= false then
			local ped = PlayerPedId()
			if IsPedShooting(ped) and not IsPedDoingDriveby(ped) then
				local _, wep = GetCurrentPedWeapon(ped)
				_, cAmmo = GetAmmoInClip(ped, wep)
				if recoils[wep] and recoils[wep] ~= 0 then
					local tv = 0
					local spread = math.random() * 2 * math.pi
					local radius = math.sqrt(math.random()) * maxSpread
					local xSpread = radius * math.cos(spread)
					local ySpread = radius * math.sin(spread)
					if GetFollowPedCamViewMode() ~= 4 then
						repeat
							Wait(0)
							local p = GetGameplayCamRelativePitch()
							SetGameplayCamRelativePitch(p + 0.1, 0.2)
							tv = tv + 0.1
						until tv >= recoils[wep]
					else
						repeat
							Wait(0)
							local p = GetGameplayCamRelativePitch()
							if recoils[wep] > 0.1 then
								SetGameplayCamRelativePitch(p + 0.6, 1.2)
								tv = tv + 0.6
							else
								SetGameplayCamRelativePitch(p + 0.016, 0.333)
								tv = tv + 0.1
							end
						until tv >= recoils[wep]
					end
					SetGameplayCamRelativeHeading(GetGameplayCamRelativeHeading() + xSpread) -- add x and y spread values to camera heading and pitch
					SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + ySpread, 1.0)
				end
			end
		else
			Wait(1000)
		end
		Wait(10)
	end
end)
