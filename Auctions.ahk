#NoEnv
SendMode Input

#include scriptlog.ahk

SimulateHumanLag() {
	random, delay, 1100, 3300
	sleep, delay
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
		;SimulateHumanLag()
		mousemove, 800, this.bidcoins[index], 100
		sendplay, {click}
	}
	
	BuyOutItem(index) {
		this.SelectItem(index)
		
		ScriptLog.Message("Buying item: " . index)
		;SimulateHumanLag()
		mousemove, 1450, 880, 100
		sendplay, {click}
		
		SimulateHumanLag()
		mousemove, 850, 780, 100
		sendplay, {click}
		
		sleep, 10000
		mousemove, 960, 460, 100
		sendplay, {click}		
	}
}

class EquipmentSearchPage {
	Close() {
		SimulateHumanLag()
		mousemove, 390, 230, 100
		sendplay, {click}
	}
	
	SetItemType(type) {
		ScriptLog.Message("Setting item type: " . type)
		SimulateHumanLag()
		mousemove, 630, 345, 100
		sendplay, {click}
		
		SimulateHumanLag()
		y := object("1-Hand", 390, "2-Hand", 420, "Off-Hand", 450, "Armor", 480, "Follower Special", 510)
		mousemove, 420, y[type], 100
		sendplay, {click}
	}
	
	SetMinItemLevel(level) {
		ScriptLog.Message("Setting item level: " . level)
		SimulateHumanLag()
		mousemove, 410, 450, 100
		sendplay, {click}
		
		SimulateHumanLag()
		sendplay, ^{a}
		SimulateHumanLag()
		sendplay, %level%
	}
	
	SetItemQuality(quality) {
		ScriptLog.Message("Setting item quality: " . quality)
		SimulateHumanLag()
		mousemove, 630, 450, 100
		sendplay, {click}
		
		SimulateHumanLag()
		y := object("All", 495, "Inferior", 525, "Normal", 555, "Superior", 585, "Magic", 615, "Rare", 645, "Legendary", 675)		
		mousemove, 550, y[quality], 100
		sendplay, {click}
	}
	
	SetMaxBuyOut(gold) {
		ScriptLog.Message("Setting buyout: " . gold)
		SimulateHumanLag()
		mousemove, 520, 530, 100
		sendplay, {click}

		SimulateHumanLag()	
		sendplay, ^{a}
		SimulateHumanLag()
		sendplay, %gold%
	}
	
	Search() {
		ScriptLog.Message("Searching for items...")
		SimulateHumanLag()
		mousemove, 520, 840, 100
		sendplay, {click}
		
		sleep 5000
		return new SearchResultPage()
	}
}

class AuctionHouseSearchPage {
	NavigateToEquipmentSearchPage() {
				SimulateHumanLag()

		mousemove, 515, 240, 100
		sendplay, {click}

		return new EquipmentSearchPage()
	}
	
	NavigateToGemsSearchPage() {
		SimulateHumanLag()		
		mousemove, 515, 290, 100
		sendplay, {click}
	}
	
	NavigateToCraftingAndDyesSearchPage() {
		SimulateHumanLag()		
		mousemove, 515, 350, 100
		sendplay, {click}
	}
	
	NavigateToPagesAndRecipesSearchPage() {
		SimulateHumanLag()		
		mousemove, 515, 405, 100
		sendplay, {click}
	}
}


class AuctionHousePage {
	Close() {
		SimulateHumanLag()		
		mousemove, 1580, 110, 100
		sendplay, {click}
	}
	
	NavigateToSearchPage() {
		SimulateHumanLag()
		mousemove, 630, 160, 100
		sendplay, {click}

		return new AuctionHouseSearchPage()
	}
}

class HeroPage {	
	NavigateToAuctionHouse() {
		SimulateHumanLag()
		mousemove, 230, 640, 100
		sendplay, {click}
		
		return new AuctionHousePage()
	}
}
