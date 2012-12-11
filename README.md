# megaraid-collectd

Braindead script to watch megaraid status.

Slap this in your collectd config:

```
Loadplugin exec

<Plugin exec>
  Exec "root:root" "/path/to/megaraid-collectd.pl"
</Plugin>
```
