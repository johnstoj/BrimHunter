#NoEnv
#Warn
#Persistent 

SendMode Input
SetWorkingDir %A_ScriptDir%

#include scriptlog.ahk
#include auctions.ahk

ScriptLog.Message("BrimHunter v1.0 by Jotsnhoj")
BrimHunter:
	ScriptLog.Message("Waking. *Yawn* *Stretch*")
	IfWinExist, Diablo III
	{
		blockinput, sendandmouse
		winactivate, Diablo III
		sleep, 2000

		home := new HeroPage()
		auctions := home.NavigateToAuctionHouse()
		search := auctions.NavigateToSearchPage()

		equipmentSearchPage := search.NavigateToEquipmentSearchPage()		
		equipmentSearchPage.SetMinItemLevel(60)
		equipmentSearchPage.SetItemQuality("Legendary")
		equipmentSearchPage.SetMaxBuyOut(25000)
		equipment := ["1-Hand", "2-Hand", "Off-Hand", "Armor", "Follower Special"]
		for index, type in equipment {
			equipmentSearchPage.SetItemType(type)

			results := equipmentSearchPage.Search()
			loop % results.CurrentResultCount()  {
				results.BuyOutItem(a_index)
				;results.SelectItem(a_index)
			}		
		}
		
		auctions.Close()
		
		random, nextrun, 180000, 300000
		ScriptLog.Message("Next run scheduled in " . nextrun . "ms." . "`n")
		settimer, BrimHunter, %nextrun%
	}
return

esc::
	blockinput, default
	ScriptLog.Message("Stopping on user request.")
	exitapp
return