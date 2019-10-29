# encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do
  # user_name, phone, date_time
  @error  = ''
  hh = {:user_name => 'имя', :phone => 'телефон', :date_time => 'дату и время посещения'}
  @user_name = params[:user_name]
  @phone = params[:phone]
  @date_time = params[:date_time]
  @baber = params[:baber] 
  @color = params[:color1]

  # if hh{:user_name} == ''
  #   @error = 'NAME ABCENSE!!!!!'
  # end
  @error = hh.select {|key| params[key] == ''}.values.join(", ")
  @error = "Введите " + @error if @error != ''
  return erb :visit if @error != ''

    # if params[key] == ''
    #   @error = value
    #   return erb :visit
    # end

  # end
  
  @title = "Thank you!"
  @message = "Уважаемый #{@user_name}, мы ждём вас #{@date_time} у выбранного парикмахера #{@baber}, color #{@color}."

  # запишем в файл то, что ввёл клиент
  f = File.open './public/users.txt', 'a'
  f.write "User: #{@user_name}, phone: #{@phone}, date and time: #{@date_time}, Baber: #{@baber}, #{@color}.\n"
  f.close

  erb :message
end

get '/admin' do
	erb :admin
end

post '/admin' do
  @login = params[:login]
  @password = params[:password]

  # проверим логин и пароль, и пускаем внутрь или нет:
  if @login == 'admin' && @password == '12345'
    @logfile = File.open("./public/users.txt", "r:utf-8")
    @contents = @logfile.read
    @logfile.close
    erb :watch_result
    # @file.close - должно быть, но тогда не работает. указал в erb
  else
    @report = '<p>Доступ запрещён! Неправильный логин или пароль.</p>'
    erb :admin
  end
end