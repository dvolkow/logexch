#!/bin/bash

APP_NAME="logexch"
APP_USER="logexch"

INSTALL_DIR="/srv/${APP_NAME}"
SYSTEMD_DIR="/etc/systemd/system"

if ! id "${APP_USER}" &>/dev/null; then
    sudo useradd -r -s /sbin/nologin "${APP_USER}"
fi

mkdir -p "${INSTALL_DIR}" /etc/logexch /var/log/logexch

tar -xzf "logexch_prod.tar.gz" -C "${INSTALL_DIR}"
rm "logexch_prod.tar.gz"

sudo chown -R "${APP_USER}:${APP_USER}" "${INSTALL_DIR}"
sudo chown -R "${APP_USER}:${APP_USER}" /var/log/logexch
sudo chmod 755 /var/log/logexch

cp "logexch.service" "${SYSTEMD_DIR}/"
systemctl daemon-reload
