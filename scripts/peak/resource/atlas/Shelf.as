package peak.resource.atlas
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import peak.resource.atlas.native.NativeAtlas;
   
   public class Shelf
   {
      
      private var atlas:NativeAtlas;
      
      public var posX:int;
      
      public var posY:int;
      
      public var height:int;
      
      public var availableX:int;
      
      public function Shelf(param1:NativeAtlas, param2:int, param3:int, param4:int)
      {
         super();
         this.atlas = param1;
         this.posY = param2;
         this.posX = 0;
         this.height = param3;
         this.availableX = param4;
      }
      
      public function place(param1:BlockReference) : void
      {
         var _loc9_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc4_:Number = (posX + 1) / atlas.textureSize;
         var _loc3_:Number = (posY + 1) / atlas.textureSize;
         var _loc8_:Number = (param1.wReal + posX + 1) / atlas.textureSize;
         var _loc6_:Number = (param1.hReal + posY + 1) / atlas.textureSize;
         param1.place(atlas,_loc4_,_loc8_,_loc3_,_loc6_);
         var _loc7_:Rectangle = new Rectangle(param1.x,param1.y,param1.wReal,param1.hReal);
         var _loc10_:Point = new Point(posX + 1,posY + 1);
         atlas.bitmapData.copyPixels(param1.bitmapData,_loc7_,_loc10_);
         if(!param1.bitmapData.transparent)
         {
            _loc9_ = _loc10_.x;
            _loc11_ = _loc10_.y;
            _loc5_ = param1.wReal;
            _loc2_ = param1.hReal;
            _loc7_.x = _loc9_;
            _loc7_.width = _loc5_;
            _loc7_.height = 1;
            _loc10_.x = _loc9_;
            _loc7_.y = _loc11_;
            _loc10_.y = _loc7_.y - 1;
            atlas.bitmapData.copyPixels(atlas.bitmapData,_loc7_,_loc10_);
            _loc7_.y = _loc11_ + _loc2_ - 1;
            _loc10_.y = _loc7_.y + 1;
            atlas.bitmapData.copyPixels(atlas.bitmapData,_loc7_,_loc10_);
            _loc7_.y = _loc11_ - 1;
            _loc7_.width = 1;
            _loc7_.height = _loc2_ + 2;
            _loc10_.y = _loc11_ - 1;
            _loc7_.x = _loc9_;
            _loc10_.x = _loc7_.x - 1;
            atlas.bitmapData.copyPixels(atlas.bitmapData,_loc7_,_loc10_);
            _loc7_.x = _loc9_ + _loc5_ - 1;
            _loc10_.x = _loc7_.x + 1;
            atlas.bitmapData.copyPixels(atlas.bitmapData,_loc7_,_loc10_);
         }
         atlas.blocks.push(param1);
         posX += param1.w;
         availableX -= param1.w;
         atlas.tidy = false;
      }
   }
}

