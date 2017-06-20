# AMazeIng

This is a small video game about maze, create on Gosu library. You need to find the way to specific point in the maze to win the game

Classic mode             |  Multiplayer mode
:-------------------------:|:-------------------------:
![](./images/classic.jpg?raw=true)  |  ![](./images/multiplayer.jpg?raw=true)

## Requirements

This gem needs [Gosu](https://www.libgosu.org/) installed on your machine in order to render graphics

To install, follow the constructions in [Gosu's documentation](https://github.com/gosu/gosu/wiki) on Github

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'a_maze_ing'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install a_maze_ing

## Usage

After install AMazeIng you can quickly run the game in classic mode by excecute the following command:

    $ a_maze_ing

or

    $ a_maze_ing classic

To play in multiplayer mode run the following command:

    $ a_maze_ing multiplayer

Global Options: 

    --fullscreen (-f) will run the game in full screen mode

## Features Todo List

* Menu screen
* Custom mode - custom difficulty
* Enemy mode - Race to the target before get hit by the enemies

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/at-cuongtran/a_maze_ing.
