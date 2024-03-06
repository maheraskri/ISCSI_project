#!/bin/bash 

# Install the targetcli package
dnf install targetcli -y 

targetcli  << EOF
cd /backstores/block
create dev=/dev/vdb name=lun0

cd /iscsi/
create wwn=iqn.2023-10.lab.askri:target 

cd /iscsi/iqn.2023-10.lab.askri:target/tpg1/luns
create /backstores/block/lun0

cd ../acls/
create wwn=iqn.2023-10.lab.askri:client

cd /iscsi/iqn.2023-10.lab.askri:target/tpg1/portals
delete 0.0.0.0 3260
create ip_address=10.1.1.100 ip_port=3260

cd /iscsi/iqn.2023-10.lab.askri:target/tpg1/
set auth userid=meher password=test1234

EOF

