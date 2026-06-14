#!/bin/bash

SECRETS_DIR="secrets"

init_secret() {
	FILE="$1"
	LABEL="$2"

	if [ ! -f "${SECRETS_DIR}/${FILE}" ]; then
		while true; do
			printf "%s: " "${LABEL}"
			read -s PASS1
			echo

			printf "Confirm %s: " "${LABEL}"
			read -s PASS2
			echo

			if [ -z "${PASS1}" ]; then
				echo "Password cannot be empty"
			elif [ "${PASS1}" != "${PASS2}" ]; then
				echo "Passwords do not match"
			else
				printf "%s" "${PASS1}" > "${SECRETS_DIR}/${FILE}"
				echo "Created ${FILE}"
				break
			fi
		done
	else
		echo "${FILE} already exists"
	fi
}

init_secret "db_pwd.txt" "Database user password"
init_secret "db_root_pwd.txt" "Database root password"
init_secret "wp_user_pwd.txt" "WordPress user password"
init_secret "wp_admin_pwd.txt" "WordPress admin password"