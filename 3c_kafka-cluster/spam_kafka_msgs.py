#!/usr/bin/python3

import signal
import time
from kafka import KafkaProducer
from kafka.errors import KafkaError


k_msg = '%s,"999",%s,123456123,11:22:33:44:55:aa,'\
    'mission_a,mission_a_rule_1,10.5.5.1,10.5.5.2,8080,10041,"pcap",3,15'


producer = KafkaProducer(bootstrap_servers=['localhost:9092'])

class GracefulKiller:
    kill_now = False
    def __init__(self):
        signal.signal(signal.SIGINT, self.exit_gracefully)
        signal.signal(signal.SIGTERM, self.exit_gracefully)

    def exit_gracefully(self, *args):
        self.kill_now = True

if __name__ == '__main__':
    killer = GracefulKiller()

    while not killer.kill_now:
        time.sleep(0.5)
        print(k_msg % (round(time.time()), round(time.time())))
        future = producer.send('test_missiona_pf3_hit_stats',
            (k_msg % (round(time.time()), round(time.time())))
            .encode())

    print("End of the program. I was killed gracefully :)")
