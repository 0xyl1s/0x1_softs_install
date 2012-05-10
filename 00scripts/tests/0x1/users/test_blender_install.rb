# encoding: utf-8
# tested with ruby 1.9.3

module X module Users
  require 'minitest/autorun'

  class TestBlenderInstall < MiniTest::Unit::TestCase
    require_relative '../../../lib/0x1/users/blender_install.rb'

    def setup
      @blender_install = BlenderInstall.new(%W[v263 linux_x86_64 true])
    end

    def test_run
      skip("first step...")
    end
  end

end end

# >>>>>  projet epiculture/ec1   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{{{
# Sources, Infos & Contact : http://www.epiculture.org
# Author: Pierre-Maël Crétinon
# License: GNU GPLv3 ( www.epiculture.org/ec1/LICENSE )
# Copyright: 2010-2012 Pierre-Maël Crétinon
# Sponsor: studio Helianova - http://studio.helianova.com
# ――――――――――――――――――――――――――――――――――――――#}}}
#vim: ft=ruby
