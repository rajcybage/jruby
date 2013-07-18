project 'JRuby Rake Plugin' do

  model_version '4.0.0'
  id 'org.jruby.plugins:jruby-rake-plugin:1.7.5.dev'
  inherit 'org.jruby:jruby-artifacts:1.7.5.dev'
  packaging 'maven-plugin'

  properties( 'main.basedir' => '${project.parent.parent.basedir}' )

  jar 'org.apache.maven:maven-plugin-api:2.0.4'
  jar 'org.apache.maven:maven-project:2.0.4'
  jar 'ant:ant:1.6.2'
  jar 'org.jruby:jruby-core:${project.version}'

  plugin( :plugin,
          'goalPrefix' =>  'jruby-rake' )
  plugin( :compiler,
          'excludes' => [ 'none' ] )
  plugin( :jar,
          'excludes' => [ 'none' ] )
end
