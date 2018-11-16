class TitleBracketsValidator < ActiveModel::Validator
  def validate(movie)
    title = movie.title
    l = []
    inverses = { ")" => "(", "]" => "[", "}" => "{" }

    title.each_char.with_index do |c, i|
      l << c if ["(", "[", "{"].include? c

      if [")", "]", "}"].include? c
        movie.errors.add(:right_bracket, "shouldn't appear before the left bracket") if l.empty?
        movie.errors.add(:brackets, "shouldn't be empty") if title[i-1] == inverses[c] # if the previous char is also a bracket

        if inverses[c] == l.last
          l.pop # brackets match; pop them off
        else
          movie.errors.add(:right_bracket, "does not match")
        end
      end
    end
    movie.errors.add(:brackets, "haven't been correctly closed") unless l.empty? # at this point l should be empty
    p movie.title
    p movie.errors
  end
end