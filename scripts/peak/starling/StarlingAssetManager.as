package peak.starling
{
   import flash.display3D.Context3D;
   import flash.display3D.textures.RectangleTexture;
   import flash.display3D.textures.Texture;
   import flash.display3D.textures.TextureBase;
   import flash.filesystem.File;
   import flash.filesystem.FileStream;
   import flash.system.System;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import starling.core.Starling;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   import starling.text.BitmapFont;
   import starling.text.TextField;
   import starling.textures.ConcreteTexture;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class StarlingAssetManager extends EventDispatcher
   {
      
      protected var textures:Dictionary;
      
      protected var atlases:Dictionary;
      
      protected var hitDatas:Dictionary;
      
      protected var asyncTextures:Vector.<starling.textures.Texture>;
      
      protected var asyncSources:Dictionary;
      
      public var files:Vector.<AssetFile>;
      
      public function StarlingAssetManager()
      {
         super();
         textures = new Dictionary();
         atlases = new Dictionary();
         hitDatas = new Dictionary();
         files = new Vector.<AssetFile>(0);
         asyncTextures = new Vector.<starling.textures.Texture>(0);
         asyncSources = new Dictionary();
      }
      
      protected static function createTextureFromRawData(param1:ByteArray, param2:Number = 1) : starling.textures.Texture
      {
         var _loc9_:* = 0;
         var _loc8_:TextureBase = null;
         var _loc5_:flash.display3D.textures.Texture = null;
         var _loc7_:* = 0;
         var _loc6_:* = 0;
         var _loc14_:int = 0;
         var _loc3_:RectangleTexture = null;
         var _loc12_:Context3D = Starling.context;
         var _loc4_:uint = param1.length;
         var _loc13_:uint = 0;
         var _loc11_:uint = 1;
         _loc9_ = 1;
         while(_loc9_ <= _loc4_ >> 4)
         {
            _loc13_++;
            _loc9_ <<= 2;
            _loc11_ <<= 1;
         }
         var _loc10_:Boolean = _loc4_ != 1 << (_loc13_ << 1) << 2;
         if(_loc10_)
         {
            _loc5_ = _loc12_.createTexture(_loc11_,_loc11_,"bgra",false,_loc13_);
            _loc7_ = 0;
            _loc6_ = 0;
            while(_loc7_ < _loc4_ && _loc6_ < _loc13_ + 1)
            {
               _loc14_ = 1 << (_loc13_ - _loc6_ << 1) << 2;
               _loc5_.uploadFromByteArray(param1,_loc7_,_loc6_);
               _loc7_ += _loc14_;
               _loc6_++;
            }
            _loc8_ = _loc5_;
         }
         else
         {
            _loc3_ = _loc12_.createRectangleTexture(_loc11_,_loc11_,"bgra",false);
            _loc3_.uploadFromByteArray(param1,0);
            _loc8_ = _loc3_;
         }
         return new ConcreteTexture(_loc8_,"bgra",_loc11_,_loc11_,_loc10_,false,false,param2);
      }
      
      public function enqueuePath(param1:String, param2:Number = 1, param3:Boolean = false) : void
      {
         enqueueFile(File.applicationDirectory.resolvePath(param1),param2,param3);
      }
      
      public function enqueueFile(param1:File, param2:Number, param3:Boolean) : void
      {
         if(param1.isDirectory)
         {
            for each(var _loc4_ in param1.getDirectoryListing())
            {
               enqueueFile(_loc4_,param2,param3);
            }
         }
         else
         {
            files.push(new AssetFile(param1,param2,param3));
         }
      }
      
      public function loadQueue(param1:Function = null) : void
      {
         var _loc10_:Array = null;
         var _loc18_:String = null;
         var _loc12_:String = null;
         var _loc6_:starling.textures.Texture = null;
         var _loc19_:ByteArray = null;
         var _loc5_:ByteArray = null;
         var _loc8_:XML = null;
         var _loc15_:String = null;
         var _loc13_:starling.textures.Texture = null;
         var _loc2_:starling.textures.Texture = null;
         var _loc4_:starling.textures.Texture = null;
         var _loc16_:FileStream = new FileStream();
         var _loc9_:ByteArray = new ByteArray();
         var _loc14_:Dictionary = new Dictionary();
         var _loc11_:Dictionary = new Dictionary();
         var _loc7_:Dictionary = new Dictionary();
         var _loc17_:Number = 0;
         var _loc3_:Number = files.length;
         for each(var _loc20_ in files)
         {
            _loc10_ = _loc20_.file.name.split(".");
            _loc18_ = _loc10_.shift();
            _loc16_.open(_loc20_.file,"read");
            _loc9_.length = _loc16_.bytesAvailable;
            _loc16_.readBytes(_loc9_);
            while(_loc10_.length > 0)
            {
               switch(_loc12_ = _loc10_.pop())
               {
                  case "lzma":
                     _loc9_.uncompress("lzma");
                     break;
                  case "xml":
                     _loc14_[_loc18_] = new XML(_loc9_);
                     break;
                  case "fnt":
                     _loc11_[_loc18_] = new XML(_loc9_);
                     break;
                  case "raw":
                     textures[_loc18_] = createTextureFromRawData(_loc9_,_loc20_.scale);
                     break;
                  case "atf":
                     if(_loc20_.async)
                     {
                        _loc19_ = new ByteArray();
                        _loc19_.writeBytes(_loc9_);
                        _loc6_ = createTextureFromAtfData(_loc19_,_loc20_.scale,true);
                        asyncSources[_loc6_] = _loc19_;
                        asyncTextures.push(_loc6_);
                     }
                     else
                     {
                        _loc6_ = createTextureFromAtfData(_loc9_,_loc20_.scale,false);
                     }
                     textures[_loc18_] = _loc6_;
                     break;
                  case "hit":
                     _loc5_ = new ByteArray();
                     _loc5_.writeBytes(_loc9_);
                     _loc7_[_loc18_] = _loc5_;
               }
            }
            if(Boolean(param1))
            {
               param1(++_loc17_ / _loc3_);
            }
         }
         for(_loc15_ in _loc14_)
         {
            _loc8_ = _loc14_[_loc15_] as XML;
            _loc13_ = getTexture(_loc15_);
            atlases[_loc15_] = new TextureAtlas(_loc13_,_loc8_);
            delete textures[_loc15_];
            System.disposeXML(_loc8_);
         }
         for(_loc15_ in _loc11_)
         {
            _loc8_ = _loc11_[_loc15_] as XML;
            _loc2_ = getTexture(_loc15_);
            TextField.registerBitmapFont(new BitmapFont(_loc2_,_loc8_),_loc15_);
            delete textures[_loc15_];
            System.disposeXML(_loc8_);
         }
         for(_loc15_ in _loc7_)
         {
            _loc4_ = getTextureAtlas(_loc15_).texture;
            hitDatas[_loc15_] = new HitData(_loc7_[_loc15_] as ByteArray,_loc4_.width,_loc4_.height);
         }
         _loc9_.clear();
         files = new Vector.<AssetFile>(0);
         if(asyncTextures.length == 0)
         {
            dispatchEvent(new Event("complete"));
         }
      }
      
      public function getTexture(param1:String) : starling.textures.Texture
      {
         var _loc2_:starling.textures.Texture = null;
         if(param1 in textures)
         {
            return textures[param1];
         }
         for each(var _loc3_ in atlases)
         {
            _loc2_ = _loc3_.getTexture(param1);
            if(_loc2_)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getTextureAtlas(param1:String) : TextureAtlas
      {
         return atlases[param1] as TextureAtlas;
      }
      
      public function getHitData(param1:String) : HitData
      {
         return hitDatas[param1] as HitData;
      }
      
      protected function createTextureFromAtfData(param1:ByteArray, param2:Number = 1, param3:Boolean = false) : starling.textures.Texture
      {
         return starling.textures.Texture.fromAtfData(param1,param2,false,param3 ? onAsyncAtfUploadComplete : null);
      }
      
      protected function onAsyncAtfUploadComplete(param1:starling.textures.Texture) : void
      {
         (asyncSources[param1] as ByteArray).clear();
         delete asyncSources[param1];
         asyncTextures.splice(asyncTextures.indexOf(param1),1);
         if(asyncTextures.length == 0)
         {
            dispatchEvent(new Event("complete"));
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc2_ in hitDatas)
         {
            _loc2_.source.clear();
         }
         for each(var _loc1_ in atlases)
         {
            _loc1_.dispose();
         }
      }
   }
}

import flash.filesystem.File;

class AssetFile
{
   
   public var file:File;
   
   public var scale:Number;
   
   public var async:Boolean;
   
   public function AssetFile(param1:File, param2:Number, param3:Boolean)
   {
      super();
      this.file = param1;
      this.scale = param2;
      this.async = param3;
   }
}
