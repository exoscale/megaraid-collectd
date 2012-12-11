# Megaraid::Collectd

Simple gem which provides a long-running process
to help collectd graph megaraid status.

This relies on the command `megaclisas-status` being
available

## Installation

Install it yourself as:

    $ gem install megaraid-collectd

## Usage

Drop the following in your collectd configuration:

```
<Plugin exec>
  Exec "root:root" "megaraid-collectd.rb"
</Plugin>
```
