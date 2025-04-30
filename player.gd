extends Area2D

signal hit
#
#@export var speed = 400 # How fast the player will move (pixels/sec).
#var screen_size # Size of the game window.
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#screen_size = get_viewport_rect().size
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#var velocity = Vector2.ZERO # The player's movement vector.
	#position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	#if Input.is_action_pressed("move_right"):
		#print('right')
		#velocity.x += 1 * delta
	#if Input.is_action_pressed("move_left"):
		#print('left')
		#velocity.x -= 1 * delta
	#if Input.is_action_pressed("move_down"):
		#print('down')
		#velocity.y += 1 * delta
	#if Input.is_action_pressed("move_up"):
		#print('up')
		#velocity.y -= 1 * delta
	#else:
		#$AnimatedSprite2D.stop()
