#Warn All
#Warn UseUnsetGlobal, off
#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.

ScriptLog := new ScriptLog()

class ScriptLog {
	static instance
	static logfile

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

	Message(msg) {
		callstack := exception("", -1, 0)
		formattime, timestamp, , dd-MM-yyyy HH:mm:ss
		message := "`n" . timestamp . " " . callstack.file . ":" . callstack.line . " " . msg
		tooltip, %message%, 0, 0
		FileAppend %message%, % this.logfile
	}



}
