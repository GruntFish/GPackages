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

ifeq ($(ARCH),aarch64)
  AGH_ARCH:=arm64
  PKG_HASH:=564263ad884e020009b6175914f1de993e13c47ae6f45fa591e7bb9d29d6dea5
else ifeq ($(ARCH),arm)
  AGH_ARCH:=armv7
  PKG_HASH:=9daf97873fcd0ac479e8e610d6fc13256e7d4480f8332020b0c5056665577766
else ifeq ($(ARCH),x86_64)
  AGH_ARCH:=amd64
  PKG_HASH:=0413be8bc00d1b04ff29f33f47e7915e65424620ffa7644c146b7424809bf875
else ifeq ($(ARCH),mipsel)
  AGH_ARCH:=mipsle_softfloat
  PKG_HASH:=612ae44490e8513f147d4847a606ce551e3b8092896b825b183425b5b9af470c
else ifeq ($(ARCH),mips)
  AGH_ARCH:=mips_softfloat
  PKG_HASH:=b96bc511ecd00f7a3ded55ca479c4be04c58e37389984425e3e118f93495f964
else
  AGH_ARCH:=$(ARCH)
  PKG_HASH:=skip
endif

PKG_SOURCE_URL:=https://github.com/AdguardTeam/AdGuardHome/releases/download/v$(PKG_VERSION)/
PKG_SOURCE:=AdGuardHome_linux_$(AGH_ARCH).tar.gz

include $(INCLUDE_DIR)/package.mk

define Package/adguardhome
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Network-wide ads and trackers blocking DNS server
  URL:=https://github.com/AdguardTeam/AdGuardHome
  DEPENDS:=+ca-bundle
endef

define Package/adguardhome/description
Free and open source, powerful network-wide ads and trackers blocking DNS server.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(TAR) -C $(PKG_BUILD_DIR) -xzf $(DL_DIR)/$(PKG_SOURCE)
	mv $(PKG_BUILD_DIR)/AdGuardHome/* $(PKG_BUILD_DIR)/
	rm -rf $(PKG_BUILD_DIR)/AdGuardHome
endef

define Build/Compile

endef

define Package/adguardhome/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/AdGuardHome $(1)/usr/bin/AdGuardHome
endef

$(eval $(call BuildPackage,adguardhome))
