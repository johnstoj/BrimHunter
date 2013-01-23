#NoEnv
SendMode Input

#include scriptlog.ahk

SimulateHumanLag(lower = 1100, upper = 3300) {
	random, delay, lower, upper
	sleep, delay
}

SimulateHumanClick(x, y, rx = 3, ry = 3) {
	blockinput, mouse
	SimulateHumanLag()
	mousemove, x, y, 100
	
	SimulateHumanLag(25, 55)
	sendplay, {click}
	blockinput, off
}

SimulateHumanDataEntry(keys, x, y, rx = 3, ry = 3) {
	blockinput, on
	SimulateHumanLag()
	mousemove, x, y, 100
	
	SimulateHumanLag(25, 55)
	sendplay, {click}
	
	SimulateHumanLag()
	sendplay, %keys%
	blockinput, off
}

class SearchResultPage {	
	static bidcoins := [317, 362, 407, 452, 497, 542, 587, 632, 677, 722, 767]
	
	CurrentResultCount() {
		found := 0
		
		loop % this.bidcoins.maxindex() {
			ImageSearch, x, y, 1324, this.bidcoins[a_index], 1335, this.bidcoins[a_index] + 11, *50 %a_scriptdir%\images\goldcoin.png
			if (errorlevel != 0) {
				break
			}
			
			found += 1
		}
		
		ScriptLog.Message("Found " . found . " items.")
		return found
	}
	
	SelectItem(index) {
		ScriptLog.Message("Selecting item: " . index)
		mousemove, 800, this.bidcoins[index], 100
		sendplay, {click}
	}
	
	BuyOutItem(index) {
		this.SelectItem(index)
		
		ScriptLog.Message("Buying item: " . index)
		mousemove, 1450, 880, 100
		sendplay, {click}
		
		SimulateHumanClick(850, 780)
		
		sleep, 7000
		SimulateHumanClick(960, 460)
	}
}

class EquipmentSearchPage {
	Close() {
		SimulateHumanClick(390, 230)
	}
	
	SetItemType(type) {
		ScriptLog.Message("Setting item type: " . type)
		SimulateHumanClick(630, 345)
		
		y := object("1-Hand", 390, "2-Hand", 420, "Off-Hand", 450, "Armor", 480, "Follower Special", 510)		
		SimulateHumanClick(420, y[type])
	}
	
	SetMinItemLevel(level) {
		ScriptLog.Message("Setting item level: " . level)
		SimulateHumanDataEntry("^{a}" . level, 410, 450)
	}
	
	SetItemQuality(quality) {
		ScriptLog.Message("Setting item quality: " . quality)
		SimulateHumanClick(630, 450)
		
		y := object("All", 495, "Inferior", 525, "Normal", 555, "Superior", 585, "Magic", 615, "Rare", 645, "Legendary", 675)		
		SimulateHumanClick(550, y[quality])
	}
	
	SetMaxBuyOut(gold) {
		ScriptLog.Message("Setting buyout: " . gold)
		SimulateHumanDataEntry("^{a}" . gold, 520, 530)
	}
	
	Search() {
		ScriptLog.Message("Searching for items...")
		SimulateHumanClick(520, 840)
		
		sleep 5000
		return new SearchResultPage()
	}
}

class AuctionHouseSearchPage {
	NavigateToEquipmentSearchPage() {
		SimulateHumanClick(515, 240)

		return new EquipmentSearchPage()
	}
	
	NavigateToGemsSearchPage() {
		SimulateHumanClick(515, 290)
	}
	
	NavigateToCraftingAndDyesSearchPage() {
		SimulateHumanClick(515, 350)
	}
	
	NavigateToPagesAndRecipesSearchPage() {
		SimulateHumanClick(515, 405)
	}
}


class AuctionHousePage {
	Close() {
		SimulateHumanClick(1580, 110)
	}
	
	NavigateToSearchPage() {
		SimulateHumanClick(630, 160)

		return new AuctionHouseSearchPage()
	}
}

class HeroPage {	
	NavigateToAuctionHouse() {
		SimulateHumanClick(230, 640)
		
		return new AuctionHousePage()
	}
}
