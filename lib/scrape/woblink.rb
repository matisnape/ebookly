require 'selenium-webdriver'
require 'capybara'
require 'capybara/dsl'
require 'capybara/minitest'
require 'nokogiri'
require 'json'
require 'byebug'
ENV['RAILS_ENV'] ||= 'production'
require_relative '../../config/environment'

module Scrape
  class Woblink
    include Capybara::DSL
    include Capybara::Minitest::Assertions

    attr_accessor :assertions

    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, browser: :chrome)
    end
    Capybara.javascript_driver = :chrome
    Capybara.configure do |config|
      config.default_max_wait_time = 5
      config.default_driver = :selenium
    end

    def initialize()
      @login = Rails.application.credentials.woblink[:login]
      @password = Rails.application.credentials.woblink[:password]
      self.assertions = 0
      @books = []
    end

    def run!
      login
      go_to_shelf
      list_all_books
      check_against_database
    end

    private

    def login
      visit 'https://woblink.com/logowanie'
      if page.find("#nw_popup_zamknij")
        page.find("#nw_popup_zamknij").click
      end
      if page.find("#onesignal-popover-cancel-button")
        page.find("#onesignal-popover-cancel-button").click
      end
      within 'form#login-form' do
        fill_in 'Adres email', with: @login
        fill_in 'Hasło', with: @password
      end
      click_button 'ZALOGUJ SIĘ'
    end

    def go_to_shelf
      visit 'https://woblink.com/profile/moja-polka?per_page=999'
      page.find("button[title='Zmień na widok listy']").click
      page.find("#shelf-filters-sort").assert_text "SORTUJ WG: Data zakupu"
      page.find("#shelf-filters-pagination").assert_text "POKAŻ: Wszystkie"
    end

    def list_all_books
      doc = Nokogiri::HTML(page.html)
      byebug



    end

    def check_against_database
    end

    def save_to_db(book)
    end

    def save_books_to_database(arr)
      arr.each do |book|
        save_to_db(book)
      end
    end

  end
end
