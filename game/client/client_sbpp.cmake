set(GAMENAME hl2sbpp)

set(EXTRA_COMPILE_DEFINITIONS 
	HL2MP
	HL2_CLIENT_DLL
	HL2SB
	SBPP
	ARGG
	LUA_SDK
	NEXT_BOT
	GLOWS_ENABLE
)

set(EXTRA_INCLUDE_DIRECTORIES 
	${SRC_DIR}/game/client/lua
	${SRC_DIR}/game/client/lua/scripted_controls
	${SRC_DIR}/game/client/hl1
	${SRC_DIR}/game/client/hl2mp/ui
	${SRC_DIR}/game/client/hl2mp
	${SRC_DIR}/game/shared/hl2mp
	${SRC_DIR}/game/client/hl2
	${SRC_DIR}/game/client/hl2/elements
	${SRC_DIR}/game/shared/hl1
	${SRC_DIR}/game/shared/hl2
	${SRC_DIR}/game/shared/Multiplayer
	${SRC_DIR}/game/shared/lua
	${SRC_DIR}/game/shared/sbpp
	${SRC_DIR}/game/client/sbpp
	${SRC_DIR}/public/lua
	${SRC_DIR}/lua/etc
	${SRC_DIR}/lua/src
	${SRC_DIR}/thirdparty/cpp-httplib/include
)

set(CLIENT_SOURCES
	c_team_objectiveresource.cpp
	c_team_objectiveresource.h
	c_team_train_watcher.cpp
	c_team_train_watcher.h
	hud_voicestatus.cpp
	${SRC_DIR}/game/shared/predicted_viewmodel.cpp
	${SRC_DIR}/game/shared/predicted_viewmodel.h
	${SRC_DIR}/game/shared/teamplay_round_timer.cpp
	${SRC_DIR}/game/shared/teamplay_round_timer.h
)

source_group("Source Files" FILES ${CLIENT_SOURCES})

set(NEXTBOT_SOURCES
	NextBot/C_NextBot.cpp
	NextBot/C_NextBot.h
)

source_group("Source Files/NextBot" FILES ${NEXTBOT_SOURCES})

set(CLIENT_LUA_SOURCES
	${SRC_DIR}/game/shared/lua/luamanager.cpp

	lua/lc_baseanimating.cpp
	lua/lc_baseentity.cpp
	lua/lc_baseplayer.cpp
	lua/lcdll_util.cpp
	lua/liclientshadowmgr.cpp
	lua/lprediction.cpp
	lua/lc_recipientfilter.cpp
	lua/scripted_controls/lButton.cpp
	lua/scripted_controls/lCheckButton.cpp
	lua/scripted_controls/lFrame.cpp
	lua/scripted_controls/lPropertyDialog.cpp
	lua/scripted_controls/lPropertyPage.cpp
	lua/scripted_controls/scriptedclientluapanel.cpp
	lua/scripted_controls/scriptedhudviewport.cpp
	lua/scripted_controls/lPanel.cpp
		
	${SRC_DIR}/game/shared/lua/lsrcinit.cpp
	${SRC_DIR}/game/shared/lua/ltakedamageinfo.cpp
	${SRC_DIR}/game/shared/lua/lbaseplayer_shared.cpp
	${SRC_DIR}/game/shared/lua/lbaseentity_shared.cpp
	${SRC_DIR}/game/shared/lua/lbasecombatweapon_shared.cpp
	${SRC_DIR}/game/shared/lua/lshareddefs.cpp
	${SRC_DIR}/game/shared/lua/lutil_shared.cpp
	${SRC_DIR}/game/shared/lua/basescripted.cpp
	${SRC_DIR}/game/shared/lua/leffect_dispatch_data.cpp
	${SRC_DIR}/game/shared/lua/lhl2mp_player_shared.cpp
	${SRC_DIR}/game/shared/lua/limovehelper.cpp
	${SRC_DIR}/game/shared/lua/lipredictionsystem.cpp
	${SRC_DIR}/game/shared/lua/lin_buttons.cpp
	${SRC_DIR}/game/shared/lua/weapon_hl2mpbase_scriptedweapon.cpp
	${SRC_DIR}/game/shared/lua/mountaddons.cpp
		
	${SRC_DIR}/public/lua/vgui/LISurface.cpp
	${SRC_DIR}/public/lua/lColor.cpp
	${SRC_DIR}/public/lua/tier0/ldbg.cpp
	${SRC_DIR}/public/lua/tier1/lconvar.cpp
	${SRC_DIR}/public/lua/lnetworkstringtabledefs.cpp
	${SRC_DIR}/public/lua/mathlib/lmathlib.cpp
	${SRC_DIR}/public/lua/mathlib/lvector.cpp
	${SRC_DIR}/public/lua/mathlib/lvmatrix.cpp
	${SRC_DIR}/public/lua/vgui_controls/lvgui_controls.cpp
	${SRC_DIR}/public/lua/lgametrace.cpp
	${SRC_DIR}/public/lua/SoundEmitterSystem/lisoundemittersystembase.cpp
	${SRC_DIR}/public/lua/lvphysics_interface.cpp
	${SRC_DIR}/public/lua/engine/livdebugoverlay.cpp
	${SRC_DIR}/public/lua/lcdll_int.cpp
	${SRC_DIR}/public/lua/leiface.cpp
	${SRC_DIR}/public/lua/lienginevgui.cpp
	${SRC_DIR}/public/lua/lfilesystem.cpp
	${SRC_DIR}/public/lua/lglobalvars_base.cpp
	${SRC_DIR}/public/lua/lbspflags.cpp
	${SRC_DIR}/public/lua/vphysics/lperformance.cpp
	${SRC_DIR}/public/lua/tier1/LKeyValues.cpp
	${SRC_DIR}/public/lua/tier1/liconvar.cpp
	${SRC_DIR}/public/lua/vgui_controls/lPanel.cpp
	${SRC_DIR}/public/lua/vgui_controls/lEditablePanel.cpp
	${SRC_DIR}/public/lua/vgui/LVGUI.cpp
	${SRC_DIR}/public/lua/vgui/LIScheme.cpp
	${SRC_DIR}/public/lua/vgui/LIInput.cpp
	${SRC_DIR}/public/lua/materialsystem/limaterial.cpp
	${SRC_DIR}/public/lua/licvar.cpp
	${SRC_DIR}/public/lua/vstdlib/lrandom.cpp
)

source_group("Source Files/Lua" FILES ${CLIENT_LUA_SOURCES})

set(GUNMOD_SOURCES
	gunmod/c_grenade_stickybomb.cpp
)

source_group("Source Files/Gunmod" FILES ${GUNMOD_SOURCES})

set(HLS_SOURCES
	hl1/hl1_c_rpg_rocket.cpp
	hl1/hl1_c_weapon__stubs.cpp
	hl1/hl1_fx_gauss.cpp
	hl1/hl1_fx_shelleject.cpp
	${SRC_DIR}/game/shared/hl1/hl1mp_basecombatweapon_shared.cpp
	${SRC_DIR}/game/shared/hl1/hl1_basecombatweapon_shared.cpp
	${SRC_DIR}/game/shared/hl1/hl1mp_weapon_357.cpp
	${SRC_DIR}/game/shared/hl1/hl1mp_weapon_crossbow.cpp
	${SRC_DIR}/game/shared/hl1/hl1mp_weapon_egon.cpp
	${SRC_DIR}/game/shared/hl1/hl1mp_weapon_gauss.cpp
	${SRC_DIR}/game/shared/hl1/hl1mp_weapon_glock.cpp
	${SRC_DIR}/game/shared/hl1/hl1mp_weapon_handgrenade.cpp
	${SRC_DIR}/game/shared/hl1/hl1mp_weapon_hornetgun.cpp
	${SRC_DIR}/game/shared/hl1/hl1mp_weapon_mp5.cpp
	${SRC_DIR}/game/shared/hl1/hl1mp_weapon_rpg.cpp
	${SRC_DIR}/game/shared/hl1/hl1mp_weapon_sachel.cpp
	${SRC_DIR}/game/shared/hl1/hl1mp_weapon_shotgun.cpp
	${SRC_DIR}/game/server/hl1/hl1_weapon_crowbar.cpp
)

source_group("Source Files/Half-Life: Source" FILES ${HLS_SOURCES})

set(HL2SBPP_SOURCES
	cstrike/fx_cs_weaponfx.cpp
	sbpp/c_vehicle_chair.cpp
	sbpp/dynamicsky.cpp
	sbpp/dynamicsky.h
	sbpp/hud_watermark.cpp
	sbpp/hud_watermark.h
	sbpp/id.cpp
	sbpp/mapload_background.cpp
	sbpp/mapload_background.h
	sbpp/vtfscreenshot.cpp

	lua/lc_baseanimatingoverlay.cpp
	lua/lc_baseflex.cpp
	lua/lc_baseanimatingoverlay.h
	lua/lc_baseflex.h
	lua/scripted_controls/lLabel.cpp
	lua/scripted_controls/lTextEntry.cpp
	lua/scripted_controls/lImagePanel.cpp
	lua/scripted_controls/lSlider.cpp
	lua/scripted_controls/lMenu.cpp
	lua/scripted_controls/lMenuButton.cpp
	lua/scripted_controls/lRadioButton.cpp
	lua/scripted_controls/lComboBox.cpp
	lua/lc_nextbot.cpp
	lua/lc_nextbot.h

	lua/materialsystem/limesh.cpp
	lua/materialsystem/limesh.h
	lua/materialsystem/lmaterials.cpp
	lua/materialsystem/lmeshbuilder.cpp
	lua/materialsystem/lmeshbuilder.h
	lua/materialsystem/litexture.cpp
	lua/materialsystem/litexture.h
	lua/materialsystem/lmatrendercontext.cpp
	lua/materialsystem/lmatrendercontext.h
	lua/materialsystem/lmaterialvar.cpp
	lua/materialsystem/lmaterialvar.h

	lua/lnet_client.cpp
)

set(HL2SBPP_SHARED_SOURCES
	${SRC_DIR}/game/shared/hl2mp/hl2mp_playeranimstate.cpp
	${SRC_DIR}/game/shared/hl2mp/hl2mp_playeranimstate.h
	${SRC_DIR}/game/shared/lua/lammodef.cpp
	${SRC_DIR}/game/shared/lua/lammodef.h
	${SRC_DIR}/game/shared/Multiplayer/multiplayer_animstate.cpp
	${SRC_DIR}/game/shared/Multiplayer/multiplayer_animstate.h
	#${SRC_DIR}/public/zip/miniz.c
	#${SRC_DIR}/public/zip/miniz.h
	${SRC_DIR}/public/zip_utils.cpp
	${SRC_DIR}/game/shared/lua/luacachefile.cpp
	${SRC_DIR}/game/shared/lua/luacachefile.h
	${SRC_DIR}/game/shared/lua/lnet_shared.cpp
	${SRC_DIR}/game/shared/lua/lnet_shared.h
	${SRC_DIR}/game/shared/sbpp/handviewmodel_shared.cpp
	${SRC_DIR}/game/shared/sbpp/mount.cpp
	${SRC_DIR}/game/shared/sbpp/weapon_bugbait.cpp
	${SRC_DIR}/game/shared/sbpp/weapon_physgun.cpp
	${SRC_DIR}/game/shared/sbpp/webmanager.cpp
	${SRC_DIR}/game/shared/sbpp/webmanager.h
)

source_group("Source Files/HL2SB++" FILES ${HL2SBPP_SOURCES} ${HL2SBPP_SHARED_SOURCES})

set(HL2_SOURCES
	episodic/c_vort_charge_token.cpp
	${SRC_DIR}/game/shared/hl2/basehlcombatweapon_shared.cpp
	hl2/c_antlion_dust.cpp
	hl2/c_ar2_explosion.cpp
	hl2/c_barnacle.cpp
	hl2/c_barney.cpp
	hl2/c_basehelicopter.cpp
	hl2/c_basehelicopter.h
	hl2/c_basehlcombatweapon.cpp
	hl2/c_basehlcombatweapon.h
	hl2/c_basehlplayer.cpp
	hl2/c_basehlplayer.h
	hl2/c_citadel_effects.cpp
	hl2/c_corpse.cpp
	hl2/c_corpse.h
	hl2/c_env_alyxtemp.cpp
	hl2/c_env_headcrabcanister.cpp
	hl2/c_env_starfield.cpp
	hl2/c_func_tankmortar.cpp
	hl2/c_hl2_playerlocaldata.cpp
	hl2/c_hl2_playerlocaldata.h
	hl2/c_info_teleporter_countdown.cpp
	hl2/c_npc_antlionguard.cpp
	hl2/c_npc_combinegunship.cpp
	hl2/c_npc_manhack.cpp
	hl2/c_npc_rollermine.cpp
	hl2/c_plasma_beam_node.cpp
	hl2/c_prop_combine_ball.cpp
	hl2/c_prop_combine_ball.h
	hl2/c_rotorwash.cpp
	hl2/c_script_intro.cpp
	${SRC_DIR}/game/shared/script_intro_shared.cpp
	hl2/c_strider.cpp
	hl2/c_te_concussiveexplosion.cpp
	hl2/c_te_flare.cpp
	hl2/c_thumper_dust.cpp
	hl2/c_vehicle_airboat.cpp
	hl2/c_vehicle_cannon.cpp
	hl2/c_vehicle_crane.cpp
	hl2/c_vehicle_crane.h
	hl2/c_vehicle_prisoner_pod.cpp
	hl2/c_weapon__stubs_hl2.cpp
	hl2/c_weapon_crossbow.cpp
	${SRC_DIR}/game/shared/hl2/citadel_effects_shared.h
	${SRC_DIR}/game/shared/hl2/env_headcrabcanister_shared.cpp
	${SRC_DIR}/game/shared/hl2/env_headcrabcanister_shared.h
	hl2/fx_antlion.cpp
	hl2/fx_bugbait.cpp
	hl2/fx_hl2_impacts.cpp
	hl2/fx_hl2_tracers.cpp
	hl2/hl2_clientmode.cpp
	${SRC_DIR}/game/shared/hl2/hl2_gamerules.cpp
	${SRC_DIR}/game/shared/hl2/hl2_gamerules.h
	${SRC_DIR}/game/shared/hl2/hl2_shareddefs.h
	${SRC_DIR}/game/shared/hl2/hl2_usermessages.cpp
	${SRC_DIR}/game/shared/hl2/hl_gamemovement.cpp
	${SRC_DIR}/game/shared/hl2/hl_gamemovement.h
	hl2/hl_in_main.cpp
	hl2/hl_prediction.cpp
	hl2/hud_ammo.cpp
	hl2/hud_battery.cpp
	hl2/hud_blood.cpp
	hl2/hud_credits.cpp
	hl2/hud_damageindicator.cpp
	hl2/hud_flashlight.cpp
	hl2/hud_health.cpp
	hl2/hud_poisondamageindicator.cpp
	hl2/hud_quickinfo.cpp
	hud_squadstatus.cpp
	hl2/hud_suitpower.cpp
	hl2/hud_suitpower.h
	hl2/hud_weaponselection.cpp
	hl2/hud_zoom.cpp
	hl2/shieldproxy.cpp
	hl2/vgui_rootpanel_hl2.cpp
)

source_group("Source Files/HL2 DLL" FILES ${HL2_SOURCES})

set(HL2MP_SOURCES
	hl2mp/c_hl2mp_player.cpp
	hl2mp/c_hl2mp_player.h
	hl2mp/c_te_hl2mp_shotgun_shot.cpp
	hl2mp/clientmode_hl2mpnormal.cpp
	hl2mp/clientmode_hl2mpnormal.h
	${SRC_DIR}/game/shared/hl2mp/hl2mp_gamerules.cpp
	${SRC_DIR}/game/shared/hl2mp/hl2mp_gamerules.h
	${SRC_DIR}/game/shared/hl2mp/hl2mp_player_shared.cpp
	${SRC_DIR}/game/shared/hl2mp/hl2mp_player_shared.h
	${SRC_DIR}/game/shared/hl2mp/hl2mp_weapon_parse.cpp
	${SRC_DIR}/game/shared/hl2mp/hl2mp_weapon_parse.h
)

source_group("Source Files/HL2MP" FILES ${HL2MP_SOURCES})

set(HL2MP_WEAPONS_SOURCES
	${SRC_DIR}/game/shared/hl2mp/weapon_357.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_ar2.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_ar2.h
	${SRC_DIR}/game/shared/hl2mp/weapon_crossbow.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_crowbar.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_frag.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_hl2mpbase.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_hl2mpbase.h
	${SRC_DIR}/game/shared/hl2mp/weapon_hl2mpbase_machinegun.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_hl2mpbase_machinegun.h
	${SRC_DIR}/game/shared/hl2mp/weapon_hl2mpbasebasebludgeon.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_hl2mpbasehlmpcombatweapon.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_hl2mpbasehlmpcombatweapon.h
	${SRC_DIR}/game/shared/hl2mp/weapon_physcannon.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_physcannon.h
	${SRC_DIR}/game/shared/hl2mp/weapon_pistol.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_rpg.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_rpg.h
	${SRC_DIR}/game/shared/hl2mp/weapon_shotgun.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_slam.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_slam.h
	${SRC_DIR}/game/shared/hl2mp/weapon_smg1.cpp
	${SRC_DIR}/game/shared/hl2mp/weapon_stunstick.cpp
)

source_group("Source Files/HL2MP/Weapons" FILES ${HL2MP_WEAPON_SOURCES})

set(HL2MP_UI_SOURCES
	hl2mp/ui/backgroundpanel.cpp
	hl2mp/ui/backgroundpanel.h
	hl2mp/hl2mp_hud_chat.cpp
	hl2mp/hl2mp_hud_chat.h
	hl2mp/hl2mp_hud_target_id.cpp
	hl2mp/hl2mp_hud_team.cpp
	hl2mp/ui/hl2mpclientscoreboard.cpp
	hl2mp/ui/hl2mpclientscoreboard.h
	hl2mp/ui/hl2mptextwindow.cpp
	hl2mp/ui/hl2mptextwindow.h
	hl2mp/hud_deathnotice.cpp
)

source_group("Source Files/HL2MP/UI" FILES ${HL2MP_UI_SOURCES})

set(
	EXCLUDE_SOURCES
	"${SRC_DIR}/game/shared/weapon_parse_default.cpp"
)

set(SOURCES
	${CLIENT_SOURCES}
	${NEXTBOT_SOURCES}
	${HL2SBPP_SOURCES}
	${HL2SBPP_SHARED_SOURCES}
	${HL2_SOURCES}
	${HL2MP_SOURCES}
	${HL2MP_WEAPONS_SOURCES}
	${HL2MP_UI_SOURCES}
)

add_game_library(client_hl2sbpp ${GAMENAME} ${SOURCES})

target_use_client_base(client_hl2sbpp ${EXCLUDE_SOURCES})

target_include_directories(
	client_hl2sbpp PRIVATE
	${EXTRA_INCLUDE_DIRECTORIES}
)

target_compile_definitions(
	client_hl2sbpp PRIVATE
	${EXTRA_COMPILE_DEFINITIONS}
)

target_link_libraries(
	client_hl2sbpp PRIVATE
	httplib::httplib
	lua
)
