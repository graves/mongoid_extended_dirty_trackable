[![Build Status](https://travis-ci.org/graves/mongoid_extended_dirty_trackable.svg?branch=master)](https://travis-ci.org/graves/mongoid_extended_dirty_trackable)

# Mongoid::ExtendedDirtyTrackable

A Mongoid Extension that gives you the ability to track changes to embedded and related documents through a parent.

It was born from a need in a production app I work on from which it was extracted. If you'd like a pretty detailed run down of what exactly the code is doing you can find it on [my blog.](http://blog.ooo.pm/dirty-tracking-embedded-documents-with-mongoid/)

I don't consider this Gem production ready. Mostly because I ran into some issues when writing the specs after Gemifying the original Concern. None of these problems exist in my production app so I'm lead to believe they are the result of the _hack_ job I did setting up and tearing down mongo for the tests. I plan on working these issues out in the near future and if you'd like to know more check out my [blog post that covers them.](http://blog.ooo.pm/post-im-gonna-write-tomorrow-morning)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongoid_extended_dirty_trackable'
```

And then execute:

    $ bundle

Or install it yourself with:

    $ gem install mongoid_extended_dirty_trackable

## Usage

I tried to make the specs work as documentation but for those of you averse to reading them I'll make it easy for you.

```ruby
class Account
  include Mongoid::Document
  include Mongoid::ExtendedDirtyTrackable

  field :name

  embeds_one :address
  embeds_many :invoices
  has_many :offices
end

account = Account.create(name: "Prestige Worldwide")
account.name = "Umbrella Corp"
account.changed?                             #=> true
account.changes["name"]                      #=> ["Prestige Worldwide", "Umbrella Corp"]

account.create_address(zipcode: "90210")
account.address.zipcode = "1000 AS"
account.changed?                             #=> true
account.changes["zipcode"]                   #=> ["90210", "1000 AS"]

account.invoices.create(total: 420.00)
account.invoices.first.total = 69.69
account.changed?                             #=> true
account.changes["total"]                     #=> [420.00, 69.69]

office = account.offices.create(number: 666)
office.number = 5446

account.changed?                             #=> true
account.changes["number"]                    #=> [666, 5446]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

All pull requests are met with open arms and gratitude.

Check the TODO file or the Github Issue tracker for suggestions on where to begin.

Please be sure your pull request includes descriptive commit messages and tests that cover your feature, change, or bug.

1. Fork it ( https://github.com/graves/mongoid_extended_dirty_trackable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Similar Projects

[versative/mongoid_relations_dirty_tracking](https://github.com/versative/mongoid_relations_dirty_tracking) - This is a little more full featured and much more in the direction I plan on taking but I feel like it can be done in a more simple manner with less code.

[millisami/gist:721466](https://gist.github.com/millisami/721466) - The code in this Gist no longer works or maybe it never did but it served as the inspiration for my Gem. Thanks [millisami!](https://github.com/millisami)
