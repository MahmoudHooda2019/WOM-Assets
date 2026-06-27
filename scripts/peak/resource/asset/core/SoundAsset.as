package peak.resource.asset.core
{
   import flash.events.EventDispatcher;
   import flash.media.Sound;
   
   public class SoundAsset extends EventDispatcher
   {
      
      protected var _sound:Sound;
      
      public function SoundAsset(param1:Sound)
      {
         super();
         _sound = param1;
      }
      
      public function get sound() : Sound
      {
         return _sound;
      }
      
      public function get available() : Boolean
      {
         return _sound != null;
      }
      
      public function get complete() : Boolean
      {
         return available;
      }
   }
}

