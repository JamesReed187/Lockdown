extends Node2D

@onready var Message = $Message
@onready var Send = $Send
@onready var Messages = $Messages
@onready var chatbox =$Chatbox


func _on_send_pressed() -> void:
	pass

func _ready():
	if Input.is_action_just_pressed("chatbox"):
		chatbox.hide()
