#NoEnv
#Warn
#Persistent 
#SingleInstance force

SendMode Input
SetWorkingDir %A_ScriptDir%

#include ScriptLog.ahk
#include Auctions.ahk
#include Utils.ahk

totalbought := 0

BrimHunter:
	IfWinExist, Diablo III
	{
		winactivate, Diablo III
		ScriptLog.Message("BrimHunter Waking... *Yawn* *Stretch* *Scratch*")
		sleep, 2000

		home := new HeroPage()
		auctions := home.NavigateToAuctionHouse()
		search := auctions.NavigateToSearchPage()

		equipmentSearchPage := search.NavigateToEquipmentSearchPage()		
		equipmentSearchPage.SetMinItemLevel(60)
		equipmentSearchPage.SetItemQuality("Legendary")
		equipmentSearchPage.SetMaxBuyOut(22000)
		
		itemsbought := 0
		equipment := ["1-Hand", "2-Hand", "Off-Hand", "Armor"]
		while (equipment.maxindex()) {
			random, index, 1, equipment.maxindex()
			equipmentSearchPage.SetItemType(equipment[index])
			equipment.remove(index)

			results := equipmentSearchPage.Search()
			loop % results.CurrentResultCount()  {
				itemsbought += results.BuyOutItem(a_index)
			}		
		}
		
		totalbought += itemsbought
		ScriptLog.Message("Items bought: " . itemsbought . ", Total: " . totalbought)
		auctions.Close()
		
		random, nextrun, 2000, 300000
		ScriptLog.Message("Sleeping for ~" . MilliToHMS(nextrun) . "." . "`n")
		settimer, BrimHunter, %nextrun%
	}
return

end::
	blockinput, off
	ScriptLog.Message("Stopping on user request.")
	ScriptLog.Message("Total number of items bought this session: " . totalbought)
	exitapp
return