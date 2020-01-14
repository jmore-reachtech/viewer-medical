the file settings.conf and the directory medical are loaded into /data/app on the target
vals.txt acts as the host microcontroller on the console port (ttymcx1 on the target, ttyXXX on your host)
-->  cat vals.txt > /dev/ttyUSB0
115200, N, 8, 1
