# AMazeIng

This is a small video game about maze, create on Gosu library. Solve the maze yourself or play with friend.

Classic mode               |    Multiplayer mode
:-------------------------:|:-------------------------:
![](./images/classic.jpg?raw=true)  |  ![](./images/multiplayer.jpg?raw=true)

Annoying Friend mode       |    Time Hunter mode
:-------------------------:|:-------------------------:
![](./images/annoying_friend.jpg?raw=true)  |  Comming soon, I'm working on it 



## Requirements

[Gosu](https://www.libgosu.org/) gem requires some libraries to be installed system-wide. If you got error installing gosu during install process, follow below instruction

### OSX

Gosu depends on the [SDL 2 library](http://www.libsdl.org/). Please install [Homebrew](http://brew.sh/) and run 

    brew install sdl2

And then install a_maze_ing again  

### Ubuntu

In order for Gosu to be installed on Linux, you need the following packages (the names will be slightly different in every distribution):

`libsdl2-dev`, `libsdl2-ttf-dev`, `libpango1.0-dev`, `libgl1-mesa-dev`, `libopenal-dev`, `libsndfile-dev`, `libmpg123-dev` (starting in 0.12.0)


Run following command to install

    $ sudo apt-get install build-essential libsdl2-dev libsdl2-ttf-dev libpango1.0-dev \
                     libgl1-mesa-dev libopenal-dev libsndfile-dev libmpg123-dev

And then install a_maze_ing again

### Other OS

You can find all install constructions in [Gosu's documentation](https://github.com/gosu/gosu/wiki) on Github to install Gosu completely
    
## Installation

Run following command

    $ gem install a_maze_ing

## Usage

After install AMazeIng you can quickly run the game in classic mode by excecute the following command:

    $ a_maze_ing

or

    $ a_maze_ing classic

To play in Multiplayer mode run the following command:

    $ a_maze_ing m

To play in Annoying Friend mode run the following command:

    $ a_maze_ing af

Global Options: 

    --fullscreen (-f) will run the game in full screen mode

## Construction

### Control keys

Normaly you can use Up, Down, Left, Right key to move your character to that specific direction.

In two player mode, player 2 will use W, S, A, D key to move Up, Down, Left and Right instead.

### Game mode

#### Classic mode

Find the way to the gate (the white square), the maze will get more complex as level increase

#### Multiplayer mode

There will be two player control two square, green and cyan, race to the gate (white square) at the same time. Who solve the maze first will get the point. 

#### Annoying Friend mode

There will be also two player control two square but green and red. Player 2 will control the red square and not race to the gate but try to catch his friend (the green one). Players will get point if he/she finished his/her mission

## Features Todo List

* Menu screen
* Custom mode - custom difficulty
* Enemy mode - Race to the target before get hit by the enemies

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/at-cuongtran/a_maze_ing.
