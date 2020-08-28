# coffee-machine

## One time setup

### Install rvm (Ruby version manager)
`\curl -sSL https://get.rvm.io | bash -s stable --ruby`

### Install ruby(system wide)
```
rvm install 2.7.0 --with-openssl-dir=`brew --prefix openssl`
```

### Install bundler
```
gem update --system
gem install bundler:2.1.2
```

### Setup repo
```
git clone git@github.com:saleemjaffer/sj_coffee_machine.git
rvm install "2.7.0-sj_coffee_machine"
bundle install # To install all the required gems
```

## Run specs
I have used [RSpec](https://rspec.info/) for testing. From the project root:
- Run `rspec spec/coffee_machine_spec.rb` to run all specs
- Run `rspec spec/coffee_machine_spec.rb:<line_number>` to run a particular spec. (eg: `rspec spec/coffee_machine_spec.rb:67` will run only the particular `it` block)
