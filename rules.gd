extends Node2D

func _ready() -> void:
	$Label/AnimationPlayer.play("scaleUp")
	
func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("oke"):
			get_tree().change_scene_to_file("res://main.tscn")
		if Global.musicOn:
			$clickSound.play()
