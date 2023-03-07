

# About

*** Here is step by step how to do that job:**
1. Drive to the farm
2. Use target to play minigame
3. You will get Apples from there
4. Drive to the proccess place and use your target
5. You will be able to sell your apples or press it to the juice
6. Drive to the seller and all all your juice
7. Get paid and repeat

Everything can be edited within the config this supports langs/different languanges by editing the text in the config.

Created By
- Atu.#7878

# Support Discord
https://discord.gg/fkM22XjMns

# Dependencies (ESX):
- [ox_inventory](https://github.com/overextended/ox_inventory)
- [ox_target](https://github.com/overextended/ox_target)
- [ox_lib](https://github.com/overextended/ox_lib)
- [ESX_Legacy](https://github.com/esx-framework/esx-legacy)

## Preview's
- [ShowCase Video](https://streamable.com/if6rv8)



# Install ESX
#### Items

ox inventory/data/item.lua

Step 1.
```
['apple'] = {
		label = 'Red Apple',
		weight = 125,
		client = {
			status = { hunger = 750 },
			anim = 'eating',
			prop = { model = `ng_proc_food_aple2a`, pos = vec3(0.02, 0.02, -0.04), rot = vec3(0.0, 0.0, 0.0) }, --- or use ng_proc_food_aple1a as prop
			usetime = 2500,
			notification = 'You ate a delicious Apple'
		},
	},
	['green_apple'] = {
		label = 'Green Apple',
		weight = 125,
		client = {
			status = { hunger = 750 },
			anim = 'eating',
			prop = { model = `ng_proc_food_aple2a`, pos = vec3(0.02, 0.02, -0.04), rot = vec3(0.0, 0.0, 0.0) }, --- or use ng_proc_food_aple1a as prop
			usetime = 2500,
			notification = 'You ate a delicious Apple'
		},
	},
	['rotten_apple'] = {
		label = 'Rotten Apple',
		weight = 125,
		client = {
			status = { hunger = 25 },
			anim = 'eating',
			prop = { model = `ng_proc_food_aple2a`, pos = vec3(0.02, 0.02, -0.04), rot = vec3(0.0, 0.0, 0.0) }, --- or use ng_proc_food_aple1a as prop
			usetime = 2500,
			notification = 'You ate a old stinky rotten Apple and now you feel like throwing up!'
		},
	},


	['apple_juice'] = {
		label = 'Apple Juice',
		weight = 600,
		client = {
			status = { thirst = 100000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_script_bottle_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You have refreshed your self with a nice cold bottle of Apple juice'
		}
	},

```
step 3. ox_inventory/modules/ items/client.lua
Item('rotten_apple', function(data, slot) -- causes drug effect
	ox_inventory:useItem(data, function(data)
		if data then
			local playerPed = PlayerPedId()

			-- RequestAnimSet("move_m@drunk@moderatedrunk") 
			-- while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
			--   Wait(0)
			-- end    
		
			-- TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, 1)
			-- Wait(3000)
			-- ClearPedTasksImmediately(playerPed)
			SetTimecycleModifier("spectator5")
			SetPedMotionBlur(playerPed, true)
			-- SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
		
			--Efects
			local player = PlayerId()
			SetRunSprintMultiplierForPlayer(player, 0.5)
		
			Wait(2000)
			ResetPedMovementClipset(playerPed, 0)
			ClearTimecycleModifier()
			ResetScenarioTypesEnabled()
			SetRunSprintMultiplierForPlayer(player, 1.0)
		end
	end)
end)

#### Images

Step 3. Move the images from the atu_apple/Images to \[ox]\ox_inventory\web\images

## MAKE SURE THAT YOU WILL PUT 'ensure atu_apple'  to server.cfg
