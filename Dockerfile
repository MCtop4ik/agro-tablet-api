FROM ruby:3.2
WORKDIR /app

# Устанавливаем зависимости
RUN apt-get update -qq && apt-get install -y nodejs yarn

# Копируем Gemfile и Gemfile.lock
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Копируем все файлы проекта
COPY . .

# Открываем порт и запускаем сервер
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]