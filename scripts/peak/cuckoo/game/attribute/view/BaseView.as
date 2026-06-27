package peak.cuckoo.game.attribute.view
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.behavior.render.gpu.GpuImage;
   import peak.cuckoo.game.behavior.render.gpu.GpuTransformableImage;
   
   public class BaseView extends Attribute
   {
      
      public static const TYPE_ID:String = "BaseView";
      
      public var layerId:int;
      
      public var prepared:Boolean = false;
      
      public var bitmap:Bitmap;
      
      public var _bitmapData:BitmapData;
      
      public var bitmapDataRect:Rectangle;
      
      protected var ownerSprite:GameSprite;
      
      public var gpuImage:GpuImage;
      
      public var gpuTransformableImage:GpuTransformableImage;
      
      public var transformable:Boolean;
      
      public var width:Number = 0;
      
      public var height:Number = 0;
      
      public function BaseView(param1:int, param2:Boolean = false)
      {
         super();
         this.layerId = param1;
         this.transformable = param2;
      }
      
      override public function get typeId() : String
      {
         return "BaseView";
      }
      
      override public function init() : void
      {
         super.init();
         ownerSprite = owner as GameSprite;
         owner.root.render.prepareView(this);
      }
      
      override public function enable() : void
      {
         super.enable();
      }
      
      override public function disable() : void
      {
         super.disable();
      }
      
      override public function destroy() : void
      {
         if(ownerSprite && ownerSprite.root && layerId in ownerSprite.root.layers)
         {
            (ownerSprite.root.layers[layerId] as Layer).allChildrenContainer.remove(ownerSprite);
         }
         super.destroy();
      }
      
      public function set bitmapData(param1:BitmapData) : void
      {
      }
      
      public function colorFilter(param1:uint = 16777215) : void
      {
         if(gpuImage)
         {
            gpuImage.updateColorFilter(param1);
         }
      }
      
      public function rgbaFilter(param1:uint = 4294967295) : void
      {
         if(gpuImage)
         {
            gpuImage.updateRGBAFilter(param1);
         }
      }
      
      public function rgbaFilterNumber(param1:Number = 1, param2:Number = 1, param3:Number = 1, param4:Number = 1) : void
      {
         if(gpuImage)
         {
            gpuImage.updateColorFilterInt(param1,param2,param3,param4);
         }
      }
      
      public function alphaFilter(param1:Number = 1) : void
      {
         if(gpuImage)
         {
            gpuImage.updateAlphaFilter(param1);
         }
      }
      
      public function glowEnabled(param1:Boolean) : void
      {
      }
      
      public function scale(param1:Number = 1, param2:Number = 1) : void
      {
         if(gpuTransformableImage)
         {
            gpuTransformableImage.scale(param1,param2);
         }
      }
      
      public function scaleFixed(param1:Number) : void
      {
         if(gpuTransformableImage)
         {
            gpuTransformableImage.scale(param1,param1);
         }
      }
      
      public function rotate(param1:Number) : void
      {
         if(gpuTransformableImage)
         {
            gpuTransformableImage.angle(param1);
         }
      }
      
      public function resetTransformation() : void
      {
         if(gpuTransformableImage)
         {
            gpuTransformableImage.resetTransformation();
         }
      }
      
      public function applyMatrix(param1:Matrix) : void
      {
         if(gpuTransformableImage)
         {
            gpuTransformableImage.applyMatrix(param1);
         }
      }
      
      public function hitTest(param1:int, param2:int) : Boolean
      {
         if(gpuImage)
         {
            return gpuImage.hitTest(param1,param2);
         }
         return false;
      }
   }
}

