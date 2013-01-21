#NoEnv
#Warn
#Persistent 

SendMode Input
SetWorkingDir %A_ScriptDir%

#include scriptlog.ahk
#include auctions.ahk

ScriptLog.Message("Starting...")
BrimHunter:
	ScriptLog.Message("Looking for items...")
	IfWinExist, Diablo III
	{
		blockinput, sendandmouse
		winactivate, Diablo III
		sleep, 2000

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
		
		random, nextrun, 180000, 300000
		ScriptLog.Message("Next run scheduled in " . nextrun . "ms." . "`n")
		settimer, BrimHunter, %nextrun%
	}
return

esc::
	blockinput, default
	ScriptLog.Message("Stopping on request.")
	exitapp
return