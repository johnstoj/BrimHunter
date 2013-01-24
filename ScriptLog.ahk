#Warn All
#Warn UseUnsetGlobal, off
#NoEnv

ScriptLog := new ScriptLog()

class ScriptLog {
	static instance
	static logfile
	static history := []

	__New() {
		if !this.instance {
			this.instance := this

			global AHK_SCRIPT_LOG, AHK_SCRIPT_LOG_OVERWRITE
			if (AHK_SCRIPT_LOG = "") {
				stringsplit, scriptname, A_ScriptName, "."
				AHK_SCRIPT_LOG := scriptname1 . ".log"
			}

			;msgbox % AHK_SCRIPT_LOG
			this.logfile := AHK_SCRIPT_LOG

			if (AHK_SCRIPT_LOG_OVERWRITE = "" or AHK_SCRIPT_LOG_OVERWRITE = true) {
				if (fileexist(this.logfile)) {  
					FileDelete % this.logfile
					if (errorlevel <> 0) {
						throw "Can't delete log file " . this.logfile
					}
				}
				
			}
		}

		return this.instance
	}

	__Delete() {
	}

	GetLogFilePath() {
		return this.logfile
	}

	GetMessageHistory(message = "", historydepth = 5) {
		if (message != "") {
			if (this.history.maxindex() = historydepth)
				this.history.remove(1)
			
			this.history.insert(message)
		}
			
		buffer := ""
		loop % this.history.maxindex() {
			buffer .= this.history[a_index]
		}
		
		return buffer
	}

	Message(msg) {
		callstack := exception("", -1, 0)
		scriptfilepath := callstack.file
		splitpath, scriptfilepath, scriptfile
		formattime, timestamp, , dd-MM-yyyy HH:mm:ss
		message := "`n" . timestamp . " " . scriptfile . ":" . callstack.line . " " . msg
				
		tooltip, % this.GetMessageHistory(message), 0, 0
		FileAppend %message%, % this.logfile
	}

}
