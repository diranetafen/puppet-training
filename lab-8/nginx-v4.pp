$app = "nginx"
$version = "v4"
$content = "<h2>Welcome to ${app}-${version}.pp By Dirane on puppet server</h2>"

package { "install $app":
  name   => $app,
  ensure => 'installed',
}

service { "start $app":
  name      => $app,
  ensure    => 'running',
  enable    => 'true',
  #nginx redemarre que si exécution de package ou de file
  subscribe => [
    Package["install $app"],
    File['/usr/share/nginx/html/index.html'],
  ],
}

#eventuelement file notifie le service nginx,
if $osfamily == 'RedHat' {
  file { '/usr/share/nginx/html/index.html':
  content => $content,
  notify  => Service["start $app"],
  }
}
