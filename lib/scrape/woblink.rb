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
      create_missing_authors
      save_books_to_database
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
        first_author = item.css('.author a').children.map(&:text).first
        if first_author.nil?
          author = "autor zbiorowy".split(' ')
        else
          author = first_author.split(' ')
        end
        @purchased_books << {
          title: title,
          author_attributes: {
            first_name: author[0..-2].join(' '),   # the rest without last name
            last_name: author.last                 # last word separated by space
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
      # list books already in database
      synced_books = []
      db_books.each do |db_book|
        synced_books << {
          title: db_book.title,
          author_attributes: {
            first_name: db_book.author.first_name,
            last_name: db_book.author.last_name
          }
        }
      end
      @books_to_sync = @purchased_books - synced_books
    end

    def create_missing_authors
      missing_authors = @books_to_sync.map{ |bk| bk[:author_attributes]}.uniq
      existing_authors = Author.all.pluck(:first_name, :last_name)

      authors_to_add = missing_authors - existing_authors
      puts "Authors to create: #{authors_to_add.count}"

      # create missing authors in database
      authors_to_add.each do |person|
        Author.create(first_name: person[:first_name], last_name: person[:last_name])
        puts "Created: #{person[:first_name]} #{person[:last_name]}"
      end
    end

    def save_to_db(book)
      binding.pry

    end

    def save_books_to_database
      @books_to_sync.each do |book|
        save_to_db(book)
      end
    end

  end
end
