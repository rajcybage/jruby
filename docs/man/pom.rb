project 'JRuby Manual pages' do

  model_version '4.0.0'
  id 'org.jruby:man:1.7.5.dev'
  inherit 'org.jruby:docs:1.7.5.dev'
  packaging 'pom'

  plugin 'com.agilejava.docbkx:docbkx-maven-plugin:2.0.8' do
    jar( 'org.docbook:docbook-xml:4.4',
         :scope => 'runtime' )

    execute_goals( 'generate-html', 'generate-pdf', 'generate-manpages',
                   :phase => 'generate-sources' )
  end

end
