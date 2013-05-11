json.array!(@words) do |word|
  json.extract! word, :name, :freq, :attr
  json.url word_url(word, format: :json)
end