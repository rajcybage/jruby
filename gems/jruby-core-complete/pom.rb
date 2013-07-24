project 'JRuby Core Complete' do

  id 'org.jruby:jruby-core-complete:1.7.5.dev'
  inherit 'org.jruby:jruby-artifacts:1.7.5.dev'

  packaging 'jar'

  properties( 'jruby.basedir' => '${basedir}/../../',
              'main.basedir' => '${project.parent.parent.basedir}',
              'jruby.complete.home' => '${project.build.outputDirectory}/META-INF/jruby.home' )

  jar 'org.jruby:jruby-core:${project.version}'

  plugin :shade, '2.1' do
    execute_goals( 'shade',
                   :id => 'pack artifact',
                   :phase => 'package',
                   'relocations' => [ { 'pattern' =>  'org.objectweb',
                                        'shadedPattern' =>  'org.jruby.org.objectweb' } ] )
  end

end
