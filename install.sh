#! /bin/bash

RESULT_SUCCESS=0

function configure_bluetooth_serial_interface {
	echo 'configuring bluetooth serial interface'
	local bt_config_dir='/etc/systemd/system/bluetooth.target.wants'
	if [ ! -d $bt_config_dir ]; then
		echo 'Bluetooth configuration directory is not available'
		echo 'Check if Bluez is installed'
		return 1
	fi

	pushd $bt_config_dir
        #`pwd`

	local bt_config_file='./bluetooth.service'
	if [ ! -f $bt_config_file ]; then 
		echo 'Bluetooth config file is not available'
		echo 'check if Bluez is installed properly'
		return 1
	fi

	`cp bluetooth.service bluetooth.service.bak`
	echo 'created backup of bluetooth.service file'
	
	local execstart_setting=`grep 'ExecStart' bluetooth.service`
	echo "ExecStart setting found: $execstart_setting"
	#new_execstart_setting =
	
	popd
	#`pwd`
	return 0 
}

configure_bluetooth_serial_interface
result=$?

if (( result == RESULT_SUCCESS )); then 
	echo 'Bluetooth serial interface configured successfully'
fi