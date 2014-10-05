# Noter

Dumps text into timestamped files under ~/.notes.

Use it for keeping a journal, or for short -- or long -- notes during the workday.

## Installation

Add this line to your application's Gemfile:

    gem 'noter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install noter

## Usage

    Usage: noter [options]
        -f, --file FILE                  Create a note using the given file
        -g, --grep STRING                Only show files that contain a specific string
        -l, --one-line                   Show first line of each note file
        -m, --message MESSAGE            Create a note using the given string
        -n, --name                       Include names when showing files
            --no-color                   Don't colorize output
        -s, --search STRING              Show a file with the given index
        -t, --tail COUNT                 the last n files
        -u, --unpaged                    Don't page the output
        -v, --view INDEX                 View a file with the given index

## Contributing

1. Fork it ( http://github.com/<my-github-username>/noter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
