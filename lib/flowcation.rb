require 'nokogiri'
require 'fileutils'
require 'yaml'
require 'active_support/concern'
require 'active_support/inflector'

require "flowcation/version"
require "flowcation/registry"
require "flowcation/callbacks"
require "flowcation/settings"
require "flowcation/file_writer"
require "flowcation/runtime"
require 'flowcation/block'
require 'flowcation/substitution'
require 'flowcation/substitutions'
require 'flowcation/layout'
require 'flowcation/template'
require 'flowcation/partial'
require 'flowcation/render'
require 'flowcation/overwrite_exception'
require 'flowcation/block_not_found_exception'
require 'flowcation/substitution_not_found_exception'
require 'flowcation/assets'
require 'flowcation/layout_helper'

module Flowcation
  DEFAULT_GENERATED_TEXT = "GENERATED_BY_FLOWCATION"
  DEFAULT_COMMENT = "<!-- ::comment:: -->"
  def self.generate(config)
    Flowcation::Settings.from_config(config['flowcation'])
    Flowcation::Assets.from_config(config['assets'])
    Flowcation::Assets.from_config(config['files'])

    Flowcation::Runtime.register_layouts_from_config(config['layouts'])
    Flowcation::Runtime.register_templates_from_config(config['templates'])
    Flowcation::Runtime.register_partial_from_config(config['partials'])
  end
end
