class_name CardView
extends Button


signal card_clicked(card: CardData, selected: bool)


const CARD_ASSET_PATH := "res://assets/cards/%s-%d.png"
const CARD_BACK_ASSET_PATH := "res://assets/cards/Back.png"

const SUIT_LETTERS := {
	CardData.Suit.CLUBS: "C",
	CardData.Suit.DIAMONDS: "D",
	CardData.Suit.HEARTS: "H",
	CardData.Suit.SPADES: "S"
}

 
var card_data: CardData


func _ready() -> void:
	pressed.connect(_on_pressed)


func setup(new_card: CardData) -> void:
	card_data = new_card
	tooltip_text = card_data.get_display_name()
	show_back()


func show_front() -> void:
	var suit_letter: String = SUIT_LETTERS[card_data.suit]
	var asset_path := CARD_ASSET_PATH % [
		suit_letter,
		card_data.rank
	]
	$Face.texture = load(asset_path)

func show_back() -> void:
	$Face.texture = load(CARD_BACK_ASSET_PATH)

func _on_pressed() -> void:
	if button_pressed:
		show_front()
	else:
		show_back()
		

	card_clicked.emit(card_data, button_pressed)
