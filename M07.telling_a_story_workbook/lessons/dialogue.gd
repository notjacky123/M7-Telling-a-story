extends Control

var expressions := {
	"happy": preload ("res://assets/emotion_happy.png"),
	"regular": preload ("res://assets/emotion_regular.png"),
	"sad": preload ("res://assets/emotion_sad.png"),
}
var bodies := {
	"sophia": preload ("res://assets/sophia.png"),
	"pink": preload ("res://assets/pink.png")
}

var dialogue_items: Array[Dictionary] = [
	{
		"expression": expressions["regular"],
		"text": "pink why aren't you appring",
		"character": bodies["sophia"],
	},
	{
		"expression": expressions["sad"],
		"text": "it was supposed to be body, not bodies",
		"character": bodies["pink"],
	},
	{
		"expression": expressions["happy"],
		"text": "oh i see.",
		"character": bodies["sophia"],
	},
	{
		"expression": expressions["regular"],
		"text": "well bye pink.",
		"character": bodies["sophia"],
	},
	{
		"expression": expressions["happy"],
		"text": "bye sophia",
		"character": bodies["pink"],
	},
]
	
var current_item_index := 0

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var body: TextureRect = %body
@onready var expression: TextureRect = %Expression

func show_text() -> void:
	var current_item := dialogue_items[current_item_index]
	rich_text_label.text = current_item["text"]
	expression.texture = current_item["expression"]
	body.texture = current_item["character"]
	rich_text_label.visible_ratio = 0.0
	var tween := create_tween()
	var text_appearing_duration: float = current_item["text"].length() / 30.0
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)
	var sound_max_offset := audio_stream_player.stream.get_length() - text_appearing_duration
	var sound_start_position := randf() * sound_max_offset
	audio_stream_player.play(sound_start_position)
	tween.finished.connect(audio_stream_player.stop)
	
	slide_in()
	
	next_button.disabled = true
	tween.finished.connect(func() -> void:
		next_button.disabled = false
		)
	
func _ready() -> void:
	show_text()
	next_button.pressed.connect(advance)
	
func advance() -> void:
	current_item_index += 1
	if current_item_index == dialogue_items.size():
		get_tree().quit()
	else:
		show_text()
	
func slide_in() -> void:
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)
	body.position.x = 200.0
	tween.tween_property(body, "position:x", 0.0, 0.3)
	body.modulate.a = 0.0
	tween.parallel().tween_property(body, "modulate:a", 1.0, 0.2)
