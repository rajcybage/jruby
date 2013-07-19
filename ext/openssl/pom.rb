project 'JRuby OpenSSL' do

  model_version '4.0.0'
  id 'org.jruby:openssl:0.8.9-SNAPSHOT'
  inherit 'org.jruby:jruby-ext:1.7.5.dev'
  packaging 'jar'

  properties( 'main.basedir' => '${project.parent.parent.basedir}',
              'openssl.dir' => '${project.basedir}/../../lib/ruby/shared' )

  jar( 'junit:junit',
       :scope => 'test' )
  jar( 'org.bouncycastle:bcpkix-jdk15on:${bc.version}',
       :scope => 'provided' )
  jar( 'org.bouncycastle:bcprov-jdk15on:${bc.version}',
       :scope => 'provided' )
  jar( 'org.jruby:jruby-core:${project.parent.version}',
       :scope => 'provided' )

  plugin( :jar,
          'outputDirectory' =>  '${openssl.dir}' )
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
                   :id => 'copy bouncy-castle',
                   :phase => 'process-classes',
                   'artifactItems' => [ { 'groupId' =>  'org.bouncycastle',
                                          'artifactId' =>  'bcpkix-jdk15on',
                                          'version' =>  '${bc.version}',
                                          'type' =>  'jar',
                                          'overWrite' =>  'false',
                                          'outputDirectory' =>  '${openssl.dir}' },
                                        { 'groupId' =>  'org.bouncycastle',
                                          'artifactId' =>  'bcprov-jdk15on',
                                          'version' =>  '${bc.version}',
                                          'type' =>  'jar',
                                          'overWrite' =>  'false',
                                          'outputDirectory' =>  '${openssl.dir}' } ] )
  end

  plugin( :clean,
          'filesets' => [ { 'directory' =>  '${openssl.dir}',
                            'includes' => [ 'bc*-jdk15on-*.jar',
                                            'jopenssl.jar' ] } ] )

  build do
    final_name 'jopenssl'
  end

end
