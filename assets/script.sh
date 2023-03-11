#!/bin/bash

rclone --verbose --config ../src/rclone.conf copy --progress --no-traverse remote:ssh/backup/ssh.tar /home/abhishek/.
tar xvf ssh.tar
mv ssh .ssh
chmod 0400 .ssh/id_rsa

/bin/zsh