class_name GameManager
extends Node

const HAND_SIZE := 10

var stock: Array[CardData] = []
var discard_pile: Array[CardData] = []
var player_one_hand: Array[CardData] = []
var player_two_hand: Array[CardData] = []


func start_new_game() -> void:
	stock.clear()
	discard_pile.clear()
	player_one_hand.clear()
	player_two_hand.clear()

	_create_deck()
	stock.shuffle()
	_deal_cards()
	discard_pile.append(stock.pop_back())

	_sort_hand(player_one_hand)
	_sort_hand(player_two_hand)

	assert(player_one_hand.size() == HAND_SIZE)
	assert(player_two_hand.size() == HAND_SIZE)
	assert(discard_pile.size() == 1)
	assert(stock.size() == 31)


func _create_deck() -> void:
	for suit_value in CardData.Suit.values():
		for rank_value in range(1, 14):
			var card := CardData.new(suit_value, rank_value)
			stock.append(card)

	assert(stock.size() == 52)


func _deal_cards() -> void:
	for card_index in range(HAND_SIZE):
		player_one_hand.append(stock.pop_back())
		player_two_hand.append(stock.pop_back())


func _sort_hand(hand: Array[CardData]) -> void:
	hand.sort_custom(
		func(first_card: CardData, second_card: CardData) -> bool:
			if first_card.suit == second_card.suit:
				return first_card.rank < second_card.rank

			return first_card.suit < second_card.suit
	)


func hand_to_text(hand: Array[CardData]) -> String:
	var card_names := PackedStringArray()

	for card in hand:
		card_names.append(card.get_display_name())

	return "  ".join(card_names)
