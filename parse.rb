
require 'open-uri'
require 'nokogiri'
require 'csv'
#require 'magic_encoding'

 @f = CSV.open('methods.csv', 'w')
 @g = CSV.open('info.csv', 'w')
1.upto(1) do |page|

url = "http://www.oaontc.ru/services/registers/lnk/?&page=#{page}"

html = open(url)

m = Nokogiri::HTML(html)

rows = m.css('table a')


  rows.each do |row|
	@link = 'http://www.oaontc.ru' + row.to_s.split[1].to_s[6..36]
	  
		html_1 = open("#{@link}")
		#html_1 = open('http://www.oaontc.ru/services/registers/lnk/1081864/')

		m_1 = Nokogiri::HTML(html_1)

		 rows_1 = m_1.css('table td')
		  @num = rows_1[29].to_s[4..12] #number
		  @date = rows_1[29].to_s[15..24] #date
		  @name = rows_1[3]#.to_s.split(/[td<>\/]/) #name
		  @title = rows_1[17]#.to_s.split(/[td<>\/]/) #title
		  @address = rows_1[19]#.to_s.split(/[td<>\/]/) #address
		  @phone = rows_1[21]#.to_s.split(/[td<>\/]/) #phone
		  @mail = rows_1[25]#.to_s.split(/[td<>\/]/) # #mail
		 
		  @man = rows_1[27]#.to_s.split(/[td<>\/]/)

						
        rows_1.each do |n|
		   	if n.to_s.include? 'Методы контроля:'
		      	 @x_0 = rows_1.index(n).next
		 	elsif n.to_s.include? 'Виды деятельности:'
		      	 @x_1 = rows_1.index(n)
		end 
 	 	    	
    end              
 	  	@meth = rows_1[@x_0...@x_1]
 	  
   # puts @num, @date, @name, @title, @man, @address, @phone, @mail, @meth
    @g <<  [@date, @title, @name, @address, @phone, @mail, @man, @link,]
    @f << [@meth] 
   	  
 end
 end

   