let g:rspec_command = "!bundle exec rspec --drb {spec}"
map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>t :call RunNearestSpec()<CR>
