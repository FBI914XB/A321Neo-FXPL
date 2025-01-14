include("cockpit_commands.lua")
include("cockpit_datarefs.lua")
include("dynamic_datarefs.lua")
include("failures_datarefs.lua")
include("global_functions.lua")

sasl.options.setAircraftPanelRendering(true)
sasl.options.setInteractivity(true)
sasl.options.set3DRendering(true)

-- devel
sasl.options.setLuaErrorsHandling(SASL_STOP_PROCESSING)



size = { 4096, 2048 }

panelWidth3d = 4096
panelHeight3d = 2048



components = {
  engine_and_apu {},
  FBW {},
  cabin_screens {},
  flight_controls {},
  fcu_ap_at {},
  AT {},
  ADIRS {},
  MCDU {},
  packs {},
  aircond {},
  wheel {},
  source_switching {},
  PFD {},
  ECAM {},
  EWD {},
  EWD_logic {},
  EWD_flight_phases {},
  HUD {}
 }

 --windows
MCDU_window = contextWindow {
  name = "Airbus MCDU";
  position = { 150 , 150 , 463 , 683 };
  noBackground = true ;
  proportional = false ;
  minimumSize = { 463 , 683 };
  maximumSize = { 877 , 1365 };
  gravity = { 0 , 1 , 0 , 1 };
  visible = false ;
  components = {
    MCDU_popup {position = { 0 , 0 , 463 , 683 }, focused = true}
  };
}

Vnav_debug_window = contextWindow {
  name = "VNAV DEBUG";
  position = { 50 , 50 , 750 , 450 };
  noBackground = true ;
  proportional = false ;
  minimumSize = { 750 , 450 };
  maximumSize = { 1125 , 675 };
  gravity = { 0 , 1 , 0 , 1 };
  visible = false ;
  components = {
    vnav_debug {position = { 0 , 0 , 750 , 450 }}
  };
}

Packs_debug_window = contextWindow {
  name = "PACKS DEBUG";
  position = { 100 , 100 , 750 , 450 };
  noBackground = true ;
  proportional = false ;
  minimumSize = { 750 , 450 };
  maximumSize = { 1125 , 675 };
  gravity = { 0 , 1 , 0 , 1 };
  visible = false ;
  components = {
    packs_debug {position = { 0 , 0 , 750 , 450 }}
  };
}

FBW_debug_window = contextWindow {
  name = "FBW DEBUG";
  position = { 150 , 150 , 340 , 500 };
  noBackground = true ;
  proportional = false ;
  minimumSize = { 170 , 250 };
  maximumSize = { 340 , 500 };
  gravity = { 0 , 1 , 0 , 1 };
  visible = false ;
  components = {
    FBW_debug {position = { 0 , 0 , 340 , 500 }}
  };
}

FBW_graph = contextWindow {
  name = "FBW GRAPH";
  position = { 50 , 50 , 420 , 340};
  noBackground = true ;
  proportional = false ;
  minimumSize = { 420 , 340 };
  maximumSize = { 420 , 340 };
  gravity = { 0 , 1 , 0 , 1 };
  visible = false ;
  components = {
    FBW_graph {position = { 0 , 0 , 420 , 340 }}
  };
}

ECAM_debug_window = contextWindow {
  name = "ECAM DEBUG";
  position = { 200 , 200 , 340 , 200};
  noBackground = true ;
  proportional = false ;
  minimumSize = { 340 , 400 };
  maximumSize = { 340 , 400 };
  gravity = { 0 , 1 , 0 , 1 };
  visible = false ;
  components = {
    ECAM_debug {position = { 0 , 0 , 340 , 200 }}
  };
}

DMC_debug_window = contextWindow {
  name = "DMC DEBUG";
  position = { 200 , 200 , 400 , 200};
  noBackground = true ;
  proportional = false ;
  minimumSize = { 400 , 200 };
  maximumSize = { 400 , 200 };
  gravity = { 0 , 1 , 0 , 1 };
  visible = false ;
  components = {
    dmc_debug {position = { 0 , 0 , 400 , 200 }}
  };
}

--menu item functions
function Show_hide_MCDU()
  MCDU_window:setIsVisible(not MCDU_window:isVisible())
end

function Show_hide_vnav_debug()
  Vnav_debug_window:setIsVisible(not Vnav_debug_window:isVisible())
end

function Show_hide_packs_debug()
  Packs_debug_window:setIsVisible(not Packs_debug_window:isVisible())
end

function Show_hide_FBW_debug()
  FBW_debug_window:setIsVisible(not FBW_debug_window:isVisible())
end

function Show_hide_FBW_graph()
  FBW_graph:setIsVisible(not FBW_graph:isVisible())
end

function Show_hide_ECAM_debug()
  ECAM_debug_window:setIsVisible(not ECAM_debug_window:isVisible())
end

function Show_hide_DMC_debug()
  DMC_debug_window:setIsVisible(not DMC_debug_window:isVisible())
end


-- create top level menu in plugins menu
Menu_master	= sasl.appendMenuItem (PLUGINS_MENU_ID, "A321NEO" )
-- add a submenu
Menu_main	= sasl.createMenu ("", PLUGINS_MENU_ID, Menu_master)
-- add menu entry
ShowHideMCDU        = sasl.appendMenuItem(Menu_main, "Show/Hide MCDU", Show_hide_MCDU)
-- add menu entry
ShowHideVnavDebug	= sasl.appendMenuItem(Menu_main, "Show/Hide VNAV Debug", Show_hide_vnav_debug)
-- add menu entry
ShowHidePacksDebug	= sasl.appendMenuItem(Menu_main, "Show/Hide PACKS Debug", Show_hide_packs_debug)
-- add menu entry
ShowHideFBWDebug	= sasl.appendMenuItem(Menu_main, "Show/Hide FBW Debug", Show_hide_FBW_debug)
-- add menu entry
ShowHideFBWGraph	= sasl.appendMenuItem(Menu_main, "Show/Hide FBW Graph", Show_hide_FBW_graph)
-- add menu entry
ShowHideECAMDebug	= sasl.appendMenuItem(Menu_main, "Show/Hide ECAM Debug", Show_hide_ECAM_debug)
-- add menu entry
ShowHideDMCDebug	= sasl.appendMenuItem(Menu_main, "Show/Hide DMC Debug", Show_hide_DMC_debug)
--initialise menu item status
sasl.setMenuItemState(Menu_main, ShowHideVnavDebug, MENU_UNCHECKED)
sasl.setMenuItemState(Menu_main, ShowHidePacksDebug, MENU_UNCHECKED)
sasl.setMenuItemState(Menu_main, ShowHideFBWDebug, MENU_UNCHECKED)
sasl.setMenuItemState(Menu_main, ShowHideECAMDebug, MENU_UNCHECKED)
sasl.setMenuItemState(Menu_main, ShowHideDMCDebug, MENU_UNCHECKED)
