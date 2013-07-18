project 'JRuby Integration Tests' do

  model_version '4.0.0'
  id 'org.jruby:jruby-tests:1.7.5.dev'
  inherit 'org.jruby:jruby-parent:1.7.5.dev'
  packaging 'jar'

  repository( 'file:${jruby.basedir}/localrepo',
              :id => 'localrepo' )
  repository( 'http://rubygems-proxy.torquebox.org/releases',
              :id => 'rubygems-releases' )
  repository( 'https://oss.sonatype.org/content/repositories/snapshots/',
              :id => 'sonatype' ) do
    releases 'false'
    snapshots 'true'
  end

  plugin_repository( 'https://oss.sonatype.org/content/repositories/snapshots/',
                     :id => 'sonatype' ) do
    releases 'false'
    snapshots 'true'
  end
  plugin_repository( 'http://rubygems-proxy.torquebox.org/releases',
                     :id => 'rubygems-releases' )

  properties( 'jruby.basedir' => '${basedir}/..',
              'gem.home' => '${jruby.basedir}/lib/ruby/gems/shared' )

  jar 'org.jruby:jruby-core:${project.version}'
  jar( 'junit:junit:4.11',
       :scope => 'test' )
  jar( 'org.apache.ant:ant:1.8.4',
       :scope => 'provided' )
  jar( 'bsf:bsf:2.4.0',
       :scope => 'provided' )
  jar( 'commons-logging:commons-logging:1.1.3',
       :scope => 'test' )
  jar( 'org.livetribe:livetribe-jsr223:2.0.7',
       :scope => 'test' )
  jar( 'requireTest:requireTest:1.0',
       :scope => 'test' )
  gem 'rubygems:rake:${rake.version}'
  gem 'rubygems:rspec:${rspec.version}'
  gem 'rubygems:jruby-launcher:${jruby-launcher.version}'
  gem 'rubygems:minitest:${minitest.version}'
  gem 'rubygems:minitest-excludes:${minitest-excludes.version}'
  gem 'rubygems:json:${json.version}'
  gem 'rubygems:rdoc:${rdoc.version}'

  plugin 'de.saumya.mojo:gem-maven-plugin:${jruby.plugins.version}' do
    execute_goals( 'initialize',
                   :phase => 'initialize',
                   'gemPath' =>  '${gem.home}',
                   'gemHome' =>  '${gem.home}',
                   'binDirectory' =>  '${jruby.basedir}/bin',
                   'includeRubygemsInTestResources' =>  'false',
                   'libDirectory' =>  '${jruby.basedir}/lib',
                   'jrubyJvmArgs' =>  '-Djruby.home=${jruby.basedir}' )
  end

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
                   :id => 'copy jars for testing',
                   :phase => 'process-classes',
                   'artifactItems' => [ { 'groupId' =>  'junit',
                                          'artifactId' =>  'junit',
                                          'version' =>  '4.11',
                                          'type' =>  'jar',
                                          'overWrite' =>  'false',
                                          'outputDirectory' =>  'target',
                                          'destFileName' =>  'junit.jar' },
                                        { 'groupId' =>  'com.googlecode.jarjar',
                                          'artifactId' =>  'jarjar',
                                          'version' =>  '1.1',
                                          'type' =>  'jar',
                                          'overWrite' =>  'false',
                                          'outputDirectory' =>  'target',
                                          'destFileName' =>  'jarjar.jar' },
                                        { 'groupId' =>  'bsf',
                                          'artifactId' =>  'bsf',
                                          'version' =>  '2.4.0',
                                          'type' =>  'jar',
                                          'overWrite' =>  'false',
                                          'outputDirectory' =>  'target',
                                          'destFileName' =>  'bsf.jar' } ] )
  end

  plugin( :surefire,
          'forkCount' =>  '1C',
          'reuseForks' =>  'false',
          'systemProperties' => {
            'jruby.compat.version' =>  '1.9',
            'jruby.home' =>  '${project.parent.basedir}'
          },
          'testFailureIgnore' =>  'true',
          'argLine' => [ '-Xmx${jruby.test.memory}',
                         '-XX:MaxPermSize=${jruby.test.memory.permgen}',
                         '-Dfile.encoding=UTF-8' ],
          'includes' => [ 'org/jruby/test/MainTestSuite.java',
                          'org/jruby/embed/**/*Test*.java' ] )
  plugin( :site,
          'skip' =>  'true',
          'skipDeploy' =>  'true' )

  build do
    default_goal 'test'
    test_source_directory '.'
  end

end
