extends Node2D

func _ready() -> void:
	$themeSong.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://start.tscn")
	if Global.musicOn:
		$clickSound.play()

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("oke"):
			get_tree().change_scene_to_file("res://start.tscn")
		if Global.musicOn:
			$clickSound.play()
