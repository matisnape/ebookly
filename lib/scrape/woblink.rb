require 'capybara'
require 'capybara/dsl'
require 'capybara/minitest'

module Scrape
  class Woblink
    include Capybara::DSL

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
      @purchased_books = []
      @books_to_sync = []
    end

    def run!
      login
      go_to_shelf
      list_all_books
      check_against_database
      save_books_to_database(@books_to_sync)
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
      items = doc.css('.shelf-book')
      # collect books & authors
      items.each do |item|
        title = item.css("h3").text
        author = item.css('.author a').children.map(&:text).first
        @purchased_books << {
          title: title,
          author_attributes: {
            first_name:         # the rest without last name
            last_name:          # last word separated by space
          }
        }
      end
      puts "Number of books on shelf: #{@purchased_books.size}"
    end

    def check_against_database
      shop = Shop.find_by(name: "Woblink")
      db_books = shop.books

      puts "Number of books in database: #{db_books.count}"
      if @purchased_books.count == db_books.count
        return "No new books available"
      end

      synced_books = []
      db_books.each do |db_book|
        synced_books << {
          title: db_book.title,
          author_attributes: {
            first_name: db_book.author.first_name
            last_name: db_book.author.last_name
          }
        }
      end

      @books_to_sync = @purchased_books - synced_books

      missing_authors = @books_to_sync.map{ |bk| bk[:author]}.uniq
      existing_authors = Author.all.pluck(:first_name, :last_name)
      existing_authors2 = []
      existing_authors.each do |aut|
        existing_authors2 << "#{aut[0]} #{aut[1]}"
      end
      authors_to_add = (missing_authors - existing_authors2).compact

      # create missing authors in database

      @books_to_sync.each do |book|
        # here create the books
      end

    end

    def create_missing_authors

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
