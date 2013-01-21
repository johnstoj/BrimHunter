#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%

#include auctions.ahk

winactivate, Diablo III
sleep, 3000

home := new HeroPage()
auctions := home.NavigateToAuctionHouse()
search := auctions.NavigateToSearchPage()

equipment := search.NavigateToEquipmentSearchPage()
equipment.SetItemType("Armor")
equipment.SetMinItemLevel(60)
equipment.SetItemQuality("Legendary")
equipment.SetMaxBuyOut(25000)

results := equipment.Search()
loop % results.CurrentResultCount()  {
	results.BuyOutItem(a_index)
	;results.SelectItem(a_index)
}

auctions.Close()