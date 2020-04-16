extends ColorRect



func play(n: String):
	$anim.play(n)

func skip(n: String):
	$anim.play(n)
	$anim.advance(1000)

func is_playing():
	return $anim.is_playing()



func lose():
	skip("fade-in")
	play("slide-in")
	
	$big.text = "Game Over"
	$small.text = lost_texts[randi() % lost_texts.size()]

func win():
	skip("fade-in")
	play("slide-in")
	
	$big.text = "Great Job"
	$small.text = won_texts[randi() % won_texts.size()]



const lost_texts = [
	"heh, try harder next time",
	"did you forget your glasses ?",
	"wow, that's lame",
	"git gud bruh",
	"i don't even know what to say",
	"don't think too much about it",
	"it's not the first thing you fail at",
]

const won_texts = [
	"i'll give you that one",
	"what did you expect ? a medal ?",
	"that was an easy one",
	"you passed. barely",
	"damn finally",
	"took you long enough",
	"never thought you'll make it",
	"could be better"
]
