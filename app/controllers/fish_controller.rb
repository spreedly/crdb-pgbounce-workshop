class FishController < ApplicationController
    def index
        sleep(0.25)
        # long query in sql 10% of the time
        longquery = rand(100) > 90
        sql = "SELECT pg_sleep(3)"
        if longquery
            ActiveRecord::Base.connection.execute(sql)
            @fishes = []
        else
            @fishes = Fish.all
        end
    end
end
