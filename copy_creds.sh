#!/bin/bash

DB_NAME=torque
sed -i "s/\$db_host = '.*';/\$db_host = '$DB_HOST';/g" $1
sed -i "s/\$db_user = '.*';/\$db_user = '$DB_USER';/g" $1
sed -i "s/\$db_pass = '.*';/\$db_pass = '$DB_PASS';/g" $1
sed -i "s/\$db_name = '.*';/\$db_name = '$DB_NAME';/g" $1
sed -i "s/\$torque_id = '.*';/\$torque_id = '$TORQUE_ID';/g" $1
sed -i "s/\$gmapsApiKey = '.*';/\$gmapsApiKey = '$GMAPS_API_KEY';/g" $1

if [[ $AUTH_USERS ]] && [[ $AUTH_PASSWORDS ]]; then
	userArr=( ${AUTH_USERS//;/ } )
	passArr=( ${AUTH_PASSWORDS//;/ } )
	if [ ${#userArr[@]} -ne ${#passArr[@]} ]; then
		echo "Number of items in AUTH_USERS does not match the number of items in AUTH_PASSWORDS"
		exit 1
	fi

	for (( i=0; i<${#userArr[@]}; i++ )); do
		sed -i "/$users = array();/ a \$users[] = array('user' => '${userArr[$i]}', 'pass' => '${passArr[$i]}');" $1
	done
fi


if [ "$USE_FAHRENHEIT" == "true" ]; then
	sed -i "s/\$source_is_fahrenheit = .*;/\$source_is_fahrenheit = true;/g" $1
	sed -i "s/\$use_fahrenheit = .*;/\$use_fahrenheit = true;/g" $1
fi

if [ "$USE_MILES" == "true" ]; then
	sed -i "s/\$source_is_miles = .*;/\$source_is_miles = true;/g" $1
	sed -i "s/\$use_miles = .*/\$use_miles = true;/g" $1
fi

if [[ $HIDE_EMPTY_VARIABLES ]]; then
	sed -i "s/\$hide_empty_variables = .*;/\$hide_empty_variables = $HIDE_EMPTY_VARIABLES;/g" $1
fi
if [[ $SHOW_SESSION_LENGTH ]]; then
	sed -i "s/\$show_session_length = .*;/\$show_session_length = $SHOW_SESSION_LENGTH;/g" $1
fi
if [[ $MIN_SESSION_SIZE ]]; then
	sed -i "s/\$min_session_size = .*;/\$min_session_size = $MIN_SESSION_SIZE;/g" $1
fi