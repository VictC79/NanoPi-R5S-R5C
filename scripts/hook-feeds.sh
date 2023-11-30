#!/bin/bash
#=================================================
# File name: hook-feeds.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================
# Svn checkout packages from immortalwrt's repository

pushd customfeeds

# Add luci-app-eqos
svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-eqos luci/applications/luci-app-eqos

# Add luci-proto-modemmanager
svn co https://github.com/immortalwrt/luci/trunk/protocols/luci-proto-modemmanager luci/protocols/luci-proto-modemmanager

# Add luci-app-gowebdav
svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-gowebdav luci/applications/luci-app-gowebdav
svn co https://github.com/immortalwrt/packages/trunk/net/gowebdav packages/net/gowebdav

# Add tmate
git clone --depth=1 https://github.com/immortalwrt/openwrt-tmate

# Add gotop
svn co https://github.com/immortalwrt/packages/branches/openwrt-18.06/admin/gotop packages/admin/gotop

# Add minieap
svn co https://github.com/immortalwrt/packages/trunk/net/minieap packages/net/minieap

# passwall vssr bypass
svn co https://github.com/kenzok8/trunk/small/chinadns-ng packages/net/chinadns-ng
svn co https://github.com/kenzok8/trunk/small/dns2socks packages/net/dns2socks
svn co https://github.com/kenzok8/trunk/small/dns2tcp packages/net/dns2tcp
svn co https://github.com/kenzok8/trunk/small/microsocks packages/net/microsocks
svn co https://github.com/kenzok8/trunk/small/tcping packages/net/tcping
svn co https://github.com/kenzok8/trunk/small/brook packages/net/brook
svn co https://github.com/kenzok8/trunk/small/hysteria packages/net/hysteria
svn co https://github.com/kenzok8/trunk/small/naiveproxy packages/net/naiveproxy
svn co https://github.com/kenzok8/trunk/small/shadowsocks-rust-sslocal packages/net/shadowsocks-rust-sslocal
svn co https://github.com/kenzok8/trunk/small/shadowsocks-rust-ssserver packages/net/shadowsocks-rust-ssserver
svn co https://github.com/kenzok8/trunk/small/shadowsocksr-libev-ssr-local packages/net/shadowsocksr-libev-ssr-local
svn co https://github.com/kenzok8/trunk/small/shadowsocksr-libev-ssr-redir packages/net/shadowsocksr-libev-ssr-redir
svn co https://github.com/kenzok8/trunk/small/shadowsocksr-libev-ssr-server packages/net/shadowsocksr-libev-ssr-server
svn co https://github.com/kenzok8/trunk/small/simple-obfs packages/net/simple-obfs
svn co https://github.com/kenzok8/trunk/small/sing-box packages/net/sing-box
svn co https://github.com/kenzok8/trunk/small/trojan-go packages/net/trojan-go
svn co https://github.com/kenzok8/trunk/small/trojan-plus packages/net/trojan-plus
svn co https://github.com/kenzok8/trunk/small/v2ray-plugin packages/net/v2ray-plugin
svn co https://github.com/kenzok8/trunk/small/xray-core packages/net/xray-core
svn co https://github.com/kenzok8/trunk/small/xray-plugin packages/net/xray-plugin
svn co https://github.com/kenzok8/trunk/small/tuic-client packages/net/tuic-client





# Replace smartdns with the official version
rm -rf packages/net/smartdns
svn co https://github.com/openwrt/packages/trunk/net/smartdns packages/net/smartdns
popd

# Set to local feeds
pushd customfeeds/packages
export packages_feed="$(pwd)"
popd
pushd customfeeds/luci
export luci_feed="$(pwd)"
popd
sed -i '/src-git packages/d' feeds.conf.default
echo "src-link packages $packages_feed" >> feeds.conf.default
sed -i '/src-git luci/d' feeds.conf.default
echo "src-link luci $luci_feed" >> feeds.conf.default

# Update feeds
./scripts/feeds update -a
