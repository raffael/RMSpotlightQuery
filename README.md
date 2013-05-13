# RMSpotlightQuey

Objects of this class are NSThread subclasses to query the mdfind command line tool, a tool to query the Spotlight index.

## Usage:
### Running a simple query
	// assuming delegate implements the delegate protocol
	RMSpotlightQuery *query = [RMSpotlightQuery queryWithDelegate:self];
	[query query:@"image.jpg"];
	// The delegate will be notified with a NSArray of filename strings

### Running a query to find an exactly specified filename
	RMSpotlightQuery *query = [RMSpotlightQuery queryWithDelegate:self];
	[query queryExactFilename:@"image.jpg"];

### Running a query using mdfind options
	RMSpotlightQuery *query = [RMSpotlightQuery queryWithDelegate:self];
	[query query:@"image.jpg" withOptions:@[/*...*/]];

## Contact

* Raffael Hannemann
* [@raffael-me](http://www.twitter.com/raffael-me/)
* http://www.raffael.me/

## License

Copyright (c) 2013 Raffael Hannemann
Under BSD License.

## Want more?

Follow [@raffael-me](http://www.twitter.com/raffael-me/) for similar releases.
