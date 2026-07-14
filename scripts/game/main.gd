extends Control


const CARD_VIEW_SCENE: PackedScene = preload("res://scenes/cards/CardView.tscn")


@onready var game_manager: GameManager = $GameManager

@onready var player_one_title: Label = %PlayerOneTitle
@onready var player_two_title: Label = %PlayerTwoTitle

@onready var player_one_hand: HBoxContainer = %PlayerOneHand
@onready var player_two_hand: HBoxContainer = %PlayerTwoHand

@onready var stock_label: Label = %StockLabel
@onready var status_label: Label = %StatusLabel
@onready var deal_button: Button = %DealButton


func _ready() -> void:
	deal_button.pressed.connect(_on_deal_button_pressed)
	_start_new_game()


func _on_deal_button_pressed() -> void:
	_start_new_game()


func _start_new_game() -> void:
	game_manager.start_new_game()
	status_label.text = "Select one or more cards."
	_update_interface()


func _update_interface() -> void:
	player_one_title.text = (
		"Player 1 — %d cards"
		% game_manager.player_one_hand.size()
	)

	player_two_title.text = (
		"Player 2 — %d cards"
		% game_manager.player_two_hand.size()
	)

	_populate_hand(
		player_one_hand,
		game_manager.player_one_hand,
		1
	)

	_populate_hand(
		player_two_hand,
		game_manager.player_two_hand,
		2
	)

	stock_label.text = "Stock: %d cards" % game_manager.stock.size()


func _populate_hand(
	container: HBoxContainer,
	hand: Array[CardData],
	player_number: int
) -> void:
	for old_card in container.get_children():
		container.remove_child(old_card)
		old_card.queue_free()

	for card_data in hand:
		var card_view := CARD_VIEW_SCENE.instantiate() as CardView

		card_view.setup(card_data)
		card_view.card_clicked.connect(
			_on_card_clicked.bind(player_number)
		)

		container.add_child(card_view)


func _on_card_clicked(
	card: CardData,
	selected: bool,
	player_number: int
) -> void:
	var action := "selected" if selected else "deselected"

	status_label.text = (
		"Player %d %s %s"
		% [
			player_number,
			action,
			card.get_display_name()
		]
	)
