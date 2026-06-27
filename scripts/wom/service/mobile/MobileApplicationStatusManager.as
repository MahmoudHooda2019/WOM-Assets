package wom.service.mobile
{
   import com.freshplanet.ane.AirDeviceId;
   import flash.events.Event;
   import org.robotlegs.mvcs.Actor;
   import peak.i18n.PText;
   import peak.network.ServerConnection;
   import peak.resource.SoundPlayer;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.mobile.MobileAlertDialogsEvent;
   import wom.controller.event.mobile.MobileApplicationEvent;
   import wom.controller.event.mobile.MobileApplicationStatusEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.message.request.MobileApplicationStatusChangedRequest;
   import wom.model.mobile.MobileAlertDialog;
   
   public class MobileApplicationStatusManager extends Actor
   {
      
      public static const SHORT:int = 0;
      
      public static const MEDIUM:int = 1;
      
      public static const LONG:int = 2;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var mobileNetworkInfoService:MobileNetworkInfoService;
      
      [Inject(name="gameServer")]
      public var serverConnection:ServerConnection;
      
      private var idleMode:Boolean;
      
      private var _autoReload:Boolean;
      
      private var _idleTimeoutDuration:int;
      
      public function MobileApplicationStatusManager()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         idleMode = false;
         _autoReload = true;
         _idleTimeoutDuration = 0;
         eventMap.mapListener(eventDispatcher,"activate",onActivate,Event);
         eventMap.mapListener(eventDispatcher,"deactivate",onDeactivate,Event);
         eventMap.mapListener(eventDispatcher,"disconnected",onDisconnected,Event);
      }
      
      private function onDisconnected(param1:MobileApplicationStatusEvent) : void
      {
         if(param1.autoReload)
         {
            dispatch(new MobileApplicationEvent("restartMobileApplication"));
         }
         else if(param1.networkNotConnected)
         {
            var _temp_7:* = §§findproperty(MobileAlertDialogsEvent);
            var _temp_6:* = "showMobileAlertDialog";
            var _temp_5:* = §§findproperty(MobileAlertDialog);
            var _temp_4:* = 1;
            var _temp_3:* = 4;
            var _loc2_:String = "m.ui.popups.noconnection.title";
            var _temp_2:* = peak.i18n.PText.INSTANCE.getText0(_loc2_);
            var _loc3_:String = "m.ui.popups.noconnection.message";
            var _temp_1:* = peak.i18n.PText.INSTANCE.getText0(_loc3_);
            var _loc4_:String = "m.ui.popups.noconnection.retry";
            dispatch(new MobileAlertDialogsEvent(_temp_6,new MobileAlertDialog(_temp_4,_temp_3,_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc4_))));
         }
         else
         {
            var _temp_15:* = §§findproperty(MobileAlertDialogsEvent);
            var _temp_14:* = "showMobileAlertDialog";
            var _temp_13:* = §§findproperty(MobileAlertDialog);
            var _temp_12:* = 1;
            var _temp_11:* = 0;
            var _loc5_:String = "m.ui.popups.disconnect.title";
            var _temp_10:* = peak.i18n.PText.INSTANCE.getText0(_loc5_);
            var _loc6_:String = "m.ui.popups.disconnect.message";
            var _temp_9:* = peak.i18n.PText.INSTANCE.getText0(_loc6_);
            var _loc7_:String = "m.ui.popups.disconnect.reload";
            dispatch(new MobileAlertDialogsEvent(_temp_14,new MobileAlertDialog(_temp_12,_temp_11,_temp_10,_temp_9,peak.i18n.PText.INSTANCE.getText0(_loc7_))));
         }
      }
      
      private function onActivate(param1:Event) : void
      {
         if(idleMode)
         {
            if(AirDeviceId.getInstance().isOnIOS && !mobileNetworkInfoService.isNetworkConnected())
            {
               dispatch(new MobileApplicationStatusEvent("disconnected",false,true));
            }
            else
            {
               idleMode = false;
               if(serverConnection.connected)
               {
                  _autoReload = true;
                  dispatch(new OutgoingMessageEvent("outgoingMessage",new MobileApplicationStatusChangedRequest(1)));
                  soundPlayer.musicEnabled = documentConfiguration.settings.musicEnabled;
               }
            }
         }
      }
      
      private function onDeactivate(param1:Event) : void
      {
         if(serverConnection.connected)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new MobileApplicationStatusChangedRequest(0,_idleTimeoutDuration)));
            soundPlayer.musicEnabled = false;
            idleMode = true;
            _idleTimeoutDuration = 0;
         }
      }
      
      public function set idleTimeoutDuration(param1:int) : void
      {
         _idleTimeoutDuration = param1;
      }
      
      public function set autoReload(param1:Boolean) : void
      {
         _autoReload = param1;
      }
      
      public function get autoReload() : Boolean
      {
         return _autoReload;
      }
   }
}

