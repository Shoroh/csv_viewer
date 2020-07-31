# CSV Viewer

![](https://ic.pics.livejournal.com/microgenius/12282563/365683/365683_original.png)

## Usage:

```
$ csv_viewer some_csv_file.csv [options]

CSV parsing options:
    -s, --separator=COL_SEP          CSV column separator, ',' - by default.

Page options:
    -r, --rows=ROWS                  Rows per page. 10 by default.

Design options:
    -d, --design=DESIGN              ascii (by default) or UTF

Debug options:
    -m, --memory                     Show memory usage.

Common options:
    -h, --help                       Show this message
        --version                    Show version
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csv_viewer'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install csv_viewer

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CsvViewer project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/csv_viewer/blob/master/CODE_OF_CONDUCT.md).
