# Copyright 2023 Yurii Ivanov <yivanov00@gmail.com>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="Ethereum miner program user"
ACCT_USER_ID=600
ACCT_USER_HOME=/var/lib/etminer
ACCT_USER_GROUPS=( ethminer )

acct-user_add_deps
