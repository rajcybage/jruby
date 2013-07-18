project 'JRuby Docs' do

  model_version '4.0.0'
  id 'org.jruby:docs:1.7.5.dev'
  inherit 'org.jruby:jruby-parent:1.7.5.dev'
  packaging 'pom'

  source_code( 'http://kenai.com/projects/jruby/sources',
               :connection => 'scm:git:git://kenai.com/jruby~main/docs',
               :developer_connection => 'scm:git:ssh://git.kenai.com/jruby~main/docs' )

  modules [ 'man' ]

end
