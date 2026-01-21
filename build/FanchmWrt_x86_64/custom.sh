#!/bin/bash

echo "🔄 清理旧 feeds..."
./scripts/feeds clean
echo "🔄 更新所有 feeds..."
./scripts/feeds update -a > /dev/null
echo "📥 安装所有 feeds（强制覆盖冲突项）..."
./scripts/feeds install -a -f > /dev/null
echo "📥 再次安装所有 feeds（确保完整）..."
./scripts/feeds install -a -f > /dev/null
echo "✅ feeds 更新与安装完成"

echo "📦 正在克隆第三方软件包"
git clone --depth=1 https://github.com/sirpdboy/luci-theme-kucat package/luci-theme-kucat > /dev/null 2>&1
git clone --depth=1 https://github.com/sirpdboy/luci-app-kucat-config package/luci-app-kucat-config > /dev/null 2>&1
git clone --depth=1 https://github.com/peditx/luci-theme-peditx package/luci-theme-peditx > /dev/null 2>&1
git clone --depth=1 https://github.com/gdy666/luci-app-lucky package/lucky > /dev/null 2>&1
git clone --depth=1 https://github.com/sirpdboy/luci-app-advancedplus package/luci-app-advancedplus > /dev/null 2>&1
git clone --depth=1 https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset > /dev/null 2>&1
git clone --depth=1 https://github.com/sbwml/luci-app-filemanager package/luci-app-filemanager > /dev/null 2>&1
git clone --depth=1 https://github.com/sirpdboy/luci-app-poweroffdevice package/luci-app-poweroffdevice > /dev/null 2>&1
git clone --depth=1 -b master https://github.com/x-wrt/com.x-wrt package/luci-app-xwan > /dev/null 2>&1

git clone --depth=1 -b main https://github.com/xztxy/small-package small-package-temp > /dev/null 2>&1
cp -r small-package-temp/luci-app-syncdial package/ 2>/dev/null
cp -r small-package-temp/nikki package/ 2>/dev/null
rm -rf small-package-temp
echo "✅ 第三方软件包克隆完成"

echo "🔄 安装第三方软件包..."
./scripts/feeds install luci-theme-kucat > /dev/null 2>&1
./scripts/feeds install luci-app-kucat-config > /dev/null 2>&1
./scripts/feeds install luci-theme-peditx > /dev/null 2>&1
./scripts/feeds install luci-app-lucky > /dev/null 2>&1
./scripts/feeds install luci-app-advancedplus > /dev/null 2>&1
./scripts/feeds install luci-app-autotimeset > /dev/null 2>&1
./scripts/feeds install luci-app-filemanager > /dev/null 2>&1
./scripts/feeds install luci-app-poweroffdevice > /dev/null 2>&1
./scripts/feeds install luci-app-xwan > /dev/null 2>&1
./scripts/feeds install luci-app-syncdial > /dev/null 2>&1
./scripts/feeds install luci-app-nikki > /dev/null 2>&1
echo "✅ 第三方软件包安装完成"

NET="package/base-files/luci2/bin/config_generate"
ZZZ="package/lean/default-settings/files/zzz-default-settings"

sed -i 's#192.168.1.1#192.168.15.1#g' $NET
sed -i "s/LEDE /Built on $(TZ=UTC-8 date "+%Y.%m.%d") @ LEDE /g" $ZZZ

sed -i 's#%D %V, %C#%D %V, %C FanchmWrt#g' package/base-files/files/etc/banner

cd $WORKPATH
touch ./.config

cat >> .config <<EOF
CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_x86_64_Generic=y
EOF

cat >> .config <<EOF
CONFIG_TARGET_KERNEL_PARTSIZE=32
CONFIG_TARGET_ROOTFS_PARTSIZE=512
EOF

cat >> .config <<EOF
CONFIG_TARGET_IMAGES_GZIP=y
EOF

cat >> .config <<EOF
CONFIG_EFI_IMAGES=y
EOF

cat >> .config <<EOF
CONFIG_OPENSSL_ENGINE=y
CONFIG_OPENSSL_OPTIMIZE_SPEED=y
CONFIG_OPENSSL_WITH_ASM=y
CONFIG_OPENSSL_WITH_CHACHA_POLY1305=y
CONFIG_OPENSSL_WITH_CMS=y
CONFIG_OPENSSL_WITH_DEPRECATED=y
CONFIG_OPENSSL_WITH_ERROR_MESSAGES=y
CONFIG_OPENSSL_WITH_IDEA=y
CONFIG_OPENSSL_WITH_MDC2=y
CONFIG_OPENSSL_WITH_PSK=y
CONFIG_OPENSSL_WITH_SEED=y
CONFIG_OPENSSL_WITH_SRP=y
CONFIG_OPENSSL_WITH_TLS13=y
CONFIG_OPENSSL_WITH_WHIRLPOOL=y
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_dnsmasq_full_dhcpv6=y
CONFIG_PACKAGE_ipv6helper=y
EOF

cat >> .config <<EOF
CONFIG_QCOW2_IMAGES=y
CONFIG_VHDX_IMAGES=y
CONFIG_VMDK_IMAGES=y
CONFIG_TARGET_IMAGES_PAD=y
CONFIG_TARGET_ROOTFS_TARGZ=y
CONFIG_TARGET_ROOTFS_EXT4FS=y
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_collectd=y
CONFIG_PACKAGE_collectd-mod-cpu=y
CONFIG_PACKAGE_collectd-mod-interface=y
CONFIG_PACKAGE_collectd-mod-iwinfo=y
CONFIG_PACKAGE_collectd-mod-load=y
CONFIG_PACKAGE_collectd-mod-memory=y
CONFIG_PACKAGE_collectd-mod-network=y
CONFIG_PACKAGE_collectd-mod-rrdtool=y
CONFIG_PACKAGE_rrdtool1=y
CONFIG_PACKAGE_librrd1=y
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_ip6tables-nft=y
CONFIG_PACKAGE_iptables-mod-conntrack-extra=y
CONFIG_PACKAGE_iptables-mod-ipopt=y
CONFIG_PACKAGE_iptables-nft=y
CONFIG_PACKAGE_kmod-ip6tables=y
CONFIG_PACKAGE_kmod-ipt-conntrack-extra=y
CONFIG_PACKAGE_kmod-ipt-ipopt=y
CONFIG_PACKAGE_kmod-mlx4-core=y
CONFIG_PACKAGE_kmod-mlx5-core=y
CONFIG_PACKAGE_kmod-mlxfw=y
CONFIG_PACKAGE_kmod-nf-conncount=y
CONFIG_PACKAGE_kmod-nf-ipt6=y
CONFIG_PACKAGE_kmod-nft-compat=y
CONFIG_PACKAGE_libiptext=y
CONFIG_PACKAGE_libiptext-nft=y
CONFIG_PACKAGE_libiptext6=y
CONFIG_PACKAGE_xtables-nft=y
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-poweroff=y
CONFIG_PACKAGE_luci-app-openclash=y
CONFIG_PACKAGE_luci-app-argon-config=y
CONFIG_PACKAGE_luci-app-design-config=y
CONFIG_PACKAGE_luci-app-filemanager=y
CONFIG_PACKAGE_luci-app-mwan3=y
CONFIG_PACKAGE_luci-app-statistics=y
CONFIG_PACKAGE_luci-app-ttyd=y
CONFIG_PACKAGE_luci-i18n-filemanager-zh-cn=y
CONFIG_PACKAGE_luci-i18n-mwan3-zh-cn=y
CONFIG_PACKAGE_luci-i18n-statistics-zh-cn=y
CONFIG_PACKAGE_luci-i18n-ttyd-zh-cn=y
CONFIG_PACKAGE_mwan3=y
CONFIG_PACKAGE_ttyd=y
CONFIG_PACKAGE_luci-app-lucky=y
CONFIG_PACKAGE_luci-i18n-lucky-zh-cn=y
CONFIG_PACKAGE_lucky=y
CONFIG_PACKAGE_luci-app-nikki=y
CONFIG_PACKAGE_luci-i18n-nikki-zh-cn=y
CONFIG_PACKAGE_nikki=y
CONFIG_PACKAGE_luci-app-syncdial=y
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-oaf=y
CONFIG_PACKAGE_luci-app-serverchan=n
CONFIG_PACKAGE_luci-app-eqos=n
CONFIG_PACKAGE_luci-app-control-weburl=n
CONFIG_PACKAGE_luci-app-smartdns=n
CONFIG_PACKAGE_luci-app-adguardhome=n
CONFIG_PACKAGE_luci-app-autotimeset=n
CONFIG_PACKAGE_luci-app-ddnsto=n
CONFIG_PACKAGE_ddnsto=n
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-ssr-plus=n
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_SagerNet_Core is not set
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-passwall=n
CONFIG_PACKAGE_luci-app-passwall2=n
CONFIG_PACKAGE_naiveproxy=n
CONFIG_PACKAGE_chinadns-ng=n
CONFIG_PACKAGE_brook=n
CONFIG_PACKAGE_trojan-go=n
CONFIG_PACKAGE_xray-plugin=n
CONFIG_PACKAGE_shadowsocks-rust-sslocal=n
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-turboacc=y
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-filebrowser=y
CONFIG_PACKAGE_luci-app-ddns=y
CONFIG_PACKAGE_luci-app-filetransfer=y
CONFIG_PACKAGE_luci-app-wolplus=y
CONFIG_PACKAGE_luci-app-diskman=y
CONFIG_PACKAGE_luci-app-wireguard=y
CONFIG_PACKAGE_luci-proto-wireguard=y
CONFIG_PACKAGE_luci-app-store=y
CONFIG_PACKAGE_luci-app-uhttpd=y
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-wol=n
CONFIG_PACKAGE_luci-app-gowebdav=n
CONFIG_PACKAGE_luci-app-accesscontrol=n
CONFIG_PACKAGE_luci-app-wrtbwmon=n
CONFIG_PACKAGE_luci-app-vlmcsd=n
CONFIG_PACKAGE_luci-app-arpbind=n
CONFIG_PACKAGE_luci-app-nlbwmon=n
CONFIG_PACKAGE_luci-app-sqm=n
CONFIG_PACKAGE_luci-app-dockerman=n
CONFIG_PACKAGE_luci-app-adbyby-plus=n
CONFIG_PACKAGE_luci-app-webadmin=n
CONFIG_PACKAGE_luci-app-autoreboot=n
CONFIG_PACKAGE_luci-app-upnp=y
CONFIG_PACKAGE_luci-app-nps=n
CONFIG_PACKAGE_luci-app-frpc=n
CONFIG_PACKAGE_luci-app-haproxy-tcp=n
CONFIG_PACKAGE_luci-app-transmission=n
CONFIG_PACKAGE_luci-app-qbittorrent=n
CONFIG_PACKAGE_luci-app-amule=n
CONFIG_PACKAGE_luci-app-xlnetacc=n
CONFIG_PACKAGE_luci-app-zerotier=n
CONFIG_PACKAGE_luci-app-hd-idle=n
CONFIG_PACKAGE_luci-app-unblockmusic=n
CONFIG_PACKAGE_luci-app-airplay2=n
CONFIG_PACKAGE_luci-app-music-remote-center=n
CONFIG_PACKAGE_luci-app-usb-printer=n
CONFIG_PACKAGE_luci-app-jd-dailybonus=n
CONFIG_PACKAGE_luci-app-uugamebooster=n
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-v2ray-server=n
CONFIG_PACKAGE_luci-app-pptp-server=n
CONFIG_PACKAGE_luci-app-ipsec-vpnd=n
CONFIG_PACKAGE_luci-app-openvpn-server=n
CONFIG_PACKAGE_luci-app-softethervpn=n
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-samba4=y
CONFIG_PACKAGE_samba4-server=y
CONFIG_PACKAGE_samba4-libs=y
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-minidlna=n
CONFIG_PACKAGE_luci-app-vsftpd=n
CONFIG_PACKAGE_luci-app-ksmbd=n
CONFIG_PACKAGE_luci-app-samba=n
CONFIG_PACKAGE_autosamba=n
CONFIG_PACKAGE_samba36-server=n
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_luci-theme-argon=y
CONFIG_PACKAGE_luci-theme-design=y
CONFIG_PACKAGE_luci-theme-kucat=y
CONFIG_PACKAGE_luci-theme-peditx=y
CONFIG_PACKAGE_luci-theme-edge=n
CONFIG_PACKAGE_luci-app-kucat-config=y
CONFIG_PACKAGE_luci-i18n-kucat-config-zh-cn=y
EOF

cat >> .config <<EOF
CONFIG_PACKAGE_firewall4=y
CONFIG_PACKAGE_firewall=n
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_htop=y
CONFIG_PACKAGE_nano=y
CONFIG_PACKAGE_wget=y
CONFIG_PACKAGE_bash=y
CONFIG_PACKAGE_kmod-tun=y
CONFIG_PACKAGE_snmpd=y
CONFIG_PACKAGE_libcap=y
CONFIG_PACKAGE_libcap-bin=y
CONFIG_PACKAGE_ip6tables-mod-nat=y
CONFIG_PACKAGE_iptables-mod-extra=y
CONFIG_PACKAGE_vsftpd=y
CONFIG_PACKAGE_vsftpd-alt=n
CONFIG_PACKAGE_openssh-sftp-server=y
CONFIG_PACKAGE_qemu-ga=y
CONFIG_PACKAGE_autocore-x86=y
CONFIG_PACKAGE_kmod-fuse=y
CONFIG_PACKAGE_vim=y
CONFIG_PACKAGE_libncurses=y
CONFIG_PACKAGE_libopenssl=y
CONFIG_PACKAGE_libuv=y
CONFIG_PACKAGE_libwebsockets-full=y
CONFIG_PACKAGE_terminfo=y
CONFIG_PACKAGE_libltdl=y
EOF

cat >> .config <<EOF
CONFIG_HAS_FPU=y
CONFIG_PACKAGE_lvm2=y
CONFIG_PACKAGE_kmod-dm=y
CONFIG_PACKAGE_libdevmapper=y
EOF

sed -i 's/^[ \t]*//g' ./.config

cd $HOME
