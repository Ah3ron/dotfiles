local cfg = hl.config

cfg({
	general = {
		gaps_in = 4,
		gaps_out = 10,
		border_size = 1,
		resize_on_border = false,
		allow_tearing = false,
		layout = "master",
	},
	decoration = {
		rounding = 8,
		active_opacity = 1.0,
		inactive_opacity = 0.8,
		dim_inactive = true,
		dim_strength = 0.1,
		shadow = {
			enabled = true,
			range = 30,
			render_power = 5,
			offset = { 0, 5 },
			color = "rgba(00000070)",
		},
		blur = {
			enabled = true,
			size = 10,
			passes = 3,
			ignore_opacity = true,
			new_optimizations = true,
			xray = true,
			noise = 0.02,
			contrast = 1.1,
			vibrancy = 0.2,
			vibrancy_darkness = 0.3,
		},
	},
	animations = { enabled = false },
	dwindle = {
		preserve_split = true,
		force_split = 2,
		smart_resizing = true,
	},
	master = {
		orientation = "center",
		slave_count_for_center_master = 4,
		new_status = "slave",
		new_on_active = "after",
		mfact = 0.52,
	},
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
	xwayland = {
		force_zero_scaling = true,
	},
})
