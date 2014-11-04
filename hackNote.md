###创建新target

File->New->Target

选择Bundle

Bundle Extension填写osax。

###修改新target的Info.plist文件

Bundle OS Type code 修改为 osax

添加Scriptable为YES

Bundle creator OS Type code 修改为 luan（特定字符串，这个不确定）

增加Scripting definition file name 为 controlWindows.sdef（可以使用${}那种，但是我不熟，sdef文件名应与项目名相同）

增加以下：

	OSAXHandlers[Dictionary]
		Events[Dictinary]
			tryosaxx[Dictionary](Scripting Bridge发送的字段)
				ThreadSafe[Boolean] NO
				Handler[String]loadPlugin(SB触发函数)
				Context[String]Process
			
将生成的.osax文件拷贝到/Users/app/Library/ScriptingAdditions。

###监听App启动，发送SB

	#import <ScriptingBridge/ScriptingBridge.h>
添加以上头文件，``ScriptingBridge/ScriptingBridge.h``顾名思义引入SB。

添加``ScriptingBridge.framework``框架。

	[[[NSWorkspace sharedWorkspace] notificationCenter]
	     addObserver:self selector:@selector(someAppEngine:)
	     name:NSWorkspaceDidLaunchApplicationNotification object:nil];
	    
在``applicationDidFinishLaunching``中添加以上代码监听App启动，如果有其他App启动，则注册的selector启动。

以下代码为selector实现。

	- (void) someAppEngine:(NSNotification*)notification
	{
	    NSDictionary* appInfo = [notification userInfo];
	    NSString* appName = [appInfo objectForKey:@"NSApplicationName"];
	    NSLog(@"appName: %@", appName);
	    
	    pid_t pid = [[appInfo objectForKey:@"NSApplicationProcessIdentifier"] intValue];
	    SBApplication *app = [SBApplication applicationWithProcessIdentifier:pid];
	    app.delegate = self;
	    if (!app)
	    {
	        NSLog(@"Can't find app with pid %d", pid);
	        return;
	    }
	    
	    [app setSendMode:kAENoReply | kAENeverInteract | kAEDontRecord];
    id injectReply = [app sendEvent:'cnwd' id:'load' parameters:0];
    
	    if (injectReply != nil)
	    {
	        NSLog(@"unexpected injectReply: %@", injectReply);
	    }
	    else
	    {
	        NSLog(@"expected injectReply%@", injectReply);
	    }
	}

如果事件发送出现问题则``- (void) eventDidFail:(const AppleEvent*)event withError:(NSError*)error``该方法触发。


问题：

运行controlWindows后，thridScriptTest第一次运行可以响应脚本扩展。
但是osaxTry不行。

要想thridScriptTest再次响应需要再次运行controlWindows。
也就是运行controlWindows后需要紧接着运行thridScriptTest。

可能是osax拷贝的位置有问题？

easySIMBL 把osax放置在用户的library文件夹下，但是我的不行只能放置在系统library文件夹下。