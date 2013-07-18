project 'JRuby Stdlib' do

  model_version '4.0.0'
  id 'org.jruby:jruby-stdlib:1.7.5.dev'
  inherit 'org.jruby:jruby-artifacts:1.7.5.dev'
  packaging 'jar'

  properties( 'jruby.basedir' => '${basedir}/../../',
              'jruby.complete.gems' => '${jruby.complete.home}/lib/ruby/gems/shared',
              'main.basedir' => '${project.parent.parent.basedir}',
              'gem.home' => '${jruby.basedir}/lib/ruby/gems/shared',
              'jruby.complete.home' => '${project.build.outputDirectory}/META-INF/jruby.home' )

  jar( 'org.jruby:readline:1.0-SNAPSHOT',
       :scope => 'provided' )
  jar( 'org.jruby:openssl:0.8.9-SNAPSHOT',
       :scope => 'provided' )
  jar 'org.bouncycastle:bcpkix-jdk15on:${bc.version}'
  jar 'org.bouncycastle:bcprov-jdk15on:${bc.version}'


  build do

    resource do
      directory '${gem.home}'
      includes 'gems/rake-${rake.version}/**/*', 'specifications/rake-${rake.version}.gemspec'
      excludes 
      target_path '${jruby.complete.gems}'
    end

    resource do
      directory '${jruby.basedir}'
      includes 'bin/jruby', 'bin/*jruby*', 'bin/*gem*', 'bin/*ri*', 'bin/*rdoc*', 'bin/*irb*', 'bin/generate_yaml_index.rb', 'bin/testrb', 'bin/ast*', 'bin/spec.bat', 'bin/rake', 'bin/rake.bat'
      excludes 
      target_path '${jruby.complete.home}'
    end

    resource do
      directory '${jruby.basedir}'
      includes 'lib/ruby/1.8/**', 'lib/ruby/1.9/**', 'lib/ruby/2.0/**', 'lib/ruby/shared/**'
      excludes 'lib/**/bc*.jar'
      target_path '${jruby.complete.home}'
    end
  end

end
