from datetime import datetime
import argparse
import time
 
# assigned regular string date
date_time = datetime.now()
unix = (time.mktime(date_time.timetuple()))
 
# print regular python date&time
print("date_time =>",unix)
 
# displaying unix timestamp after conversion
print("unix_timestamp => ", datetime.fromtimestamp(unix).weekday())
print(datetime.utcfromtimestamp(unix).strftime('%Y-%m-%d %H:%M:%S'))





