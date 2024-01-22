echo "loading module mine"
use path
use str
fn last2 { |p|
  var dir-count = (str:split / $pwd | count)
  if (> $dir-count 3) {
    echo ../(path:join (path:base (path:dir $p)) (path:base $p))
  } else {
    echo $p
  }
}
