# Capistrano Rails Server Setup

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

### Introduction
Capistrano is an open-source tool for running scripts on multiple servers; its main use is deploying web applications. It automates the process of making a new version of an application available on one or more web servers, including supporting tasks such as changing databases.For more information go to [capistrano.com](https://capistranorb.com) 

Capistrano offers many advanced options that won’t be covered in this guide as I have stated, This resource is for you who need to use this ASAP, copy the content in the deploy.rb file and modify to suit your config.

### Server Dependencies or Requirements
It’s important to make sure that your server is POSIX-compilant and has SSH access. Don’t forget to setup your SSH keys (Mac or Windows). If you can’t SSH into your server, Capistrano isn’t going to work for you.
Prepare your Project for Capistrano
Navigate to your application’s root directory .

### How to Install Capistrano
In order to install Capistrano you will need Ruby and RubyGems installed on your computer. If you’re on a Mac running macOS 10.5+, you’re ready to go. If not, you can use this reference to learn how to install Ruby and RubyGems.

Add this to your gemfile:
```ruby
group :development do
  gem 'capistrano-figaro-yml', '~> 1.0.2'
  gem 'capistrano-rbenv', '~> 2.1',   require: false
  gem 'capistrano-rails',"~> 1.4",   require: false
  gem 'capistrano-bundler', require: false
  # gem 'capistrano3-puma',   require: false
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sshkit-sudo'
  gem "capistrano", "~> 3.11.2", require: false
end

```
And run, this will install all gems added to your gemfile
```bash
$ bundle install
```
This command creates a special file called Capfile in your project, and adds a template deployment recipe at `config/deploy.rb` in your Rails project. The Capfile helps Capistrano load your recipes and libraries properly, but you don’t need to edit it for now.
Instead, open the deploy.rb and replace everything in it with the content on this `deploy.rb` file, and run
```ssh
$ cap install
```

### Conclusion
I hope this works for you. 
