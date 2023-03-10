#!/bin/bash

rclone --verbose --config ../src/rclone.conf copy --progress --no-traverse remote:ssh/backup/ssh.tar /home/abhishek/.