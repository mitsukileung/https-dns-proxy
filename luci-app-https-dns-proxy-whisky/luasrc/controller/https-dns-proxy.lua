
module("luci.controller.https-dns-proxy", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/https-dns-proxy") then
		return
	end
	entry({"admin","services", "https-dns-proxy"}, cbi("https-dns-proxy"), _("HTTPS DNS Proxy")).dependent=false
	entry({"admin","services","https-dns-proxy","act_status"},call("act_status")).leaf=true
end

function act_status()
  local e={}
  e.running=luci.sys.call("ps -w | grep https-dns-proxy | grep -v grep >/dev/null")==0
  luci.http.prepare_content("application/json")
  luci.http.write_json(e)
end
