project 'JRuby Artifacts' do

  model_version '4.0.0'
  id 'org.jruby:jruby-artifacts:1.7.5.dev'
  inherit 'org.jruby:jruby-parent:1.7.5.dev'
  packaging 'pom'

  profile 'all' do

    modules [ 'jruby',
            'jruby-stdlib',
            'jruby-complete',
            'jruby-rake-plugin',
            'jruby-dist',
            'jruby-osgi-test' ]

  end

  profile 'main' do

    modules [ 'jruby',
            'jruby-stdlib' ]

  end

  profile 'complete' do

    modules [ 'jruby-stdlib',
            'jruby-complete' ]

  end

  profile 'rake-plugin' do

    modules [ 'jruby-rake-plugin' ]

  end

  profile 'dist' do

    modules [ 'jruby-dist' ]

  end

end
