extends Node2D

export var fps_visible = false
export var menu_visible = false

func _ready():
	$"Basic Menu/Exit Button".connect("pressed", self, "_exit_button_pressed")
	$"Basic Menu/Show FPS Checkbox".connect("pressed", self, "_show_fps_checkbox_pressed")
	set_fps_hud_visibility(fps_visible)
	set_menu_visibility(menu_visible)

func _process(_delta):
	$"FPS Counter/FPS Number".text = str(Performance.get_monitor(Performance.TIME_FPS))

func set_fps_hud_visibility(b: bool, update_checkbox_too: bool = true):
	fps_visible = b
	$"FPS Counter".visible = fps_visible
	if update_checkbox_too:
		$"Basic Menu/Show FPS Checkbox".pressed = fps_visible

func set_menu_visibility(b: bool):
	menu_visible = b
	$"Basic Menu".visible = menu_visible

func _input(event):
	if event is InputEventKey:
		if event.is_pressed():
			if event.scancode == KEY_END:
				get_tree().quit()
			elif event.scancode == KEY_HOME:
				self.set_fps_hud_visibility(!fps_visible)
			elif event.scancode == KEY_ESCAPE:
				set_menu_visibility(!menu_visible)

func _exit_button_pressed():
	get_tree().quit()

func _show_fps_checkbox_pressed():
	set_fps_hud_visibility($"Basic Menu/Show FPS Checkbox".pressed, false)
