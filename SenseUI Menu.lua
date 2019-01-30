-- Check if SenseUI was loaded.
if SenseUI == nil then
	RunScript( "senseui.lua" );
end
------------ rage bot
local switch_enabled = gui.GetValue("rbot_enable");
local trg_selection = 1;
local fov_rr = 180;
local s_limit = 3;
local sa_rage = (gui.GetValue("rbot_silentaim") + 1);
local ff_rage = gui.GetValue("rbot_team");
local aimlock = gui.GetValue("rbot_aimlock");
local nospread = gui.GetValue("rbot_antispread");
local norecoil = gui.GetValue("rbot_antirecoil");
local pa_rage = (gui.GetValue("rbot_positionadjustment") + 1);
local resolver = gui.GetValue("rbot_resolver");
local delayshot = (gui.GetValue("rbot_delayshot") + 1);
local taser_hc = gui.GetValue("rbot_taser_hitchance");
local quickstop = 3;
local dquickstop = false;
local aa_enable = gui.GetValue("rbot_antiaim_enable");
local attargets = (gui.GetValue("rbot_antiaim_at_targets") + 1);
local adirection = (gui.GetValue("rbot_antiaim_autodir") + 1); 
local jitter_r = gui.GetValue("rbot_antiaim_jitter_range");
local spinbot_s = gui.GetValue("rbot_antiaim_spinbot_speed");
local speedswitch = (gui.GetValue("rbot_antiaim_switch_speed") * 100);
local switch_r = gui.GetValue("rbot_antiaim_switch_range");
local aa_choose = 1;
local pitch_stand = (gui.GetValue("rbot_antiaim_stand_pitch_real") + 1);
local yaw_stand = (gui.GetValue("rbot_antiaim_stand_real") + 1);
local desync_stand = (gui.GetValue("rbot_antiaim_stand_desync") + 1);
local custom_pitch = gui.GetValue("rbot_antiaim_stand_pitch_custom");
local custom_yaw = gui.GetValue("rbot_antiaim_stand_real_add");
local stand_velocity = gui.GetValue("rbot_antiaim_stand_velocity");
local pitch_move = (gui.GetValue("rbot_antiaim_move_pitch_real") + 1);
local yaw_move = (gui.GetValue("rbot_antiaim_move_real") + 1);
local desync_move = (gui.GetValue("rbot_antiaim_move_desync") + 1);
local custom_pitch_move = gui.GetValue("rbot_antiaim_move_pitch_custom");
local custom_yaw_move = gui.GetValue("rbot_antiaim_move_real_add");
local pitch_edge = (gui.GetValue("rbot_antiaim_edge_pitch_real") + 1);
local yaw_edge = (gui.GetValue("rbot_antiaim_edge_real") + 1);
local desync_edge = (gui.GetValue("rbot_antiaim_edge_desync") + 1);
local custom_pitch_edge = gui.GetValue("rbot_antiaim_edge_pitch_custom");
local custom_yaw_edge = gui.GetValue("rbot_antiaim_edge_real_add");
local autorevolver = gui.GetValue("rbot_revolver_autocock");
local autoawpbody = gui.GetValue("rbot_sniper_autoawp");
local autopistol = gui.GetValue("rbot_pistol_autopistol");
local autoscope = 3;
local fakeduck_bind = gui.GetValue("rbot_antiaim_fakeduck");
local override_resolver = gui.GetValue("rbot_resolver_override");
local auntrusted = (gui.GetValue("msc_restrict") + 1);
--------- gun settings
local weapon_select = 1;
------- some func
local skinc = gui.GetValue("msc_skinchanger");
local playerlist = gui.GetValue("msc_playerlist");
-------------- for normal work
local window_moveable = true;
local draw_texture = false;
local bind_button = SenseUI.Keys.home;
local bind_active = false;
local bind_detect = SenseUI.KeyDetection.on_hotkey;
local show_gradient = true;
local window_bkey = SenseUI.Keys.delete;
local window_bact = false;
local window_bdet = SenseUI.KeyDetection.on_hotkey;

SenseUI.EnableLogs = true;

function draw_callback()
	if SenseUI.BeginWindow( "wnd1", 50, 50, 620, 600) then
		SenseUI.DrawTabBar();

		if show_gradient then
			SenseUI.AddGradient();
		end

		SenseUI.SetWindowDrawTexture( draw_texture ); -- Makes huge fps drop. Not recommended to use yet
		SenseUI.SetWindowMoveable( window_moveable );
		SenseUI.SetWindowOpenKey( window_bkey );

		if SenseUI.BeginTab( "aimbot", SenseUI.Icons.rage ) then
			if SenseUI.BeginGroup( "mainaim", "Aimbot", 25, 25, 235, 380 ) then
				switch_enabled = SenseUI.Checkbox( "Enabled", switch_enabled );
				if switch_enabled then
					gui.SetValue("rbot_active", 1);
					gui.SetValue("rbot_enable", 1);
					else
					gui.SetValue("rbot_enable", 0);
					gui.SetValue("rbot_active", 0);
				end
				SenseUI.Label( "Target Selection" );
				trg_selection = SenseUI.Combo("Target Selection", { "FOV", "Distance", "Next Shot", "Lowest Health", "Highest Damage", "Lowest Latency" }, trg_selection);
				gui.SetValue("rbot_pistol_mode", trg_selection-1);
				gui.SetValue("rbot_revolver_mode", trg_selection-1);
				gui.SetValue("rbot_smg_mode", trg_selection-1);
				gui.SetValue("rbot_rifle_mode", trg_selection-1);
				gui.SetValue("rbot_shotgun_mode", trg_selection-1);
				gui.SetValue("rbot_scout_mode", trg_selection-1);
				gui.SetValue("rbot_autosniper_mode", trg_selection-1);
				gui.SetValue("rbot_sniper_mode", trg_selection-1);
				gui.SetValue("rbot_lmg_mode", trg_selection-1);
				fov_rr = SenseUI.Slider("FOV Range", 0, 180, "°", "0°", "180°", false, fov_rr);
				gui.SetValue("rbot_fov", fov_rr);
				SenseUI.Label("Speed Limit");
				s_limit = SenseUI.Combo("Speed limit", { "Off", "On", "Auto" }, s_limit);
				gui.SetValue("rbot_speedlimit", s_limit-1);
				SenseUI.Label("Silent Aim");
				sa_rage = SenseUI.Combo("Sa_rage", { "Off", "Client-Side", "Server-Side" }, sa_rage);
				gui.SetValue("rbot_silentaim", sa_rage-1);
				ff_rage = SenseUI.Checkbox("Friendly Fire", ff_rage);
				gui.SetValue("rbot_team", ff_rage);
				aimlock = SenseUI.Checkbox("Aim Lock", aimlock);
				gui.SetValue("rbot_aimlock", aimlock);
				SenseUI.Label("Position Adjustment");
				pa_rage = SenseUI.Combo("PA_rage", { "Off", "Low", "Medium", "High", "Very High", "Adaptive", "Last Record" }, pa_rage);
				gui.SetValue("rbot_positionadjustment", pa_rage-1);
				resolver = SenseUI.Checkbox("Resolver", resolver);
				gui.SetValue("rbot_resolver", resolver);
				override_resolver = SenseUI.Bind("rrresolv", true, override_resolver);
				gui.SetValue("rbot_resolver_override", override_resolver);
				taser_hc = SenseUI.Slider("Taser Hitchance", 0, 100, "%", "0%", "100%", false, taser_hc);
				gui.SetValue("rbot_taser_hitchance", taser_hc);
				SenseUI.EndGroup();
			end
			if SenseUI.BeginGroup( "otheraim", "Other", 285, 25, 235, 380 ) then
				nospread = SenseUI.Checkbox("No Spread", nospread);
				gui.SetValue("rbot_antispread", nospread);
				norecoil = SenseUI.Checkbox("No Recoil", norecoil);
				gui.SetValue("rbot_antirecoil", norecoil);
				SenseUI.Label("Delay Shot");				
				delayshot = SenseUI.Combo("DS_rage", { "Off", "Accurate Unlag", "Accurate History" }, delayshot);
				gui.SetValue("rbot_delayshot", delayshot-1);
				SenseUI.Label("Auto Stop");
				quickstop = SenseUI.Combo("QS_rage", { "Off", "Full Stop", "Minimal Speed" }, quickstop);
				gui.SetValue("rbot_pistol_autostop", quickstop-1);
				gui.SetValue("rbot_revolver_autostop", quickstop-1);
				gui.SetValue("rbot_smg_autostop", quickstop-1);
				gui.SetValue("rbot_rifle_autostop", quickstop-1);
				gui.SetValue("rbot_shotgun_autostop", quickstop-1);
				gui.SetValue("rbot_scout_autostop", quickstop-1);
				gui.SetValue("rbot_autosniper_autostop", quickstop-1);
				gui.SetValue("rbot_sniper_autostop", quickstop-1);
				gui.SetValue("rbot_lmg_autostop", quickstop-1);
				SenseUI.Label("Auto Scope");
				autoscope = SenseUI.Combo("az_rage", { "Off", "On - Auto Unzoom", "On - No Unzoom" }, autoscope);
				gui.SetValue("rbot_autosniper_autoscope", autoscope-1);
				gui.SetValue("rbot_sniper_autoscope", autoscope-1);
				gui.SetValue("rbot_scout_autoscope", autoscope-1);
				dquickstop = SenseUI.Checkbox("Auto Duck", dquickstop);
				gui.SetValue("rbot_pistol_autostop_duck", dquickstop);
				gui.SetValue("rbot_revolver_autostop_duck", dquickstop);
				gui.SetValue("rbot_smg_autostop_duck", dquickstop);
				gui.SetValue("rbot_rifle_autostop_duck", dquickstop);
				gui.SetValue("rbot_shotgun_autostop_duck", dquickstop);
				gui.SetValue("rbot_scout_autostop_duck", dquickstop);
				gui.SetValue("rbot_autosniper_autostop_duck", dquickstop);
				gui.SetValue("rbot_sniper_autostop_duck", dquickstop);
				gui.SetValue("rbot_lmg_autostop_duck", dquickstop);
				autorevolver = SenseUI.Checkbox("Auto Revolver", autorevolver);
				gui.SetValue("rbot_revolver_autocock", autorevolver);
				autoawpbody = SenseUI.Checkbox("AWP Body", autoawpbody);
				gui.SetValue("rbot_sniper_autoawp", autoawpbody);
				autopistol = SenseUI.Checkbox("Auto Pistol", autopistol);
				gui.SetValue("rbot_pistol_autopistol", autopistol);
				SenseUI.EndGroup();
			end
		end
		SenseUI.EndTab();
		if SenseUI.BeginTab( "antiaim", SenseUI.Icons.antiaim ) then
			if SenseUI.BeginGroup( "antiaim main", "Anti-Aim Main", 25, 25, 235, 255 ) then
				aa_enable = SenseUI.Checkbox("Enable AA", aa_enable);
				gui.SetValue("rbot_antiaim_enable", aa_enable);
				SenseUI.Label("At Targets");
				attargets = SenseUI.Combo("attargets_rage", { "Off", "Average", "Closest" }, attargets);
				gui.SetValue("rbot_antiaim_at_targets", attargets-1);
				SenseUI.Label("Auto Direction");
				adirection = SenseUI.Combo("adirection_rage", { "Off", "Default", "Desync", "Desync Jitter" }, adirection);
				gui.SetValue("rbot_antiaim_autodir", adirection-1);
				jitter_r = SenseUI.Slider("Jitter Range", 0, 180, "°", "0°", "180°", false, jitter_r);
				gui.SetValue("rbot_antiaim_jitter_range", jitter_r);
				spinbot_s = SenseUI.Slider("Spinbot Speed", -200, 200, "", "-20", "20", false, spinbot_s);
				gui.SetValue("rbot_antiaim_spinbot_speed", spinbot_s / 10);
				speedswitch = SenseUI.Slider("Switch Speed", 0, 100, "%", "0%", "100%", false, speedswitch);
				gui.SetValue("rbot_antiaim_switch_speed", speedswitch / 100);
				switch_r = SenseUI.Slider("Switch Range", 0, 180, "°", "0°", "180°", false, switch_r);
				gui.SetValue("rbot_antiaim_switch_range", switch_r);
				SenseUI.Label("Fake Duck Bind");
				fakeduck_bind = SenseUI.Bind("fduck", true, fakeduck_bind);
				gui.SetValue("rbot_antiaim_fakeduck", fakeduck_bind);
				SenseUI.EndGroup();
			end
			if SenseUI.BeginGroup( "anti-aim", "Anti-Aim", 285, 25, 235, 380 ) then
				SenseUI.Label("AA Mode Choose");
				aa_choose = SenseUI.Combo( "aa_choose_rage", { "Stand", "Move", "Edge" }, aa_choose);
				if aa_choose == 1 then
					SenseUI.Label("Pitch");
					pitch_stand = SenseUI.Combo( "pitch_rage_stand", { "Off", "Emotion", "Down", "Up", "Zero", "Mixed", "Custom" }, pitch_stand);
					gui.SetValue("rbot_antiaim_stand_pitch_real", pitch_stand-1);
					custom_pitch = SenseUI.Slider( "Custom Pitch", -180, 180, "°", "0°", "180°", false, custom_pitch);
					gui.SetValue("rbot_antiaim_stand_pitch_custom", custom_pitch);
					SenseUI.Label("Yaw");
					yaw_stand = SenseUI.Combo( "just choose2", { "Off", "Static", "Spinbot", "Jitter", "Zero", "Switch" }, yaw_stand);
					gui.SetValue("rbot_antiaim_stand_real", yaw_stand-1);
					custom_yaw = SenseUI.Slider( "Custom Yaw", -180, 180, "°", "0°", "180°", false, custom_yaw);
					gui.SetValue("rbot_antiaim_stand_real_add", custom_yaw);
					SenseUI.Label("Yaw Desync");
					desync_stand = SenseUI.Combo( "just choose3", { "Off", "Still", "Balance", "Stretch", "Jitter" }, desync_stand);
					gui.SetValue("rbot_antiaim_stand_desync", desync_stand-1);
					stand_velocity = SenseUI.Slider( "Stand Velocity Treshold", 0, 250, "", "0.1", "250", false, stand_velocity);
					gui.SetValue("rbot_antiaim_stand_velocity", stand_velocity);
				else if aa_choose == 2 then
					SenseUI.Label("Pitch");
					pitch_move = SenseUI.Combo( "just choose4", { "Off", "Emotion", "Down", "Up", "Zero", "Mixed", "Custom" }, pitch_move);
					gui.SetValue("rbot_antiaim_move_pitch_real", pitch_move-1);
					custom_pitch_move = SenseUI.Slider( "Custom Pitch", -180, 180, "°", "0°", "180°", false, custom_pitch_move);
					gui.SetValue("rbot_antiaim_move_pitch_custom", custom_pitch_move);
					SenseUI.Label("Yaw");
					yaw_move = SenseUI.Combo( "just choose5", { "Off", "Static", "Spinbot", "Jitter", "Zero", "Switch" }, yaw_move);
					gui.SetValue("rbot_antiaim_move_real", yaw_move-1);
					custom_yaw_move = SenseUI.Slider( "Custom Yaw", -180, 180, "°", "0°", "180°", false, custom_yaw_move);
					gui.SetValue("rbot_antiaim_move_real_add", custom_yaw_move);
					SenseUI.Label("Yaw Desync");
					desync_move = SenseUI.Combo( "just choose6", { "Off", "Still", "Balance", "Stretch", "Jitter" }, desync_move);
					gui.SetValue("rbot_antiaim_move_desync", desync_move-1);
				else if aa_choose == 3 then
					SenseUI.Label("Pitch");
					pitch_edge = SenseUI.Combo( "just choose7", { "Off", "Emotion", "Down", "Up", "Zero", "Mixed", "Custom" }, pitch_edge);
					gui.SetValue("rbot_antiaim_edge_pitch_real", pitch_edge-1);
					custom_pitch_edge = SenseUI.Slider( "Custom Pitch", -180, 180, "°", "0°", "180°", false, custom_pitch_edge);
					gui.SetValue("rbot_antiaim_edge_pitch_custom", custom_pitch_edge);
					SenseUI.Label("Yaw");
					yaw_edge = SenseUI.Combo( "just choose8", { "Off", "Static", "Spinbot", "Jitter", "Zero", "Switch" }, yaw_edge);
					gui.SetValue("rbot_antiaim_edge_real", yaw_edge-1);
					custom_yaw_edge = SenseUI.Slider( "Custom Yaw", -180, 180, "°", "0°", "180°", false, custom_yaw_edge);
					gui.SetValue("rbot_antiaim_edge_real_add", custom_yaw_edge);
					SenseUI.Label("Yaw Desync");
					desync_edge = SenseUI.Combo( "just choose9", { "Off", "Still", "Balance", "Stretch", "Jitter" }, desync_edge);
					gui.SetValue("rbot_antiaim_edge_desync", desync_edge-1);
				end
				end
				end
				SenseUI.EndGroup();
			end
		end
		SenseUI.EndTab();
		if SenseUI.BeginTab( "gunsettings", SenseUI.Icons.legit ) then
			if SenseUI.BeginGroup( "gunssettingss", "Main", 25, 25, 235, 400 ) then
				SenseUI.Label("Weapon Selection");
				weapon_select = SenseUI.Combo("nvmd_rage", { "Pistol", "Revolver", "SMG", "Rifle", "Shotgun", "Scout", "AutoSniper", "AWP", "LMG" }, weapon_select );
				if weapon_select == 1 then
				
				local p_autowall = (gui.GetValue("rbot_pistol_autowall") + 1);
				local p_hitchance = gui.GetValue("rbot_pistol_hitchance");
				local p_mindamage = gui.GetValue("rbot_pistol_mindamage");
				local p_hitprior = (gui.GetValue("rbot_pistol_hitbox") + 1);
				local p_bodyaim = (gui.GetValue("rbot_pistol_hitbox_bodyaim") + 1);
				local p_method = (gui.GetValue("rbot_pistol_hitbox_method") + 1);
				local p_baimX = gui.GetValue("rbot_pistol_bodyaftershots");
				local p_baimHP = gui.GetValue("rbot_pistol_bodyifhplower");
				local p_hscale = (gui.GetValue("rbot_pistol_hitbox_head_ps") * 100);
				local p_nscale = (gui.GetValue("rbot_pistol_hitbox_neck_ps") * 100);
				local p_cscale = (gui.GetValue("rbot_pistol_hitbox_chest_ps") * 100);
				local p_sscale = (gui.GetValue("rbot_pistol_hitbox_stomach_ps") * 100);
				local p_pscale = (gui.GetValue("rbot_pistol_hitbox_pelvis_ps") * 100);
				local p_ascale = (gui.GetValue("rbot_pistol_hitbox_arms_ps") * 100);
				local p_lscale = (gui.GetValue("rbot_pistol_hitbox_legs_ps") * 100);
				local p_autoscale = gui.GetValue("rbot_pistol_hitbox_auto_ps");
				local p_autoscales = (gui.GetValue("rbot_pistol_hitbox_auto_ps_max") * 100);
				
				SenseUI.Label("Auto Wall Type");
				p_autowall = SenseUI.Combo("p_autowall", { "Off", "Accurate", "Optimized" }, p_autowall);
				gui.SetValue("rbot_pistol_autowall", p_autowall-1);
				p_hitchance = SenseUI.Slider("Hit Chance", 0, 100, "%", "0%", "100%", false, p_hitchance);
				gui.SetValue("rbot_pistol_hitchance", p_hitchance);
				p_mindamage = SenseUI.Slider("Minimal Damage", 0, 100, "", "0", "100", false, p_mindamage);
				gui.SetValue("rbot_pistol_mindamage", p_mindamage);
				SenseUI.Label("Hitbox Priority");
				p_hitprior = SenseUI.Combo("p_hitprior", { "Head", "Neck", "Check", "Stomach", "Pelvis", "Center" }, p_hitprior);
				gui.SetValue("rbot_pistol_hitbox", p_hitprior-1);
				SenseUI.Label("Body Aim Hitbox");
				p_bodyaim = SenseUI.Combo("p_bodyaim", { "Pelvis", "Pelvis + Edge", "Center" }, p_bodyaim);
				gui.SetValue("rbot_pistol_hitbox_bodyaim", p_bodyaim-1);
				SenseUI.Label("Hitbox Selection Method");
				p_method = SenseUI.Combo("p_method", { "Damage", "Accuracy" }, p_method);
				gui.SetValue("rbot_pistol_hitbox_method", p_method-1);
				p_baimX = SenseUI.Slider("Body Aim after X Shots", 0, 15, "", "0", "15", false, p_baimX);
				gui.SetValue("rbot_pistol_bodyaftershots", p_baimX);
				p_baimHP = SenseUI.Slider("Body Aim if HP Lower Than", 0, 100, "", "0", "100", false, p_baimHP);
				gui.SetValue("rbot_pistol_bodyifhplower", p_baimHP);
				
				local p_adaptive = gui.GetValue("rbot_pistol_hitbox_adaptive");
				p_adaptive = SenseUI.Checkbox("Adaptive Hitbox", p_adaptive);
				gui.SetValue("rbot_pistol_hitbox_adaptive", p_adaptive); 
				local p_points = gui.GetValue("rbot_pistol_hitbox_optpoints");
				p_points = SenseUI.Checkbox("Nearby Points", p_points);
				gui.SetValue("rbot_pistol_hitbox_optpoints", p_points);
				local p_backtrack = gui.GetValue("rbot_pistol_hitbox_optbacktrack");
				p_backtrack = SenseUI.Checkbox("Backtrack Points", p_backtrack);
				gui.SetValue("rbot_pistol_hitbox_optbacktrack", p_backtrack);
				
					else if weapon_select == 2 then
					
					local rev_autowall = (gui.GetValue("rbot_revolver_autowall") + 1);
					local rev_hitchance = gui.GetValue("rbot_revolver_hitchance");
					local rev_mindamage = gui.GetValue("rbot_revolver_mindamage");
					local rev_hitprior = (gui.GetValue("rbot_revolver_hitbox") + 1);
					local rev_bodyaim = (gui.GetValue("rbot_revolver_hitbox_bodyaim") + 1);
					local rev_method = (gui.GetValue("rbot_revolver_hitbox_method") + 1);
					local rev_baimX = gui.GetValue("rbot_revolver_bodyaftershots");
					local rev_baimHP = gui.GetValue("rbot_revolver_bodyifhplower");
					local rev_hscale = (gui.GetValue("rbot_revolver_hitbox_head_ps") * 100);
					local rev_nscale = (gui.GetValue("rbot_revolver_hitbox_neck_ps") * 100);
					local rev_cscale = (gui.GetValue("rbot_revolver_hitbox_chest_ps") * 100);
					local rev_sscale = (gui.GetValue("rbot_revolver_hitbox_stomach_ps") * 100);
					local rev_pscale = (gui.GetValue("rbot_revolver_hitbox_pelvis_ps") * 100);
					local rev_ascale = (gui.GetValue("rbot_revolver_hitbox_arms_ps") * 100);
					local rev_lscale = (gui.GetValue("rbot_revolver_hitbox_legs_ps") * 100);
					local rev_autoscale = gui.GetValue("rbot_revolver_hitbox_auto_ps");
					local rev_autoscales = (gui.GetValue("rbot_revolver_hitbox_auto_ps_max") * 100);
					
					SenseUI.Label("Auto Wall Type");
					rev_autowall = SenseUI.Combo("rev_autowall", { "Off", "Accurate", "Optimized" }, rev_autowall);
					gui.SetValue("rbot_revolver_autowall", rev_autowall-1);
					rev_hitchance = SenseUI.Slider("Hit Chance", 0, 100, "%", "0%", "100%", false, rev_hitchance);
					gui.SetValue("rbot_revolver_hitchance", rev_hitchance);
					rev_mindamage = SenseUI.Slider("Minimal Damage", 0, 100, "", "0", "100", false, rev_mindamage);
					gui.SetValue("rbot_revolver_mindamage", rev_mindamage);
					SenseUI.Label("Hitbox Priority");
					rev_hitprior = SenseUI.Combo("rev_hitprior", { "Head", "Neck", "Check", "Stomach", "Pelvis", "Center" }, rev_hitprior);
					gui.SetValue("rbot_revolver_hitbox", rev_hitprior-1);
					SenseUI.Label("Body Aim Hitbox");
					rev_bodyaim = SenseUI.Combo("rev_bodyaim", { "Pelvis", "Pelvis + Edge", "Center" }, rev_bodyaim);
					gui.SetValue("rbot_revolver_hitbox_bodyaim", rev_bodyaim-1);
					SenseUI.Label("Hitbox Selection Method");
					rev_method = SenseUI.Combo("rev_method", { "Damage", "Accuracy" }, rev_method);
					gui.SetValue("rbot_revolver_hitbox_method", rev_method-1);
					rev_baimX = SenseUI.Slider("Body Aim after X Shots", 0, 15, "", "0", "15", false, rev_baimX);
					gui.SetValue("rbot_revolver_bodyaftershots", rev_baimX);
					rev_baimHP = SenseUI.Slider("Body Aim if HP Lower Than", 0, 100, "", "0", "100", false, rev_baimHP);
					gui.SetValue("rbot_revolver_bodyifhplower", rev_baimHP);
					
					local r_adaptive = gui.GetValue("rbot_revolver_hitbox_adaptive");
					r_adaptive = SenseUI.Checkbox("Adaptive Hitbox", r_adaptive);
					gui.SetValue("rbot_revolver_hitbox_adaptive", r_adaptive);
					local r_points = gui.GetValue("rbot_revolver_hitbox_optpoints");
					r_points = SenseUI.Checkbox("Nearby Points", r_points);
					gui.SetValue("rbot_revolver_hitbox_optpoints", r_points);
					local r_backtrack = gui.GetValue("rbot_revolver_hitbox_optbacktrack");
					r_backtrack = SenseUI.Checkbox("Backtrack Points", r_backtrack);
					gui.SetValue("rbot_revolver_hitbox_optbacktrack", r_backtrack);
						else if weapon_select == 3 then
						
						local smg_autowall = (gui.GetValue("rbot_smg_autowall") + 1);
						local smg_hitchance = gui.GetValue("rbot_smg_hitchance");
						local smg_mindamage = gui.GetValue("rbot_smg_mindamage");
						local smg_hitprior = (gui.GetValue("rbot_smg_hitbox") + 1);
						local smg_bodyaim = (gui.GetValue("rbot_smg_hitbox_bodyaim") + 1);
						local smg_method = (gui.GetValue("rbot_smg_hitbox_method") + 1);
						local smg_baimX = gui.GetValue("rbot_smg_bodyaftershots");
						local smg_baimHP = gui.GetValue("rbot_smg_bodyifhplower");
						local smg_hscale = (gui.GetValue("rbot_smg_hitbox_head_ps") * 100);
						local smg_nscale = (gui.GetValue("rbot_smg_hitbox_neck_ps") * 100);
						local smg_cscale = (gui.GetValue("rbot_smg_hitbox_chest_ps") * 100);
						local smg_sscale = (gui.GetValue("rbot_smg_hitbox_stomach_ps") * 100);
						local smg_pscale = (gui.GetValue("rbot_smg_hitbox_pelvis_ps") * 100);
						local smg_ascale = (gui.GetValue("rbot_smg_hitbox_arms_ps") * 100);
						local smg_lscale = (gui.GetValue("rbot_smg_hitbox_legs_ps") * 100);
						local smg_autoscale = gui.GetValue("rbot_smg_hitbox_auto_ps");
						local smg_autoscales = (gui.GetValue("rbot_smg_hitbox_auto_ps_max") * 100);
						
						SenseUI.Label("Auto Wall Type");
						smg_autowall = SenseUI.Combo("smg_autowall", { "Off", "Accurate", "Optimized" }, smg_autowall);
						gui.SetValue("rbot_smg_autowall", smg_autowall-1);
						smg_hitchance = SenseUI.Slider("Hit Chance", 0, 100, "%", "0%", "100%", false, smg_hitchance);
						gui.SetValue("rbot_smg_hitchance", smg_hitchance);
						smg_mindamage = SenseUI.Slider("Minimal Damage", 0, 100, "", "0", "100", false, smg_mindamage);
						gui.SetValue("rbot_smg_mindamage", smg_mindamage);
						SenseUI.Label("Hitbox Priority");
						smg_hitprior = SenseUI.Combo("smg_hitprior", { "Head", "Neck", "Check", "Stomach", "Pelvis", "Center" }, smg_hitprior);
						gui.SetValue("rbot_smg_hitbox", smg_hitprior-1);
						SenseUI.Label("Body Aim Hitbox");
						smg_bodyaim = SenseUI.Combo("smg_bodyaim", { "Pelvis", "Pelvis + Edge", "Center" }, smg_bodyaim);
						gui.SetValue("rbot_smg_hitbox_bodyaim", smg_bodyaim-1);
						SenseUI.Label("Hitbox Selection Method");
						smg_method = SenseUI.Combo("smg_method", { "Damage", "Accuracy" }, smg_method);
						gui.SetValue("rbot_smg_hitbox_method", smg_method-1);
						smg_baimX = SenseUI.Slider("Body Aim after X Shots", 0, 15, "", "0", "15", false, smg_baimX);
						gui.SetValue("rbot_smg_bodyaftershots", smg_baimX);
						smg_baimHP = SenseUI.Slider("Body Aim if HP Lower Than", 0, 100, "", "0", "100", false, smg_baimHP);
						gui.SetValue("rbot_smg_bodyifhplower", smg_baimHP);
						
						local smg_adaptive = gui.GetValue("rbot_smg_hitbox_adaptive");
						smg_adaptive = SenseUI.Checkbox("Adaptive Hitbox", smg_adaptive);
						gui.SetValue("rbot_smg_hitbox_adaptive", smg_adaptive);
						local smg_points = gui.GetValue("rbot_smg_hitbox_optpoints");
						smg_points = SenseUI.Checkbox("Nearby Points", smg_points);
						gui.SetValue("rbot_smg_hitbox_optpoints", smg_points);
						local smg_backtrack = gui.GetValue("rbot_smg_hitbox_optbacktrack");
						smg_backtrack = SenseUI.Checkbox("Backtrack Points", smg_backtrack);
						gui.SetValue("rbot_smg_hitbox_optbacktrack", smg_backtrack);
							else if weapon_select == 4 then
							
							local rifle_autowall = (gui.GetValue("rbot_rifle_autowall") + 1);
							local rifle_hitchance = gui.GetValue("rbot_rifle_hitchance");
							local rifle_mindamage = gui.GetValue("rbot_rifle_mindamage");
							local rifle_hitprior = (gui.GetValue("rbot_rifle_hitbox") + 1);
							local rifle_bodyaim = (gui.GetValue("rbot_rifle_hitbox_bodyaim") + 1);
							local rifle_method = (gui.GetValue("rbot_rifle_hitbox_method") + 1);
							local rifle_baimX = gui.GetValue("rbot_rifle_bodyaftershots");
							local rifle_baimHP = gui.GetValue("rbot_rifle_bodyifhplower");
							local rifle_hscale = (gui.GetValue("rbot_rifle_hitbox_head_ps") * 100);
							local rifle_nscale = (gui.GetValue("rbot_rifle_hitbox_neck_ps") * 100);
							local rifle_cscale = (gui.GetValue("rbot_rifle_hitbox_chest_ps") * 100);
							local rifle_sscale = (gui.GetValue("rbot_rifle_hitbox_stomach_ps") * 100);
							local rifle_pscale = (gui.GetValue("rbot_rifle_hitbox_pelvis_ps") * 100);
							local rifle_ascale = (gui.GetValue("rbot_rifle_hitbox_arms_ps") * 100);
							local rifle_lscale = (gui.GetValue("rbot_rifle_hitbox_legs_ps") * 100);
							local rifle_autoscale = gui.GetValue("rbot_rifle_hitbox_auto_ps");
							local rifle_autoscales = (gui.GetValue("rbot_rifle_hitbox_auto_ps_max") * 100);
							
							SenseUI.Label("Auto Wall Type");
							rifle_autowall = SenseUI.Combo("rifle_autowall", { "Off", "Accurate", "Optimized" }, rifle_autowall);
							gui.SetValue("rbot_rifle_autowall", rifle_autowall-1);
							rifle_hitchance = SenseUI.Slider("Hit Chance", 0, 100, "%", "0%", "100%", false, rifle_hitchance);
							gui.SetValue("rbot_rifle_hitchance", rifle_hitchance);
							rifle_mindamage = SenseUI.Slider("Minimal Damage", 0, 100, "", "0", "100", false, rifle_mindamage);
							gui.SetValue("rbot_rifle_mindamage", rifle_mindamage);
							SenseUI.Label("Hitbox Priority");
							rifle_hitprior = SenseUI.Combo("rifle_hitprior", { "Head", "Neck", "Check", "Stomach", "Pelvis", "Center" }, rifle_hitprior);
							gui.SetValue("rbot_rifle_hitbox", rifle_hitprior-1);
							SenseUI.Label("Body Aim Hitbox");
							rifle_bodyaim = SenseUI.Combo("rifle_bodyaim", { "Pelvis", "Pelvis + Edge", "Center" }, rifle_bodyaim);
							gui.SetValue("rbot_rifle_hitbox_bodyaim", rifle_bodyaim-1);
							SenseUI.Label("Hitbox Selection Method");
							rifle_method = SenseUI.Combo("rifle_method", { "Damage", "Accuracy" }, rifle_method);
							gui.SetValue("rbot_rifle_hitbox_method", rifle_method-1);
							rifle_baimX = SenseUI.Slider("Body Aim after X Shots", 0, 15, "", "0", "15", false, rifle_baimX);
							gui.SetValue("rbot_rifle_bodyaftershots", rifle_baimX);
							rifle_baimHP = SenseUI.Slider("Body Aim if HP Lower Than", 0, 100, "", "0", "100", false, rifle_baimHP);
							gui.SetValue("rbot_rifle_bodyifhplower", rifle_baimHP);
							
							local rif_adaptive = gui.GetValue("rbot_rifle_hitbox_adaptive"); 
							rif_adaptive = SenseUI.Checkbox("Adaptive Hitbox", rif_adaptive);
							gui.SetValue("rbot_rifle_hitbox_adaptive", rif_adaptive);
							local rif_points = gui.GetValue("rbot_rifle_hitbox_optpoints");
							rif_points = SenseUI.Checkbox("Nearby Points", rif_points);
							gui.SetValue("rbot_rifle_hitbox_optpoints", rif_points);
							local rif_backtrack = gui.GetValue("rbot_rifle_hitbox_optbacktrack");
							rif_backtrack = SenseUI.Checkbox("Backtrack Points", rif_backtrack);
							gui.SetValue("rbot_rifle_hitbox_optbacktrack", rif_backtrack);
								else if weapon_select == 5 then
								
								local shotgun_autowall = (gui.GetValue("rbot_shotgun_autowall") + 1);
								local shotgun_hitchance = gui.GetValue("rbot_shotgun_hitchance");
								local shotgun_mindamage = gui.GetValue("rbot_shotgun_mindamage");
								local shotgun_hitprior = (gui.GetValue("rbot_shotgun_hitbox") + 1);
								local shotgun_bodyaim = (gui.GetValue("rbot_shotgun_hitbox_bodyaim") + 1);
								local shotgun_method = (gui.GetValue("rbot_shotgun_hitbox_method") + 1);
								local shotgun_baimX = gui.GetValue("rbot_shotgun_bodyaftershots");
								local shotgun_baimHP = gui.GetValue("rbot_shotgun_bodyifhplower");
								local shotgun_hscale = (gui.GetValue("rbot_shotgun_hitbox_head_ps") * 100);
								local shotgun_nscale = (gui.GetValue("rbot_shotgun_hitbox_neck_ps") * 100);
								local shotgun_cscale = (gui.GetValue("rbot_shotgun_hitbox_chest_ps") * 100);
								local shotgun_sscale = (gui.GetValue("rbot_shotgun_hitbox_stomach_ps") * 100);
								local shotgun_pscale = (gui.GetValue("rbot_shotgun_hitbox_pelvis_ps") * 100);
								local shotgun_ascale = (gui.GetValue("rbot_shotgun_hitbox_arms_ps") * 100);
								local shotgun_lscale = (gui.GetValue("rbot_shotgun_hitbox_legs_ps") * 100);
								local shotgun_autoscale = gui.GetValue("rbot_shotgun_hitbox_auto_ps");
								local shotgun_autoscales = (gui.GetValue("rbot_shotgun_hitbox_auto_ps_max") * 100);
								
								SenseUI.Label("Auto Wall Type");
								shotgun_autowall = SenseUI.Combo("shotgun_autowall", { "Off", "Accurate", "Optimized" }, shotgun_autowall);
								gui.SetValue("rbot_shotgun_autowall", shotgun_autowall-1);
								shotgun_hitchance = SenseUI.Slider("Hit Chance", 0, 100, "%", "0%", "100%", false, shotgun_hitchance);
								gui.SetValue("rbot_shotgun_hitchance", shotgun_hitchance);
								shotgun_mindamage = SenseUI.Slider("Minimal Damage", 0, 100, "", "0", "100", false, shotgun_mindamage);
								gui.SetValue("rbot_shotgun_mindamage", shotgun_mindamage);
								SenseUI.Label("Hitbox Priority");
								shotgun_hitprior = SenseUI.Combo("shotgun_hitprior", { "Head", "Neck", "Check", "Stomach", "Pelvis", "Center" }, shotgun_hitprior);
								gui.SetValue("rbot_shotgun_hitbox", shotgun_hitprior-1);
								SenseUI.Label("Body Aim Hitbox");
								shotgun_bodyaim = SenseUI.Combo("shotgun_bodyaim", { "Pelvis", "Pelvis + Edge", "Center" }, shotgun_bodyaim);
								gui.SetValue("rbot_shotgun_hitbox_bodyaim", shotgun_bodyaim-1);
								SenseUI.Label("Hitbox Selection Method");
								shotgun_method = SenseUI.Combo("shotgun_method", { "Damage", "Accuracy" }, shotgun_method);
								gui.SetValue("rbot_shotgun_hitbox_method", shotgun_method-1);
								shotgun_baimX = SenseUI.Slider("Body Aim after X Shots", 0, 15, "", "0", "15", false, shotgun_baimX);
								gui.SetValue("rbot_shotgun_bodyaftershots", shotgun_baimX);
								shotgun_baimHP = SenseUI.Slider("Body Aim if HP Lower Than", 0, 100, "", "0", "100", false, shotgun_baimHP);
								gui.SetValue("rbot_shotgun_bodyifhplower", shotgun_baimHP);
								
								local sgun_adaptive = gui.GetValue("rbot_shotgun_hitbox_adaptive");
								sgun_adaptive = SenseUI.Checkbox("Adaptive Hitbox", sgun_adaptive);
								gui.SetValue("rbot_shotgun_hitbox_adaptive", sgun_adaptive);
								local sgun_points = gui.GetValue("rbot_shotgun_hitbox_optpoints");
								sgun_points = SenseUI.Checkbox("Nearby Points", sgun_points);
								gui.SetValue("rbot_shotgun_hitbox_optpoints", sgun_points);
								local sgun_backtrack = gui.GetValue("rbot_shotgun_hitbox_optbacktrack");
								sgun_backtrack = SenseUI.Checkbox("Backtrack Points", sgun_backtrack);
								gui.SetValue("rbot_shotgun_hitbox_optbacktrack", sgun_backtrack);
									else if weapon_select == 6 then
									
									local scout_autowall = (gui.GetValue("rbot_scout_autowall") + 1);
									local scout_hitchance = gui.GetValue("rbot_scout_hitchance");
									local scout_mindamage = gui.GetValue("rbot_scout_mindamage");
									local scout_hitprior = (gui.GetValue("rbot_scout_hitbox") + 1);
									local scout_bodyaim = (gui.GetValue("rbot_scout_hitbox_bodyaim") + 1);
									local scout_method = (gui.GetValue("rbot_scout_hitbox_method") + 1);
									local scout_baimX = gui.GetValue("rbot_scout_bodyaftershots");
									local scout_baimHP = gui.GetValue("rbot_scout_bodyifhplower");
									local scout_hscale = (gui.GetValue("rbot_scout_hitbox_head_ps") * 100);
									local scout_nscale = (gui.GetValue("rbot_scout_hitbox_neck_ps") * 100);
									local scout_cscale = (gui.GetValue("rbot_scout_hitbox_chest_ps") * 100);
									local scout_sscale = (gui.GetValue("rbot_scout_hitbox_stomach_ps") * 100);
									local scout_pscale = (gui.GetValue("rbot_scout_hitbox_pelvis_ps") * 100);
									local scout_ascale = (gui.GetValue("rbot_scout_hitbox_arms_ps") * 100);
									local scout_lscale = (gui.GetValue("rbot_scout_hitbox_legs_ps") * 100);
									local scout_autoscale = gui.GetValue("rbot_scout_hitbox_auto_ps");
									local scout_autoscales = (gui.GetValue("rbot_scout_hitbox_auto_ps_max") * 100);
									
									SenseUI.Label("Auto Wall Type");
									scout_autowall = SenseUI.Combo("scout_autowall", { "Off", "Accurate", "Optimized" }, scout_autowall);
									gui.SetValue("rbot_scout_autowall", scout_autowall-1);
									scout_hitchance = SenseUI.Slider("Hit Chance", 0, 100, "%", "0%", "100%", false, scout_hitchance);
									gui.SetValue("rbot_scout_hitchance", scout_hitchance);
									scout_mindamage = SenseUI.Slider("Minimal Damage", 0, 100, "", "0", "100", false, scout_mindamage);
									gui.SetValue("rbot_scout_mindamage", scout_mindamage);
									SenseUI.Label("Hitbox Priority");
									scout_hitprior = SenseUI.Combo("scout_hitprior", { "Head", "Neck", "Check", "Stomach", "Pelvis", "Center" }, scout_hitprior);
									gui.SetValue("rbot_scout_hitbox", scout_hitprior-1);
									SenseUI.Label("Body Aim Hitbox");
									scout_bodyaim = SenseUI.Combo("scout_bodyaim", { "Pelvis", "Pelvis + Edge", "Center" }, scout_bodyaim);
									gui.SetValue("rbot_scout_hitbox_bodyaim", scout_bodyaim-1);
									SenseUI.Label("Hitbox Selection Method");
									scout_method = SenseUI.Combo("scout_method", { "Damage", "Accuracy" }, scout_method);
									gui.SetValue("rbot_scout_hitbox_method", scout_method-1);
									scout_baimX = SenseUI.Slider("Body Aim after X Shots", 0, 15, "", "0", "15", false, scout_baimX);
									gui.SetValue("rbot_scout_bodyaftershots", scout_baimX);
									scout_baimHP = SenseUI.Slider("Body Aim if HP Lower Than", 0, 100, "", "0", "100", false, scout_baimHP);
									gui.SetValue("rbot_scout_bodyifhplower", scout_baimHP);	

									local scout_adaptive = gui.GetValue("rbot_scout_hitbox_adaptive");
									scout_adaptive = SenseUI.Checkbox("Adaptive Hitbox", scout_adaptive);
									gui.SetValue("rbot_scout_hitbox_adaptive", scout_adaptive);
									local scout_points = gui.GetValue("rbot_scout_hitbox_optpoints");
									scout_points = SenseUI.Checkbox("Nearby Points", scout_points);
									gui.SetValue("rbot_scout_hitbox_optpoints", scout_points);
									local scout_backtrack = gui.GetValue("rbot_scout_hitbox_optbacktrack");
									scout_backtrack = SenseUI.Checkbox("Backtrack Points", scout_backtrack);
									gui.SetValue("rbot_scout_hitbox_optbacktrack", scout_backtrack);									
										else if weapon_select == 7 then
										
										local autosniper_autowall = (gui.GetValue("rbot_autosniper_autowall") + 1);
										local autosniper_hitchance = gui.GetValue("rbot_autosniper_hitchance");
										local autosniper_mindamage = gui.GetValue("rbot_autosniper_mindamage");
										local autosniper_hitprior = (gui.GetValue("rbot_autosniper_hitbox") + 1);
										local autosniper_bodyaim = (gui.GetValue("rbot_autosniper_hitbox_bodyaim") + 1);
										local autosniper_method = (gui.GetValue("rbot_autosniper_hitbox_method") + 1);
										local autosniper_baimX = gui.GetValue("rbot_autosniper_bodyaftershots");
										local autosniper_baimHP = gui.GetValue("rbot_autosniper_bodyifhplower");
										local autosniper_hscale = (gui.GetValue("rbot_autosniper_hitbox_head_ps") * 100);
										local autosniper_nscale = (gui.GetValue("rbot_autosniper_hitbox_neck_ps") * 100);
										local autosniper_cscale = (gui.GetValue("rbot_autosniper_hitbox_chest_ps") * 100);
										local autosniper_sscale = (gui.GetValue("rbot_autosniper_hitbox_stomach_ps") * 100);
										local autosniper_pscale = (gui.GetValue("rbot_autosniper_hitbox_pelvis_ps") * 100);
										local autosniper_ascale = (gui.GetValue("rbot_autosniper_hitbox_arms_ps") * 100);
										local autosniper_lscale = (gui.GetValue("rbot_autosniper_hitbox_legs_ps") * 100);
										local autosniper_autoscale = gui.GetValue("rbot_autosniper_hitbox_auto_ps");
										local autosniper_autoscales = (gui.GetValue("rbot_autosniper_hitbox_auto_ps_max") * 100);
										
										SenseUI.Label("Auto Wall Type");
										autosniper_autowall = SenseUI.Combo("autosniper_autowall", { "Off", "Accurate", "Optimized" }, autosniper_autowall);
										gui.SetValue("rbot_autosniper_autowall", autosniper_autowall-1);
										autosniper_hitchance = SenseUI.Slider("Hit Chance", 0, 100, "%", "0%", "100%", false, autosniper_hitchance);
										gui.SetValue("rbot_autosniper_hitchance", autosniper_hitchance);
										autosniper_mindamage = SenseUI.Slider("Minimal Damage", 0, 100, "", "0", "100", false, autosniper_mindamage);
										gui.SetValue("rbot_autosniper_mindamage", autosniper_mindamage);
										SenseUI.Label("Hitbox Priority");
										autosniper_hitprior = SenseUI.Combo("autosniper_hitprior", { "Head", "Neck", "Check", "Stomach", "Pelvis", "Center" }, autosniper_hitprior);
										gui.SetValue("rbot_autosniper_hitbox", autosniper_hitprior-1);
										SenseUI.Label("Body Aim Hitbox");
										autosniper_bodyaim = SenseUI.Combo("autosniper_bodyaim", { "Pelvis", "Pelvis + Edge", "Center" }, autosniper_bodyaim);
										gui.SetValue("rbot_autosniper_hitbox_bodyaim", autosniper_bodyaim-1);
										SenseUI.Label("Hitbox Selection Method");
										autosniper_method = SenseUI.Combo("autosniper_method", { "Damage", "Accuracy" }, autosniper_method);
										gui.SetValue("rbot_autosniper_hitbox_method", autosniper_method-1);
										autosniper_baimX = SenseUI.Slider("Body Aim after X Shots", 0, 15, "", "0", "15", false, autosniper_baimX);
										gui.SetValue("rbot_autosniper_bodyaftershots", autosniper_baimX);
										autosniper_baimHP = SenseUI.Slider("Body Aim if HP Lower Than", 0, 100, "", "0", "100", false, autosniper_baimHP);
										gui.SetValue("rbot_autosniper_bodyifhplower", autosniper_baimHP);

										local asnipe_adaptive = gui.GetValue("rbot_autosniper_hitbox_adaptive");
										asnipe_adaptive = SenseUI.Checkbox("Adaptive Hitbox", asnipe_adaptive);
										gui.SetValue("rbot_autosniper_hitbox_adaptive", asnipe_adaptive);
										local asnipe_points = gui.GetValue("rbot_autosniper_hitbox_optpoints");
										asnipe_points = SenseUI.Checkbox("Nearby Points", asnipe_points);
										gui.SetValue("rbot_autosniper_hitbox_optpoints", asnipe_points);
										local asnipe_backtrack = gui.GetValue("rbot_autosniper_hitbox_optbacktrack");
										asnipe_backtrack = SenseUI.Checkbox("Backtrack Points", asnipe_backtrack);
										gui.SetValue("rbot_autosniper_hitbox_optbacktrack", asnipe_backtrack);										
											else if weapon_select == 8 then
											
											local sniper_autowall = (gui.GetValue("rbot_sniper_autowall") + 1);
											local sniper_hitchance = gui.GetValue("rbot_sniper_hitchance");
											local sniper_mindamage = gui.GetValue("rbot_sniper_mindamage");
											local sniper_hitprior = (gui.GetValue("rbot_sniper_hitbox") + 1);
											local sniper_bodyaim = (gui.GetValue("rbot_sniper_hitbox_bodyaim") + 1);
											local sniper_method = (gui.GetValue("rbot_sniper_hitbox_method") + 1);
											local sniper_baimX = gui.GetValue("rbot_sniper_bodyaftershots");
											local sniper_baimHP = gui.GetValue("rbot_sniper_bodyifhplower");
											local sniper_hscale = (gui.GetValue("rbot_sniper_hitbox_head_ps") * 100);
											local sniper_nscale = (gui.GetValue("rbot_sniper_hitbox_neck_ps") * 100);
											local sniper_cscale = (gui.GetValue("rbot_sniper_hitbox_chest_ps") * 100);
											local sniper_sscale = (gui.GetValue("rbot_sniper_hitbox_stomach_ps") * 100);
											local sniper_pscale = (gui.GetValue("rbot_sniper_hitbox_pelvis_ps") * 100);
											local sniper_ascale = (gui.GetValue("rbot_sniper_hitbox_arms_ps") * 100);
											local sniper_lscale = (gui.GetValue("rbot_sniper_hitbox_legs_ps") * 100);
											local sniper_autoscale = gui.GetValue("rbot_sniper_hitbox_auto_ps");
											local sniper_autoscales = (gui.GetValue("rbot_sniper_hitbox_auto_ps_max") * 100);
											
											SenseUI.Label("Auto Wall Type");
											sniper_autowall = SenseUI.Combo("sniper_autowall", { "Off", "Accurate", "Optimized" }, sniper_autowall);
											gui.SetValue("rbot_sniper_autowall", sniper_autowall-1);
											sniper_hitchance = SenseUI.Slider("Hit Chance", 0, 100, "%", "0%", "100%", false, sniper_hitchance);
											gui.SetValue("rbot_sniper_hitchance", sniper_hitchance);
											sniper_mindamage = SenseUI.Slider("Minimal Damage", 0, 100, "", "0", "100", false, sniper_mindamage);
											gui.SetValue("rbot_sniper_mindamage", sniper_mindamage);
											SenseUI.Label("Hitbox Priority");
											sniper_hitprior = SenseUI.Combo("sniper_hitprior", { "Head", "Neck", "Check", "Stomach", "Pelvis", "Center" }, sniper_hitprior);
											gui.SetValue("rbot_sniper_hitbox", sniper_hitprior-1);
											SenseUI.Label("Body Aim Hitbox");
											sniper_bodyaim = SenseUI.Combo("sniper_bodyaim", { "Pelvis", "Pelvis + Edge", "Center" }, sniper_bodyaim);
											gui.SetValue("rbot_sniper_hitbox_bodyaim", sniper_bodyaim-1);
											SenseUI.Label("Hitbox Selection Method");
											sniper_method = SenseUI.Combo("sniper_method", { "Damage", "Accuracy" }, sniper_method);
											gui.SetValue("rbot_sniper_hitbox_method", sniper_method-1);
											sniper_baimX = SenseUI.Slider("Body Aim after X Shots", 0, 15, "", "0", "15", false, sniper_baimX);
											gui.SetValue("rbot_sniper_bodyaftershots", sniper_baimX);
											sniper_baimHP = SenseUI.Slider("Body Aim if HP Lower Than", 0, 100, "", "0", "100", false, sniper_baimHP);
											gui.SetValue("rbot_sniper_bodyifhplower", sniper_baimHP);
											
											local sniper_adaptive = gui.GetValue("rbot_sniper_hitbox_adaptive");
											sniper_adaptive = SenseUI.Checkbox("Adaptive Hitbox", sniper_adaptive);
											gui.SetValue("rbot_sniper_hitbox_adaptive", sniper_adaptive);
											local sniper_points = gui.GetValue("rbot_sniper_hitbox_optpoints");
											sniper_points = SenseUI.Checkbox("Nearby Points", sniper_points);
											gui.SetValue("rbot_sniper_hitbox_optpoints", sniper_points);
											local sniper_backtrack = gui.GetValue("rbot_sniper_hitbox_optbacktrack");
											sniper_backtrack = SenseUI.Checkbox("Backtrack Points", sniper_backtrack);
											gui.SetValue("rbot_sniper_hitbox_optbacktrack", sniper_backtrack);
												else if weapon_select == 9 then
												
												local lmg_autowall = (gui.GetValue("rbot_lmg_autowall") + 1);
												local lmg_hitchance = gui.GetValue("rbot_lmg_hitchance");
												local lmg_mindamage = gui.GetValue("rbot_lmg_mindamage");
												local lmg_hitprior = (gui.GetValue("rbot_lmg_hitbox") + 1);
												local lmg_bodyaim = (gui.GetValue("rbot_lmg_hitbox_bodyaim") + 1);
												local lmg_method = (gui.GetValue("rbot_lmg_hitbox_method") + 1);
												local lmg_baimX = gui.GetValue("rbot_lmg_bodyaftershots");
												local lmg_baimHP = gui.GetValue("rbot_lmg_bodyifhplower");
												local lmg_hscale = (gui.GetValue("rbot_lmg_hitbox_head_ps") * 100);
												local lmg_nscale = (gui.GetValue("rbot_lmg_hitbox_neck_ps") * 100);
												local lmg_cscale = (gui.GetValue("rbot_lmg_hitbox_chest_ps") * 100);
												local lmg_sscale = (gui.GetValue("rbot_lmg_hitbox_stomach_ps") * 100);
												local lmg_pscale = (gui.GetValue("rbot_lmg_hitbox_pelvis_ps") * 100);
												local lmg_ascale = (gui.GetValue("rbot_lmg_hitbox_arms_ps") * 100);
												local lmg_lscale = (gui.GetValue("rbot_lmg_hitbox_legs_ps") * 100);
												local lmg_autoscale = gui.GetValue("rbot_lmg_hitbox_auto_ps");
												local lmg_autoscales = (gui.GetValue("rbot_lmg_hitbox_auto_ps_max") * 100);
												
												SenseUI.Label("Auto Wall Type");
												lmg_autowall = SenseUI.Combo("lmg_autowall", { "Off", "Accurate", "Optimized" }, lmg_autowall);
												gui.SetValue("rbot_lmg_autowall", lmg_autowall-1);
												lmg_hitchance = SenseUI.Slider("Hit Chance", 0, 100, "%", "0%", "100%", false, lmg_hitchance);
												gui.SetValue("rbot_lmg_hitchance", lmg_hitchance);
												lmg_mindamage = SenseUI.Slider("Minimal Damage", 0, 100, "", "0", "100", false, lmg_mindamage);
												gui.SetValue("rbot_lmg_mindamage", lmg_mindamage);
												SenseUI.Label("Hitbox Priority");
												lmg_hitprior = SenseUI.Combo("lmg_hitprior", { "Head", "Neck", "Check", "Stomach", "Pelvis", "Center" }, lmg_hitprior);
												gui.SetValue("rbot_lmg_hitbox", lmg_hitprior-1);
												SenseUI.Label("Body Aim Hitbox");
												lmg_bodyaim = SenseUI.Combo("lmg_bodyaim", { "Pelvis", "Pelvis + Edge", "Center" }, lmg_bodyaim);
												gui.SetValue("rbot_lmg_hitbox_bodyaim", lmg_bodyaim-1);
												SenseUI.Label("Hitbox Selection Method");
												lmg_method = SenseUI.Combo("lmg_method", { "Damage", "Accuracy" }, lmg_method);
												gui.SetValue("rbot_lmg_hitbox_method", lmg_method-1);
												lmg_baimX = SenseUI.Slider("Body Aim after X Shots", 0, 15, "", "0", "15", false, lmg_baimX);
												gui.SetValue("rbot_lmg_bodyaftershots", lmg_baimX);
												lmg_baimHP = SenseUI.Slider("Body Aim if HP Lower Than", 0, 100, "", "0", "100", false, lmg_baimHP);
												gui.SetValue("rbot_lmg_bodyifhplower", lmg_baimHP);		
												
												local lmg_adaptive = gui.GetValue("rbot_lmg_hitbox_adaptive");
												lmg_adaptive = SenseUI.Checkbox("Adaptive Hitbox", lmg_adaptive);
												gui.SetValue("rbot_lmg_hitbox_adaptive", lmg_adaptive);
												local lmg_points = gui.GetValue("rbot_lmg_hitbox_optpoints");
												lmg_points = SenseUI.Checkbox("Nearby Points", lmg_points);
												gui.SetValue("rbot_lmg_hitbox_optpoints", lmg_points);
												local lmg_backtrack = gui.GetValue("rbot_lmg_hitbox_optbacktrack");
												lmg_backtrack = SenseUI.Checkbox("Backtrack Points", lmg_backtrack);
												gui.SetValue("rbot_lmg_hitbox_optbacktrack", lmg_backtrack);
												end
											end
										end
									end
								end
							end
						end
					end
				end
			SenseUI.EndGroup();
			end
			if SenseUI.BeginGroup( "hitscans", "Hitscan", 285, 25, 235, 380 ) then
				if weapon_select == 1 then
				
				local p_autowall = (gui.GetValue("rbot_pistol_autowall") + 1);
				local p_hitchance = gui.GetValue("rbot_pistol_hitchance");
				local p_mindamage = gui.GetValue("rbot_pistol_mindamage");
				local p_hitprior = (gui.GetValue("rbot_pistol_hitbox") + 1);
				local p_bodyaim = (gui.GetValue("rbot_pistol_hitbox_bodyaim") + 1);
				local p_method = (gui.GetValue("rbot_pistol_hitbox_method") + 1);
				local p_baimX = gui.GetValue("rbot_pistol_bodyaftershots");
				local p_baimHP = gui.GetValue("rbot_pistol_bodyifhplower");
				local p_hscale = (gui.GetValue("rbot_pistol_hitbox_head_ps") * 100);
				local p_nscale = (gui.GetValue("rbot_pistol_hitbox_neck_ps") * 100);
				local p_cscale = (gui.GetValue("rbot_pistol_hitbox_chest_ps") * 100);
				local p_sscale = (gui.GetValue("rbot_pistol_hitbox_stomach_ps") * 100);
				local p_pscale = (gui.GetValue("rbot_pistol_hitbox_pelvis_ps") * 100);
				local p_ascale = (gui.GetValue("rbot_pistol_hitbox_arms_ps") * 100);
				local p_lscale = (gui.GetValue("rbot_pistol_hitbox_legs_ps") * 100);
				local p_autoscale = gui.GetValue("rbot_pistol_hitbox_auto_ps");
				local p_autoscales = (gui.GetValue("rbot_pistol_hitbox_auto_ps_max") * 100);
				
				p_hscale = SenseUI.Slider("Head Scale", 0, 100, "%", "0%", "100%", false, p_hscale);
				gui.SetValue("rbot_pistol_hitbox_head_ps", p_hscale / 100);
				p_nscale = SenseUI.Slider("Neck Scale", 0, 100, "%", "0%", "100%", false, p_nscale);
				gui.SetValue("rbot_pistol_hitbox_neck_ps", p_nscale / 100);
				p_cscale = SenseUI.Slider("Chest Scale", 0, 100, "%", "0%", "100%", false, p_cscale);
				gui.SetValue("rbot_pistol_hitbox_chest_ps", p_cscale / 100);
				p_sscale = SenseUI.Slider("Stomach Scale", 0, 100, "%", "0%", "100%", false, p_sscale);
				gui.SetValue("rbot_pistol_hitbox_stomach_ps", p_sscale / 100);
				p_pscale = SenseUI.Slider("Pelvis Scale", 0, 100, "%", "0%", "100%", false, p_pscale);
				gui.SetValue("rbot_pistol_hitbox_pelvis_ps", p_pscale / 100);
				p_ascale = SenseUI.Slider("Arms Scale", 0, 100, "%", "0%", "100%", false, p_ascale);
				gui.SetValue("rbot_pistol_hitbox_arms_ps", p_ascale / 100);
				p_lscale = SenseUI.Slider("Legs Scale", 0, 100, "%", "0%", "100%", false, p_lscale);
				gui.SetValue("rbot_pistol_hitbox_legs_ps", p_lscale / 100);
				p_autoscale = SenseUI.Checkbox("Auto Scale", p_autoscale);
				gui.SetValue("rbot_pistol_hitbox_auto_ps", p_autoscale);
				p_autoscales = SenseUI.Slider("Auto Scale Max", 0, 100, "%", "0%", "100%", false, p_autoscales);
				gui.SetValue("rbot_pistol_hitbox_auto_ps_max", p_autoscales / 100);
				local pistol_head = gui.GetValue("rbot_pistol_hitbox_head");
				pistol_head = SenseUI.Checkbox("Head Points", pistol_head);
				gui.SetValue("rbot_pistol_hitbox_head", pistol_head);
				local pistol_neck = gui.GetValue("rbot_pistol_hitbox_neck");
				pistol_neck = SenseUI.Checkbox("Neck Points", pistol_neck);
				gui.SetValue("rbot_pistol_hitbox_neck", pistol_neck);
				local pistol_chest = gui.GetValue("rbot_pistol_hitbox_chest");
				pistol_chest = SenseUI.Checkbox("Chest Points", pistol_chest);
				gui.SetValue("rbot_pistol_hitbox_chest", pistol_chest);
				local pistol_stomach = gui.GetValue("rbot_pistol_hitbox_stomach");
				pistol_stomach = SenseUI.Checkbox("Stomach Points", pistol_stomach);
				gui.SetValue("rbot_pistol_hitbox_stomach", pistol_stomach);
				local pistol_pelvis = gui.GetValue("rbot_pistol_hitbox_pelvis");
				pistol_pelvis = SenseUI.Checkbox("Pelvis Points", pistol_pelvis);
				gui.SetValue("rbot_pistol_hitbox_pelvis", pistol_pelvis);
				local pistol_arms = gui.GetValue("rbot_pistol_hitbox_arms");
				pistol_arms = SenseUI.Checkbox("Arms Points", pistol_arms);
				gui.SetValue("rbot_pistol_hitbox_arms", pistol_arms);
				local pistol_legs = gui.GetValue("rbot_pistol_hitbox_legs");
				pistol_legs = SenseUI.Checkbox("Legs Points", pistol_legs);
				gui.SetValue("rbot_pistol_hitbox_legs", pistol_legs);
					else if weapon_select == 2 then
					
					local rev_autowall = (gui.GetValue("rbot_revolver_autowall") + 1);
					local rev_hitchance = gui.GetValue("rbot_revolver_hitchance");
					local rev_mindamage = gui.GetValue("rbot_revolver_mindamage");
					local rev_hitprior = (gui.GetValue("rbot_revolver_hitbox") + 1);
					local rev_bodyaim = (gui.GetValue("rbot_revolver_hitbox_bodyaim") + 1);
					local rev_method = (gui.GetValue("rbot_revolver_hitbox_method") + 1);
					local rev_baimX = gui.GetValue("rbot_revolver_bodyaftershots");
					local rev_baimHP = gui.GetValue("rbot_revolver_bodyifhplower");
					local rev_hscale = (gui.GetValue("rbot_revolver_hitbox_head_ps") * 100);
					local rev_nscale = (gui.GetValue("rbot_revolver_hitbox_neck_ps") * 100);
					local rev_cscale = (gui.GetValue("rbot_revolver_hitbox_chest_ps") * 100);
					local rev_sscale = (gui.GetValue("rbot_revolver_hitbox_stomach_ps") * 100);
					local rev_pscale = (gui.GetValue("rbot_revolver_hitbox_pelvis_ps") * 100);
					local rev_ascale = (gui.GetValue("rbot_revolver_hitbox_arms_ps") * 100);
					local rev_lscale = (gui.GetValue("rbot_revolver_hitbox_legs_ps") * 100);
					local rev_autoscale = gui.GetValue("rbot_revolver_hitbox_auto_ps");
					local rev_autoscales = (gui.GetValue("rbot_revolver_hitbox_auto_ps_max") * 100);
					
					rev_hscale = SenseUI.Slider("Head Scale", 0, 100, "%", "0%", "100%", false, rev_hscale);
					gui.SetValue("rbot_revolver_hitbox_head_ps", rev_hscale / 100);
					rev_nscale = SenseUI.Slider("Neck Scale", 0, 100, "%", "0%", "100%", false, rev_nscale);
					gui.SetValue("rbot_revolver_hitbox_neck_ps", rev_nscale / 100);
					rev_cscale = SenseUI.Slider("Chest Scale", 0, 100, "%", "0%", "100%", false, rev_cscale);
					gui.SetValue("rbot_revolver_hitbox_chest_ps", rev_cscale / 100);
					rev_sscale = SenseUI.Slider("Stomach Scale", 0, 100, "%", "0%", "100%", false, rev_sscale);
					gui.SetValue("rbot_revolver_hitbox_stomach_ps", rev_sscale / 100);
					rev_pscale = SenseUI.Slider("Pelvis Scale", 0, 100, "%", "0%", "100%", false, rev_pscale);
					gui.SetValue("rbot_revolver_hitbox_pelvis_ps", rev_pscale / 100);
					rev_ascale = SenseUI.Slider("Arms Scale", 0, 100, "%", "0%", "100%", false, rev_ascale);
					gui.SetValue("rbot_revolver_hitbox_arms_ps", rev_ascale / 100);
					rev_lscale = SenseUI.Slider("Legs Scale", 0, 100, "%", "0%", "100%", false, rev_lscale);
					gui.SetValue("rbot_revolver_hitbox_legs_ps", rev_lscale / 100);
					rev_autoscale = SenseUI.Checkbox("Auto Scale", rev_autoscale);
					gui.SetValue("rbot_revolver_hitbox_auto_ps", rev_autoscale);
					rev_autoscales = SenseUI.Slider("Auto Scale Max", 0, 100, "%", "0%", "100%", false, rev_autoscales);
					gui.SetValue("rbot_revolver_hitbox_auto_ps_max", rev_autoscales / 100);
					local revolver_head = gui.GetValue("rbot_revolver_hitbox_head");
					revolver_head = SenseUI.Checkbox("Head Points", revolver_head);
					gui.SetValue("rbot_revolver_hitbox_head", revolver_head);
					local revolver_neck = gui.GetValue("rbot_revolver_hitbox_neck");
					revolver_neck = SenseUI.Checkbox("Neck Points", revolver_neck);
					gui.SetValue("rbot_revolver_hitbox_neck", revolver_neck);
					local revolver_chest = gui.GetValue("rbot_revolver_hitbox_chest");
					revolver_chest = SenseUI.Checkbox("Chest Points", revolver_chest);
					gui.SetValue("rbot_revolver_hitbox_chest", revolver_chest);
					local revolver_stomach = gui.GetValue("rbot_revolver_hitbox_stomach");
					revolver_stomach = SenseUI.Checkbox("Stomach Points", revolver_stomach);
					gui.SetValue("rbot_revolver_hitbox_stomach", revolver_stomach);
					local revolver_pelvis = gui.GetValue("rbot_revolver_hitbox_pelvis");
					revolver_pelvis = SenseUI.Checkbox("Pelvis Points", revolver_pelvis);
					gui.SetValue("rbot_revolver_hitbox_pelvis", revolver_pelvis);
					local revolver_arms = gui.GetValue("rbot_revolver_hitbox_arms");
					revolver_arms = SenseUI.Checkbox("Arms Points", revolver_arms);
					gui.SetValue("rbot_revolver_hitbox_arms", revolver_arms);
					local revolver_legs = gui.GetValue("rbot_revolver_hitbox_legs");
					revolver_legs = SenseUI.Checkbox("Legs Points", revolver_legs);
					gui.SetValue("rbot_revolver_hitbox_legs", revolver_legs);
						else if weapon_select == 3 then
						
						local smg_autowall = (gui.GetValue("rbot_smg_autowall") + 1);
						local smg_hitchance = gui.GetValue("rbot_smg_hitchance");
						local smg_mindamage = gui.GetValue("rbot_smg_mindamage");
						local smg_hitprior = (gui.GetValue("rbot_smg_hitbox") + 1);
						local smg_bodyaim = (gui.GetValue("rbot_smg_hitbox_bodyaim") + 1);
						local smg_method = (gui.GetValue("rbot_smg_hitbox_method") + 1);
						local smg_baimX = gui.GetValue("rbot_smg_bodyaftershots");
						local smg_baimHP = gui.GetValue("rbot_smg_bodyifhplower");
						local smg_hscale = (gui.GetValue("rbot_smg_hitbox_head_ps") * 100);
						local smg_nscale = (gui.GetValue("rbot_smg_hitbox_neck_ps") * 100);
						local smg_cscale = (gui.GetValue("rbot_smg_hitbox_chest_ps") * 100);
						local smg_sscale = (gui.GetValue("rbot_smg_hitbox_stomach_ps") * 100);
						local smg_pscale = (gui.GetValue("rbot_smg_hitbox_pelvis_ps") * 100);
						local smg_ascale = (gui.GetValue("rbot_smg_hitbox_arms_ps") * 100);
						local smg_lscale = (gui.GetValue("rbot_smg_hitbox_legs_ps") * 100);
						local smg_autoscale = gui.GetValue("rbot_smg_hitbox_auto_ps");
						local smg_autoscales = (gui.GetValue("rbot_smg_hitbox_auto_ps_max") * 100);
						
						
						smg_hscale = SenseUI.Slider("Head Scale", 0, 100, "%", "0%", "100%", false, smg_hscale);
						gui.SetValue("rbot_smg_hitbox_head_ps", smg_hscale / 100);
						smg_nscale = SenseUI.Slider("Neck Scale", 0, 100, "%", "0%", "100%", false, smg_nscale);
						gui.SetValue("rbot_smg_hitbox_neck_ps", smg_nscale / 100);
						smg_cscale = SenseUI.Slider("Chest Scale", 0, 100, "%", "0%", "100%", false, smg_cscale);
						gui.SetValue("rbot_smg_hitbox_chest_ps", smg_cscale / 100);
						smg_sscale = SenseUI.Slider("Stomach Scale", 0, 100, "%", "0%", "100%", false, smg_sscale);
						gui.SetValue("rbot_smg_hitbox_stomach_ps", smg_sscale / 100);
						smg_pscale = SenseUI.Slider("Pelvis Scale", 0, 100, "%", "0%", "100%", false, smg_pscale);
						gui.SetValue("rbot_smg_hitbox_pelvis_ps", smg_pscale / 100);
						smg_ascale = SenseUI.Slider("Arms Scale", 0, 100, "%", "0%", "100%", false, smg_ascale);
						gui.SetValue("rbot_smg_hitbox_arms_ps", smg_ascale / 100);
						smg_lscale = SenseUI.Slider("Legs Scale", 0, 100, "%", "0%", "100%", false, smg_lscale);
						gui.SetValue("rbot_smg_hitbox_legs_ps", smg_lscale / 100);
						smg_autoscale = SenseUI.Checkbox("Auto Scale", smg_autoscale);
						gui.SetValue("rbot_smg_hitbox_auto_ps", smg_autoscale);
						smg_autoscales = SenseUI.Slider("Auto Scale Max", 0, 100, "%", "0%", "100%", false, smg_autoscales);
						gui.SetValue("rbot_smg_hitbox_auto_ps_max", smg_autoscales / 100);
						local smg_head = gui.GetValue("rbot_smg_hitbox_head");
						smg_head = SenseUI.Checkbox("Head Points", smg_head);
						gui.SetValue("rbot_smg_hitbox_head", smg_head);
						local smg_neck = gui.GetValue("rbot_smg_hitbox_neck");
						smg_neck = SenseUI.Checkbox("Neck Points", smg_neck);
						gui.SetValue("rbot_smg_hitbox_neck", smg_neck);
						local smg_chest = gui.GetValue("rbot_smg_hitbox_chest");
						smg_chest = SenseUI.Checkbox("Chest Points", smg_chest);
						gui.SetValue("rbot_smg_hitbox_chest", smg_chest);
						local smg_stomach = gui.GetValue("rbot_smg_hitbox_stomach");
						smg_stomach = SenseUI.Checkbox("Stomach Points", smg_stomach);
						gui.SetValue("rbot_smg_hitbox_stomach", smg_stomach);
						local smg_pelvis = gui.GetValue("rbot_smg_hitbox_pelvis");
						smg_pelvis = SenseUI.Checkbox("Pelvis Points", smg_pelvis);
						gui.SetValue("rbot_smg_hitbox_pelvis", smg_pelvis);
						local smg_arms = gui.GetValue("rbot_smg_hitbox_arms");
						smg_arms = SenseUI.Checkbox("Arms Points", smg_arms);
						gui.SetValue("rbot_smg_hitbox_arms", smg_arms);
						local smg_legs = gui.GetValue("rbot_smg_hitbox_legs");
						smg_legs = SenseUI.Checkbox("Legs Points", smg_legs);
						gui.SetValue("rbot_smg_hitbox_legs", smg_legs);						
							else if weapon_select == 4 then
							
							local rifle_autowall = (gui.GetValue("rbot_rifle_autowall") + 1);
							local rifle_hitchance = gui.GetValue("rbot_rifle_hitchance");
							local rifle_mindamage = gui.GetValue("rbot_rifle_mindamage");
							local rifle_hitprior = (gui.GetValue("rbot_rifle_hitbox") + 1);
							local rifle_bodyaim = (gui.GetValue("rbot_rifle_hitbox_bodyaim") + 1);
							local rifle_method = (gui.GetValue("rbot_rifle_hitbox_method") + 1);
							local rifle_baimX = gui.GetValue("rbot_rifle_bodyaftershots");
							local rifle_baimHP = gui.GetValue("rbot_rifle_bodyifhplower");
							local rifle_hscale = (gui.GetValue("rbot_rifle_hitbox_head_ps") * 100);
							local rifle_nscale = (gui.GetValue("rbot_rifle_hitbox_neck_ps") * 100);
							local rifle_cscale = (gui.GetValue("rbot_rifle_hitbox_chest_ps") * 100);
							local rifle_sscale = (gui.GetValue("rbot_rifle_hitbox_stomach_ps") * 100);
							local rifle_pscale = (gui.GetValue("rbot_rifle_hitbox_pelvis_ps") * 100);
							local rifle_ascale = (gui.GetValue("rbot_rifle_hitbox_arms_ps") * 100);
							local rifle_lscale = (gui.GetValue("rbot_rifle_hitbox_legs_ps") * 100);
							local rifle_autoscale = gui.GetValue("rbot_rifle_hitbox_auto_ps");
							local rifle_autoscales = (gui.GetValue("rbot_rifle_hitbox_auto_ps_max") * 100);
							
							
							
							rifle_hscale = SenseUI.Slider("Head Scale", 0, 100, "%", "0%", "100%", false, rifle_hscale);
							gui.SetValue("rbot_rifle_hitbox_head_ps", rifle_hscale / 100);
							rifle_nscale = SenseUI.Slider("Neck Scale", 0, 100, "%", "0%", "100%", false, rifle_nscale);
							gui.SetValue("rbot_rifle_hitbox_neck_ps", rifle_nscale / 100);
							rifle_cscale = SenseUI.Slider("Chest Scale", 0, 100, "%", "0%", "100%", false, rifle_cscale);
							gui.SetValue("rbot_rifle_hitbox_chest_ps", rifle_cscale / 100);
							rifle_sscale = SenseUI.Slider("Stomach Scale", 0, 100, "%", "0%", "100%", false, rifle_sscale);
							gui.SetValue("rbot_rifle_hitbox_stomach_ps", rifle_sscale / 100);
							rifle_pscale = SenseUI.Slider("Pelvis Scale", 0, 100, "%", "0%", "100%", false, rifle_pscale);
							gui.SetValue("rbot_rifle_hitbox_pelvis_ps", rifle_pscale / 100);
							rifle_ascale = SenseUI.Slider("Arms Scale", 0, 100, "%", "0%", "100%", false, rifle_ascale);
							gui.SetValue("rbot_rifle_hitbox_arms_ps", rifle_ascale / 100);
							rifle_lscale = SenseUI.Slider("Legs Scale", 0, 100, "%", "0%", "100%", false, rifle_lscale);
							gui.SetValue("rbot_rifle_hitbox_legs_ps", rifle_lscale / 100);
							rifle_autoscale = SenseUI.Checkbox("Auto Scale", rifle_autoscale);
							gui.SetValue("rbot_rifle_hitbox_auto_ps", rifle_autoscale);
							rifle_autoscales = SenseUI.Slider("Auto Scale Max", 0, 100, "%", "0%", "100%", false, rifle_autoscales);
							gui.SetValue("rbot_rifle_hitbox_auto_ps_max", rifle_autoscales / 100);
							local rifle_head = gui.GetValue("rbot_rifle_hitbox_head");
							rifle_head = SenseUI.Checkbox("Head Points", rifle_head);
							gui.SetValue("rbot_rifle_hitbox_head", rifle_head);
							local rifle_neck = gui.GetValue("rbot_rifle_hitbox_neck");
							rifle_neck = SenseUI.Checkbox("Neck Points", rifle_neck);
							gui.SetValue("rbot_rifle_hitbox_neck", rifle_neck);
							local rifle_chest = gui.GetValue("rbot_rifle_hitbox_chest");
							rifle_chest = SenseUI.Checkbox("Chest Points", rifle_chest);
							gui.SetValue("rbot_rifle_hitbox_chest", rifle_chest);
							local rifle_stomach = gui.GetValue("rbot_rifle_hitbox_stomach");
							rifle_stomach = SenseUI.Checkbox("Stomach Points", rifle_stomach);
							gui.SetValue("rbot_rifle_hitbox_stomach", rifle_stomach);
							local rifle_pelvis = gui.GetValue("rbot_rifle_hitbox_pelvis");
							rifle_pelvis = SenseUI.Checkbox("Pelvis Points", rifle_pelvis);
							gui.SetValue("rbot_rifle_hitbox_pelvis", rifle_pelvis);
							local rifle_arms = gui.GetValue("rbot_rifle_hitbox_arms");
							rifle_arms = SenseUI.Checkbox("Arms Points", rifle_arms);
							gui.SetValue("rbot_rifle_hitbox_arms", rifle_arms);
							local rifle_legs = gui.GetValue("rbot_rifle_hitbox_legs");
							rifle_legs = SenseUI.Checkbox("Legs Points", rifle_legs);
							gui.SetValue("rbot_rifle_hitbox_legs", rifle_legs);
								else if weapon_select == 5 then
								
								local shotgun_autowall = (gui.GetValue("rbot_shotgun_autowall") + 1);
								local shotgun_hitchance = gui.GetValue("rbot_shotgun_hitchance");
								local shotgun_mindamage = gui.GetValue("rbot_shotgun_mindamage");
								local shotgun_hitprior = (gui.GetValue("rbot_shotgun_hitbox") + 1);
								local shotgun_bodyaim = (gui.GetValue("rbot_shotgun_hitbox_bodyaim") + 1);
								local shotgun_method = (gui.GetValue("rbot_shotgun_hitbox_method") + 1);
								local shotgun_baimX = gui.GetValue("rbot_shotgun_bodyaftershots");
								local shotgun_baimHP = gui.GetValue("rbot_shotgun_bodyifhplower");
								local shotgun_hscale = (gui.GetValue("rbot_shotgun_hitbox_head_ps") * 100);
								local shotgun_nscale = (gui.GetValue("rbot_shotgun_hitbox_neck_ps") * 100);
								local shotgun_cscale = (gui.GetValue("rbot_shotgun_hitbox_chest_ps") * 100);
								local shotgun_sscale = (gui.GetValue("rbot_shotgun_hitbox_stomach_ps") * 100);
								local shotgun_pscale = (gui.GetValue("rbot_shotgun_hitbox_pelvis_ps") * 100);
								local shotgun_ascale = (gui.GetValue("rbot_shotgun_hitbox_arms_ps") * 100);
								local shotgun_lscale = (gui.GetValue("rbot_shotgun_hitbox_legs_ps") * 100);
								local shotgun_autoscale = gui.GetValue("rbot_shotgun_hitbox_auto_ps");
								local shotgun_autoscales = (gui.GetValue("rbot_shotgun_hitbox_auto_ps_max") * 100);
								
								
								
								shotgun_hscale = SenseUI.Slider("Head Scale", 0, 100, "%", "0%", "100%", false, shotgun_hscale);
								gui.SetValue("rbot_shotgun_hitbox_head_ps", shotgun_hscale / 100);
								shotgun_nscale = SenseUI.Slider("Neck Scale", 0, 100, "%", "0%", "100%", false, shotgun_nscale);
								gui.SetValue("rbot_shotgun_hitbox_neck_ps", shotgun_nscale / 100);
								shotgun_cscale = SenseUI.Slider("Chest Scale", 0, 100, "%", "0%", "100%", false, shotgun_cscale);
								gui.SetValue("rbot_shotgun_hitbox_chest_ps", shotgun_cscale / 100);
								shotgun_sscale = SenseUI.Slider("Stomach Scale", 0, 100, "%", "0%", "100%", false, shotgun_sscale);
								gui.SetValue("rbot_shotgun_hitbox_stomach_ps", shotgun_sscale / 100);
								shotgun_pscale = SenseUI.Slider("Pelvis Scale", 0, 100, "%", "0%", "100%", false, shotgun_pscale);
								gui.SetValue("rbot_shotgun_hitbox_pelvis_ps", shotgun_pscale / 100);
								shotgun_ascale = SenseUI.Slider("Arms Scale", 0, 100, "%", "0%", "100%", false, shotgun_ascale);
								gui.SetValue("rbot_shotgun_hitbox_arms_ps", shotgun_ascale / 100);
								shotgun_lscale = SenseUI.Slider("Legs Scale", 0, 100, "%", "0%", "100%", false, shotgun_lscale);
								gui.SetValue("rbot_shotgun_hitbox_legs_ps", shotgun_lscale / 100);
								shotgun_autoscale = SenseUI.Checkbox("Auto Scale", shotgun_autoscale);
								gui.SetValue("rbot_shotgun_hitbox_auto_ps", shotgun_autoscale);
								shotgun_autoscales = SenseUI.Slider("Auto Scale Max", 0, 100, "%", "0%", "100%", false, shotgun_autoscales);
								gui.SetValue("rbot_shotgun_hitbox_auto_ps_max", shotgun_autoscales / 100);
								local shotgun_head = gui.GetValue("rbot_shotgun_hitbox_head");
								shotgun_head = SenseUI.Checkbox("Head Points", shotgun_head);
								gui.SetValue("rbot_shotgun_hitbox_head", shotgun_head);
								local shotgun_neck = gui.GetValue("rbot_shotgun_hitbox_neck");
								shotgun_neck = SenseUI.Checkbox("Neck Points", shotgun_neck);
								gui.SetValue("rbot_shotgun_hitbox_neck", shotgun_neck);
								local shotgun_chest = gui.GetValue("rbot_shotgun_hitbox_chest");
								shotgun_chest = SenseUI.Checkbox("Chest Points", shotgun_chest);
								gui.SetValue("rbot_shotgun_hitbox_chest", shotgun_chest);
								local shotgun_stomach = gui.GetValue("rbot_shotgun_hitbox_stomach");
								shotgun_stomach = SenseUI.Checkbox("Stomach Points", shotgun_stomach);
								gui.SetValue("rbot_shotgun_hitbox_stomach", shotgun_stomach);
								local shotgun_pelvis = gui.GetValue("rbot_shotgun_hitbox_pelvis");
								shotgun_pelvis = SenseUI.Checkbox("Pelvis Points", shotgun_pelvis);
								gui.SetValue("rbot_shotgun_hitbox_pelvis", shotgun_pelvis);
								local shotgun_arms = gui.GetValue("rbot_shotgun_hitbox_arms");
								shotgun_arms = SenseUI.Checkbox("Arms Points", shotgun_arms);
								gui.SetValue("rbot_shotgun_hitbox_arms", shotgun_arms);
								local shotgun_legs = gui.GetValue("rbot_shotgun_hitbox_legs");
								shotgun_legs = SenseUI.Checkbox("Legs Points", shotgun_legs);
								gui.SetValue("rbot_shotgun_hitbox_legs", shotgun_legs);
									else if weapon_select == 6 then
									
									local scout_autowall = (gui.GetValue("rbot_scout_autowall") + 1);
									local scout_hitchance = gui.GetValue("rbot_scout_hitchance");
									local scout_mindamage = gui.GetValue("rbot_scout_mindamage");
									local scout_hitprior = (gui.GetValue("rbot_scout_hitbox") + 1);
									local scout_bodyaim = (gui.GetValue("rbot_scout_hitbox_bodyaim") + 1);
									local scout_method = (gui.GetValue("rbot_scout_hitbox_method") + 1);
									local scout_baimX = gui.GetValue("rbot_scout_bodyaftershots");
									local scout_baimHP = gui.GetValue("rbot_scout_bodyifhplower");
									local scout_hscale = (gui.GetValue("rbot_scout_hitbox_head_ps") * 100);
									local scout_nscale = (gui.GetValue("rbot_scout_hitbox_neck_ps") * 100);
									local scout_cscale = (gui.GetValue("rbot_scout_hitbox_chest_ps") * 100);
									local scout_sscale = (gui.GetValue("rbot_scout_hitbox_stomach_ps") * 100);
									local scout_pscale = (gui.GetValue("rbot_scout_hitbox_pelvis_ps") * 100);
									local scout_ascale = (gui.GetValue("rbot_scout_hitbox_arms_ps") * 100);
									local scout_lscale = (gui.GetValue("rbot_scout_hitbox_legs_ps") * 100);
									local scout_autoscale = gui.GetValue("rbot_scout_hitbox_auto_ps");
									local scout_autoscales = (gui.GetValue("rbot_scout_hitbox_auto_ps_max") * 100);
									
									
									
									scout_hscale = SenseUI.Slider("Head Scale", 0, 100, "%", "0%", "100%", false, scout_hscale);
									gui.SetValue("rbot_scout_hitbox_head_ps", scout_hscale / 100);
									scout_nscale = SenseUI.Slider("Neck Scale", 0, 100, "%", "0%", "100%", false, scout_nscale);
									gui.SetValue("rbot_scout_hitbox_neck_ps", scout_nscale / 100);
									scout_cscale = SenseUI.Slider("Chest Scale", 0, 100, "%", "0%", "100%", false, scout_cscale);
									gui.SetValue("rbot_scout_hitbox_chest_ps", scout_cscale / 100);
									scout_sscale = SenseUI.Slider("Stomach Scale", 0, 100, "%", "0%", "100%", false, scout_sscale);
									gui.SetValue("rbot_scout_hitbox_stomach_ps", scout_sscale / 100);
									scout_pscale = SenseUI.Slider("Pelvis Scale", 0, 100, "%", "0%", "100%", false, scout_pscale);
									gui.SetValue("rbot_scout_hitbox_pelvis_ps", scout_pscale / 100);
									scout_ascale = SenseUI.Slider("Arms Scale", 0, 100, "%", "0%", "100%", false, scout_ascale);
									gui.SetValue("rbot_scout_hitbox_arms_ps", scout_ascale / 100);
									scout_lscale = SenseUI.Slider("Legs Scale", 0, 100, "%", "0%", "100%", false, scout_lscale);
									gui.SetValue("rbot_scout_hitbox_legs_ps", scout_lscale / 100);
									scout_autoscale = SenseUI.Checkbox("Auto Scale", scout_autoscale);
									gui.SetValue("rbot_scout_hitbox_auto_ps", scout_autoscale);
									scout_autoscales = SenseUI.Slider("Auto Scale Max", 0, 100, "%", "0%", "100%", false, scout_autoscales);
									gui.SetValue("rbot_scout_hitbox_auto_ps_max", scout_autoscales / 100);
									local scout_head = gui.GetValue("rbot_scout_hitbox_head");
									scout_head = SenseUI.Checkbox("Head Points", scout_head);
									gui.SetValue("rbot_scout_hitbox_head", scout_head);
									local scout_neck = gui.GetValue("rbot_scout_hitbox_neck");
									scout_neck = SenseUI.Checkbox("Neck Points", scout_neck);
									gui.SetValue("rbot_scout_hitbox_neck", scout_neck);
									local scout_chest = gui.GetValue("rbot_scout_hitbox_chest");
									scout_chest = SenseUI.Checkbox("Chest Points", scout_chest);
									gui.SetValue("rbot_scout_hitbox_chest", scout_chest);
									local scout_stomach = gui.GetValue("rbot_scout_hitbox_stomach");
									scout_stomach = SenseUI.Checkbox("Stomach Points", scout_stomach);
									gui.SetValue("rbot_scout_hitbox_stomach", scout_stomach);
									local scout_pelvis = gui.GetValue("rbot_scout_hitbox_pelvis");
									scout_pelvis = SenseUI.Checkbox("Pelvis Points", scout_pelvis);
									gui.SetValue("rbot_scout_hitbox_pelvis", scout_pelvis);
									local scout_arms = gui.GetValue("rbot_scout_hitbox_arms");
									scout_arms = SenseUI.Checkbox("Arms Points", scout_arms);
									gui.SetValue("rbot_scout_hitbox_arms", scout_arms);
									local scout_legs = gui.GetValue("rbot_scout_hitbox_legs");
									scout_legs = SenseUI.Checkbox("Legs Points", scout_legs);
									gui.SetValue("rbot_scout_hitbox_legs", scout_legs);
										else if weapon_select == 7 then
										
										local autosniper_autowall = (gui.GetValue("rbot_autosniper_autowall") + 1);
										local autosniper_hitchance = gui.GetValue("rbot_autosniper_hitchance");
										local autosniper_mindamage = gui.GetValue("rbot_autosniper_mindamage");
										local autosniper_hitprior = (gui.GetValue("rbot_autosniper_hitbox") + 1);
										local autosniper_bodyaim = (gui.GetValue("rbot_autosniper_hitbox_bodyaim") + 1);
										local autosniper_method = (gui.GetValue("rbot_autosniper_hitbox_method") + 1);
										local autosniper_baimX = gui.GetValue("rbot_autosniper_bodyaftershots");
										local autosniper_baimHP = gui.GetValue("rbot_autosniper_bodyifhplower");
										local autosniper_hscale = (gui.GetValue("rbot_autosniper_hitbox_head_ps") * 100);
										local autosniper_nscale = (gui.GetValue("rbot_autosniper_hitbox_neck_ps") * 100);
										local autosniper_cscale = (gui.GetValue("rbot_autosniper_hitbox_chest_ps") * 100);
										local autosniper_sscale = (gui.GetValue("rbot_autosniper_hitbox_stomach_ps") * 100);
										local autosniper_pscale = (gui.GetValue("rbot_autosniper_hitbox_pelvis_ps") * 100);
										local autosniper_ascale = (gui.GetValue("rbot_autosniper_hitbox_arms_ps") * 100);
										local autosniper_lscale = (gui.GetValue("rbot_autosniper_hitbox_legs_ps") * 100);
										local autosniper_autoscale = gui.GetValue("rbot_autosniper_hitbox_auto_ps");
										local autosniper_autoscales = (gui.GetValue("rbot_autosniper_hitbox_auto_ps_max") * 100);
										
										
										
										autosniper_hscale = SenseUI.Slider("Head Scale", 0, 100, "%", "0%", "100%", false, autosniper_hscale);
										gui.SetValue("rbot_autosniper_hitbox_head_ps", autosniper_hscale / 100);
										autosniper_nscale = SenseUI.Slider("Neck Scale", 0, 100, "%", "0%", "100%", false, autosniper_nscale);
										gui.SetValue("rbot_autosniper_hitbox_neck_ps", autosniper_nscale / 100);
										autosniper_cscale = SenseUI.Slider("Chest Scale", 0, 100, "%", "0%", "100%", false, autosniper_cscale);
										gui.SetValue("rbot_autosniper_hitbox_chest_ps", autosniper_cscale / 100);
										autosniper_sscale = SenseUI.Slider("Stomach Scale", 0, 100, "%", "0%", "100%", false, autosniper_sscale);
										gui.SetValue("rbot_autosniper_hitbox_stomach_ps", autosniper_sscale / 100);
										autosniper_pscale = SenseUI.Slider("Pelvis Scale", 0, 100, "%", "0%", "100%", false, autosniper_pscale);
										gui.SetValue("rbot_autosniper_hitbox_pelvis_ps", autosniper_pscale / 100);
										autosniper_ascale = SenseUI.Slider("Arms Scale", 0, 100, "%", "0%", "100%", false, autosniper_ascale);
										gui.SetValue("rbot_autosniper_hitbox_arms_ps", autosniper_ascale / 100);
										autosniper_lscale = SenseUI.Slider("Legs Scale", 0, 100, "%", "0%", "100%", false, autosniper_lscale);
										gui.SetValue("rbot_autosniper_hitbox_legs_ps", autosniper_lscale / 100);
										autosniper_autoscale = SenseUI.Checkbox("Auto Scale", autosniper_autoscale);
										gui.SetValue("rbot_autosniper_hitbox_auto_ps", autosniper_autoscale);
										autosniper_autoscales = SenseUI.Slider("Auto Scale Max", 0, 100, "%", "0%", "100%", false, autosniper_autoscales);
										gui.SetValue("rbot_autosniper_hitbox_auto_ps_max", autosniper_autoscales / 100);	
										local autosniper_head = gui.GetValue("rbot_autosniper_hitbox_head");
										autosniper_head = SenseUI.Checkbox("Head Points", autosniper_head);
										gui.SetValue("rbot_autosniper_hitbox_head", autosniper_head);
										local autosniper_neck = gui.GetValue("rbot_autosniper_hitbox_neck");
										autosniper_neck = SenseUI.Checkbox("Neck Points", autosniper_neck);
										gui.SetValue("rbot_autosniper_hitbox_neck", autosniper_neck);
										local autosniper_chest = gui.GetValue("rbot_autosniper_hitbox_chest");
										autosniper_chest = SenseUI.Checkbox("Chest Points", autosniper_chest);
										gui.SetValue("rbot_autosniper_hitbox_chest", autosniper_chest);
										local autosniper_stomach = gui.GetValue("rbot_autosniper_hitbox_stomach");
										autosniper_stomach = SenseUI.Checkbox("Stomach Points", autosniper_stomach);
										gui.SetValue("rbot_autosniper_hitbox_stomach", autosniper_stomach);
										local autosniper_pelvis = gui.GetValue("rbot_autosniper_hitbox_pelvis");
										autosniper_pelvis = SenseUI.Checkbox("Pelvis Points", autosniper_pelvis);
										gui.SetValue("rbot_autosniper_hitbox_pelvis", autosniper_pelvis);
										local autosniper_arms = gui.GetValue("rbot_autosniper_hitbox_arms");
										autosniper_arms = SenseUI.Checkbox("Arms Points", autosniper_arms);
										gui.SetValue("rbot_autosniper_hitbox_arms", autosniper_arms);
										local autosniper_legs = gui.GetValue("rbot_autosniper_hitbox_legs");
										autosniper_legs = SenseUI.Checkbox("Legs Points", autosniper_legs);
										gui.SetValue("rbot_autosniper_hitbox_legs", autosniper_legs);										
											else if weapon_select == 8 then
											
											local sniper_autowall = (gui.GetValue("rbot_sniper_autowall") + 1);
											local sniper_hitchance = gui.GetValue("rbot_sniper_hitchance");
											local sniper_mindamage = gui.GetValue("rbot_sniper_mindamage");
											local sniper_hitprior = (gui.GetValue("rbot_sniper_hitbox") + 1);
											local sniper_bodyaim = (gui.GetValue("rbot_sniper_hitbox_bodyaim") + 1);
											local sniper_method = (gui.GetValue("rbot_sniper_hitbox_method") + 1);
											local sniper_baimX = gui.GetValue("rbot_sniper_bodyaftershots");
											local sniper_baimHP = gui.GetValue("rbot_sniper_bodyifhplower");
											local sniper_hscale = (gui.GetValue("rbot_sniper_hitbox_head_ps") * 100);
											local sniper_nscale = (gui.GetValue("rbot_sniper_hitbox_neck_ps") * 100);
											local sniper_cscale = (gui.GetValue("rbot_sniper_hitbox_chest_ps") * 100);
											local sniper_sscale = (gui.GetValue("rbot_sniper_hitbox_stomach_ps") * 100);
											local sniper_pscale = (gui.GetValue("rbot_sniper_hitbox_pelvis_ps") * 100);
											local sniper_ascale = (gui.GetValue("rbot_sniper_hitbox_arms_ps") * 100);
											local sniper_lscale = (gui.GetValue("rbot_sniper_hitbox_legs_ps") * 100);
											local sniper_autoscale = gui.GetValue("rbot_sniper_hitbox_auto_ps");
											local sniper_autoscales = (gui.GetValue("rbot_sniper_hitbox_auto_ps_max") * 100);
											
											
											
											sniper_hscale = SenseUI.Slider("Head Scale", 0, 100, "%", "0%", "100%", false, sniper_hscale);
											gui.SetValue("rbot_sniper_hitbox_head_ps", sniper_hscale / 100);
											sniper_nscale = SenseUI.Slider("Neck Scale", 0, 100, "%", "0%", "100%", false, sniper_nscale);
											gui.SetValue("rbot_sniper_hitbox_neck_ps", sniper_nscale / 100);
											sniper_cscale = SenseUI.Slider("Chest Scale", 0, 100, "%", "0%", "100%", false, sniper_cscale);
											gui.SetValue("rbot_sniper_hitbox_chest_ps", sniper_cscale / 100);
											sniper_sscale = SenseUI.Slider("Stomach Scale", 0, 100, "%", "0%", "100%", false, sniper_sscale);
											gui.SetValue("rbot_sniper_hitbox_stomach_ps", sniper_sscale / 100);
											sniper_pscale = SenseUI.Slider("Pelvis Scale", 0, 100, "%", "0%", "100%", false, sniper_pscale);
											gui.SetValue("rbot_sniper_hitbox_pelvis_ps", sniper_pscale / 100);
											sniper_ascale = SenseUI.Slider("Arms Scale", 0, 100, "%", "0%", "100%", false, sniper_ascale);
											gui.SetValue("rbot_sniper_hitbox_arms_ps", sniper_ascale / 100);
											sniper_lscale = SenseUI.Slider("Legs Scale", 0, 100, "%", "0%", "100%", false, sniper_lscale);
											gui.SetValue("rbot_sniper_hitbox_legs_ps", sniper_lscale / 100);
											sniper_autoscale = SenseUI.Checkbox("Auto Scale", sniper_autoscale);
											gui.SetValue("rbot_sniper_hitbox_auto_ps", sniper_autoscale);
											sniper_autoscales = SenseUI.Slider("Auto Scale Max", 0, 100, "%", "0%", "100%", false, sniper_autoscales);
											gui.SetValue("rbot_sniper_hitbox_auto_ps_max", sniper_autoscales / 100);
											local sniper_head = gui.GetValue("rbot_sniper_hitbox_head");
											sniper_head = SenseUI.Checkbox("Head Points", sniper_head);
											gui.SetValue("rbot_sniper_hitbox_head", sniper_head);
											local sniper_neck = gui.GetValue("rbot_sniper_hitbox_neck");
											sniper_neck = SenseUI.Checkbox("Neck Points", sniper_neck);
											gui.SetValue("rbot_sniper_hitbox_neck", sniper_neck);
											local sniper_chest = gui.GetValue("rbot_sniper_hitbox_chest");
											sniper_chest = SenseUI.Checkbox("Chest Points", sniper_chest);
											gui.SetValue("rbot_sniper_hitbox_chest", sniper_chest);
											local sniper_stomach = gui.GetValue("rbot_sniper_hitbox_stomach");
											sniper_stomach = SenseUI.Checkbox("Stomach Points", sniper_stomach);
											gui.SetValue("rbot_sniper_hitbox_stomach", sniper_stomach);
											local sniper_pelvis = gui.GetValue("rbot_sniper_hitbox_pelvis");
											sniper_pelvis = SenseUI.Checkbox("Pelvis Points", sniper_pelvis);
											gui.SetValue("rbot_sniper_hitbox_pelvis", sniper_pelvis);
											local sniper_arms = gui.GetValue("rbot_sniper_hitbox_arms");
											sniper_arms = SenseUI.Checkbox("Arms Points", sniper_arms);
											gui.SetValue("rbot_sniper_hitbox_arms", sniper_arms);
											local sniper_legs = gui.GetValue("rbot_sniper_hitbox_legs");
											sniper_legs = SenseUI.Checkbox("Legs Points", sniper_legs);
											gui.SetValue("rbot_sniper_hitbox_legs", sniper_legs);											
												else if weapon_select == 9 then
												
												local lmg_autowall = (gui.GetValue("rbot_lmg_autowall") + 1);
												local lmg_hitchance = gui.GetValue("rbot_lmg_hitchance");
												local lmg_mindamage = gui.GetValue("rbot_lmg_mindamage");
												local lmg_hitprior = (gui.GetValue("rbot_lmg_hitbox") + 1);
												local lmg_bodyaim = (gui.GetValue("rbot_lmg_hitbox_bodyaim") + 1);
												local lmg_method = (gui.GetValue("rbot_lmg_hitbox_method") + 1);
												local lmg_baimX = gui.GetValue("rbot_lmg_bodyaftershots");
												local lmg_baimHP = gui.GetValue("rbot_lmg_bodyifhplower");
												local lmg_hscale = (gui.GetValue("rbot_lmg_hitbox_head_ps") * 100);
												local lmg_nscale = (gui.GetValue("rbot_lmg_hitbox_neck_ps") * 100);
												local lmg_cscale = (gui.GetValue("rbot_lmg_hitbox_chest_ps") * 100);
												local lmg_sscale = (gui.GetValue("rbot_lmg_hitbox_stomach_ps") * 100);
												local lmg_pscale = (gui.GetValue("rbot_lmg_hitbox_pelvis_ps") * 100);
												local lmg_ascale = (gui.GetValue("rbot_lmg_hitbox_arms_ps") * 100);
												local lmg_lscale = (gui.GetValue("rbot_lmg_hitbox_legs_ps") * 100);
												local lmg_autoscale = gui.GetValue("rbot_lmg_hitbox_auto_ps");
												local lmg_autoscales = (gui.GetValue("rbot_lmg_hitbox_auto_ps_max") * 100);
												
												
												
												lmg_hscale = SenseUI.Slider("Head Scale", 0, 100, "%", "0%", "100%", false, lmg_hscale);
												gui.SetValue("rbot_lmg_hitbox_head_ps", lmg_hscale / 100);
												lmg_nscale = SenseUI.Slider("Neck Scale", 0, 100, "%", "0%", "100%", false, lmg_nscale);
												gui.SetValue("rbot_lmg_hitbox_neck_ps", lmg_nscale / 100);
												lmg_cscale = SenseUI.Slider("Chest Scale", 0, 100, "%", "0%", "100%", false, lmg_cscale);
												gui.SetValue("rbot_lmg_hitbox_chest_ps", lmg_cscale / 100);
												lmg_sscale = SenseUI.Slider("Stomach Scale", 0, 100, "%", "0%", "100%", false, lmg_sscale);
												gui.SetValue("rbot_lmg_hitbox_stomach_ps", lmg_sscale / 100);
												lmg_pscale = SenseUI.Slider("Pelvis Scale", 0, 100, "%", "0%", "100%", false, lmg_pscale);
												gui.SetValue("rbot_lmg_hitbox_pelvis_ps", lmg_pscale / 100);
												lmg_ascale = SenseUI.Slider("Arms Scale", 0, 100, "%", "0%", "100%", false, lmg_ascale);
												gui.SetValue("rbot_lmg_hitbox_arms_ps", lmg_ascale / 100);
												lmg_lscale = SenseUI.Slider("Legs Scale", 0, 100, "%", "0%", "100%", false, lmg_lscale);
												gui.SetValue("rbot_lmg_hitbox_legs_ps", lmg_lscale / 100);
												lmg_autoscale = SenseUI.Checkbox("Auto Scale", lmg_autoscale);
												gui.SetValue("rbot_lmg_hitbox_auto_ps", lmg_autoscale);
												lmg_autoscales = SenseUI.Slider("Auto Scale Max", 0, 100, "%", "0%", "100%", false, lmg_autoscales);
												gui.SetValue("rbot_lmg_hitbox_auto_ps_max", lmg_autoscales / 100);	
												local lmg_head = gui.GetValue("rbot_lmg_hitbox_head");
												lmg_head = SenseUI.Checkbox("Head Points", lmg_head);
												gui.SetValue("rbot_lmg_hitbox_head", lmg_head);
												local lmg_neck = gui.GetValue("rbot_lmg_hitbox_neck");
												lmg_neck = SenseUI.Checkbox("Neck Points", lmg_neck);
												gui.SetValue("rbot_lmg_hitbox_neck", lmg_neck);
												local lmg_chest = gui.GetValue("rbot_lmg_hitbox_chest");
												lmg_chest = SenseUI.Checkbox("Chest Points", lmg_chest);
												gui.SetValue("rbot_lmg_hitbox_chest", lmg_chest);
												local lmg_stomach = gui.GetValue("rbot_lmg_hitbox_stomach");
												lmg_stomach = SenseUI.Checkbox("Stomach Points", lmg_stomach);
												gui.SetValue("rbot_lmg_hitbox_stomach", lmg_stomach);
												local lmg_pelvis = gui.GetValue("rbot_lmg_hitbox_pelvis");
												lmg_pelvis = SenseUI.Checkbox("Pelvis Points", lmg_pelvis);
												gui.SetValue("rbot_lmg_hitbox_pelvis", lmg_pelvis);
												local lmg_arms = gui.GetValue("rbot_lmg_hitbox_arms");
												lmg_arms = SenseUI.Checkbox("Arms Points", lmg_arms);
												gui.SetValue("rbot_lmg_hitbox_arms", lmg_arms);
												local lmg_legs = gui.GetValue("rbot_lmg_hitbox_legs");
												lmg_legs = SenseUI.Checkbox("Legs Points", lmg_legs);
												gui.SetValue("rbot_lmg_hitbox_legs", lmg_legs);												
												end
											end
										end
									end
								end
							end
						end
					end
				end
			SenseUI.EndGroup();
			end
		end
		SenseUI.EndTab();
		if SenseUI.BeginTab( "vissettings", SenseUI.Icons.visuals ) then
			if SenseUI.BeginGroup( "Work In Progress", "Work In Progress", 25, 25, 235, 70 ) then
				SenseUI.Label("Work In Progress", true);
				SenseUI.Label("Maybe its impossible", true);
				SenseUI.Label("To make this tab", true);
			end
			SenseUI.EndGroup();
		end
		SenseUI.EndTab();
		if SenseUI.BeginTab( "miscsettings", SenseUI.Icons.settings ) then
			if SenseUI.BeginGroup( "misc2", "Other", 285, 25, 235, 320 ) then
				auntrusted = SenseUI.Checkbox("Anti-untrusted", auntrusted);
				if auntrusted == 1 then
					gui.SetValue("msc_restrict", 2);
				end
				SenseUI.Label("Namestealer");
				local namesteal = (gui.GetValue("msc_namestealer_enable") + 1);
				namesteal = SenseUI.Combo("asdas", { "Off", "Team Only", "Enemy Only", "All" }, namesteal);
				gui.SetValue("msc_namestealer_enable", namesteal-1);
				local fakelat = gui.GetValue("msc_fakelatency_enable");
				fakelat = SenseUI.Checkbox("Fakelatency Enable", fakelat);
				gui.SetValue("msc_fakelatency_enable", fakelat);
				local fakelatsl = (gui.GetValue("msc_fakelatency_amount") * 1000);
				fakelatsl = SenseUI.Slider("Fakelatency Amount", 0, 1000, "ms", "0ms", "1000ms", false, fakelatsl);
				gui.SetValue("msc_fakelatency_amount", fakelatsl/1000);
				local fakelatkey = gui.GetValue("msc_fakelatency_key");
				fakelatkey = SenseUI.Bind("flk", true, fakelatkey);
				gui.SetValue("msc_fakelatency_key", fakelatkey);
				local fakelagenable = gui.GetValue("msc_fakelag_enable");
				fakelagenable = SenseUI.Checkbox("Fakelag Enable", fakelagenable);
				gui.SetValue("msc_fakelag_enable", fakelagenable);
				local fakelagamount = gui.GetValue("msc_fakelag_value");
				fakelagamount = SenseUI.Slider("Fakelag Amount", 1, 15, "", "1", "15", false, fakelagamount);
				gui.SetValue("msc_fakelag_value", fakelagamount);
				SenseUI.Label("Fakelag Mode");
				local fakelagmode = (gui.GetValue("msc_fakelag_mode") + 1 );
				fakelagmode = SenseUI.Combo("", { "Factor", "Switch", "Adaptive", "Random", "Peek", "Rapid Peek" }, fakelagmode);
				gui.SetValue("msc_fakelag_mode", fakelagmode-1);
				local fakelagewsh = gui.GetValue("msc_fakelag_attack");
				fakelagewsh = SenseUI.Checkbox("Fakelag while Shooting", fakelagewsh);
				gui.SetValue("msc_fakelag_attack", fakelagewsh);
				local fakelagwst = gui.GetValue("msc_fakelag_standing");
				fakelagwst = SenseUI.Checkbox("Fakelag while Standing", fakelagwst);
				gui.SetValue("msc_fakelag_standing", fakelagwst);
				local fakelagwund = gui.GetValue("msc_fakelag_unducking");
				fakelagwund = SenseUI.Checkbox("Fakelag while Unducking", fakelagwund);
				gui.SetValue("msc_fakelag_unducking", fakelagwund);
				SenseUI.Label("Fakelag Style");
				local fakelagstylell = (gui.GetValue("msc_fakelag_style") + 1 );
				fakelagstylell = SenseUI.Combo("ssd", { "Always", "Avoid Ground", "Hit Ground" }, fakelagstylell);
				gui.SetValue("msc_fakelag_style", fakelagstylell-1);
			end
			SenseUI.EndGroup();
			if SenseUI.BeginGroup( "misc", "Miscellaneous", 25, 25, 235, 550 ) then
				local msc_active = gui.GetValue("msc_active");
				msc_active = SenseUI.Checkbox("Enable", msc_active);
				gui.SetValue("msc_active", msc_active);
				---auntrusted = SenseUI.Combo("lol", { "Off", "Anti-SMAC", "Anti-untrusted" }, auntrusted);
				---gui.SetValue("msc_restrict", auntrusted-1);
				SenseUI.Label("Bunny hop");
				local bunnyhop = (gui.GetValue("msc_autojump") + 1);
				bunnyhop = SenseUI.Combo("bhop", { "Off", "Rage", "Legit" }, bunnyhop);
				gui.SetValue("msc_autojump", bunnyhop-1);
				local astrafe = gui.GetValue("msc_autostrafer_enable");
				astrafe = SenseUI.Checkbox("Air strafe", astrafe);
				gui.SetValue("msc_autostrafer_enable", astrafe);
				gui.SetValue("msc_autostrafer_airstrafe", astrafe);
				local wasdstrafe = gui.GetValue("msc_autostrafer_wasd");
				wasdstrafe = SenseUI.Checkbox("WASD Strafe", wasdstrafe);
				gui.SetValue("msc_autostrafer_wasd", wasdstrafe);
				local antisp = gui.GetValue("msc_antisp");
				antisp = SenseUI.Checkbox("Anti Spawn Protection", antisp);
				gui.SetValue("msc_antisp", antisp);
				local revealranks = gui.GetValue("msc_revealranks");
				revealranks = SenseUI.Checkbox("Reveal Competitive Ranks", revealranks);
				gui.SetValue("msc_revealranks", revealranks);
				local playerlist = gui.GetValue("msc_playerlist");
				playerlist = SenseUI.Checkbox("Player List", playerlist);
				gui.SetValue("msc_playerlist", playerlist);
				local weaplog = gui.GetValue("msc_logevents_purchases");
				weaplog = SenseUI.Checkbox("Purchases Logs", weaplog);
				gui.SetValue("msc_logevents_purchases", weaplog);
				gui.SetValue("msc_logevents", 1);
				local damagelog = gui.GetValue("msc_logevents_damage");
				damagelog = SenseUI.Checkbox("Damage Logs", damagelog);
				gui.SetValue("msc_logevents_damage", damagelog);
				gui.SetValue("msc_logevents", 1);
				local duckjump = gui.GetValue("msc_duckjump");
				duckjump = SenseUI.Checkbox("Duck Jump", duckjump);
				gui.SetValue("msc_duckjump", duckjump);
				local fastduck = gui.GetValue("msc_fastduck");
				fastduck = SenseUI.Checkbox("Fast Duck", fastduck);
				gui.SetValue("msc_fastduck", fastduck);
				local slidewalk = gui.GetValue("msc_slidewalk");
				slidewalk = SenseUI.Checkbox("Slide Walk", slidewalk);
				gui.SetValue("msc_slidewalk", slidewalk);
				SenseUI.Label("Slow Walk");
				local slowwalk = gui.GetValue("msc_slowwalk");
				slowwalk = SenseUI.Bind("sw", true, slowwalk);
				gui.SetValue("msc_slowwalk", slowwalk);
				local slowslider = (gui.GetValue("msc_slowwalkspeed") * 100);
				slowslider = SenseUI.Slider("Slow Walk Speed", 0, 100, "%", "0%", "100%", false, slowslider);
				gui.SetValue("msc_slowwalkspeed", slowslider / 100);
				local autoaccept = gui.GetValue("msc_autoaccept");
				autoaccept = SenseUI.Checkbox("Auto-Accept Match", autoaccept);
				gui.SetValue("msc_autoaccept", autoaccept);
				SenseUI.Label("Knifebot");
				local knifebot = (gui.GetValue("msc_knifebot") + 1);
				knifebot = SenseUI.Combo("combo", { "Off", "On", "Backstab Only", "Trigger", "Quick" }, knifebot);
				gui.SetValue("msc_knifebot", knifebot-1);
				local clantag = gui.GetValue("msc_clantag");
				clantag = SenseUI.Checkbox("Clan-Tag Spammer", clantag);
				gui.SetValue("msc_clantag", clantag);
				local namespam = gui.GetValue("msc_namespam");
				namespam = SenseUI.Checkbox("Name Spammer", namespam);
				gui.SetValue("msc_namespam", namespam);
				local invisiblename = gui.GetValue("msc_invisiblename");
				invisiblename = SenseUI.Checkbox("Invisible Name", invisiblename);
				gui.SetValue("msc_invisiblename", invisiblename);
			end
			SenseUI.EndGroup();
		end
		SenseUI.EndTab();
		if SenseUI.BeginTab( "skinc", SenseUI.Icons.skinchanger ) then
			if SenseUI.BeginGroup( "Skin Changer", "Skin Changer", 25, 25, 235, 70 ) then
				skinc = SenseUI.Checkbox("Skin Changer", skinc);
				gui.SetValue("msc_skinchanger", skinc);
				SenseUI.Label("You need to open original menu of AW", true);
				SenseUI.Label("For change skins", true);
			end
			SenseUI.EndGroup();
		end
		SenseUI.EndTab();
		if SenseUI.BeginTab( "players", SenseUI.Icons.playerlist ) then
			if SenseUI.BeginGroup( "Ps", "Player List", 25, 25, 235, 70 ) then
				playerlist = SenseUI.Checkbox("Player List", playerlist);
				gui.SetValue("msc_playerlist", playerlist);
				SenseUI.Label("You need to open original menu of AW", true);
				SenseUI.Label("For change priorities in player list", true);
			end
			SenseUI.EndGroup();
		end
		SenseUI.EndTab();

		SenseUI.EndWindow();
	end
end

callbacks.Register( "Draw", "suitest", draw_callback );