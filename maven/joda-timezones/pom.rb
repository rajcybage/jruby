project 'JRuby Joda Timezones' do

  model_version '4.0.0'
  id 'org.jruby:joda-timezones:2013d'
  inherit 'org.jruby:jruby-artifacts:1.7.5.dev'
  packaging 'jar'

  properties( 'tzdata.ftp.dir' => '/tz/releases',
              'tzdata.ftpserver' => 'ftp.iana.org',
              'main.basedir' => '${project.parent.parent.basedir}',
              'tzdata.tar.gz' => '${project.build.directory}/tzdata-${project.version}.tar.gz' )

  jar 'joda-time:joda-time:2.2'

  plugin 'org.codehaus.mojo:wagon-maven-plugin:1.0-beta-3' do
    jar 'org.apache.maven.wagon:wagon-ftp:2.4'

    execute_goals( 'download-single',
                   :id => 'tzdata',
                   :phase => 'generate-sources',
                   'url' =>  'ftp://anonymous:jruby%40jruby.org@${tzdata.ftpserver}',
                   'fromFile' =>  '${tzdata.ftp.dir}/tzdata${project.version}.tar.gz',
                   'toFile' =>  '${tzdata.tar.gz}' )
  end

  plugin 'org.codehaus.mojo:truezip-maven-plugin:1.1' do
    execute_goals( 'copy',
                   :id => 'copy-out-fileset',
                   :phase => 'generate-sources',
                   'fileset' => {
                     'directory' =>  '${tzdata.tar.gz}',
                     'outputDirectory' =>  '${project.build.directory}/tzdata'
                   } )
  end

  plugin( 'org.codehaus.mojo:exec-maven-plugin:1.2.1',
          'mainClass' =>  'org.joda.time.tz.ZoneInfoCompiler',
          'arguments' => [ '-src',
                           '${project.build.directory}/tzdata',
                           '-dst',
                           '${project.build.outputDirectory}/org/joda/time/tz/data',
                           'africa',
                           'antarctica',
                           'asia',
                           'australasia',
                           'europe',
                           'northamerica',
                           'southamerica',
                           'pacificnew',
                           'etcetera',
                           'backward',
                           'systemv' ],
          'systemProperties' => {
            'systemProperty' => {
              'key' =>  'org.joda.time.DateTimeZone.Provider',
              'value' =>  'org.joda.time.tz.UTCProvider'
            }
          } ) do
    execute_goals( 'java',
                   :phase => 'process-resources' )
  end

end
