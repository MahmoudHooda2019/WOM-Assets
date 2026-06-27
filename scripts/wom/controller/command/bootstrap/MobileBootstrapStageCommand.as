package wom.controller.command.bootstrap
{
   import com.greensock.plugins.SoundTransformPlugin;
   import com.greensock.plugins.TweenPlugin;
   import flash.desktop.NativeApplication;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.UncaughtErrorEvent;
   import flash.external.ExternalInterface;
   import flash.media.SoundMixer;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.ui.Mouse;
   import org.robotlegs.core.IEventMap;
   import org.robotlegs.mvcs.StarlingCommand;
   import peak.display.Viewport;
   import peak.display.ViewportResizeEvent;
   import peak.logging.LoggerContexts;
   import peak.logging.ShippingLoggerTarget;
   import peak.logging.log;
   import peak.resource.SoundPlayer;
   import peak.util.ExternalMouseHandler;
   import wom.Client;
   import wom.Environment;
   import wom.ane.velocity.VelocityController;
   import wom.ane.velocity.events.VelocityEvent;
   import wom.controller.event.ui.LeaveGamePopUpEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.domain.DomainInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.friend.InboxInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.service.facebook.FacebookAPIManager;
   import wom.service.kontagent.WomKontagentApi;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.MobileRootScreen;
   
   public class MobileBootstrapStageCommand extends StarlingCommand
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      [Inject]
      public var logShipper:ShippingLoggerTarget;
      
      [Inject]
      public var inboxInfo:InboxInfo;
      
      [Inject]
      public var facebookApiManager:FacebookAPIManager;
      
      [Inject]
      public var velocityController:VelocityController;
      
      [Inject]
      public var eventMap:IEventMap;
      
      public function MobileBootstrapStageCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         domainInfo.init();
         initStage();
         createRootScreen();
      }
      
      public function initStage() : void
      {
         Environment.loaderInfo.uncaughtErrorEvents.addEventListener("uncaughtError",onUncaughtError,false,0,true);
         Environment.stage.scaleMode = "noScale";
         Environment.stage.align = "TL";
         Environment.stage.showDefaultContextMenu = false;
         SoundMixer.audioPlaybackMode = "ambient";
         contextView.stage.addEventListener("resize",onStageResize);
         TweenPlugin.activate([SoundTransformPlugin]);
         ExternalMouseHandler.init(Environment.stage);
         MobileWomUIComponentFactory.init(assetRepository);
         var _loc1_:Object = Environment.loaderInfo.parameters;
         delete _loc1_["lang_definitions"];
         delete _loc1_["friends2"];
         delete _loc1_["womfriends2"];
         log(LoggerContexts.INFRASTRUCTURE,"Parameters",_loc1_);
         log(LoggerContexts.INFRASTRUCTURE,"Environment true",{
            "debugger":Capabilities.isDebugger,
            "os":Capabilities.os,
            "screen":Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY,
            "player":Capabilities.playerType,
            "version":Capabilities.version,
            "nativecursor":Mouse.supportsNativeCursor
         });
         eventMap.mapListener(velocityController,"panGestureMove",onStageDependentGesture,VelocityEvent);
         eventMap.mapListener(velocityController,"panGestureEnd",onStageDependentGesture,VelocityEvent);
         eventMap.mapListener(velocityController,"pinchGestureMove",onStageDependentGesture,VelocityEvent);
         eventMap.mapListener(velocityController,"pinchGestureEnd",onStageDependentGesture,VelocityEvent);
         registerMouseCursors();
         registerExternalInterfaceEvents();
         NativeApplication.nativeApplication.removeEventListener("keyDown",Client.onKeyDown);
         NativeApplication.nativeApplication.addEventListener("keyDown",onKeyDown,false,0,true);
         dispatchResizeEvent();
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 16777238)
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            Environment.stage.dispatchEvent(new LeaveGamePopUpEvent("showLeaveGamePopUp",null,0));
         }
      }
      
      private function onStageDependentGesture(param1:VelocityEvent) : void
      {
         Environment.stage.dispatchEvent(param1.clone());
      }
      
      private function registerExternalInterfaceEvents() : void
      {
         if(ExternalInterface.available)
         {
            Security.loadPolicyFile("https://womassets-a.akamaihd.net/crossdomain.xml");
            Security.loadPolicyFile("https://graph.facebook.com/crossdomain.xml");
            Security.allowDomain("*");
            ExternalInterface.addCallback("openWindow",onOpenWindow);
         }
      }
      
      private function onOpenWindow(param1:String) : void
      {
      }
      
      private function registerMouseCursors() : void
      {
      }
      
      private function onUncaughtError(param1:UncaughtErrorEvent) : void
      {
         var _loc2_:Error = null;
         try
         {
            if(param1.error is Error)
            {
               _loc2_ = param1.error as Error;
               log(LoggerContexts.UNCAUGHT_ERROR,_loc2_.name + " " + _loc2_.message + " " + _loc2_.getStackTrace());
               if(_loc2_ is SecurityError)
               {
                  return;
               }
            }
            else if(param1.error is ErrorEvent)
            {
               log(LoggerContexts.UNCAUGHT_ERROR,"ErrorEvent: " + (param1.error as ErrorEvent).errorID + " " + (param1.error as ErrorEvent).toString());
            }
            else
            {
               log(LoggerContexts.UNCAUGHT_ERROR,"Non-Error: " + param1.error);
            }
            logShipper.flushBuffer();
         }
         catch(e:Error)
         {
         }
      }
      
      private function onStageResize(param1:Event) : void
      {
         dispatchResizeEvent();
      }
      
      private function dispatchResizeEvent() : void
      {
         if(!userInfo.viewport || userInfo.viewport.width != contextView.stage.stageWidth || userInfo.viewport.height != contextView.stage.stageHeight)
         {
            dispatch(new ViewportResizeEvent("resize",new Viewport(contextView.stage.stageWidth,contextView.stage.stageHeight)));
         }
      }
      
      private function createRootScreen() : void
      {
         var _loc1_:MobileRootScreen = new MobileRootScreen();
         contextView.addChild(_loc1_);
      }
   }
}

