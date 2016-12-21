before '/snippets*' do
  authenticate!
end


get '/snippets' do
  @snippets = Snippet.all
  erb :snippets
end

get '/gists' do
  p Snippet.all
  erb :gists
end
