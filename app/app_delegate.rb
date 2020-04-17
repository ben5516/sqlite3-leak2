class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = UIViewController.alloc.init
    rootViewController.title = 'sqlite3-leak2'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible


    library_path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, true)[0]
    filename = File.join(library_path, 'test.db')
    pointer = Pointer.new(::Sqlite3.type)
    result = sqlite3_open(filename, pointer)

    1_000_000.times do
      pointer.value
    end

    sqlite3_close(pointer.value)

    puts "complete"

    true
  end
end
