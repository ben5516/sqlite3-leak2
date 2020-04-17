Barebones leak demonstration, includes only the following:

- motion-provisioning (for building to device)
- motion.h (With Andrew Haven's updates for Catalina) `gem 'motion.h', git: 'https://github.com/andrewhavens/motion.h.git', branch: 'chore/catalina-updates'`

In `Rakefile`
```ruby
app.development do
  app.codesign_certificate = MotionProvisioning.certificate(type: :development, platform: :ios)
  app.provisioning_profile = MotionProvisioning.profile(
      type: :development,
      platform: :ios,
      app_name: app.name,
      bundle_identifier: app.identifier
    )
end

app.libs << "/usr/lib/libsqlite3.dylib"
app.include "sqlite3.h"
```

In `app_delegate.rb`

```ruby
library_path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, true)[0]
filename = File.join(library_path, 'test.db')
pointer = Pointer.new(::Sqlite3.type)
result = sqlite3_open(filename, pointer)

1_000_000.times do
  pointer.value
end

sqlite3_close(pointer.value)

puts "complete"
```
