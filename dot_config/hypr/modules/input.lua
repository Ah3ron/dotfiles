local cfg = hl.config

cfg({
	input = {
		kb_layout = "us,ru",
		kb_variant = ",",
		kb_model = "",
		kb_options = "grp:alt_shift_toggle",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
			disable_while_typing = false,
		},
	},
})
hl.device({
	name = "compx-nk-mouse-nano-dongle-1",
	sensitivity = -0.7,
})
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
