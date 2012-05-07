# encoding: utf-8
# tested with ruby 1.9.3

module X module Users
  require_relative '../0x1_lib.helper.rb'

  class BlenderInstall

    def initialize(a_argv)
      x__load_modules([:standard, :online])
      blender_install_data_load()
      arguments_process(a_argv)
      install_process()
    end

    private

    def arguments_process(a_args)
      abort usage() if a_args.join == 'help'
      case a_args.size
      when 0
        versions = list_versions()
        @version = x__select_item(versions, "blender version? ")
        platforms = list_platforms(@version)
        @platform = x__select_item(platforms, "platform? ")
      when 2
        arg1 = ARGV[0].to_sym
        arg2 = ARGV[1].to_sym
        if list_versions().include?(arg1)
          @version = arg1
        else
          abort "E: arg1 (#{arg1}) is not a valid version "+
            "(#{list_versions().join(' ')})"
        end
        available_platforms = list_platforms(@version)
        if available_platforms.include?(arg2)
          @platform = arg2
        else
          abort "E: arg2 (#{arg2}) is not a valid platform for version "+
            "#{@version} (#{available_platforms.join(' ')})"
        end
      else
        abort "E: please provide 2 arguments (version / platform)"
      end
    end

    def blender_install_data_load()
      data_path_rel = '../../../data/0x1/install/blender_install.json'
      data_path_abs = File.join(File.dirname(__FILE__), data_path_rel)
      @blender_install_data = x__json_read(data_path_abs, true)
    end

    def usage()
      usage_path_rel = '../../../data/0x1/install/blender_usage'
      usage_path_abs = File.join(File.dirname(__FILE__), usage_path_rel)
      x__file_read(usage_path_abs)
    end

    def list_versions()
      @blender_install_data.keys
    end

    def list_platforms(l_version)
      @blender_install_data[l_version].keys
    end

    def install_process()
      uri_raw = @blender_install_data[@version][@platform][0]
      uri = x__parse_uri(uri_raw)
      downloaded_filename = x__filename_from_parsed_uri(uri)
      downloaded_file_extension = '.tar.bz2'
      downloaded_basename = File.basename(downloaded_filename,
                                          downloaded_file_extension)
      installed_path = "#{Dir.home}/.0x1/00mu/00sourcing/0x1_softs_installed"
      install_path = "#{installed_path}/blender/"+
        "#{@version}/#{@platform}/00install"
      x__abort_if_is_a_dir(install_path, true)

      puts "I: starting installation: blender #{@version} for #{@platform} ..."

      x__abort_unless_mkdir_p(install_path, true)
      soft_downloaded_path = "#{install_path}/#{downloaded_filename}"
      downloaded_content = x__http_download(uri)
      x__abort_unless_file_write(downloaded_content,
                                 soft_downloaded_path, true)

      downloaded_file = x__file_read(soft_downloaded_path)

      digest_source = @blender_install_data[@version][@platform][1]
      digest_checked = x__digest_create(downloaded_file)
      x__abort_unless_digest_checked(digest_source, digest_checked, true)
      puts "I: verified dowloaded #{downloaded_filename} digest: done !"

      soft_extract_dir_path = "#{installed_path}/blender/"+
        "#{@version}/#{@platform}/00install/#{downloaded_basename}"
      x__abort_if_is_a_dir(soft_extract_dir_path, true)

      x__abort_unless_extract_tarbz2(soft_downloaded_path, install_path, true)

      soft_installed_dir_path = "#{installed_path}/blender/"+
        "#{@version}/#{@platform}/00installed"
      x__abort_if_is_a_dir(soft_installed_dir_path, true)
      x__abort_unless_dir_move(soft_extract_dir_path,
                               soft_installed_dir_path, true)

      soft_executable_path = "#{soft_installed_dir_path}/blender"
      symlink = "blender_#{@version}_#{@platform}"
      installed_bin_path = "#{installed_path}/00bin"
      soft_executable_symlink = "#{installed_bin_path}/#{symlink}"
      x__abort_unless_symlink_create(soft_executable_path,
                                     soft_executable_symlink, true)

      x__abort_unless_chdir(installed_bin_path)
      x__abort_unless_symlink_create(symlink, "blender", true)
      puts "I: installed: blender #{@version} for #{@platform} ..."
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
