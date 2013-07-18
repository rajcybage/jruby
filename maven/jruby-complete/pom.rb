project 'JRuby Complete' do

  model_version '4.0.0'
  id 'org.jruby:jruby-complete:1.7.5.dev'
  inherit 'org.jruby:jruby-artifacts:1.7.5.dev'
  packaging 'jar'

  properties( 'main.basedir' => '${project.parent.parent.basedir}' )

  jar 'org.jruby:jruby-core:${project.version}'
  jar 'org.jruby:jruby-stdlib:${project.version}'

  plugin :shade, '2.1' do
    execute_goals( 'shade',
                   :id => 'pack jruby.artifact',
                   :phase => 'package',
                   'relocations' => [ { 'pattern' =>  'org.objectweb',
                                        'shadedPattern' =>  'org.jruby.org.objectweb' } ],
                   'transformers' => [ { '@implementation' =>  'org.apache.maven.plugins.shade.resource.ManifestResourceTransformer',
                                         'mainClass' =>  'org.jruby.Main' } ] )
  end

  plugin( :invoker, '1.5',
          'projectsDirectory' =>  'src/it',
          'cloneProjectsTo' =>  '${project.build.directory}/it',
          'preBuildHookScript' =>  'setup.bsh',
          'postBuildHookScript' =>  'verify.bsh' ) do
    execute_goals( 'install', 'run',
                   :id => 'integration-test',
                   'settingsFile' =>  '${basedir}/src/it/settings.xml',
                   'localRepositoryPath' =>  '${project.build.directory}/local-repo' )
  end

end
