# rpz_from_cert.pl
hole.cert.pl CERT.PL Response Policy Zones (RPZ)

The script downloads from [CERT.PL](https://www.cert.pl/ostrzezenia_phishing) a
list of blocked sites in the "/etc/hosts" file format and rewrites it in the
RPZ format. The script should be called every 5-10 minutes by the cron. The
output file can be hosted locally, for example on the intranet web server, and
utilized by local DNS resolving servers. RPZ is supported, inter alia by BIND,
Unbound, and other DNS daemons.

### Sample Unbound configuration

```
rpz:
   name: "rpz.hole.cert.pl"
   url: "https://your.hosting.server/hole.cert.pl.zone"
   zonefile: "zones/hole.cert.pl.zone"
   rpz-log: yes
   rpz-log-name: RPZ
```
