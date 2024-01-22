echo "loading module mine"
use path
use str
fn last2 { |p|
  var dir-count = (str:split / $p | count)
  if (> $dir-count 3) {
    echo ../(path:join (path:base (path:dir $p)) (path:base $p))
  } else {
    echo $p
  }
}

fn prom { 
  echo (styled λ green) (last2 (put $pwd)) (styled '> ' green)
}