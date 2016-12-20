get '/login' do
  authenticate!
  redirect '/'
end

get '/logout' do
  logout!
  redirect '/'
end
get '/login_page' do
  erb(:login_page)
end


get '/auth/callback' do
  redirect "/snippets" if handle_github_callback
  halt 401, "Unable to Authenticate Via GitHub"
end
