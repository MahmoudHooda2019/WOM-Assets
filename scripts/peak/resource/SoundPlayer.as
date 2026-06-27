package peak.resource
{
   import flash.media.Sound;
   import flash.media.SoundChannel;
   
   public interface SoundPlayer
   {
      
      function get sfxEnabled() : Boolean;
      
      function set sfxEnabled(param1:Boolean) : void;
      
      function get musicEnabled() : Boolean;
      
      function set musicEnabled(param1:Boolean) : void;
      
      function playSfx(param1:Sound, param2:Number = 0, param3:Number = 1, param4:int = 0) : SoundChannel;
      
      function playSfxById(param1:String) : SoundChannel;
      
      function playMusic(param1:Sound, param2:int = 2147483647, param3:Boolean = true) : SoundChannel;
      
      function playMusicById(param1:String, param2:int = 2147483647) : SoundChannel;
      
      function playMusicListById(param1:Array, param2:int = 2147483647) : void;
      
      function onDisableSfx(param1:Function) : void;
      
      function onEnableSfx(param1:Function) : void;
      
      function playAmbient(param1:Sound, param2:int = 2147483647) : SoundChannel;
      
      function stopAmbient() : void;
      
      function playAmbientById(param1:String, param2:int = 2147483647) : SoundChannel;
      
      function stopMusic(param1:Boolean = true) : void;
   }
}

