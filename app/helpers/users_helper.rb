module UsersHelper

    def date_valid?(str)
       str.tr!("０-９","0-9")

    if str.include?("年") and str.include?("月") and str.include?("日")
    /(\d{4})年(\d{1,2})月(\d{1,2})日/ =~ str
    birth_time =[$1,$2,$3]
    birth_time=birth_time.join("/")
    str = birth_time
    end
      !! Date.parse(str) rescue false
    end

end
