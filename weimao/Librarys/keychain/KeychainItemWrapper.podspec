Pod::Spec.new do |s|
  s.name         = "KeychainItemWrapper"
  s.version      = "0.0.1"
  s.summary      = "The KeychainItemWrapper original code from Apple, with ARC and NSDictionary support "
  s.homepage     = "https://github.com/baptistefetet/KeychainItemWrapper"
  s.license      = 'BSD'
  s.author       = { 'Baptiste FETET' => 'baptiste@octiplex.com' }
  s.source       = { :git => "https://github.com/baptistefetet/KeychainItemWrapper.git" }
  s.source_files = '*.{h,m}'
  s.requires_arc = true
end
