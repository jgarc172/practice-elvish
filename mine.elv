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

fn prom { 
	styled 'λ ' green; last1 (put $pwd); styled ' > ' green
}

fn git-status {
	var git = [&]
	git status --branch --porcelain=v2 | each {|line|
		var type key @value = (str:split ' ' $line)
		if (eq $type '#' ) {
		  #set git = (assoc $git $key (str:join ' ' $value))
		  set git[$key] = $value
		}
	}
	put $git
}

var status = ?(var git = (put (git-status 2>/dev/nul l)))
if (put status) { put (keys $git) } | each {|key| put $git[$key] }