#!/bin/bash

# 1. 解锁 USB 3.0 掩码 (适用于所有 MediaTek 7981 固件)
find target/linux/mediatek/ -name "*.dts*" | xargs sed -i 's/mediatek,u3p-dis-msk = <0x01>/mediatek,u3p-dis-msk = <0x00>/g'

# 2. 修改默认网关 IP 为 192.168.66.1
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# 3. 开启流量分载 (HW NAT) 默认开关
sed -i 's/p->hw_flow_offload = false/p->hw_flow_offload = true/g' package/network/config/firewall/files/firewall.config

# 4. (可选) 增加对 RM520N 更友好的固件名称后缀
sed -i "s/OpenWrt /Nradio-C8-5G-USB3-$(date +%Y%m%d) /g" package/base-files/files/etc/banner
