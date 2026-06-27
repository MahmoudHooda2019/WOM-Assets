package peak.resource.atlas.starling
{
   import peak.resource.atlas.*;
   import peak.resource.atlas.native.NativeAtlas;
   import peak.starling.HitData;
   import starling.textures.TextureAtlas;
   import wom.Environment;
   
   public class StarlingAtlasManager extends AtlasManager
   {
      
      public var atlasArchive:Vector.<StarlingAtlas>;
      
      public function StarlingAtlasManager(param1:int, param2:int)
      {
         super(param1,param2);
         atlasArchive = new Vector.<StarlingAtlas>();
      }
      
      override public function onContextComplete() : void
      {
         for each(var _loc1_ in atlasArchive)
         {
            if(_loc1_)
            {
               if(!_loc1_.texture)
               {
                  _loc1_.texture = Environment.gpu.context3D.createTexture(_loc1_.textureSize,_loc1_.textureSize,"bgra",false);
               }
               _loc1_.uploadTexture();
            }
         }
      }
      
      override public function onContextLoss() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Atlas = null;
         _loc2_ = 0;
         while(_loc2_ < atlasArchive.length)
         {
            _loc1_ = atlasArchive[_loc2_];
            if(_loc1_)
            {
               _loc1_.onContextLoss();
            }
            _loc2_++;
         }
      }
      
      public function addTextureAtlas(param1:TextureAtlas, param2:HitData) : void
      {
         atlasArchive.push(new StarlingAtlas(this,param1,atlasArchive.length,param2));
      }
      
      public function getAtlasReference(param1:String) : StarlingAtlasReference
      {
         return references[param1];
      }
   }
}

