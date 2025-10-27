#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=adguardhome
PKG_VERSION:=0.107.67
PKG_RELEASE:=1

PKG_SOURCE:=AdGuardHome-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/AdguardTeam/AdGuardHome/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=0d74004fd17c8f185174fa09deb130ad48e2f46e946eb9fa8c66ce186d2af9cf

PKG_BUILD_DIR:=$(BUILD_DIR)/AdGuardHome-$(PKG_VERSION)

PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE.txt
PKG_MAINTAINER:=AdGuardHome Team

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=no-mips16

GO_PKG:=github.com/AdguardTeam/AdGuardHome
GO_PKG_BUILD_PKG:=$(GO_PKG)
GO_PKG_LDFLAGS:=-w -s
GO_PKG_LDFLAGS_X:=\
	main.version=v$(PKG_VERSION) \
	main.channel=release \
	main.buildTime=$(shell date -d @$(SOURCE_DATE_EPOCH) +%FT%TZ%z) \
	main.goArm=$(GO_ARM) \
	main.goMips=$(GO_MIPS)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/adguardhome
  SECTION:=net
  CATEGORY:=Network
  TITLE:=AdGuardHome DNS Filtering Server
  URL:=https://github.com/AdguardTeam/AdGuardHome
  DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
endef

define Package/adguardhome/description
  Network-wide ads & trackers blocking DNS server
endef

ADGUARD_FRONTEND_FILE:=AdGuardHome_frontend.tar.gz
define Download/adguardhome-frontend
  URL:=https://github.com/AdguardTeam/AdGuardHome/releases/download/v$(PKG_VERSION)/
  FILE:=$(ADGUARD_FRONTEND_FILE)
  HASH:=8709396e05f812f3e2085a64074384b6363fe1871b9bbb7e8f9886c1aa64b579
endef

define Build/Prepare
	echo "Extracting core source package..."; \
	$(TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf "$(DL_DIR)/$(PKG_SOURCE)"
	
	if [ -f "$(DL_DIR)/$(ADGUARD_FRONTEND_FILE)" ]; then \
		echo "Processing frontend resources..."; \
		\
		$(TAR) -C $(PKG_BUILD_DIR) -xzf "$(DL_DIR)/$(ADGUARD_FRONTEND_FILE)"; \
		\
		find $(PKG_BUILD_DIR) -maxdepth 3 -type f -name "index.html" | head -1 | while read nested_index; do \
			nested_dir=$$(dirname "$$nested_index"); \
			parent_dir=$$(dirname "$$nested_dir"); \
			\
			if [ "$$parent_dir" != "$(PKG_BUILD_DIR)" ]; then \
				if [ -d "$$nested_dir/static" ] || [ -f "$$nested_dir/favicon.ico" ]; then \
					echo "Promoting frontend from nested directory: $$nested_dir"; \
					mv "$$nested_dir"/* $(PKG_BUILD_DIR)/ 2>/dev/null || true; \
					rm -rf "$$nested_dir"; \
				fi \
			fi \
		done; \
		\
		echo "Frontend processing completed"; \
	else \
		echo "Warning: Frontend package not found at $(DL_DIR)/$(ADGUARD_FRONTEND_FILE)"; \
	fi
	
	echo "Verifying build directory structure..."; \
	echo "=== Core files ==="; \
	if [ -f "$(PKG_BUILD_DIR)/main.go" ]; then \
		echo "✓ main.go found"; \
	else \
		echo "✗ main.go missing"; exit 1; \
	fi; \
	if [ -f "$(PKG_BUILD_DIR)/go.mod" ]; then \
		echo "✓ go.mod found"; \
	else \
		echo "✗ go.mod missing"; exit 1; \
	fi; \
	\
	echo "=== Frontend files ==="; \
	if [ -f "$(PKG_BUILD_DIR)/index.html" ]; then \
		echo "✓ index.html found"; \
	else \
		echo "⚠ index.html missing"; \
	fi; \
	if [ -d "$(PKG_BUILD_DIR)/static" ]; then \
		echo "✓ static directory found"; \
		ls $(PKG_BUILD_DIR)/static/ | head -5 | while read line; do echo "  - $$line"; done; \
	else \
		echo "⚠ static directory missing"; \
	fi; \
	\
	echo "=== Top-level files ==="; \
	ls -la $(PKG_BUILD_DIR)/ | grep -E "(\.go$|\.html$|^static$|^build$)" | head -10; \
	echo "Build directory preparation completed successfully"
endef

define Package/adguardhome/install
	$(call GoPackage/Package/Install/Bin,$(1))
endef

$(eval $(call Download,adguardhome-frontend))
$(eval $(call GoBinPackage,adguardhome))
$(eval $(call BuildPackage,adguardhome))
