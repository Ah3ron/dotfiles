return {
	config_dir = (os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")) .. "/hypr",
	terminal = "alacritty",
	fileManager = "nautilus",
	browser = "helium-browser",
	mainMod = "SUPER",
}
