extends CanvasLayer

export var coins = 0
export var pies = 0

func _ready():
	$Coins.text = String(coins) 
	$Pie.text = String(pies) 

func _on_Coin_coin_collected():
	coins += 1
	_ready()


func _on_Pies_pie_collected():
	pies += 1
	_ready()
