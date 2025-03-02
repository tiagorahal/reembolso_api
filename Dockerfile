# Use an official Ruby image as a base
FROM ruby:3.2.2

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the application files
COPY . .

# Expose port
EXPOSE 3000

# Start the server
CMD ["rails", "server", "-b", "0.0.0.0"]
