class PagesController < ApplicationController
    #each of these is an action that automatically brings up a corresponding view. it also passes in the @title variable which is used in the erb layout
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
