FROM ruby:3.3.8

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  npm \
  libmariadb-dev \
  default-mysql-client

# Set working directory
WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the app code
COPY . .

# Add entrypoint
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Expose port for Rails
EXPOSE 3000

# Use entrypoint
ENTRYPOINT ["entrypoint.sh"]

# Default command to run the server
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
