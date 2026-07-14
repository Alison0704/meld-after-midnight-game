class_name CardData
extends RefCounted


enum Suit {
	CLUBS,
	DIAMONDS,
	HEARTS,
	SPADES
}


var suit: Suit
var rank: int


func _init(new_suit: Suit, new_rank: int) -> void:
	suit = new_suit
	rank = new_rank


func get_display_name() -> String:
	var rank_names := {
		1: "A",
		11: "J",
		12: "Q",
		13: "K"
	}

	var suit_symbols := {
		Suit.CLUBS: "♣",
		Suit.DIAMONDS: "♦",
		Suit.HEARTS: "♥",
		Suit.SPADES: "♠"
	}

	var rank_text: String = rank_names.get(rank, str(rank))
	var suit_text: String = suit_symbols[suit]

	return rank_text + suit_text