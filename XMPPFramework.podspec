Pod::Spec.new do |s|
  s.name = 'XMPPFramework'
  s.version = '3.6.4'
  s.license = { :type => 'BSD', :file => 'copying.txt' }
  s.summary = 'An XMPP Framework in Objective-C for the Mac / iOS development community.'
  s.homepage = 'https://github.com/robbiehanson/XMPPFramework'
  s.author = { 'Robbie Hanson' => 'robbiehanson@deusty.com' }
  s.source = { :git => 'https://github.com/robbiehanson/XMPPFramework.git', :tag => '3.6.4' }

  s.description = 'XMPPFramework provides a core implementation of RFC-3920 (the xmpp standard), along with
                  the tools needed to read & write XML. It comes with multiple popular extensions (XEP\'s),
                  all built atop a modular architecture, allowing you to plug-in any code needed for the job.
                  Additionally the framework is massively parallel and thread-safe. Structured using GCD,
                  this framework performs well regardless of whether it\'s being run on an old iPhone, or
                  on a 12-core Mac Pro. (And it won\'t block the main thread... at all).'
  s.requires_arc = true
  
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  s.default_subspec = 'Core'
  s.prepare_command = "echo '#import \"XMPP.h\"' > XMPPFramework.h\n grep '#define _XMPP_' -r Extensions \\\n | tr '-' '_' \\\n | perl -pe 's/Extensions\\/([A-z0-9_]*)\\/([A-z]*.h).*/\\n#ifdef HAVE_XMPP_SUBSPEC_\\U\\1\\n\\E#import \"\\2\"\\n#endif/' \\\n >> XMPPFramework.h\n"
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2 $(SDKROOT)/usr/include/libresolv' }
  
  s.subspec 'Core' do |ss|
    
    ss.source_files = "XMPPFramework.h", "Core/**/*.{h,m}", "Vendor/libidn/*.h", 'Authentication/**/*.{h,m}', 'Categories/**/*.{h,m}', 'Utilities/**/*.{h,m}'
    ss.resources = '**/*.{xcdatamodel,xcdatamodeld}'
    ss.vendored_libraries = 'Vendor/libidn/libidn.a'
    ss.libraries = 'xml2', 'resolv'

    ss.dependency 'CocoaLumberjack','~>1.6.2'
    ss.dependency 'CocoaAsyncSocket','~>7.3.1'
    ss.ios.dependency 'XMPPFramework/KissXML'
  end

  s.subspec 'KissXML' do |ss|
    ss.platform = :ios
    ss.source_files = 'Vendor/KissXML/**/*.{h,m}'
    ss.libraries = "xml2"
  end

  s.subspec 'BandwidthMonitor' do |ss|
    ss.source_files = 'Extensions/BandwidthMonitor'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_BANDWIDTHMONITOR'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'CoreDataStorage' do |ss|
    ss.source_files = 'Extensions/CoreDataStorage/**/*.{h,m}'
    ss.framework  = 'CoreData'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_COREDATASTORAGE'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'FileTransfer' do |ss|
    ss.source_files = 'Extensions/FileTransfer/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_FILETRANSFER'
    ss.dependency 'XMPPFramework/Core'
    ss.dependency 'XMPPFramework/XEP-0065'
  end

  s.subspec 'GoogleSharedStatus' do |ss|
    ss.source_files = 'Extensions/GoogleSharedStatus/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_GOOGLESHAREDSTATUS'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'ProcessOne' do |ss|
    ss.source_files = 'Extensions/ProcessOne/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_PROCESSONE'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'Reconnect' do |ss|
    ss.source_files = 'Extensions/Reconnect/**/*.{h,m}'
    ss.framework = 'SystemConfiguration'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_RECONNECT'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'Roster' do |ss|
    ss.source_files = 'Extensions/Roster/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_ROSTER'
    ss.dependency 'XMPPFramework/CoreDataStorage'
    ss.dependency 'XMPPFramework/XEP-0203'
  end
  
  s.subspec 'SystemInputActivityMonitor' do |ss|
    ss.platform = :osx
    ss.source_files = 'Extensions/SystemInputActivityMonitor/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_SYSTEMINPUTACTIVITYMONITOR'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0009' do |ss|
    ss.source_files = 'Extensions/XEP-0009/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0009'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0012' do |ss|
    ss.source_files = 'Extensions/XEP-0012/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0012'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0016' do |ss|
    ss.source_files = 'Extensions/XEP-0016/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0016'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0045' do |ss|
    ss.source_files = 'Extensions/XEP-0045/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0045'
    ss.dependency 'XMPPFramework/CoreDataStorage'
    ss.dependency 'XMPPFramework/XEP-0203'
  end

  s.subspec 'XEP-0054' do |ss|
    ss.source_files = 'Extensions/XEP-0054/**/*.{h,m}', 'Extensions/XEP-0153/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0054'
    ss.framework = 'CoreLocation'
    ss.dependency 'XMPPFramework/Roster'
  end

  s.subspec 'XEP-0059' do |ss|
    ss.source_files = 'Extensions/XEP-0059/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0059'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0060' do |ss|
    ss.source_files = 'Extensions/XEP-0060/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0060'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0065' do |ss|
    ss.source_files = 'Extensions/XEP-0065/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0065'
    ss.dependency 'XMPPFramework/Core'
  end
    
  s.subspec 'XEP-0066' do |ss|
    ss.source_files = 'Extensions/XEP-0066/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0066'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0077' do |ss|
    ss.source_files = 'Extensions/XEP-0077/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0077'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0082' do |ss|
    ss.source_files = 'Extensions/XEP-0082/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0082'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0085' do |ss|
    ss.source_files = 'Extensions/XEP-0085/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0085'
    ss.dependency 'XMPPFramework/Core'
  end
 
  s.subspec 'XEP-0092' do |ss|
    ss.source_files = 'Extensions/XEP-0092/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0092'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0100' do |ss|
    ss.source_files = 'Extensions/XEP-0100/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0100'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0106' do |ss|
    ss.source_files = 'Extensions/XEP-0106/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0106'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0115' do |ss|
    ss.source_files = 'Extensions/XEP-0115/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0115'
    ss.dependency 'XMPPFramework/CoreDataStorage'
  end

  s.subspec 'XEP-0136' do |ss|
    ss.source_files = 'Extensions/XEP-0136/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0136'
    ss.dependency 'XMPPFramework/CoreDataStorage'
    ss.dependency 'XMPPFramework/XEP-0203'
    ss.dependency 'XMPPFramework/XEP-0085'
  end

  s.subspec 'XEP-0153' do |ss|
    ss.source_files = 'Extensions/XEP-0054/**/*.{h,m}', 'Extensions/XEP-0153/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0153'
    ss.framework = 'CoreLocation'
    ss.dependency 'XMPPFramework/Roster'
  end

  s.subspec 'XEP-0172' do |ss|
    ss.source_files = 'Extensions/XEP-0172/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0172'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0184' do |ss|
    ss.source_files = 'Extensions/XEP-0184/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0184'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0191' do |ss|
    ss.source_files = 'Extensions/XEP-0191/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0191'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0198' do |ss|
    ss.source_files = 'Extensions/XEP-0198/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0198'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0199' do |ss|
    ss.source_files = 'Extensions/XEP-0199/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0199'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0202' do |ss|
    ss.source_files = 'Extensions/XEP-0202/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0202'
    ss.dependency 'XMPPFramework/XEP-0082'
  end
   
  s.subspec 'XEP-0203' do |ss|
    ss.source_files = 'Extensions/XEP-0203/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0203'
    ss.dependency 'XMPPFramework/XEP-0082'
  end

  s.subspec 'XEP-0223' do |ss|
    ss.source_files = 'Extensions/XEP-0223/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0223'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0224' do |ss|
    ss.source_files = 'Extensions/XEP-0224/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0224'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0280' do |ss|
    ss.source_files = 'Extensions/XEP-0280/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0280'
    ss.dependency 'XMPPFramework/Core'
    ss.dependency 'XMPPFramework/XEP-0297'
  end

  s.subspec 'XEP-0297' do |ss|
    ss.source_files = 'Extensions/XEP-0297/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0297'
    ss.dependency 'XMPPFramework/XEP-0203'
  end

  s.subspec 'XEP-0308' do |ss|
    ss.source_files = 'Extensions/XEP-0308/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0308'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0333' do |ss|
    ss.source_files = 'Extensions/XEP-0333/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0333'
    ss.dependency 'XMPPFramework/Core'
  end

  s.subspec 'XEP-0335' do |ss|
    ss.source_files = 'Extensions/XEP-0335/**/*.{h,m}'
    ss.prefix_header_contents = '#define HAVE_XMPP_SUBSPEC_XEP_0335'
    ss.dependency 'XMPPFramework/Core'
  end

end