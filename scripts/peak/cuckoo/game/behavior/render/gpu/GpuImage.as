package peak.cuckoo.game.behavior.render.gpu
{
   import flash.display3D.Context3D;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.ByteArray;
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.bounds.RenderBounds;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.behavior.animation.Animation;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   import peak.starling.*;
   import wom.Environment;
   
   public class GpuImage extends Attribute
   {
      
      public static const TYPE_ID:String = "GpuImage";
      
      public static const TINTED:uint = 1;
      
      private static const helperByteArray:ByteArray = new ByteArray();
      
      protected var context3D:Context3D;
      
      protected var vertexBuffer:VertexBuffer3D;
      
      public var state:uint;
      
      public var tint:uint = 4294967295;
      
      public var vertexBufferByteArray:ByteArray;
      
      public var vertexBufferIndex:uint = 0;
      
      public var vertexBufferOffset:uint = 0;
      
      public const TEMP_SIZE:int = 4;
      
      public var assetView:AssetView;
      
      public var renderBounds:RenderBounds;
      
      protected var render:GpuStarlingRender;
      
      protected var gameSprite:GameSprite;
      
      protected var reference:StarlingAtlasReference;
      
      public var frameX:Number;
      
      public var frameY:Number;
      
      public var frameXR:Number;
      
      public var frameYR:Number;
      
      public var ready:Boolean = false;
      
      public function GpuImage()
      {
         super();
      }
      
      override public function get typeId() : String
      {
         return "GpuImage";
      }
      
      override public function init() : void
      {
         renderBounds = owner.componentManager["RenderBounds"] as RenderBounds;
         render = owner.root.render as GpuStarlingRender;
         gameSprite = owner as GameSprite;
         if(gameSprite.view is AssetView)
         {
            assetView = gameSprite.view as AssetView;
         }
      }
      
      public function assetReady() : void
      {
         var _loc1_:Animation = null;
         var _loc2_:StarlingAtlasReference = null;
         context3D = Environment.gpu.context3D;
         if(!context3D)
         {
            return;
         }
         if(!assetView)
         {
            return;
         }
         if("Animation" in gameSprite.componentManager)
         {
            _loc1_ = gameSprite.componentManager["Animation"] as Animation;
         }
         if(!_loc1_)
         {
            _loc2_ = render.atlasManager.getAtlasReference(assetView.assetId);
            if(!_loc2_)
            {
               trace("-----------------------------------------ATLAS REFERENCE NOT FOUND---------------" + assetView.assetId);
            }
            else if(_loc2_.starlingAtlas)
            {
               this.reference = _loc2_;
               render.addToVertexBuffer(this);
               assetView.width = _loc2_.width;
               assetView.height = _loc2_.height;
               renderBounds.init();
               ready = true;
            }
         }
         else if(_loc1_.prepared)
         {
            render.addToVertexBuffer(this);
            assetView.width = _loc1_.frameWidth;
            assetView.height = _loc1_.frameHeight;
            renderBounds.init();
            ready = true;
         }
      }
      
      public function onContextLoss() : void
      {
         if(context3D != Environment.gpu.context3D)
         {
            context3D = Environment.gpu.context3D;
         }
      }
      
      public function updateCoords(param1:Boolean = false) : void
      {
         if(!vertexBufferByteArray)
         {
            return;
         }
         var _loc3_:Number = renderBounds.point.x + frameX;
         var _loc4_:Number = renderBounds.right + frameXR;
         var _loc2_:Number = renderBounds.bottom + frameYR;
         var _loc5_:Number = renderBounds.point.y + frameY;
         vertexBufferByteArray.position = vertexBufferOffset;
         vertexBufferByteArray.writeFloat(_loc3_);
         vertexBufferByteArray.writeFloat(_loc2_);
         vertexBufferByteArray.position = vertexBufferOffset + 5 * 4;
         vertexBufferByteArray.writeFloat(_loc3_);
         vertexBufferByteArray.writeFloat(_loc5_);
         vertexBufferByteArray.position = vertexBufferOffset + 10 * 4;
         vertexBufferByteArray.writeFloat(_loc4_);
         vertexBufferByteArray.writeFloat(_loc2_);
         vertexBufferByteArray.position = vertexBufferOffset + 15 * 4;
         vertexBufferByteArray.writeFloat(_loc4_);
         vertexBufferByteArray.writeFloat(_loc5_);
      }
      
      public function setAtlasReference(param1:StarlingAtlasReference) : void
      {
         state &= 65535;
         state |= param1.starlingAtlas.index << 16;
         frameX = param1.frameX;
         frameXR = param1.frameXR;
         frameY = param1.frameY;
         frameYR = param1.frameYR;
         this.reference = param1;
         if(!vertexBufferByteArray)
         {
            return;
         }
         vertexBufferByteArray.position = vertexBufferOffset + 2 * 4;
         vertexBufferByteArray.writeFloat(param1.uMin);
         vertexBufferByteArray.writeFloat(param1.vMax);
         vertexBufferByteArray.position = vertexBufferOffset + 7 * 4;
         vertexBufferByteArray.writeFloat(param1.uMin);
         vertexBufferByteArray.writeFloat(param1.vMin);
         vertexBufferByteArray.position = vertexBufferOffset + 12 * 4;
         vertexBufferByteArray.writeFloat(param1.uMax);
         vertexBufferByteArray.writeFloat(param1.vMax);
         vertexBufferByteArray.position = vertexBufferOffset + 17 * 4;
         vertexBufferByteArray.writeFloat(param1.uMax);
         vertexBufferByteArray.writeFloat(param1.vMin);
         updateCoords();
      }
      
      public function updateRGBAFilter(param1:uint = 4294967295) : void
      {
         if(!vertexBufferByteArray)
         {
            return;
         }
         tint = param1;
         if(this.tint != 4294967295)
         {
            this.state |= 1;
         }
         else
         {
            this.state &= ~1;
         }
         helperByteArray.position = 0;
         helperByteArray.writeUnsignedInt(param1);
         vertexBufferByteArray.position = vertexBufferOffset + 4 * 4;
         vertexBufferByteArray.writeBytes(helperByteArray,0,4);
         vertexBufferByteArray.position = vertexBufferOffset + 9 * 4;
         vertexBufferByteArray.writeBytes(helperByteArray,0,4);
         vertexBufferByteArray.position = vertexBufferOffset + 14 * 4;
         vertexBufferByteArray.writeBytes(helperByteArray,0,4);
         vertexBufferByteArray.position = vertexBufferOffset + 19 * 4;
         vertexBufferByteArray.writeBytes(helperByteArray,0,4);
      }
      
      final protected function invalidateTint() : void
      {
         if(tint != 4294967295)
         {
            state |= 1;
         }
         else
         {
            state &= ~1;
         }
      }
      
      public function updateColorFilter(param1:uint) : void
      {
         if(!vertexBufferByteArray)
         {
            return;
         }
         tint &= 255;
         tint |= param1 << 8;
         if(this.tint != 4294967295)
         {
            this.state |= 1;
         }
         else
         {
            this.state &= ~1;
         }
         helperByteArray.position = 0;
         helperByteArray.writeUnsignedInt(param1 << 8);
         vertexBufferByteArray.position = vertexBufferOffset + 4 * 4;
         vertexBufferByteArray.writeBytes(helperByteArray,0,3);
         vertexBufferByteArray.position = vertexBufferOffset + 9 * 4;
         vertexBufferByteArray.writeBytes(helperByteArray,0,3);
         vertexBufferByteArray.position = vertexBufferOffset + 14 * 4;
         vertexBufferByteArray.writeBytes(helperByteArray,0,3);
         vertexBufferByteArray.position = vertexBufferOffset + 19 * 4;
         vertexBufferByteArray.writeBytes(helperByteArray,0,3);
      }
      
      public function updateAlphaFilter(param1:Number = 1) : void
      {
         if(!vertexBufferByteArray)
         {
            return;
         }
         tint &= 4294967040;
         tint |= param1 * 255;
         if(this.tint != 4294967295)
         {
            this.state |= 1;
         }
         else
         {
            this.state &= ~1;
         }
         var _loc2_:int = param1 * 255;
         vertexBufferByteArray.position = vertexBufferOffset + 4 * 4 + 3;
         vertexBufferByteArray.writeByte(_loc2_);
         vertexBufferByteArray.position = vertexBufferOffset + 9 * 4 + 3;
         vertexBufferByteArray.writeByte(_loc2_);
         vertexBufferByteArray.position = vertexBufferOffset + 14 * 4 + 3;
         vertexBufferByteArray.writeByte(_loc2_);
         vertexBufferByteArray.position = vertexBufferOffset + 19 * 4 + 3;
         vertexBufferByteArray.writeByte(_loc2_);
      }
      
      public function updateColorFilterInt(param1:Number = 1, param2:Number = 1, param3:Number = 1, param4:Number = 1) : void
      {
         if(!vertexBufferByteArray)
         {
            return;
         }
         tint = param1 * 255 << 24 | param2 * 255 << 16 | param3 * 255 << 8 | param4 * 255;
         if(this.tint != 4294967295)
         {
            this.state |= 1;
         }
         else
         {
            this.state &= ~1;
         }
         helperByteArray.position = 0;
         helperByteArray.writeByte(param1 * 255);
         helperByteArray.writeByte(param2 * 255);
         helperByteArray.writeByte(param3 * 255);
         helperByteArray.writeByte(param4 * 255);
         vertexBufferByteArray.position = vertexBufferOffset + 4 * 4;
         vertexBufferByteArray.writeBytes(helperByteArray,0,4);
         vertexBufferByteArray.position = vertexBufferOffset + 9 * 4;
         vertexBufferByteArray.writeBytes(helperByteArray,0,4);
         vertexBufferByteArray.position = vertexBufferOffset + 14 * 4;
         vertexBufferByteArray.writeBytes(helperByteArray,0,4);
         vertexBufferByteArray.position = vertexBufferOffset + 19 * 4;
         vertexBufferByteArray.writeBytes(helperByteArray,0,4);
      }
      
      public function updateFilter(param1:uint) : void
      {
         state &= 4294902015;
         state |= param1 << 8;
      }
      
      public function setVertexBuffer(param1:uint) : void
      {
         vertexBufferByteArray = render.buffer;
         this.vertexBuffer = render.context3DVertexBuffer;
         vertexBufferOffset = param1 * 20;
         vertexBufferIndex = param1;
         updateRGBAFilter();
         if(reference)
         {
            setAtlasReference(reference);
         }
      }
      
      override public function destroy() : void
      {
         render.removeFromVertexBuffer(this);
         vertexBufferByteArray = null;
         ready = false;
         super.destroy();
      }
      
      public function hitTest(param1:int, param2:int) : Boolean
      {
         param1 -= frameX;
         param2 -= frameY;
         if(reference && reference.starlingAtlas.hitData && param1 >= 0 && param2 >= 0 && param1 <= reference.atlasWidth && param2 <= reference.atlasHeight)
         {
            var _temp_7:* = reference.starlingAtlas.hitData;
            var _temp_6:* = reference.x + param1;
            var _loc4_:Number = reference.y + param2;
            var _loc6_:Number = _temp_6;
            var _loc3_:HitData = _temp_7;
            var _loc5_:int = _loc4_ * _loc3_.width + _loc6_;
            return (_loc3_.source[_loc5_ >>> 3] & 1 << (_loc5_ & 7)) != 0;
         }
         return false;
      }
   }
}

