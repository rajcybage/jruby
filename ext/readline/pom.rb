project 'JRuby Readline' do

  model_version '4.0.0'
  id 'org.jruby:readline:1.0-SNAPSHOT'
  inherit 'org.jruby:jruby-ext:1.7.5.dev'
  packaging 'jar'

  properties( 'readline.dir' => '${project.basedir}/../../lib/ruby/shared/readline',
              'main.basedir' => '${project.parent.parent.basedir}' )

  jar( 'junit:junit',
       :scope => 'test' )
  jar( 'org.jruby:jruby-core:${project.parent.version}',
       :scope => 'provided' )
  jar( 'jline:jline:2.11',
       :scope => 'provided' )

  overrides do
    plugin( 'org.eclipse.m2e:lifecycle-mapping:1.0.0',
            'lifecycleMappingMetadata' => {
              'pluginExecutions' => [ { 'pluginExecutionFilter' => {
                                          'groupId' =>  'org.apache.maven.plugins',
                                          'artifactId' =>  'maven-dependency-plugin',
                                          'versionRange' =>  '[2.8,)',
                                          'goals' => [ 'copy' ]
                                        },
                                        'action' => {
                                          'ignore' =>  ''
                                        } } ]
            } )
  end

  plugin( :clean,
          'filesets' => [ { 'directory' =>  '${readline.dir}',
                            'includes' => [ 'jline-*.jar',
                                            'readline.jar' ] } ] )
  plugin( :compiler,
          'encoding' =>  'utf-8',
          'debug' =>  'true',
          'verbose' =>  'true',
          'fork' =>  'true',
          'showWarnings' =>  'true',
          'showDeprecation' =>  'true',
          'source' =>  '${base.java.version}',
          'target' =>  '${base.java.version}' )
  plugin :dependency do
    execute_goals( 'copy',
                   :id => 'copy jline',
                   :phase => 'process-classes',
                   'artifactItems' => [ { 'groupId' =>  'jline',
                                          'artifactId' =>  'jline',
                                          'version' =>  '2.11',
                                          'type' =>  'jar',
                                          'overWrite' =>  'false',
                                          'outputDirectory' =>  '${readline.dir}' } ] )
  end

end
