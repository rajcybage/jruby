project 'JRuby' do

  model_version '4.0.0'
  id 'org.jruby:jruby-parent:1.7.5.dev'
  packaging 'pom'

  repository( 'file:${basedir}/localrepo',
              :id => 'localrepo' )
  repository( 'https://oss.sonatype.org/content/repositories/snapshots/',
              :id => 'sonatype' ) do
    releases 'false'
    snapshots 'true'
  end

  source_code( 'https://github.com/jruby/jruby',
               :connection => 'scm:git:git://github.com/jruby/jruby.git',
               :developer_connection => 'scm:git:ssh://git@github.com/jruby/jruby.git' )

  distribution do
    site( 'https://github.com/jruby/jruby',
          :id => 'gh-pages',
          :name => 'JRuby Site' )
  end

  properties( 'json.version' => '1.7.3',
              'jruby-launcher.version' => '1.0.18.pre1',
              'minitest-excludes.version' => '1.0.2',
              'jruby.plugins.version' => '1.0.0-beta-1-SNAPSHOT',
              'diff-lcs.version' => '1.1.3',
              'github.global.server' => 'github',
              'main.basedir' => '${project.basedir}',
              'bc.version' => '1.47',
              'rake.version' => '10.1.0',
              'rdoc.version' => '3.12',
              'rspec.version' => '2.14.1',
              'rspec-core.version' => '2.14.2',
              'rspec-expectations.version' => '2.14.0',
              'project.build.sourceEncoding' => 'utf-8',
              'minitest.version' => '4.7.5',
              'base.java.version' => '1.6',
              'rspec-mocks.version' => '2.14.1' )

  modules [ 'ext',
            'core',
            'test' ]

  overrides do
    jar( 'junit:junit:4.11',
         :scope => 'test' )

    plugin( :site, '3.3',
            'skipDeploy' =>  'true' )
    plugin :antrun, '1.7'
    plugin :assembly, '2.4'
    plugin :install, '2.4'
    plugin :deploy, '2.7'
    plugin :resources, '2.6'
    plugin :clean, '2.5'
    plugin :dependency, '2.8'
    plugin :release, '2.4.1'
    plugin :jar, '2.4'
    plugin :compiler, '3.1'
    plugin :shade, '2.1'
    plugin :surefire, '2.15'
    plugin :plugin, '3.2'
    plugin :invoker, '1.8'
    plugin 'org.eclipse.m2e:lifecycle-mapping:1.0.0'
    plugin :'scm-publish', '1.0-beta-2'
  end

  plugin( :site,
          'port' =>  '9000',
          'tempWebappDirectory' =>  '${basedir}/target/site/tempdir' ) do
    execute_goals( 'stage',
                   :id => 'stage-for-scm-publish',
                   :phase => 'post-site',
                   'skipDeploy' =>  'false' )
  end

  plugin( :'scm-publish', '1.0-beta-2',
          'scmBranch' =>  'gh-pages',
          'pubScmUrl' =>  'scm:git:git@github.com:jruby/jruby.git',
          'tryUpdate' =>  'true' ) do
    execute_goals( 'publish-scm',
                   :id => 'scm-publish',
                   :phase => 'site-deploy' )
  end


  build do
    default_goal 'package'
  end

  profile 'gems' do

    modules [ 'gems' ]

  end

  profile 'docs' do

    modules [ 'docs' ]

  end

  profile 'main' do

    modules [ 'maven' ]

  end

  profile 'complete' do

    modules [ 'maven' ]

  end

  profile 'rake-plugin' do

    modules [ 'maven' ]

  end

  profile 'dist' do

    modules [ 'maven' ]

  end

  profile 'all' do

    modules [ 'docs',
            'maven' ]

    plugin :site do
      execute_goals( 'stage',
                     :phase => 'post-site' )
    end


    build do
      default_goal 'post-site'
    end

  end

  reporting do
    plugin( :'project-info-reports', '2.4',
            'dependencyLocationsEnabled' =>  'false',
            'dependencyDetailsEnabled' =>  'false' )
    plugin :changelog, '2.2'
    plugin( :checkstyle, '2.9.1',
            'configLocation' =>  '${main.basedir}/docs/style_checks.xml',
            'propertyExpansion' =>  'cacheFile=${project.build.directory}/checkstyle-cachefile' ) do
      report_set( 'checkstyle',
                  :inherited => 'false' )
    end

    plugin :dependency, '2.8' do
      report_set 'analyze-report'
    end

    plugin 'org.codehaus.mojo:findbugs-maven-plugin:2.5'
    plugin( :javadoc, '2.9',
            'quiet' =>  'true',
            'aggregate' =>  'true',
            'failOnError' =>  'false',
            'detectOfflineLinks' =>  'false',
            'show' =>  'package',
            'level' =>  'package',
            'maxmemory' =>  '512M' ) do
      report_set( 'javadoc',
                  'quiet' =>  'true',
                  'failOnError' =>  'false',
                  'detectOfflineLinks' =>  'false' )
    end

    plugin( :pmd, '2.7.1',
            'linkXRef' =>  'true',
            'sourceEncoding' =>  'utf-8',
            'minimumTokens' =>  '100',
            'targetJdk' =>  '1.6' )
    plugin :'surefire-report', '2.14.1'
    plugin( 'org.codehaus.mojo:taglist-maven-plugin:2.4',
            'tagListOptions' => {
              'tagClasses' => {
                'tagClass' => {
                  'tags' => [ { 'matchString' =>  'todo',
                                'matchType' =>  'ignoreCase' },
                              { 'matchString' =>  'FIXME',
                                'matchType' =>  'ignoreCase' },
                              { 'matchString' =>  'deprecated',
                                'matchType' =>  'ignoreCase' } ]
                }
              }
            } )
    plugin 'org.codehaus.mojo:versions-maven-plugin:2.1' do
      report_set 'dependency-updates-report', 'plugin-updates-report', 'property-updates-report'
    end

  end

end
