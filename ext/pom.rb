project 'JRuby Ext' do

  model_version '4.0.0'
  id 'org.jruby:jruby-ext:1.7.5.dev'
  inherit 'org.jruby:jruby-parent:1.7.5.dev'
  packaging 'pom'

  modules [ 'openssl',
            'readline',
            'ripper' ]

end
