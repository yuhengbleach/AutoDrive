#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import logging
import logging.handlers

def initLog(log_path, log_name="av_gateway", level=logging.INFO, when="H", backup=7,
            format="%(asctime)s,%(levelname)s,[%(filename)s,%(funcName)s,%(lineno)d],%(message)s",
            datefmt="%Y%m%d %H:%M:%S"
            ):
    dir = os.path.dirname(log_path)
    if not os.path.isdir(dir):
        os.makedirs(dir)
    formatter = logging.Formatter(format, datefmt)
    logger = logging.getLogger(log_name)
    logger.setLevel(level)
    fh = logging.handlers.TimedRotatingFileHandler(log_path + ".log", when=when, backupCount=backup)
    fh.setLevel(level)
    fh.setFormatter(formatter)
    logger.addHandler(fh)
    
    fh2 = logging.handlers.TimedRotatingFileHandler(log_path + ".log.wf", when=when, backupCount=backup)
    fh2.setLevel(logging.WARNING)
    fh2.setFormatter(formatter)
    logger.addHandler(fh2)
    logger.info('StartLogging')
    return logger
