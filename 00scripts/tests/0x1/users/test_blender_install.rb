# encoding: utf-8
# tested with ruby 1.9.3

module X module Users
  require 'minitest/autorun'

  class TestBlenderInstall < MiniTest::Unit::TestCase
    require_relative '../../../lib/0x1/users/blender_install.rb'

    def setup
      @blender_install = BlenderInstall.new("v263", "linux_x86_64", "true")
    end

    def test_initialize
      skip("first step...")
    end

    def test_usage
      skip("first step...")
    end

    def test_arguments_process
      skip("first step...")
    end

    def test_soft_install_data_load
      skip("first step...")
    end

    def test_list_versions
      skip("first step...")
    end

    def test_list_platforms
      skip("first step...")
    end

    def test_run
      skip("first step...")
    end
  end

end end

# Project infos >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>># {{{
# Project: Epiculture
# Author: Pierre-Mael Cretinon
# Email: projects2011@3eclipses.com
# License: GNU GPLv3
#
# Notes:
#
# License details:
# <copyright/copyleft>
# Copyright 2010-2011 (c) Pierre-Mael CRETINON <copyleft@pierremael.net>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 
# </copyright/copyleft>
# Project infos <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<# }}}
#vim: ft=ruby
