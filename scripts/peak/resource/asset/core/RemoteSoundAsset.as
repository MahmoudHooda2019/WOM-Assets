package peak.resource.asset.core
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.net.URLRequest;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   
   public class RemoteSoundAsset extends SoundAsset
   {
      
      public function RemoteSoundAsset(param1:String)
      {
         var _loc2_:Sound = new Sound(new URLRequest(param1));
         _loc2_.addEventListener("complete",onSourceLoaded);
         _loc2_.addEventListener("ioError",onSourceLoadError);
         super(_loc2_);
      }
      
      private function onSourceLoadError(param1:Event) : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"RemoteSoundAsset error",param1.toString());
      }
      
      private function onSourceLoaded(param1:Event) : void
      {
         dispatchEvent(new Event("change"));
      }
      
      override public function get complete() : Boolean
      {
         return available && _sound.bytesLoaded == _sound.bytesTotal;
      }
   }
}

