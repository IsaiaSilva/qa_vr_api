require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec/matchers'
require 'selenium-webdriver'

require "cucumber"
require "httparty"
require "httparty/request"
require "httparty/response/headers"
require "rspec"

require_relative 'helper.rb'

World(Capybara::DSL)
World(Capybara::RSpecMatchers)

HEADLESS = ENV['HEADLESS']
ENVIRONMENT_TYPE = ENV['ENVIRONMENT_TYPE']

CONFIG = YAML.load_file(File.dirname(__FILE__) + "/data/#{ENVIRONMENT_TYPE}.yml")
#puts CONFIG

## Configuração do Selenium Browser
Capybara.register_driver :selenium do |app|
    if HEADLESS.eql?('sem_headless')
        Capybara::Selenium::Driver.new(
            app,
            browser: :chrome, 
            desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
                'chromeOptions' => { 'args' => ['--disable-infobars', 'windows-size=1600,1024'] }
            )
        )
        elsif HEADLESS.eql?('com_headless')
            Capybara::Selenium::Driver.new(
                app,
                browser: :chrome,     
                desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
                    'chromeOptions' => { 'args' => ['headless',
                                                    '--disable-infobars', 
                                                    'disable-gpu',
                                                    'windows-size=1600,1024'] }
                )
            )
        elsif HEADLESS.eql?('firefox')
            Capybara::Selenium::Driver.new(app,browser: :firefox, marionette: true)
    end
end

Capybara.configure do |config|
    config.default_driver = :selenium
    config.default_max_wait_time = 10
    config.app_host = CONFIG['url_padrao']
end

# Keeps the tests independent by closing the browser and opening for each test scenario
After do  
    Capybara.current_session.driver.quit  
end