local rule = hl.window_rule

-- system fix
rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- layer rules
hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
	},
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

-- floating apps and dialogs
rule({
	match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
	float = true,
	keep_aspect_ratio = true,
	move = "(monitor_w*0.73) (monitor_h*0.72)",
	pin = true,
	opacity = 1,
})

rule({
	match = { title = "Select what to share" },
	float = true,
	pin = true,
	center = true,
	size = { 500, 500 },
})

for _, pat in ipairs({
	"^(Open File)(.*)$",
	"^(Select a File)(.*)$",
	"^(Open Folder)(.*)$",
	"^(Save As)(.*)$",
	"^(File Upload)(.*)$",
	"^(.*)(wants to save)$",
	"^(.*)(wants to open)$",
}) do
	rule({
		match = { title = pat },
		center = true,
		float = true,
	})
end

rule({
	match = { class = "^(pavucontrol|org\\.pulseaudio\\.pavucontrol)$" },
	float = true,
	size = "(monitor_w*.45) (monitor_h*.45)",
	center = true,
})

rule({
	match = { class = "org.quickshell$" },
	float = true,
})

rule({
	match = { class = "dev.noctalia.Noctalia" },
	float = true,
	size = { 1080, 920 },
})

-- immediate render (games / protons)
for _, title in ipairs({
	".*\\.exe",
	".*minecraft.*",
	"Genshin Impact",
}) do
	rule({
		match = { title = title },
		immediate = true,
	})
end

rule({
	match = { class = "^(steam_app).*" },
	immediate = true,
})

-- workspace routing
for _, w in ipairs({
	{ class = "steam", workspace = "3 silent" },
	{ class = "org.telegram.desktop", workspace = "4 silent" },
}) do
	rule({
		match = { class = w.class },
		workspace = w.workspace,
	})
end
