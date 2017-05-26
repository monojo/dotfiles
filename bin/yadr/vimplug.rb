require 'fileutils'

module Vimplug
    @vimplug_path = File.expand_path File.join(ENV['HOME'], '.vim', 'myplug.plug')
  def self.add_plugin_to_vimplug(plugin_repo)
    return if contains_vimplug? plugin_repo

    plugs = plug_from_file
    last_bundle_dir = plugs.rindex{ |line| line =~ /^Plug / }
    last_bundle_dir = last_bundle_dir ? last_bundle_dir+1 : 0
    plugs.insert last_bundle_dir, "Plug \'#{plugin_repo}\'"
    write_plugs_to_file plugs
  end

  def self.remove_plugin_from_vundle(plugin_repo)
    plugs = plug_from_file
    deleted_value = plugs.reject!{ |line| line =~ /Plug '#{plugin_repo}'/ }

    write_plugs_to_file plugs

    !deleted_value.nil?
  end

  def self.plug_list
    plug_from_file.select{ |line| line =~ /^Plug .*/ }.map{ |line| line.gsub(/Plug "(.*)"/, '\1')}
  end

  def self.update_plug
    system "vim --noplugin -u #{ENV['HOME']}/.vim/vimplug.vim -N \"+set hidden\" \"+syntax on\" +PlugClean! +PlugInstall +qall"
  end

  def self.update_no_clean_plug
      system "vim --noplugin -u #{ENV['HOME']}/.vim/vimplug.vim -N \"+set hidden\" \"+syntax on\" +PlugInstall +qall"
  end

  private
  def self.contains_vimplug?(plug_name)
    FileUtils.touch(@vimplug_path) unless File.exists? @vimplug_path
    File.read(@vimplug_path).include?(plug_name)
  end

  def self.plug_from_file
    FileUtils.touch(@vimplug_path) unless File.exists? @vimplug_path
    File.read(@vimplug_path).split("\n")
  end

  def self.write_plugs_to_file(plugs)
    FileUtils.cp(@vimplug_path, "#{@vimplug_path}.bak")
    vundle_file = File.open(@vimplug_path, "w")
    vundle_file.write(plugs.join("\n"))
    vundle_file.close
  end
end
