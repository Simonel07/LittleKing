extends Control

func _ready():
	$MarginContainer/CenterContainer/VBoxContainer/TextureButton.grab_focus()
	$MarginContainer/Sprite/AnimationPlayer.play("New Anim (2)")

func _physics_process(delta):
	if $MarginContainer/CenterContainer/VBoxContainer/TextureButton.is_hovered() == true:
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton.grab_focus()
	if $MarginContainer/CenterContainer/VBoxContainer/TextureButton2.is_hovered():
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton2.grab_focus()
	if $MarginContainer/CenterContainer/VBoxContainer/TextureButton3.is_hovered():
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton3.grab_focus()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton.grab_focus()
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state

func _on_TextureButton_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state

func _on_TextureButton2_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")


func _on_TextureButton3_pressed():
	get_tree().quit()


func _on_TouchScreenButton_pressed():
	$MarginContainer/CenterContainer/VBoxContainer/TextureButton.grab_focus()
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state


func _on_Continue_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state


func _on_MainMenu_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")


func _on_Exit_pressed():
	get_tree().quit()
