#Warn All
#Warn UseUnsetGlobal, off

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

