# encoding: utf-8
# tested with ruby 1.9.2

module Ec1 module Installs
require 'ec1/lib/toolkit/standard.rb'
include Ec1::Lib::Toolkit::Standard
require 'ec1/lib/toolkit/online.rb'
include Ec1::Lib::Toolkit::Online

########################### >>>> Ec1_lib
########################### <<<< Ec1_lib

class Blender

def initialize
end

def install_261_linux_x86_64

  #uri_raw = "http://ip.helianova.com/index.shtml"
  uri_raw = "http://download.blender.org/release/Blender2.61/blender-2.61-linux-glibc27-x86_64.tar.bz2"
  
  uri = e__parse_uri(uri_raw)
  abort "ERROR verifying dowloaded blender_261_linux_x86_64 digest!" unless download_content = e__http_download(uri)
  puts "downloading blender_261_linux_x86_64: done!"

  mu_softs_installed_path = "#{ENV['HOME']}/.ec1/00mu/00sourcing/ec1_softs_installed"
  soft_downloaded_dir_path = "#{mu_softs_installed_path}/blender/2.61/linux_x86_64/00install"
  abort "ERROR: #{soft_downloaded_dir_path} directory exists already" if e__is_a_dir?(soft_downloaded_dir_path)
  abort "ERROR: can't create directory #{soft_downloaded_dir_path}" unless e__mkdir_p(soft_downloaded_dir_path)
  soft_downloaded_path = "#{soft_downloaded_dir_path}/blender-2.61-linux-glibc27-x86_64.tar.bz2"
  abort "ERROR: can't write file #{soft_downloaded_path}" unless e__file_write(download_content, soft_downloaded_path)
  abort "ERROR: can't read downloaded file #{soft_downloaded_path}" unless check_digest = e__file_read(soft_downloaded_path)
  abort "ERROR verifying dowloaded blender_261_linux_x86_64 digest!" unless e__digest_create(check_digest) == '6b42d76da83a07e64695920e1163f70264ed67ee156f79b0786c97f927fde0e4'
  puts "verified dowloaded blender_261_linux_x86_64 digest: done !"
  soft_extract_dir_path = "#{mu_softs_installed_path}/blender/2.61/linux_x86_64/00install/blender-2.61-linux-glibc27-x86_64"
  abort "ERROR: extract path #{soft_extract_dir_path} exists already" if e__is_a_dir?(soft_extract_dir_path)
  abort "ERROR: can't extract #{soft_downloaded_path} on #{soft_installed_dir_path}" unless system "tar jxvf #{soft_downloaded_path} -C #{soft_downloaded_dir_path}"
  soft_installed_dir_path = "#{mu_softs_installed_path}/blender/2.61/linux_x86_64/00installed"
  abort "ERROR: #{soft_installed_dir_path} directory exists already" if e__is_a_dir?(soft_installed_dir_path)
  abort "ERROR: can't move #{soft_extract_dir_path} to #{soft_installed_dir_path}" unless e__dir_move(soft_extract_dir_path, soft_installed_dir_path)
  soft_executable_path = "#{soft_installed_dir_path}/blender"
  soft_executable_symlink = "#{mu_softs_installed_path}/00bin/blender2.61_linux_x86_64"
  abort "ERROR: can't create symlink #{soft_executable_symlink} pointing to #{soft_executable_path}" unless e__symlink_create(soft_executable_path, soft_executable_symlink)

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
#vim: foldmethod=marker
