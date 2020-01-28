Pod::Spec.new do |spec|

  spec.name                   = 'CBHMapReduceKit'
  spec.version                = '1.1.0'
  spec.module_name            = 'CBHMapReduceKit'

  spec.summary                = 'Adds map, filter, and reduce methods to common collection types.'
  spec.homepage               = 'https://github.com/chris-huxtable/CBHMapReduceKit'

  spec.license                = { :type => 'ISC', :file => 'LICENSE' }

  spec.author                 = { 'Chris Huxtable' => 'chris@huxtable.ca' }
  spec.social_media_url       = 'https://twitter.com/@Chris_Huxtable'

  spec.osx.deployment_target  = '10.11'

  spec.source                 = { :git => 'https://github.com/chris-huxtable/CBHMapReduceKit.git', :tag => "v#{spec.version}" }

  spec.requires_arc           = true

  spec.public_header_files    = 'CBHMapReduceKit/*.h'
  #spec.private_header_files   = 'CBHMapReduceKit/_*.h'
  spec.source_files           = 'CBHMapReduceKit/*.{h,m}'

end
