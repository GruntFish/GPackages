#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=adguardhome
PKG_VERSION:=0.107.67
PKG_RELEASE:=1

PKG_MAINTAINER:=Dobroslaw Kijowski <dobo90@gmail.com>, George Sapkin <george@sapk.in>
PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE.txt

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

# 根据架构设置下载的二进制文件
ifeq ($(ARCH),aarch64)
  AGH_ARCH:=arm64
else ifeq ($(ARCH),arm)
  AGH_ARCH:=armv7
else ifeq ($(ARCH),x86_64)
  AGH_ARCH:=amd64
else ifeq ($(ARCH),mipsel)
  AGH_ARCH:=mipsle-softfloat
else ifeq ($(ARCH),mips)
  AGH_ARCH:=mips-softfloat
else
  AGH_ARCH:=$(ARCH)
endif

PKG_SOURCE_URL:=https://github.com/AdguardTeam/AdGuardHome/releases/download/v$(PKG_VERSION)/
PKG_SOURCE:=AdGuardHome_linux_$(AGH_ARCH).tar.gz
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/adguardhome
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Network-wide ads and trackers blocking DNS server
  URL:=https://github.com/AdguardTeam/AdGuardHome
  DEPENDS:=+ca-bundle
  USERID:=adguardhome=853:adguardhome=853
endef

define Package/adguardhome/description
Free and open source, powerful network-wide ads and trackers blocking DNS server.
endef

define Package/adguardhome/conffiles
/etc/AdGuardHome.yaml
/etc/config/AdGuardHome
endef

define Build/Prepare
        mkdir -p $(PKG_BUILD_DIR)
        $(TAR) -C $(PKG_BUILD_DIR) -xzf $(DL_DIR)/$(PKG_SOURCE) --strip-components=1
endef

define Build/Compile
        # 预编译二进制，无需编译
endef

define Package/adguardhome/install
        $(INSTALL_DIR) $(1)/usr/bin
        $(INSTALL_BIN) $(PKG_BUILD_DIR)/AdGuardHome $(1)/usr/bin/AdGuardHome

        $(INSTALL_DIR) $(1)/etc/config
        $(INSTALL_CONF) ./files/adguardhome.config $(1)/etc/config/AdGuardHome

        # $(INSTALL_DIR) $(1)/etc/init.d
        # $(INSTALL_BIN) ./files/AdGuardHome.init $(1)/etc/init.d/AdGuardHome

        $(INSTALL_DIR) $(1)/etc/AdGuardHome
        $(INSTALL_CONF) $(PKG_BUILD_DIR)/AdGuardHome.yaml $(1)/etc/AdGuardHome/AdGuardHome.yaml

        $(INSTALL_DIR) $(1)/etc/capabilities
        $(INSTALL_CONF) ./files/adguardhome.json $(1)/etc/capabilities/adguardhome.json
endef

$(eval $(call BuildPackage,adguardhome))