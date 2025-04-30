extends Node2D

@export var speed = 75 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var moveUp = false
var moveDown = false
var moveLeft = false
var moveRight = false

var canUp = true
var canDown = true
var canLeft = true
var canRight = true

var hearts = 3

@export var ghostSpeed = 45
var playerInRadar = false
var playerInRadar2 = false
@onready var player = $"Player"  # Referensi ke node pemain
@onready var ghostChar = $"ghost"
@onready var ghostChar2 = $ghost2
var playerX
var playerY
var ghostX
var ghostY
var ghostX2
var ghostY2

var inBush = false

#var jumpScareArray = [$jumpscare/VideoStreamPlayer, $jumpscare/VideoStreamPlayer2, $jumpscare/VideoStreamPlayer3, $jumpscare/VideoStreamPlayer4]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.musicOn:
		$sound/inGameSound.play()
	screen_size = get_viewport_rect().size
	$ghost/Sprite2D/AnimationPlayer.play("ghost")
	$portal/portal1/splash.visible = false
	$portal/portal2/splash.visible = false
	$Player/teleportEffect.visible = false
	$portal/portal1/splash/AnimationPlayer.stop()
	$ghost.position.x = randi_range(795, 915)
	$ghost.position.y = randi_range(70, 320)
	$ghost2.position.x = randi_range(465, 915)
	$ghost2.position.y = randi_range(400, 570)  
	playerX = player.position.x
	playerY = player.position.y
	ghostX = ghostChar.position.x
	ghostY = ghostChar.position.y
	ghostX2 = ghostChar2.position.x
	ghostY2 = ghostChar2.position.y
	$jumpscare/VideoStreamPlayer.stop()
	$jumpscare/VideoStreamPlayer/AudioStreamPlayer.stop()
	$jumpscare/VideoStreamPlayer2.stop()
	$jumpscare/VideoStreamPlayer2/AudioStreamPlayer.stop()
	$jumpscare/VideoStreamPlayer3.stop()
	$jumpscare/VideoStreamPlayer3/AudioStreamPlayer.stop()
	$jumpscare/VideoStreamPlayer4.stop()
	$jumpscare/VideoStreamPlayer4/AudioStreamPlayer.stop()
	Global.points = 0
	
func jumpScare():
	var random_number = randi_range(0, 3)
	if random_number == 0:
		$jumpscare/VideoStreamPlayer.play()
		$jumpscare/VideoStreamPlayer/AudioStreamPlayer.play()
	if random_number == 1:
		$jumpscare/VideoStreamPlayer2.play()
		$jumpscare/VideoStreamPlayer2/AudioStreamPlayer.play()
	if random_number == 2:
		$jumpscare/VideoStreamPlayer3.play()
		$jumpscare/VideoStreamPlayer3/AudioStreamPlayer.play()
	if random_number == 3:
		$jumpscare/VideoStreamPlayer4.play()
		$jumpscare/VideoStreamPlayer4/AudioStreamPlayer.play()

func upPoints():
	if Global.musicOn:
		$sound/poinSound.play()
	Global.points += 5
	if Global.points == 1090:
		get_tree().change_scene_to_file("res://finish.tscn")
	$scores.text ="Score : " + str(Global.points)

func ghost():
	jumpScare()
	$"Player".position.x = 466
	$'Player'.position.y = 73
	$ghost.position.x = randi_range(795, 915)
	var pindahPosisi = true
	if pindahPosisi:
		if hearts == 2:
			$"heart/heart three".visible = false
		if hearts == 1:
			$"heart/heart two".visible = false
		if hearts == 0:
			$"heart/heart one".visible = false
			get_tree().change_scene_to_file("res://game over.tscn")
	

func _input(event):
	if event is InputEventKey:
		if canUp and event.is_action_pressed("move_up"):
			canDown = false
			canLeft = false
			canRight = false
		elif event.is_action_released("move_up"):
			canDown = true
			canLeft = true
			canRight = true
		if canDown and event.is_action_pressed("move_down"):
			canUp = false
			canLeft = false
			canRight = false
		elif event.is_action_released("move_down"):
			canUp = true
			canLeft = true
			canRight = true
		if canRight and event.is_action_pressed("move_right"):
			canUp = false
			canLeft = false
			canDown = false
		elif event.is_action_released("move_right"):
			canUp = true
			canLeft = true
			canDown = true
		if canLeft and event.is_action_pressed("move_left"):
			canUp = false
			canRight = false
			canDown = false
		elif event.is_action_released("move_left"):
			canUp = true
			canRight = true
			canDown = true
			
func _process(delta):
	if playerInRadar && not inBush:
		if ghostX > playerX:
			$ghost.position.x -= ghostSpeed * delta
			ghostX = $ghost.position.x
		elif ghostX < playerX:
			$ghost.position.x += ghostSpeed * delta
			ghostX = $ghost.position.x
		if ghostY > playerY:
			$ghost.position.y -= ghostSpeed * delta
			ghostY = $ghost.position.y
		elif ghostY < playerY:
			$ghost.position.y += ghostSpeed * delta
			ghostY = $ghost.position.y
		if $ghost.position.y > 320:
			$ghost.position.y = 320
			ghostY = $ghost.position.y
	
	if playerInRadar2 && not inBush:
		if ghostX2 > playerX:
			$ghost2.position.x -= ghostSpeed * delta
			ghostX2 = $ghost2.position.x
		elif ghostX2 < playerX:
			$ghost2.position.x += ghostSpeed * delta
			ghostX2 = $ghost2.position.x
		if ghostY2 > playerY:
			$ghost2.position.y -= ghostSpeed * delta
			ghostY2 = $ghost2.position.y
		elif ghostY2 < playerY:
			$ghost2.position.y += ghostSpeed * delta
			ghostY2 = $ghost2.position.y
		if $ghost2.position.y < 360:
			$ghost2.position.y = 360
			ghostY2 = $ghost2.position.y
			
	if Input.is_action_pressed("move_right"):
		if canRight:
			$Player.position.x += speed * delta
			$Player/AnimatedSprite2D.play("left")
			playerX = player.position.x
			moveRight = true
			moveUp = false
			moveDown = false
			moveLeft = false
	if Input.is_action_pressed("move_left"):
		if canLeft:
			$Player.position.x -= speed * delta
			$Player/AnimatedSprite2D.play("right")
			playerX = player.position.x
			moveLeft = true
			moveUp = false
			moveDown = false
			moveRight = false
	if Input.is_action_pressed("move_up"):
		if canUp:
			$Player.position.y -= speed * delta
			$Player/AnimatedSprite2D.play("down")
			playerY = player.position.y
			moveUp = true
			moveLeft = false
			moveDown = false
			moveRight = false
	if Input.is_action_pressed("move_down"):
		if canDown:
			$Player.position.y += speed * delta
			$Player/AnimatedSprite2D.play("up")
			playerY = player.position.y
			moveDown = true
			moveUp = false
			moveLeft = false
			moveRight = false
	else:
		$Player/AnimatedSprite2D.stop()

func _on_player_body_entered(body) -> void:
	if body.is_in_group('wall'):
		if Global.musicOn:
				$sound/crashSound.play()
		if moveUp:
			canUp = false
			$Player.position.y += 5
		if moveDown:
			canDown = false
			$Player.position.y -= 5
		if moveLeft:
			canLeft = false
			$Player.position.x += 5
		if moveRight:
			canRight = false
			$Player.position.x -= 5
	elif body.is_in_group('points'):
		body.free()
		upPoints()
	elif body.is_in_group('ghost'):
		hearts -= 1
		ghost()
	elif body.is_in_group('radar'):
		if Global.musicOn:
			$sound/ghostSound.play()
		playerInRadar = true
	elif body.is_in_group('radar2'):
		if Global.musicOn:
			$sound/ghostSound.play()
		playerInRadar2 = true
	elif body.name == "portal1":
		$portal/portal1/splash.visible = true
		$Player/teleportEffect.visible = true
		$portal/portal1/splash/AnimationPlayer.play("splash")
		if Global.musicOn:
			$sound/splashSound.play()
		$portal/portal1/Timer.start()
		$Player/teleportEffect/AnimationPlayer.play("teleport")
		$Player.position.x = 890
	elif body.name == "portal2":
		$portal/portal2/splash.visible = true
		$Player/teleportEffect.visible = true
		$portal/portal2/splash/AnimationPlayer.play("splash")
		if Global.musicOn:
			$sound/splashSound.play()
		$portal/portal2/Timer.start()
		$Player/teleportEffect/AnimationPlayer.play("teleport")
		$Player.position.x = 500
	elif body.is_in_group('bush'):
		inBush = true
		if Global.musicOn:
			$sound/rustleSound.play()
		
func _on_player_body_exited(body) -> void:
	if body.is_in_group("wall"):  # Saat keluar dari tembok, reset flag
		canDown = true
		canRight = true
		canLeft = true
		canUp = true
	elif body.is_in_group('radar'):
		if Global.musicOn:
			$sound/ghostSound.stop()
		playerInRadar = false
	elif body.is_in_group('radar2'):
		if Global.musicOn:
			$sound/ghostSound.stop()
		playerInRadar2 = false
	elif body.is_in_group('bush'):
		inBush = false
 

func _on_timer_timeout() -> void:
	$portal/portal1/splash.visible = false
	$portal/portal1/splash/AnimationPlayer.stop()
	$portal/portal2/splash.visible = false
	$portal/portal2/splash/AnimationPlayer.stop()
	$Player/teleportEffect/AnimationPlayer.stop()
	$Player/teleportEffect.visible = false

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game over.tscn")
