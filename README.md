# Dillinger

Dillinger is a library for detecting and parsing bank statements in Ruby.

> *NOTE:* This gem is still under active development. The API *will* change
> before v1.0.0 is released.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dillinger'
```

And then execute:

```bash
bundle
```

## Usage

### Load transactions

```ruby
# Open the statement file
file = open('./spec/fixtures/example_ofx.ofx')

# Initialize a new Dillinger parser. This will return `false` if the statement
# format can't be detected
parser =  Dillinger.new(file)
# => #<Dillinger::Parser::Ofx ...>

# Parse the statement
parser.parse

# Loop though the transaction set
parser.transactions.each do |t|
  puts "#{t.particulars} - $#{t.amount.to_f}"
end

# Savings - $-500.0
# EFTPOS - $-3.8
# 12-3456-7890123-45 001 INTEREST - $-456.78
# Wages - $5678.9

```

### Check the statement format

```ruby
# Open the statement file
file = open('./spec/fixtures/example_qif.qif')

# Check if the file is an OFX statement
Dillinger::Parser::Ofx.test(file)
# => false

# Check if the file is an QIF statement
Dillinger::Parser::Qif.test(file)
# => true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release` to create a git tag for the version, push git
commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/dotledger/dillinger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

Copyright 2015, Kale Worsley, BitBot Limited.

Dillinger is made available under the MIT License. See [LICENSE](LICENSE) for details.
