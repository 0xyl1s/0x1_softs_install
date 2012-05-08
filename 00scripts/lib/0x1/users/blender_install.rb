# encoding: utf-8
# tested with ruby 1.9.3
# test >> ../../../tests/0x1/users/blender_install.rb

module X module Users
  require_relative '../0x1_lib.helper.rb'

  class BlenderInstall

    def initialize(a_argv)
      x__load_modules([:standard, :online])
      @usage_path_rel = '../../../data/0x1/users/blender_install_usage'
      @data_path_rel = '../../../data/0x1/users/blender_install_data.json'
      @soft_name = 'blender'
      soft_install_data_load()
      arguments_process(a_argv)
      run()
    end

    private

    def usage()
      usage_path_abs = x__abort_unless_rel_abs_path(__FILE__, @usage_path_rel)
      x__file_read(usage_path_abs)
    end

    def arguments_process(a_args)
      abort usage() if a_args.join == 'help'
      case a_args.size
      when 0
        versions = list_versions()
        @version = x__select_item(versions, "#{@soft_name} version? ")
        platforms = list_platforms(@version)
        @platform = x__select_item(platforms, "platform? ")
        @overwrite_symlink = x__confirm("\nOverwrite #{@soft_name} symlink"+
                                        " if needed (y/n)? ")
      when 3
        arg1 = ARGV[0].to_sym
        if list_versions().include?(arg1)
          @version = arg1
        else
          abort "E: arg1 (#{arg1}) is not a valid version "+
            "(#{list_versions().join(' ')})"
        end
        arg2 = ARGV[1].to_sym
        available_platforms = list_platforms(@version)
        if available_platforms.include?(arg2)
          @platform = arg2
        else
          abort "E: arg2 (#{arg2}) is not a valid platform for version "+
            "#{@version} (#{available_platforms.join(' ')})"
        end
        arg3 = ARGV[2]
        if arg3 == 'true'
          @overwrite_symlink = true
        elsif arg3 == 'false'
          @overwrite_symlink = false
        else
          abort "E: overwrite_symlink must be true or false (#{arg3})."
        end
      else
        abort "E: please provide 3 arguments (version / platform /"+
          " overwrite_symlink)"
      end
    end

    def soft_install_data_load()
      data_path_abs = x__abort_unless_rel_abs_path(__FILE__, @data_path_rel)
      @soft_install_data = x__json_read(data_path_abs, true)
    end

    def list_versions()
      @soft_install_data.keys
    end

    def list_platforms(l_version)
      @soft_install_data[l_version].keys
    end

    def run()
      @soft_ver_name = "#{@soft_name}_#{@version}_#{@platform}"
      @soft_ver_path = "#{@soft_name}/#{@version}/#{@platform}"
      @uri_raw = @soft_install_data[@version][@platform][0]
      @digest_type = @soft_install_data[@version][@platform][1]
      @digest_source = @soft_install_data[@version][@platform][2]

      uri = x__parse_uri(@uri_raw)
      downloaded_filename = x__filename_from_parsed_uri(uri)
      downloaded_file_extension = '.tar.bz2'
      downloaded_basename = File.basename(downloaded_filename,
                                          downloaded_file_extension)

      installed_path = "#{Dir.home}/.0x1/00mu/00sourcing/0x1_softs_installed"
      install_path = "#{installed_path}/#{@soft_ver_path}/00install"
      x__abort_if_is_a_dir(install_path, true)
      soft_downloaded_path = "#{install_path}/#{downloaded_filename}"
      soft_extract_dir_path = "#{installed_path}/#{@soft_ver_path}/"+
      "00install/#{downloaded_basename}"
      x__abort_if_is_a_dir(soft_extract_dir_path, true)
      soft_installed_dir_path = "#{installed_path}/#{@soft_ver_path}"+
      "/00installed"
      x__abort_if_is_a_dir(soft_installed_dir_path, true)
      soft_executable_path = "#{soft_installed_dir_path}/#{@soft_name}"
      installed_bin_path = "#{installed_path}/00bin"
      soft_executable_symlink = "#{installed_bin_path}/#{@soft_ver_name}"

      puts "I: starting installation: #{@soft_name} #{@version} for "+
      "#{@platform}..."

      x__abort_unless_mkdir_p(install_path, true)

      x__abort_unless_download_file_check_digest(@uri_raw,
                                                 downloaded_filename,
                                                 install_path,
                                                 @digest_type,
                                                 @digest_source,
                                                 true)

      x__abort_unless_extract_tarbz2(soft_downloaded_path, install_path, true)

      x__abort_unless_dir_move(soft_extract_dir_path,
                               soft_installed_dir_path, true)

      x__abort_unless_symlink_create(soft_executable_path,
                                     soft_executable_symlink, true)

      x__abort_unless_chdir(installed_bin_path)

      if x__is_a_symlink?(@soft_name) and @overwrite_symlink
        x__abort_unless_symlink_delete(@soft_name, true)
      end
      unless x__is_a_symlink?(@soft_name)
        x__abort_unless_symlink_create(@soft_ver_name, @soft_name, true)
      end

      puts "\nI: installed: #{@soft_name} #{@version} for #{@platform} ..."
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
