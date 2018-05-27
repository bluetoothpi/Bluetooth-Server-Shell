all:
	install_bluez
	install_pybluez clean

install_bluez:
	echo 'Installing Bluez'
	sudo apt-get update
	sudo apt-get install libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev -y
	wget http://www.kernel.org/pub/linux/bluetooth/bluez-5.49.tar.xz
	tar xvf bluez-5.49.tar.xz
	cd bluez-5.49; \
	./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc --lo
	make -j4; \
	sudo make install
	restart_bluetooth

restart_bluetooth:
	sudo systemctl daemon-reload
	sleep 3
	sudo systemctl stop bluetooth
	sleep 3
	sudo systemctl start bluetooth
	sleep 3
	sudo sdptool add SP
	sleep 3
	sudo hciconfig hci0 piscan
	sleep 3
	
install_pybluez:
	git clone https://github.com/pybluez/pybluez.git
	sudo apt-get install -y bluetooth libbluetooth-dev
	cd pybluez; sudo python setup.py install

clean:
	sudo rm -rf pybluez
	sudo rm -rf bluez-5.49


#Bluez installation instructions
#https://scribles.net/updating-bluez-on-raspberry-pi-5-43-to-5-48/

