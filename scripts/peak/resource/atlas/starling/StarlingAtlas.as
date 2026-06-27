package peak.resource.atlas.starling
{
   import flash.geom.Rectangle;
   import peak.resource.atlas.*;
   import peak.starling.HitData;
   import starling.textures.TextureAtlas;
   
   public class StarlingAtlas extends Atlas
   {
      
      public var textureAtlas:TextureAtlas;
      
      public var hitData:HitData;
      
      public var names:Vector.<String>;
      
      public function StarlingAtlas(param1:AtlasManager, param2:TextureAtlas, param3:uint, param4:HitData)
      {
         var _loc11_:int = 0;
         var _loc9_:StarlingAtlasReference = null;
         var _loc10_:int = 0;
         var _loc5_:Rectangle = null;
         var _loc6_:Rectangle = null;
         super(param1,0,param3);
         this.textureAtlas = param2;
         this.premultipliedAlpha = param2.texture.premultipliedAlpha;
         this.compressed = param2.texture.format == "compressedAlpha";
         texture = param2.texture.base;
         names = param2.getNames();
         this.hitData = param4;
         var _loc7_:Number = param2.texture.width;
         var _loc8_:Number = param2.texture.height;
         _loc11_ = 0;
         while(_loc11_ < names.length)
         {
            _loc9_ = new StarlingAtlasReference();
            _loc9_.name = names[_loc11_];
            _loc10_ = _loc9_.name == "GrassTile" || _loc9_.name == "GrassTileM" || _loc9_.name == "CityGreenFloor" ? 1 : 0;
            _loc5_ = param2.getRegion(_loc9_.name);
            _loc9_.uMin = (_loc5_.left + _loc10_) / _loc7_;
            _loc9_.uMax = (_loc5_.right - _loc10_) / _loc7_;
            _loc9_.vMin = (_loc5_.top + _loc10_) / _loc8_;
            _loc9_.vMax = (_loc5_.bottom - _loc10_) / _loc8_;
            _loc9_.x = _loc5_.x;
            _loc9_.y = _loc5_.y;
            _loc9_.atlasWidth = _loc9_.width = _loc5_.width;
            _loc9_.atlasHeight = _loc9_.height = _loc5_.height;
            _loc6_ = param2.getFrame(_loc9_.name);
            if(_loc6_)
            {
               _loc9_.frameX = -_loc6_.x;
               _loc9_.frameY = -_loc6_.y;
               _loc9_.frameXR = _loc5_.width - _loc6_.right;
               _loc9_.frameYR = _loc5_.height - _loc6_.bottom;
               _loc9_.width = _loc6_.width;
               _loc9_.height = _loc6_.height;
            }
            _loc9_.starlingAtlas = this;
            _loc9_.texture = this.texture;
            param1.references[_loc9_.name] = _loc9_;
            _loc11_++;
         }
      }
   }
}

