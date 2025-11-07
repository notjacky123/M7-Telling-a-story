extends Control

var bodies := {
	"sophia": preload("res://assets/sophia.png"),
	"pink": preload("res://assets/pink.png")
}

var expressions := {
	"happy": preload ("res://assets/emotion_happy.png"),
	"regular":preload("res://assets/emotion_regular.png"),
	"sad":preload("res://assets/emotion_sad.png"),
}

@onready var row_bodies: HBoxContainer = $VBoxContainer/RowBodies
@onready var row_expressions: HBoxContainer = $VBoxContainer/RowExpressions
@onready var body: TextureRect = %body
@onready var expression: TextureRect = %Expression

func create_button_pink() -> void:
	var button := Button.new()
	row_bodies.add_child(button)
	
	var key := "pink"
	button.text = key.capitalize()
	button.pressed.connect(func() -> void:
		body.texture = bodies[key]
)

func _ready() -> void:
	create_button()
	
func create_button() -> void:
	for current_body: String in bodies:
		var button := Button.new()
		row_bodies.add_child(button)
		button.text = current_body.capitalize()
		button.pressed.connect(func() -> void:
			body.texture = bodies[current_body]
		)

	for current_expression: String in expressions:
		var button := Button.new()
		row_expressions.add_child(button)
		button.text = current_expression.capitalize()
		button.pressed.connect(func() -> void:
			expression.texture = expressions[current_expression]
		)
	
