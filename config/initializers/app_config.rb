require 'yaml'
require 'ostruct'

config_defaults = {
  'hw_daemon' => {
    'port' => 7767,
    'timeout' => 15 * 60, # 15 minutes
  },
  'os_templates' => {
    'mirror' => {
      'protocol' => 'ftp',
      'host' => 'download.openvz.org',
      'path' => '/template/',
    },
    'passive_ftp' => true,
  },
  'backups' => {
    'allow_for_users' => true,
  },
  'updates' => {
    'disabled' => false,
    'period' => 3 * 24 * 60 * 60, # 3 days
    'url' => 'http://ovz-web-panel.googlecode.com/svn/installer/updates/info.xml'
  },
  'log' => {
    'max_records' => 1000
  },
  'tasks' => {
    'max_records' => 100
  },
  'branding' => {
    'show_version' => true,
  },
  'vzctl' => {
    'save_descriptions' => false,
  },
  'help' => {
    'enabled' => true, # completely enable/disable Help section in left-side Menu
    'admin_doc_url' => 'http://code.google.com/p/ovz-web-panel/wiki/AdminGuide',
    'user_doc_url' => 'http://code.google.com/p/ovz-web-panel/wiki/UserGuide',
    'support_url' => 'http://code.google.com/p/ovz-web-panel/wiki/Support',
  },
  'requests' => {
    'enabled' => true, # completely enable/disable Requests section in left-side Menu
  },
  'extjs' => {
    'cdn' => {
      'enabled' => false,
      'base_url' => 'http://extjs.cachefly.net/ext-3.1.0',
    }
  },
  'locale' => {
    'default' => 'en',
    'single' => false,
  },
  'ldap' => {
    'enabled' => false,
    'host' => 'example.com',
    'login_pattern' => 'uid=<login>,ou=people,dc=example,dc=com',
  },
  'email' => {
    'from' => '',
  },
  'base_url' => '',
  'ip_restriction' => {
    'admin_ips' => '',
  },
  'mobile' => {
    'special_ui' => true,
  },
  'virtual_servers' => {
    # any IP addresses are allowed if this option is set to FALSE
    # or if there's no IP pools defined
    'allow_ips_only_from_pools' => true,
  }
}

def hashes2ostruct(object)
  r = case object
  when Hash
    object = object.clone
    object.each do |key, value|
      object[key] = hashes2ostruct(value)
    end
    OpenStruct.new(object)
  when Array
    object.map{ |x| hashes2ostruct(x) }
  else
    object
  end
  r.freeze unless Rails.env.test?
  r
end

config_file_name = "#{Rails.root}/config/config.yml"
config = File.exist?(config_file_name) ? (YAML.load_file(config_file_name) || {}) : {}
OWP.const_set 'CONFIG', hashes2ostruct(config_defaults.deep_merge(config))

module OWP
  class << self
    def config
      CONFIG
    end
  end
end

ActionController::Base.relative_url_root = OWP.config.base_url
