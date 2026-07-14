extends TextureRect


const FRAMES: Array[Texture2D] = [
	preload("res://assets/table/normal-wood-texture/normal-wood-texture1.png"),
	preload("res://assets/table/normal-wood-texture/normal-wood-texture2.png"),
	preload("res://assets/table/normal-wood-texture/normal-wood-texture3.png"),
]

@export var frame_duration: float = 0.5


var _index := 0
var _elapsed := 0.0


func _ready() -> void:
	texture = FRAMES[0]


func _process(delta: float) -> void:
	_elapsed += delta

	if _elapsed < frame_duration:
		return

	_elapsed -= frame_duration
	_index = (_index + 1) % FRAMES.size()
	texture = FRAMES[_index]
