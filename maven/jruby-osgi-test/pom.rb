project 'JRuby OSGI Test' do

  model_version '4.0.0'
  id 'org.jruby:jruby-osgi-test:1.7.5.dev'
  inherit 'org.jruby:jruby-artifacts:1.7.5.dev'
  packaging 'jar'

  properties( 'exam.version' => '3.0.3',
              'logback.version' => '1.0.13',
              'main.basedir' => '${project.parent.parent.basedir}',
              'url.version' => '1.5.2' )

  jar 'org.osgi:org.osgi.core:5.0.0'
  jar( 'org.ops4j.pax.exam:pax-exam-container-forked:${exam.version}',
       :scope => 'test' )
  jar( 'org.ops4j.pax.exam:pax-exam-junit4:${exam.version}',
       :scope => 'test' )
  jar( 'org.ops4j.pax.exam:pax-exam-link-mvn:${exam.version}',
       :scope => 'test' )
  jar( 'org.ops4j.pax.url:pax-url-aether:${url.version}',
       :scope => 'test' )
  jar( 'ch.qos.logback:logback-core:${logback.version}',
       :scope => 'test' )
  jar( 'ch.qos.logback:logback-classic:${logback.version}',
       :scope => 'test' )
  jar( '${project.groupId}:jruby-complete:${project.version}',
       :scope => 'test' )

  plugin( :compiler, '2.5.1',
          'source' =>  '1.6',
          'target' =>  '1.6' )
  profile 'felix2' do

    jar( 'org.apache.felix:org.apache.felix.framework:2.0.5',
         :scope => 'test' )

  end

  profile 'felix4' do

    jar( 'org.apache.felix:org.apache.felix.framework:4.2.1',
         :scope => 'test' )

  end

end
