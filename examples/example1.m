%script example1

% Basic Excel example

mx = magic(5) + round(rand(5), 2);


Name = ["Alice" "Bob" "Carol" "Dave"]';
Birthdate = [datetime(1987, 3, 24), datetime(1995, 11, 7), datetime(1976, 7, 4), ...
  datetime(1998, 4, 14)]';
FavoriteNumber = rand([4 1]);
tbl = table(Name, Birthdate, FavoriteNumber);

s = struct('foo', 42, 'bar', [1 2 3], 'baz', "Hello, world!", 'qux', ...
  struct('x', magic(3), 'y', 'Some data', 'tbl',tbl, 'z', 1:3));