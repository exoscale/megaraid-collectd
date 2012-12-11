# megaraid-collectd

Braindead script to watch megaraid status.
This script makes three assumptions:

* the megaclisas-status command is available
* the sudo command is available
* the user under which you will run it has sudo access to megaclisas-status

Slap this in your collectd config:

```
Loadplugin exec

<Plugin exec>
  Exec "user:group" "/path/to/megaraid-collectd.pl"
</Plugin>
```
