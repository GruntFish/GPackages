-- Copyright (C) 2021-2022  sirpdboy  <herboy2008@gmail.com> https://github.com/sirpdboy/luci-app-lucky 
-- Licensed to the public under the Apache License 2.0.

local SYS  = require "luci.sys"

module("luci.controller.lucky", package.seeall)

function index()
	local e=entry({"admin", "services", "lucky"}, alias("admin", "services", "lucky", "setting"),_("Lucky"), 57)
	e.dependent=false
	e.acl_depends={ "luci-app-lucky" }
	entry({"admin", "services", "lucky", "setting"}, cbi("lucky"), _("Base Setting"), 20).leaf=true
end
