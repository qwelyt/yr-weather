# yr-weather
A simple CLI weather application that pulls data from <a href="http://www.yr.no/">YR.no</a>

It uses the nice module <a href="https://github.com/toreau/Weather-YR">Weather::YR</a> and pulls the data from that.

If you just get the .pm as it is, you won't be able to run this. It will complain about the translation.
Fix it by adding the following pull-request: https://github.com/incognico/Weather-YR/commit/b6e66e19929572c0275359dfe4919af8950f7cc3
And to avoid a bug which caused deep-recursion on occasion, apply this pull request: https://github.com/incognico/Weather-YR/commit/8c337350240509dc3105f7f57dc8686dfb62a870

You will also need <a hreft="http://search.cpan.org/~shlomif/Text-Table-1.130/lib/Text/Table.pm">Text::Table</a>. This prints the pretty table.

The simplest way to get the modules is to just enter your perl shell and install them.
Ie:
```
	% perl -MCPAN -e shell
	cpan[1]> install Weather::YR
	...
	cpan[i]> install Text::Table
	...
```
Then you can apply the patches to Weather::YR.

Simply run the application with `./yr-weather.pl` and it will pull data from YR.no
and print out a weather forecast. 

Or create an alias to it, like `alias weather='/path/to/yr-weather.pl'`

<img src="http://i.imgur.com/1ut03s9.png">
