#!/bin/bash
# Intercepts `ruby` in order to prepend `bundle exec` if Gemfile.lock is present
# Author: Aaron Feng (aaron@forty9ten.com)

# remember original ruby location
export CURRENT_RUBY=$(which ruby)

alias ruby="ruby_wrapper"

# call bundle exec if there's a Gemfile.lock
function ruby_wrapper() {
  # unalias it to get the real ruby version
  # this is require if ruby was switch via rvm or rbenv
  unalias ruby
  CURRENT_RUBY=$(which ruby)

  if [ -e "$(pwd)/Gemfile.lock" ]
  then
    bundle exec $CURRENT_RUBY "$@"
  else
    $CURRENT_RUBY "$@"
  fi

  # set the alias back for next interception
  alias ruby="ruby_wrapper"
}
