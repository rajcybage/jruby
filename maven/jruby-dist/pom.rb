project 'JRuby Dist' do

  model_version '4.0.0'
  id 'org.jruby:jruby-dist:1.7.5.dev'
  inherit 'org.jruby:jruby-artifacts:1.7.5.dev'
  packaging 'pom'

  properties( 'main.basedir' => '${project.parent.parent.basedir}' )

  jar( 'org.jruby:jruby-core:${project.version}',
       :scope => 'provided' )
  jar( 'org.jruby:jruby-stdlib:${project.version}',
       :scope => 'provided' )

end
