project 'JRuby Ripper' do

  model_version '4.0.0'
  id 'org.jruby:ripper:1.7.4.1-SNAPSHOT'
  inherit 'org.jruby:jruby-ext:1.7.5.dev'
  packaging 'jar'

  repository( 'file:${jruby.basedir}/localrepo',
              :id => 'localrepo' )
  repository( 'https://oss.sonatype.org/content/repositories/snapshots/',
              :id => 'sonatype' ) do
    releases 'false'
    snapshots 'true'
  end

  properties( 'shared.dir' => '${project.basedir}/../../lib/ruby/shared',
              'main.basedir' => '${project.parent.parent.basedir}',
              'project.build.sourceEncoding' => 'UTF-8',
              'base.java.version' => '1.6' )

  jar( 'junit:junit:3.8.1',
       :scope => 'test' )
  jar( 'org.jruby:jruby-core:${project.parent.version}',
       :scope => 'provided' )
  jar 'org.jruby:jay-yydebug:1.0'

  plugin( :compiler,
          'encoding' =>  'utf-8',
          'debug' =>  'true',
          'verbose' =>  'true',
          'fork' =>  'true',
          'showWarnings' =>  'true',
          'showDeprecation' =>  'true',
          'source' =>  '${base.java.version}',
          'target' =>  '${base.java.version}' )
  plugin :shade do
    execute_goals( 'shade',
                   :phase => 'package',
                   'outputFile' =>  '${shared.dir}/ripper.jar' )
  end

  plugin( :clean,
          'filesets' => [ { 'directory' =>  '${shared.dir}',
                            'includes' => [ 'ripper.jar' ] } ] )
end
