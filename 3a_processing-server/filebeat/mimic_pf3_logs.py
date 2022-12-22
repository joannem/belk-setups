#!/usr/bin/python3

'''
Writes continuous pf3-like logs to pf3.log.<timestamp>.
'''

import sys
import time
import signal
import random
import logging
import logging.handlers

LOG_FILEPATH = "sample-logs/pf3.log"

class GracefulKiller:
    kill_now = False
    def __init__(self):
        signal.signal(signal.SIGINT, self.exit_gracefully)
        signal.signal(signal.SIGTERM, self.exit_gracefully)
    def exit_gracefully(self, *args):
        self.kill_now = True

def log_setup():

    logger = logging.getLogger()
    logger.setLevel(logging.DEBUG)

    file_log_handler = logging.handlers.TimedRotatingFileHandler(
        LOG_FILEPATH, when='M', backupCount=5)
    file_log_handler.setFormatter(logging.Formatter('%(created)d %(levelname)s %(message)s'))
    logger.addHandler(file_log_handler)

    stdout_log_handler = logging.StreamHandler(sys.stdout)
    stdout_log_handler.setFormatter(logging.Formatter('%(created)d %(levelname)s %(message)s'))
    logger.addHandler(stdout_log_handler)

if __name__ == '__main__':

    killer = GracefulKiller()

    log_setup()

    stats = {
        'imiss': [0, 0], 'nombuf': [0, 0], 'qdrop': [0, 0, 0, 0],
        'omiss': 0, 'oqdrop': 0, 'cap': 0, 'xdrop': [0, 0, 0]
    }

    prev_delta = {
        'imiss': [0, 0], 'nombuf': [0, 0], 'qdrop': [0, 0, 0, 0],
        'omiss': 0, 'oqdrop': 0, 'xdrop': [0, 0, 0]
    }

    while not killer.kill_now:

        logging.info('port0 some other stuff here imiss %u (%u/s) rx_nombuf %u (%u/s)' % (
            stats['imiss'][0], prev_delta['imiss'][0], stats['nombuf'][0], prev_delta['nombuf'][0]))
        logging.info('port1 some other stuff here imiss %u (%u/s) rx_nombuf %u (%u/s)' % (
            stats['imiss'][1], prev_delta['imiss'][1], stats['nombuf'][1], prev_delta['nombuf'][1]))
        logging.info('rx0 some stuff here qdrop %u (%u/s)' % (
            stats['qdrop'][0], prev_delta['qdrop'][0]))
        logging.info('rx1 some stuff here qdrop %u (%u/s)' % (
            stats['qdrop'][1], prev_delta['qdrop'][1]))
        logging.info('rx2 some stuff here qdrop %u (%u/s)' % (
            stats['qdrop'][2], prev_delta['qdrop'][2]))
        logging.info('rx3 some stuff here qdrop %u (%u/s)' % (
            stats['qdrop'][3], prev_delta['qdrop'][3]))
        logging.info('port3 some other stuff here omiss %u (%u/s)' % (
            stats['omiss'], prev_delta['omiss']))
        logging.info('tx0 some stuff here oqdrop %u (%u/s)' % (
            stats['oqdrop'], prev_delta['oqdrop']))
        logging.info(
            '55.5uu 12.0 us cap %u Mb/s fdrop %u (%u/s) rdrop %u (%u/s) ldrop %u (%u/s)' % (
            stats['cap'],
            stats['xdrop'][0], prev_delta['xdrop'][0],
            stats['xdrop'][1], prev_delta['xdrop'][1],
            stats['xdrop'][2], prev_delta['xdrop'][2]))

        prev_delta['imiss'][0] = random.randrange(0, 1020, 7)
        stats['imiss'][0] += prev_delta['imiss'][0]
        prev_delta['imiss'][1] = random.randrange(0, 2020, 4)
        stats['imiss'][1] += prev_delta['imiss'][1]
        prev_delta['nombuf'][0] = random.randrange(0, 10, 4)
        stats['nombuf'][0] += prev_delta['nombuf'][0]
        prev_delta['nombuf'][1] = random.randrange(0, 15, 7)
        stats['nombuf'][1] += prev_delta['nombuf'][1]

        prev_delta['qdrop'][0] = random.randrange(0, 20000, 1007)
        stats['qdrop'][0] += prev_delta['qdrop'][0]
        prev_delta['qdrop'][1] = random.randrange(100, 1000, 12)
        stats['qdrop'][1] += prev_delta['qdrop'][1]
        prev_delta['qdrop'][2] = random.randrange(2000, 30000, 1007)
        stats['qdrop'][2] += prev_delta['qdrop'][2]
        prev_delta['qdrop'][3] = random.randrange(0, 10000, 1007)
        stats['qdrop'][3] += prev_delta['qdrop'][3]

        prev_delta['omiss'] = random.randrange(0, 10)
        stats['omiss'] += prev_delta['omiss']
        prev_delta['oqdrop'] = random.randrange(0, 10)
        stats['oqdrop'] += prev_delta['oqdrop']

        stats['cap']  = random.randrange(30000, 67000, 123)

        prev_delta['xdrop'][0] = random.choice([0, 0, 0, 3])
        stats['xdrop'][0] += prev_delta['xdrop'][0]
        prev_delta['xdrop'][1] = random.choice([0, 0, 0, 3])
        stats['xdrop'][1] += prev_delta['xdrop'][1]
        prev_delta['xdrop'][2] = random.choice([0, 0, 0, 3])
        stats['xdrop'][2] += prev_delta['xdrop'][2]

        time.sleep(3)

    print("===\nEnd of the program. I was killed gracefully :)")
