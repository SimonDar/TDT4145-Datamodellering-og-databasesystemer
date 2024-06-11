from datetime import datetime
import argparse
import time

parser = argparse.ArgumentParser()
parser.add_argument('--start', type=int, required=True) #Send in en unix tid
args = parser.parse_args()

start_value = args.start

print(dagToUnix[row[1][2]].value)


date_time = datetime.now()

unix = (time.mktime(date_time.timetuple()))

back_to_date = datetime.fromtimestamp(unix)

Season['AUTUMN'].value