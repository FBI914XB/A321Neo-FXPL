--sim datarefs

--a32NX datarefs
local aft_cargo_iso_valve = createGlobalPropertyi("a321neo/cockpit/aircond/aft_cargo_iso_valve", 1, false, true, false)
local a321DR_bleed_avail = createGlobalPropertyi("a321neo/cockpit/aircond/bleed_avail", 0, false, true, false)

--register commands
sasl.registerCommandHandler ( Cockpit_temp_dial_up, 0, function(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(Cockpit_temp_dial, get(Cockpit_temp_dial) + 0.05)
    end
    if phase == SASL_COMMAND_CONTINUE then
        set(Cockpit_temp_dial, get(Cockpit_temp_dial) + 0.5 * get(DELTA_TIME))
    end
end)

sasl.registerCommandHandler ( Cockpit_temp_dial_dn, 0, function(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(Cockpit_temp_dial, get(Cockpit_temp_dial) - 0.05)
    end
    if phase == SASL_COMMAND_CONTINUE then
        set(Cockpit_temp_dial, get(Cockpit_temp_dial) - 0.5 * get(DELTA_TIME))
    end
end)

sasl.registerCommandHandler ( Front_cab_temp_dial_up, 0, function(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(Front_cab_temp_dial, get(Front_cab_temp_dial) + 0.05)
    end
    if phase == SASL_COMMAND_CONTINUE then
        set(Front_cab_temp_dial, get(Front_cab_temp_dial) + 0.5 * get(DELTA_TIME))
    end
end)

sasl.registerCommandHandler ( Front_cab_temp_dial_dn, 0, function(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(Front_cab_temp_dial, get(Front_cab_temp_dial) - 0.05)
    end
    if phase == SASL_COMMAND_CONTINUE then
        set(Front_cab_temp_dial, get(Front_cab_temp_dial) - 0.5 * get(DELTA_TIME))
    end
end)

sasl.registerCommandHandler ( Aft_cab_temp_dial_up, 0, function(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(Aft_cab_temp_dial, get(Aft_cab_temp_dial) + 0.05)
    end
    if phase == SASL_COMMAND_CONTINUE then
        set(Aft_cab_temp_dial, get(Aft_cab_temp_dial) + 0.5 * get(DELTA_TIME))
    end
end)

sasl.registerCommandHandler ( Aft_cab_temp_dial_dn, 0, function(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(Aft_cab_temp_dial, get(Aft_cab_temp_dial) - 0.05)
    end
    if phase == SASL_COMMAND_CONTINUE then
        set(Aft_cab_temp_dial, get(Aft_cab_temp_dial) - 0.5 * get(DELTA_TIME))
    end
end)

sasl.registerCommandHandler ( Aft_cargo_temp_dial_up, 0, function(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(Aft_cargo_temp_dial, get(Aft_cargo_temp_dial) + 0.05)
    end
    if phase == SASL_COMMAND_CONTINUE then
        set(Aft_cargo_temp_dial, get(Aft_cargo_temp_dial) + 0.5 * get(DELTA_TIME))
    end
end)

sasl.registerCommandHandler ( Aft_cargo_temp_dial_dn, 0, function(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(Aft_cargo_temp_dial, get(Aft_cargo_temp_dial) - 0.05)
    end
    if phase == SASL_COMMAND_CONTINUE then
        set(Aft_cargo_temp_dial, get(Aft_cargo_temp_dial) - 0.5 * get(DELTA_TIME))
    end
end)

sasl.registerCommandHandler ( Toggle_cab_hotair, 0, function(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(Cab_hot_air, 1-  get(Cab_hot_air))
    end
    if phase == SASL_COMMAND_CONTINUE then
        set(Aft_cargo_temp_dial, get(Aft_cargo_temp_dial) - 0.5 * get(DELTA_TIME))
    end
end)

sasl.registerCommandHandler ( Toggle_cargo_hotair, 0, function(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(Cargo_hot_air, 1 - get(Cargo_hot_air))
    end
end)

sasl.registerCommandHandler ( Toggle_aft_cargo_iso_valve, 0, function(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(aft_cargo_iso_valve, 1 - get(aft_cargo_iso_valve))
    end
end)

--custom functions
local function cab_cond_off()
    --changing requested temperature to lowest temperature
    set(Cockpit_temp_req, Set_anim_value(get(Cockpit_temp_req), 12, 12, 30, 0.5))
    set(Front_cab_temp_req, Set_anim_value(get(Front_cab_temp_req), 12, 12, 30, 0.5))
    set(Aft_cab_temp_req, Set_anim_value(get(Aft_cab_temp_req), 12, 12, 30, 0.5))
    --changing actual temperature to outside temperatures
    set(Cockpit_temp, Set_anim_value(get(Cockpit_temp), get(OTA), -100, 100, 0.05))
    set(Front_cab_temp, Set_anim_value(get(Front_cab_temp), get(OTA), -100, 100, 0.05))
    set(Aft_cab_temp, Set_anim_value(get(Aft_cab_temp), get(OTA), -100, 100, 0.05))
end

local function cargo_cond_off()
    --changing requested temperature to lowest temperature
    set(Aft_cargo_temp_req, Set_anim_value(get(Aft_cargo_temp_req), 4, 4, 30, 0.5))
    --changing actual temperature to outside temperatures
    set(Aft_cargo_temp, Set_anim_value(get(Aft_cargo_temp), get(OTA), -100, 100, 0.05))
end

function update()
    set(Cockpit_temp_dial, Math_clamp(get(Cockpit_temp_dial), 0, 1))
    set(Front_cab_temp_dial, Math_clamp(get(Front_cab_temp_dial), 0, 1))
    set(Aft_cab_temp_dial, Math_clamp(get(Aft_cab_temp_dial), 0, 1))
    set(Aft_cargo_temp_dial, Math_clamp(get(Aft_cargo_temp_dial), 0, 1))

    if get(Left_bleed_avil) >= 0.85 or get(Mid_bleed_avil) >= 0.85 or get(Right_bleed_avil) >= 0.85 then
        set(a321DR_bleed_avail, 1)
    else
        set(a321DR_bleed_avail, 0)
    end

    if (get(Left_bleed_avil) >= 0.85 and get(Pack_L) == 1) or (get(Right_bleed_avil) >= 0.85 and get(Pack_R) == 1) then
        --cabin aircon
        if get(Cab_hot_air) == 1 then
            --changing requested temperature to dialed in temperatures
            set(Cockpit_temp_req, Set_anim_value(get(Cockpit_temp_req), 12 + 18 * get(Cockpit_temp_dial), 12, 30, 0.5))
            set(Front_cab_temp_req, Set_anim_value(get(Front_cab_temp_req), 12 + 18 * get(Front_cab_temp_dial), 12, 30, 0.5))
            set(Aft_cab_temp_req, Set_anim_value(get(Aft_cab_temp_req), 12 + 18 * get(Aft_cab_temp_dial), 12, 30, 0.5))
            --changing actual temperature to requested temperatures
            set(Cockpit_temp, Set_anim_value(get(Cockpit_temp), get(Cockpit_temp_req), 12, 30, 0.05))
            set(Front_cab_temp, Set_anim_value(get(Front_cab_temp), get(Front_cab_temp_req), 12, 30, 0.05))
            set(Aft_cab_temp, Set_anim_value(get(Aft_cab_temp), get(Aft_cab_temp_req), 12, 30, 0.05))
        else
            cab_cond_off()
        end

        --cargo aircon
        if get(aft_cargo_iso_valve) == 1 then
            if get(Cargo_hot_air) == 1 then
                --changing requested temperature to dialed in temperatures
                set(Aft_cargo_temp_req, Set_anim_value(get(Aft_cargo_temp_req), 4 + 26 * get(Aft_cargo_temp_dial), 4, 30, 0.5))
                --changing actual temperature to requested temperatures
                set(Aft_cargo_temp, Set_anim_value(get(Aft_cargo_temp), get(Aft_cargo_temp_req), 4, 30, 0.05))
            else
                cargo_cond_off()
            end
        else
            cargo_cond_off()
        end
    else
        cab_cond_off()
        cargo_cond_off()
    end
end