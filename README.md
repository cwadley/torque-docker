# torque-docker
Implements the Torque data upload app from surfrock66/torque as a Docker container.

## Building
Simply run docker build -t .

## Usage
The container exposes port 80. This can be mapped to any port on the host machine.

You must have a running instance of MySQL or MariaDB accessible by this container. You must also create a database named `torque`, and a user with write access to that database. For more information on how to do this, see the [readme for surfrock66/torque here.](https://github.com/surfrock66/torque)
Settings for the Torque upload server in creds.php are set using the following environment variables:
*(required)*
* DB_HOST - Address of the MySQL database
* DB_USER - MySQL database user for Torque to use
* DB_PASS - MySQL database password
(note: DB_NAME is statically defined as `torque`. You must provide a database with this name.)
*(optional)*
* GMAPS_API_KEY - API key you should create for Google Maps at [https://cloud.google.com/maps-platform/](https://cloud.google.com/maps-platform/). This is required if you want to use the mapping functionality in the viewer UI
* AUTH_USERS - List of usernames, separated by `;`, to be used to log into the server (ex. `user1;user2;user3`)
* AUTH_PASSWORDS - List of passwords, separated by `;`, matching the usernames defined in AUTH_USERS (ex. `pass1;pass2;pass3`)
* TORQUE_ID - Torque ID number from the Torque app (used to limit uploads to a single device)
* USE_FAHRENHEIT - (default: `false`) If `true`, sets $source_is_fahrenheit and $use_fahrenheit to true
* USE_MILES - (default: `false`) If `true`, sets $source_is_miles and $use_miles to true
* HIDE_EMPTY_VARIABLES - (default: `true`) Sets $hide_empty_variables
* SHOW_SESSION_LENGTH - (default: `true`) Sets $show_session_length
* MIN_SESSION_SIZE - (default: `20`) Sessions shorter than this many seconds will be hidden

### Example
```
docker run -d -p 8000:80 \
	-e DB_HOST=localhost \
	-e DB_USER=torque \
	-e DB_PASS=woahdude \
	-e GMAPS_API_KEY=123456789abcdefghi \
	-e AUTH_USERS='merry;pippin' \
	-e AUTH_PASSWORDS='oldtoby5;secondbreakfast1' \
	-e TORQUE_ID=012345678901234 \
	-e USE_FAHRENHEIT=true \
	-e USE_MILES=true \
	--name torque \
	cwadley/torque-docker
```

### Docker-Compose Example
The provided docker-compose.yaml file provides an example in which a MariaDB container is spun up along side the Torque container and acts as the database for the app. The database data is stored in the Docker-managed volume `torque-data`.

If using this file, you should edit the accompanying .env file with the environment variable settings you wish to use.
```
docker-compose up -d
```