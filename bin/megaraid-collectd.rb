#!/usr/bin/env ruby
lib = File.expand_path('../../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require 'rubygems'
require 'megaraid-collectd'

checker = Megaraid::Collectd::Check.new
checker.run
