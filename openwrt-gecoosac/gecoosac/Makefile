include $(TOPDIR)/rules.mk

PKG_NAME:=gecoosac
PKG_VERSION:=2.2.20251015
PKG_RELEASE:=1

# 根据架构选择核心文件名
ifeq ($(ARCH),aarch64)
  PKG_ARCH:=ac_linux_arm64
else ifeq ($(ARCH),arm)
  PKG_ARCH:=ac_linux_arm
else ifeq ($(ARCH),mips)
  PKG_ARCH:=ac_linux_mips
else ifeq ($(ARCH),mipsel)
  PKG_ARCH:=ac_linux_mipsle
else ifeq ($(ARCH),i386)
  PKG_ARCH:=ac_linux_386
else ifeq ($(ARCH),x86_64)
  PKG_ARCH:=ac_linux_amd64
else
  PKG_ARCH:=unsupported
endif

# 绝对路径指向 gecoosac-core 目录
PKG_CORE_DIR:=$(TOPDIR)/feeds/GPackages/openwrt-gecoosac/gecoosac-core

PKG_LICENSE:=AGPL-3.0-only
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=lwb1978 <lwb1978@gmail.com>

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=gecoosac server (version $(PKG_VERSION))
  URL:=http://www.cnrouter.com/
  DEPENDS:=@(aarch64||arm||i386||mips||mipsel||x86_64)
endef

# 跳过下载/解压，直接从 gecoosac-core 复制二进制
define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) $(PKG_CORE_DIR)/$(PKG_ARCH) $(PKG_BUILD_DIR)/$(PKG_NAME)
	chmod +x $(PKG_BUILD_DIR)/$(PKG_NAME)
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/bin
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
