class PagesController < ApplicationController
    def home
        @title = "Crucial Music | Home"
    end
    def about
        @title = "Crucial Music | About"
    end
    def faq
        @title = "Crucial Music | FAQ"
    end
end
