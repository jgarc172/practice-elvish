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

fn last1 {|p|
  put (path:base $p)
}

# git status as array of lines
fn git-porcelain {
  var lines = []
  # All necessary captues
  # ?() captues the exception in non-git repositories
  # /dev/null captures stderr
  # [ ] captures multipe lines (values) as one array assignable to one var lines
  var status = ?(set lines = [(git status --branch --porcelain=v2 2>/dev/null)])
  var map = [&]
  for line $lines {
    var type key @value = (str:split ' ' $line)
    set map[$key] = $value
    if (or (eq $type '?') (eq $type 1)) {
      set map[dirty] = $true
    }
  }
  put $map
}

fn git-map {
  var git = [&]
  var status = ?(var lines = [(put (git status --branch --porcelain=v2 2>/dev/null))])
  if (eq $status $ok) {
    set git[dirty] = $false
    each {|line| put $line } $lines } | each {|line|
      var type key @value = (str:split ' ' $line)
      if (eq $type '#' ) {
        set git[$key] = $value
      }
      if (or (eq $type '?') (eq $type '1')) {
        set git[dirty] = $true
      }
  }
  put $git
}
fn git-status {
var gm = (git-map)
var git-status = ""
if (> (count $gm) 0) { 
  var branch = (str:join ' ' $gm[branch.head])
  var ab = (str:join ' ' $gm[branch.ab])
  set git-status = (str:join ' ' [$branch $ab])
  set git-status = (styled $git-status cyan bold)
  if $gm[dirty] {
    set git-status = (styled $git-status red bold)
  }
  set git-status = (put '('$git-status')')
 }
 put $git-status
}

var start = (styled 'λ ' green)
var end = (styled ' > ' green)
fn dir  { last1 $pwd }

fn prom { 
  put $start (styled (dir) yellow bold)'/ ' (git-status) $end 
}

fn rprom {
  put (git-status)
}

set edit:prompt = { prom }
set edit:rprompt = { }