package peak.cuckoo.game.behavior.render.gpu
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import peak.starling.*;
   
   public class GpuTransformableImage extends GpuImage
   {
      
      private var modificationDone:Boolean = false;
      
      private var _center:Point = new Point();
      
      private var r:Matrix = new Matrix();
      
      private var m:Matrix = new Matrix();
      
      public function GpuTransformableImage()
      {
         super();
      }
      
      override public function updateCoords(param1:Boolean = false) : void
      {
         var _loc4_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc6_:Matrix = null;
         var _loc8_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc9_:Number = NaN;
         if(modificationDone)
         {
            if(!vertexBufferByteArray)
            {
               return;
            }
            if(!param1)
            {
               renderBounds.update();
               return;
            }
            _loc4_ = renderBounds.point.x + frameX;
            _loc7_ = renderBounds.right + frameXR;
            _loc2_ = renderBounds.bottom + frameYR;
            _loc10_ = renderBounds.point.y + frameY;
            _center.x = renderBounds.point.x + reference.width / 2;
            _center.y = renderBounds.point.y + reference.height / 2;
            m.identity();
            m.translate(-_center.x,-_center.y);
            m.concat(r);
            m.translate(_center.x,_center.y);
            _loc6_ = m.clone();
            m.identity();
            m.tx = _loc4_;
            m.ty = _loc2_;
            m.concat(_loc6_);
            vertexBufferByteArray.position = vertexBufferOffset;
            vertexBufferByteArray.writeFloat(m.tx);
            vertexBufferByteArray.writeFloat(m.ty);
            m.identity();
            m.tx = _loc4_;
            m.ty = _loc10_;
            m.concat(_loc6_);
            vertexBufferByteArray.position = vertexBufferOffset + 5 * 4;
            vertexBufferByteArray.writeFloat(m.tx);
            vertexBufferByteArray.writeFloat(m.ty);
            m.identity();
            m.tx = _loc7_;
            m.ty = _loc2_;
            m.concat(_loc6_);
            vertexBufferByteArray.position = vertexBufferOffset + 10 * 4;
            vertexBufferByteArray.writeFloat(m.tx);
            vertexBufferByteArray.writeFloat(m.ty);
            m.identity();
            m.tx = _loc7_;
            m.ty = _loc10_;
            m.concat(_loc6_);
            vertexBufferByteArray.position = vertexBufferOffset + 15 * 4;
            vertexBufferByteArray.writeFloat(m.tx);
            vertexBufferByteArray.writeFloat(m.ty);
            m.identity();
            m.tx = renderBounds.point.x;
            m.ty = renderBounds.point.y;
            m.concat(_loc6_);
            _loc8_ = m.tx;
            _loc5_ = m.tx;
            _loc3_ = m.ty;
            _loc9_ = m.ty;
            m.identity();
            m.tx = renderBounds.right;
            m.ty = renderBounds.bottom;
            m.concat(_loc6_);
            _loc8_ = _loc8_ > m.tx ? m.tx : _loc8_;
            _loc5_ = _loc5_ < m.tx ? m.tx : _loc5_;
            _loc3_ = _loc3_ > m.ty ? m.ty : _loc3_;
            _loc9_ = _loc9_ < m.ty ? m.ty : _loc9_;
            m.identity();
            m.tx = renderBounds.point.x;
            m.ty = renderBounds.bottom;
            m.concat(_loc6_);
            _loc8_ = _loc8_ > m.tx ? m.tx : _loc8_;
            _loc5_ = _loc5_ < m.tx ? m.tx : _loc5_;
            _loc3_ = _loc3_ > m.ty ? m.ty : _loc3_;
            _loc9_ = _loc9_ < m.ty ? m.ty : _loc9_;
            m.identity();
            m.tx = renderBounds.right;
            m.ty = renderBounds.point.y;
            m.concat(_loc6_);
            _loc8_ = _loc8_ > m.tx ? m.tx : _loc8_;
            _loc5_ = _loc5_ < m.tx ? m.tx : _loc5_;
            _loc3_ = _loc3_ > m.ty ? m.ty : _loc3_;
            _loc9_ = _loc9_ < m.ty ? m.ty : _loc9_;
            renderBounds.point.x = _loc8_;
            renderBounds.point.y = _loc3_;
            renderBounds.right = _loc5_;
            renderBounds.bottom = _loc9_;
            renderBounds.width = _loc5_ - _loc8_;
            renderBounds.height = _loc9_ - _loc3_;
         }
         else
         {
            super.updateCoords();
         }
      }
      
      public function angle(param1:Number) : void
      {
         r.identity();
         r.rotate(param1);
         modificationDone = true;
         updateCoords();
      }
      
      public function scale(param1:Number, param2:Number) : void
      {
         r.identity();
         r.scale(param1,param2);
         modificationDone = true;
         updateCoords();
      }
      
      public function applyMatrix(param1:Matrix) : void
      {
         this.r = param1.clone();
         modificationDone = true;
         updateCoords();
      }
      
      public function resetTransformation() : void
      {
         r.identity();
         modificationDone = false;
         updateCoords();
      }
      
      override public function hitTest(param1:int, param2:int) : Boolean
      {
         var _loc3_:Matrix = r.clone();
         _loc3_.invert();
         _loc3_.tx = _loc3_.ty = 0;
         m.identity();
         m.tx = param1;
         m.ty = param2;
         m.concat(_loc3_);
         param1 = m.tx - frameX;
         param2 = m.ty - frameY;
         if(reference && reference.starlingAtlas.hitData && param1 >= 0 && param2 >= 0 && param1 <= reference.atlasWidth && param2 <= reference.atlasHeight)
         {
            var _temp_7:* = reference.starlingAtlas.hitData;
            var _temp_6:* = reference.x + param1;
            var _loc6_:Number = reference.y + param2;
            var _loc8_:Number = _temp_6;
            var _loc5_:HitData = _temp_7;
            var _loc7_:int = _loc6_ * _loc5_.width + _loc8_;
            return (_loc5_.source[_loc7_ >>> 3] & 1 << (_loc7_ & 7)) != 0;
         }
         return false;
      }
   }
}

