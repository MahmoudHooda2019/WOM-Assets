package peak.resource
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Timer;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.resource.asset.core.SoundAssetReference;
   import peak.signal.Signal0;
   
   public class DefaultSoundPlayer implements SoundPlayer
   {
      
      private static const MUSIC_VOLUME:Number = 0.7;
      
      private static const AMBIENT_VOLUME:Number = 0.7;
      
      private static const SFX_VOLUME:Number = 0.5;
      
      private static const FADE_DURATION:int = 3;
      
      [Inject]
      public var assetRepository:AssetRepository;
      
      protected var currentMusicPlaylist:Array;
      
      protected var currentMusicPlaylistIndex:int;
      
      protected var currentMusicPlaylistLoop:int;
      
      private var listSpacingTimer:Timer;
      
      protected var currentlyPlayingMusic:SoundChannel;
      
      protected var currentlyPlayingAmbient:SoundChannel;
      
      private var _sfxEnabled:Boolean;
      
      private var _musicEnabled:Boolean;
      
      private var sfxDisabledSignal:Signal0;
      
      private var sfxEnabledSignal:Signal0;
      
      public function DefaultSoundPlayer()
      {
         super();
         _sfxEnabled = true;
         _musicEnabled = true;
         sfxDisabledSignal = new Signal0();
         sfxEnabledSignal = new Signal0();
         listSpacingTimer = new Timer(0,1);
         listSpacingTimer.addEventListener("timerComplete",onMusicTrackComplete);
      }
      
      public function get sfxEnabled() : Boolean
      {
         return _sfxEnabled;
      }
      
      public function set sfxEnabled(param1:Boolean) : void
      {
         _sfxEnabled = param1;
         if(!param1)
         {
            sfxDisabledSignal.dispatch();
         }
         else
         {
            sfxEnabledSignal.dispatch();
         }
      }
      
      public function get musicEnabled() : Boolean
      {
         return _musicEnabled;
      }
      
      public function set musicEnabled(param1:Boolean) : void
      {
         if(param1 != _musicEnabled)
         {
            if(currentlyPlayingMusic)
            {
               if(param1)
               {
                  if(!TweenMax.isTweening(currentlyPlayingMusic))
                  {
                     TweenLite.to(currentlyPlayingMusic,3,{"soundTransform":{"volume":0.7}});
                  }
               }
               else
               {
                  TweenLite.killTweensOf(currentlyPlayingMusic);
                  currentlyPlayingMusic.soundTransform = new SoundTransform(0);
               }
            }
            if(currentlyPlayingAmbient)
            {
               if(param1)
               {
                  if(!TweenMax.isTweening(currentlyPlayingAmbient))
                  {
                     TweenLite.to(currentlyPlayingAmbient,3,{"soundTransform":{"volume":0.7}});
                  }
               }
               else
               {
                  TweenLite.killTweensOf(currentlyPlayingAmbient);
                  currentlyPlayingAmbient.soundTransform = new SoundTransform(0);
               }
            }
         }
         _musicEnabled = param1;
      }
      
      public function playSfx(param1:Sound, param2:Number = 0, param3:Number = 1, param4:int = 0) : SoundChannel
      {
         var _loc5_:SoundChannel = null;
         try
         {
            _loc5_ = param1.play(0,param4,new SoundTransform(param3 * (_sfxEnabled ? 0.5 : 0),param2));
         }
         catch(e:Error)
         {
            _loc5_ = new SoundChannel();
         }
         return _loc5_;
      }
      
      public function playSfxById(param1:String) : SoundChannel
      {
         if(!_sfxEnabled)
         {
            return null;
         }
         var _loc2_:SoundAssetReference = assetRepository.getSoundAssetReference(param1);
         if(_loc2_.complete)
         {
            false && log(LoggerContexts.INFRASTRUCTURE,"playing sfx",param1);
            return playSfx(_loc2_.soundAsset.sound);
         }
         return null;
      }
      
      public function playMusic(param1:Sound, param2:int = 2147483647, param3:Boolean = true) : SoundChannel
      {
         stopMusic(param3);
         currentlyPlayingMusic = param1.play(0,param2,new SoundTransform(_musicEnabled && !param3 ? 0.7 : 0));
         if(_musicEnabled && param3)
         {
            TweenLite.to(currentlyPlayingAmbient,3,{"soundTransform":{"volume":0.7}});
         }
         return currentlyPlayingMusic;
      }
      
      public function stopMusic(param1:Boolean = true) : void
      {
         listSpacingTimer.reset();
         if(param1)
         {
            if(currentlyPlayingMusic)
            {
               TweenLite.to(currentlyPlayingMusic,3,{
                  "soundTransform":{"volume":0},
                  "onComplete":stopAfterFadeOut,
                  "onCompleteParams":[currentlyPlayingMusic]
               });
            }
         }
         else if(currentlyPlayingMusic)
         {
            currentlyPlayingMusic.stop();
         }
      }
      
      private function stopAfterFadeOut(param1:SoundChannel) : void
      {
         listSpacingTimer.reset();
         param1.stop();
      }
      
      public function playAmbient(param1:Sound, param2:int = 2147483647) : SoundChannel
      {
         stopAmbient();
         currentlyPlayingAmbient = param1.play(0,param2,new SoundTransform(_musicEnabled ? 0.7 : 0));
         return currentlyPlayingAmbient;
      }
      
      public function stopAmbient() : void
      {
         if(currentlyPlayingAmbient)
         {
            currentlyPlayingAmbient.stop();
         }
      }
      
      public function playAmbientById(param1:String, param2:int = 2147483647) : SoundChannel
      {
         var _loc3_:SoundAssetReference = assetRepository.getSoundAssetReference(param1);
         if(_loc3_.available)
         {
            return playAmbient(_loc3_.soundAsset.sound,param2);
         }
         return null;
      }
      
      public function playMusicById(param1:String, param2:int = 2147483647) : SoundChannel
      {
         var _loc3_:SoundAssetReference = assetRepository.getSoundAssetReference(param1);
         if(_loc3_.available)
         {
            return playMusic(_loc3_.soundAsset.sound,param2,false);
         }
         return null;
      }
      
      public function playMusicListById(param1:Array, param2:int = 2147483647) : void
      {
         currentMusicPlaylist = param1;
         currentMusicPlaylistIndex = 0;
         currentMusicPlaylistLoop = param2;
         playNextTrack();
      }
      
      public function onDisableSfx(param1:Function) : void
      {
         sfxDisabledSignal.addFunction(param1);
      }
      
      public function onEnableSfx(param1:Function) : void
      {
         sfxEnabledSignal.addFunction(param1);
      }
      
      private function onMusicTrackComplete(param1:Event) : void
      {
         playNextTrack();
      }
      
      private function playNextTrack() : void
      {
         var _loc1_:SoundChannel = null;
         var _loc2_:* = currentMusicPlaylist[currentMusicPlaylistIndex];
         if(_loc2_ is String || _loc2_ is Sound)
         {
            if(_loc2_ is Sound)
            {
               _loc1_ = playMusic(_loc2_ as Sound,0,false);
            }
            else
            {
               _loc1_ = playMusicById(_loc2_ as String,0);
            }
            if(++currentMusicPlaylistIndex == currentMusicPlaylist.length)
            {
               if(--currentMusicPlaylistLoop == 0)
               {
                  return;
               }
               currentMusicPlaylistIndex = 0;
            }
            if(_loc1_)
            {
               _loc1_.addEventListener("soundComplete",onMusicTrackComplete);
            }
            else
            {
               playNextTrack();
            }
         }
         else
         {
            if(++currentMusicPlaylistIndex == currentMusicPlaylist.length)
            {
               if(--currentMusicPlaylistLoop == 0)
               {
                  return;
               }
               currentMusicPlaylistIndex = 0;
            }
            listSpacingTimer.reset();
            listSpacingTimer.delay = _loc2_;
            listSpacingTimer.repeatCount = 1;
            listSpacingTimer.start();
         }
      }
   }
}

