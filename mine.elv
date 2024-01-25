echo "loading module mine"
use path
use str
fn last2 { |p|
  var dir-count = (str:split / $p | count)
  if (> $dir-count 3) {
    put ../(path:join (path:base (path:dir $p)) (path:base $p))
  } else {
    put $p
  }
}

fn prom { 
  styled 'λ ' green; last2 (put $pwd); styled ' > ' green
}