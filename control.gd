extends Control

signal control_pressed(button_name)
signal control_released(button_name)

func _ready() -> void:
	$UpLabel/Up.pressed.connect(_on_control_pressed.bind("up"))
	$UpLabel/Up.released.connect(_on_control_released.bind("up"))
	$DownLabel/Down.pressed.connect(_on_control_pressed.bind("down"))
	$DownLabel/Down.released.connect(_on_control_released.bind("down"))
	$LeftLabel/Left.pressed.connect(_on_control_pressed.bind("left"))
	$LeftLabel/Left.released.connect(_on_control_released.bind("left"))
	$RightLabel/Right.pressed.connect(_on_control_pressed.bind("right"))
	$RightLabel/Right.released.connect(_on_control_released.bind("right"))
	$ShootLabel/Shoot.pressed.connect(_on_control_pressed.bind("shoot"))
	$ShootLabel/Shoot.released.connect(_on_control_released.bind("shoot"))

func _on_control_pressed(name):
	control_pressed.emit(name)

func _on_control_released(name):
	control_released.emit(name)
