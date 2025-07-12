include $(TOPDIR)/rules.mk

PKG_NAME:=ipv6-check
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/ipv6-check
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=IPv6 auto check & restart wan6
  DEPENDS:=+ip-full +netifd
endef

define Package/ipv6-check/description
  Daemon that checks eth2 IPv6 status every 2 minutes and restarts wan6 if needed.
endef

define Build/Compile
endef

define Package/ipv6-check/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/ipv6-check $(1)/etc/init.d/ipv6-check

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/usr/bin/ipv6_check.sh $(1)/usr/bin/ipv6_check.sh
endef

$(eval $(call BuildPackage,ipv6-check))
