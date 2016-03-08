#!/usr/bin/env ruby
require 'rubygems'
require 'gollum/app'

# Add in commit user/email
class Precious::App
    before do
        session['gollum.author'] = {
            :name       => ENV['GOLLUM_AUTHOR_USERNAME'] || 'Anonymous',
            :email      => ENV['GOLLUM_AUTHOR_EMAIL'] || 'anon@anon.com',
        }
    end
end

load '/usr/local/bundle/bin/gollum'
