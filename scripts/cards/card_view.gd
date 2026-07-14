class_name CardView
extends Button


signal card_clicked(card: CardData, selected: bool)


var card_data: CardData


func _ready() -> void:
	pressed.connect(_on_pressed)


func setup(new_card: CardData) -> void:
	card_data = new_card
	text = card_data.get_display_name()
	tooltip_text = card_data.get_display_name()

	_apply_suit_colour()


func _apply_suit_colour() -> void:
	var is_red_suit := (
		card_data.suit == CardData.Suit.DIAMONDS
		or card_data.suit == CardData.Suit.HEARTS
	)

	var card_colour := Color("#c92a2a") if is_red_suit else Color("#202020")

	add_theme_color_override("font_color", card_colour)
	add_theme_color_override("font_hover_color", card_colour)
	add_theme_color_override("font_pressed_color", card_colour)
	add_theme_color_override("font_focus_color", card_colour)


func _on_pressed() -> void:
	card_clicked.emit(card_data, button_pressed)
