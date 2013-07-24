project 'JRuby Gems' do

  model_version '4.0.0'
  id 'org.jruby:jruby-gems:1.7.5.dev'
  inherit 'org.jruby:jruby-parent:1.7.5.dev'
  packaging 'pom'

  modules [ 'bouncy-castle-java', 
            'jruby-core-complete',
            'jruby-stdlib-complete',
            'jruby-jars' ]

end
