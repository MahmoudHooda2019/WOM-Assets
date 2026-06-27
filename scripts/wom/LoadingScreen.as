package wom
{
   import com.greensock.TweenLite;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.external.ExternalInterface;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.sendToURL;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.component.PTextField;
   import peak.display.View;
   
   public class LoadingScreen extends Sprite implements View
   {
      
      public static const LoadingBackground:Class = §LoadingBackground_jpg$ad9a276bf9233286417adc5565f266fa-217646190§;
      
      public static const LoadingProgressLight:Class = LoadingProgressLight_png$426833004e296c513f0ff46758feec76137655426;
      
      public static const LoadingProgressShadow:Class = LoadingProgressShadow_png$3900e81497202cfefdae710cd45ea94a861012018;
      
      public static const LoadingProgressTrack:Class = LoadingProgressTrack_png$9fef652a77101c23f4599fd264e3a3f193702863;
      
      public static const PeakGamesLogo:Class = §PeakGamesLogo_png$247a0b7b93be298a7544a09361719e8b-453263314§;
      
      protected static var PreloaderFont:Class = PreloaderFont_swf$fb8523b77b48a2246ea46188d945dcee115071133;
      
      private static const PEAK_API_URL:String = "http://api.peakgames.net/api/v1/" + ClientLoader.KT_API_KEY;
      
      private var kontagentUserId:Number;
      
      private var newUser:Boolean;
      
      private var progressBackground:Bitmap;
      
      private var progressTrack:DisplayObject;
      
      private var progressTrackShadow:DisplayObject;
      
      private var progressTrackLight:DisplayObject;
      
      private var progressTrackMask:Sprite;
      
      private var progressTrackLightMask:Sprite;
      
      private var peakGamesLogo:DisplayObject;
      
      private var textField:TextField;
      
      public var maskPos:int;
      
      public var percentage:int;
      
      public function LoadingScreen(param1:Number, param2:Boolean)
      {
         super();
         this.kontagentUserId = param1;
         this.newUser = param2;
         init();
      }
      
      public function init() : void
      {
         sendCustomEventToKontagent({
            "n":"InitialScreen",
            "st1":"FlashLoadStarted"
         });
         if(newUser)
         {
            sendCustomEventToKontagent({
               "n":"InitialScreen",
               "st1":"FlashFirstLoadStarted"
            });
            if(ExternalInterface.available)
            {
               ExternalInterface.call("WOM.buybuddy.track",0);
            }
         }
         initLayout();
      }
      
      public function notifyLoadingFinished() : void
      {
         sendCustomEventToKontagent({
            "n":"InitialScreen",
            "st1":"FlashLoadEnded"
         });
         if(newUser)
         {
            sendCustomEventToKontagent({
               "n":"InitialScreen",
               "st1":"FlashFirstLoadEnded"
            });
            if(ExternalInterface.available)
            {
               ExternalInterface.call("WOM.buybuddy.track",1);
            }
         }
      }
      
      public function initLayout() : void
      {
         progressBackground = new LoadingBackground();
         addChild(progressBackground);
         progressTrack = new LoadingProgressTrack();
         addChild(progressTrack);
         progressTrackShadow = new LoadingProgressShadow();
         addChild(progressTrackShadow);
         progressTrackLight = new LoadingProgressLight();
         addChild(progressTrackLight);
         peakGamesLogo = new PeakGamesLogo();
         addChild(peakGamesLogo);
         progressTrackMask = new Sprite();
         progressTrackMask.graphics.beginFill(16719872);
         progressTrackMask.graphics.drawRoundRect(0,0,1,progressTrack.height,6,6);
         addChild(progressTrackMask);
         progressTrack.mask = progressTrackMask;
         progressTrackLightMask = new Sprite();
         progressTrackLightMask.graphics.beginFill(16711680);
         progressTrackLightMask.graphics.drawRect(progressTrack.width - 1,0,1,progressTrack.height);
         addChild(progressTrackLightMask);
         progressTrackLight.mask = progressTrackLightMask;
         textField = new PTextField();
         var _loc1_:TextFormat = textField.defaultTextFormat;
         _loc1_.font = "PreloaderFont";
         _loc1_.size = 16;
         _loc1_.color = 16777215;
         textField.defaultTextFormat = _loc1_;
         textField.autoSize = "left";
         textField.filters = [new GlowFilter(0,1,4,4,12,1)];
         textField.text = "";
         addChild(textField);
      }
      
      public function drawLayout() : void
      {
         if(stage == null)
         {
            return;
         }
         this.graphics.beginFill(0,1);
         this.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
         progressBackground.x = int((stage.stageWidth - progressBackground.width) / 2);
         progressBackground.y = int((stage.stageHeight - progressBackground.height) / 2);
         progressTrackMask.x = progressTrack.x = progressTrackShadow.x = progressBackground.x + 304;
         progressTrackMask.y = progressTrack.y = progressTrackShadow.y = progressBackground.y + 371;
         progressTrackLightMask.x = progressTrackLight.x = progressTrack.x + maskPos - progressTrackLight.width;
         progressTrackLightMask.y = progressTrackLight.y = progressTrack.y - 39;
         textField.x = progressTrack.x + (progressTrack.width - textField.width >> 1);
         textField.y = progressTrack.y - 3;
         peakGamesLogo.x = progressBackground.x + 421;
         peakGamesLogo.y = progressBackground.y + 590;
      }
      
      public function updateWithProgress(param1:Number, param2:Number) : void
      {
         var _loc3_:int = Math.min(100,int(param1 / param2 * 100));
         TweenLite.to(this,1,{
            "percentage":_loc3_,
            "onUpdate":updateProgressBar
         });
      }
      
      public function updateProgressBar() : void
      {
         maskPos = progressTrack.width / 100 * percentage;
         progressTrackMask.graphics.clear();
         progressTrackMask.graphics.beginFill(16711680);
         progressTrackMask.graphics.drawRoundRect(0,0,maskPos,progressTrack.height,6,6);
         if(maskPos < progressTrackLight.width)
         {
            progressTrackLightMask.graphics.drawRect(progressTrackLight.width - Math.min(progressTrackLight.width,maskPos),0,Math.min(progressTrack.width,maskPos),progressTrackLight.height);
         }
         else
         {
            progressTrackLight.mask = null;
            progressTrackLightMask.visible = false;
         }
         textField.text = percentage + "%";
         progressTrackLight.alpha = Math.min(2 * percentage / 100,1);
         drawLayout();
      }
      
      public function sendCustomEventToKontagent(param1:Object) : void
      {
         if(isNaN(kontagentUserId))
         {
            return;
         }
         param1["s"] = kontagentUserId;
         sendCustomEvent(param1,PEAK_API_URL);
      }
      
      private function log(param1:*) : void
      {
         trace(param1);
         if(ExternalInterface.available && ExternalInterface.call("function(){return typeof window.console == \'object\'}"))
         {
            ExternalInterface.call("console.log",param1);
         }
      }
      
      private function sendCustomEvent(param1:Object, param2:String) : void
      {
         var _loc3_:URLRequest = null;
         var _loc4_:URLVariables = null;
         try
         {
            _loc3_ = new URLRequest(param2 + "/evt/");
            _loc3_.method = "GET";
            _loc4_ = new URLVariables();
            for(var _loc5_ in param1)
            {
               _loc4_[_loc5_] = param1[_loc5_];
            }
            _loc3_.data = _loc4_;
            sendToURL(_loc3_);
         }
         catch(err:Error)
         {
         }
      }
   }
}

