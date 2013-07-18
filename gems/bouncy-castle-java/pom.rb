project 'Gem redistribution of Bouncy Castle jars', 'http://github.com/jruby/jruby/tree/master/gems/bouncy-castle-java/' do

  model_version '4.0.0'
  id 'rubygems:bouncy-castle-java:1.5.0149'
  packaging 'gem'

  description 'Gem redistribution of "Legion of the Bouncy Castle Java cryptography APIs" jars at http://www.bouncycastle.org/java.html'

  developer 'nahi_at_ruby-lang_dot_org' do
    name 'Hiroshi Nakamura'
    email 'nahi@ruby-lang.org'
    roles 
  end

  repository( 'http://rubygems-proxy.torquebox.org/releases',
              :id => 'rubygems-releases' )

  plugin_repository( 'http://rubygems-proxy.torquebox.org/releases',
                     :id => 'rubygems-releases' )

  properties( 'jruby.version' => '1.7.3',
              'gem.path' => '${project.build.directory}/rubygems',
              'jruby.plugins.version' => '0.29.4',
              'gem.home' => '${project.build.directory}/rubygems',
              'project.build.sourceEncoding' => 'UTF-8' )

  overrides do
    plugin( 'org.eclipse.m2e:lifecycle-mapping:1.0.0',
            'lifecycleMappingMetadata' => {
              'pluginExecutions' => [ { 'pluginExecutionFilter' => {
                                          'groupId' =>  'de.saumya.mojo',
                                          'artifactId' =>  'gem-maven-plugin',
                                          'versionRange' =>  '[0,)',
                                          'goals' => [ 'initialize' ]
                                        },
                                        'action' => {
                                          'ignore' =>  ''
                                        } } ]
            } )
  end

  plugin( 'de.saumya.mojo:gem-maven-plugin:${jruby.plugins.version}',
          'gemspec' =>  'bouncy-castle-java.gemspec',
          'rubyforgeProject' =>  'jruby-extras',
          'files' =>  'README,LICENSE.html,lib/bouncy-castle-java.rb' ) do
    gem 'rubygems:jruby-openssl:[0,)'

  end

  plugin :dependency, '2.8' do
    execute_goals( 'copy',
                   :id => 'copy bouncy castle jars',
                   :phase => 'prepare-package',
                   'artifactItems' => [ { 'groupId' =>  'org.bouncycastle',
                                          'artifactId' =>  'bcpkix-jdk15on',
                                          'version' =>  '1.49',
                                          'type' =>  'jar',
                                          'overWrite' =>  'false',
                                          'outputDirectory' =>  '${basedir}/lib' },
                                        { 'groupId' =>  'org.bouncycastle',
                                          'artifactId' =>  'bcprov-jdk15on',
                                          'version' =>  '1.49',
                                          'type' =>  'jar',
                                          'overWrite' =>  'false',
                                          'outputDirectory' =>  '${basedir}/lib' } ] )
  end

  plugin :clean do
    execute_goals( 'clean',
                   :id => 'clean-lib',
                   :phase => 'clean',
                   'filesets' => [ { 'directory' =>  '${basedir}/lib' } ],
                   'failOnError' =>  'false' )
  end


  build do

    resource do
      directory '../../lib/ruby/shared/'
      includes 'bouncy-castle-java.rb'
      excludes 
      target_path '${basedir}/lib'
    end
  end

  profile 'executable' do

    jar( 'de.saumya.mojo:gem-assembly-descriptors:${jruby.plugins.version}',
         :scope => 'runtime' )

    plugin( :assembly, '2.4',
            'descriptorRefs' => [ 'jar-with-dependencies-and-gems' ],
            'archive' => {
              'manifest' => {
                'mainClass' =>  'de.saumya.mojo.assembly.Main'
              }
            } ) do
      jar 'de.saumya.mojo:gem-assembly-descriptors:${jruby.plugins.version}'

      execute_goals( 'assembly',
                     :id => 'in_phase_package',
                     :phase => 'package' )
    end

  end

end
