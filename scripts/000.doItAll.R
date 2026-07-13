todo <- dir('scripts/')
todo <- grep('99_|doItAll|15|ARCHIVE', todo, invert = T, value = T)

for(i in todo) {
    message(paste('*** DOING SCRIPT', i, '***'))
    source(paste('scripts', i, sep = '/'))
}