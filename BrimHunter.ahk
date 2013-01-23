#NoEnv
#Warn
#Persistent 
#SingleInstance force

SendMode Input
SetWorkingDir %A_ScriptDir%

#include ScriptLog.ahk
#include Auctions.ahk

MilliToHMS(milli, ByRef hours=0, ByRef mins=0, ByRef secs=0) {
  setformat, float, 02.0
  milli /= 1000.0
  secs := mod(milli, 60)
  setformat, float, 02.0
  secs += 0.0
  
  setformat, float, 02.0
  milli //= 60
  mins := mod(milli, 60)
  
  setformat, float, 02.0
  mins += 0.0
  
  hours := milli //60
  setformat, float, 02.0
  hours += 0.0
  
  return hours . ":" . mins . ":" . secs
}


BrimHunter:
	ScriptLog.Message("BrimHunter Waking... *Yawn* *Stretch*")
	IfWinExist, Diablo III
	{
		winactivate, Diablo III
		sleep, 2000

		home := new HeroPage()
		auctions := home.NavigateToAuctionHouse()
		search := auctions.NavigateToSearchPage()

		equipmentSearchPage := search.NavigateToEquipmentSearchPage()		
		equipmentSearchPage.SetMinItemLevel(60)
		equipmentSearchPage.SetItemQuality("Legendary")
		equipmentSearchPage.SetMaxBuyOut(22000)
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
		ScriptLog.Message("Next run scheduled in ~" . MilliToHMS(nextrun) . "." . "`n")
		settimer, BrimHunter, %nextrun%
	}
return

end::
	blockinput, off
	ScriptLog.Message("Stopping on user request.")
	exitapp
return