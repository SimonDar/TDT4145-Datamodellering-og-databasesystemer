from datetime import datetime
import time
 
# assigned regular string date
date_time = datetime.now()
 
# print regular python date&time
print("date_time =>",date_time.weekday())
 
# displaying unix timestamp after conversion
print("unix_timestamp => ",
      (time.mktime(date_time.timetuple())))