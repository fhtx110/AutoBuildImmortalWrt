#!/bin/bash

# 1. 强力解锁 USB 3.0 (移除所有 MediaTek 设备的 U3 禁用掩码)
find target/linux/mediatek/ -name "*.dts*" | xargs sed -i 's/mediatek,u3p-dis-msk = <0x01>/mediatek,u3p-dis-msk = <0x00>/g'

# 2. 修改默认 IP 为你要求的 192.168.66.1
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# 3. 强制开启硬件加速 (PPE) 默认开关，确保 5G 转发不卡 CPU
sed -i 's/p->hw_flow_offload = false/p->hw_flow_offload = true/g' package/network/config/firewall/files/firewall.config
sed -i 's/p->hw_flow_offload = '\''0'\''/p->hw_flow_offload = '\''1'\''/g' package/network/config/firewall/files/firewall.config
