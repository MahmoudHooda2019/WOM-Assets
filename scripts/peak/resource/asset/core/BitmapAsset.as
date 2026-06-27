package peak.resource.asset.core
{
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import peak.resource.asset.display.AssetContent;
   import peak.resource.asset.display.ScalableAssetPainter;
   import peak.resource.asset.display.Scale9AssetPainter;
   
   public class BitmapAsset extends EventDispatcher
   {
      
      protected var _dependencies:Vector.<BitmapAssetReference>;
      
      protected var _bitmapData:BitmapData;
      
      protected var _hasAnimation:Boolean;
      
      protected var _scalePainter:ScalableAssetPainter;
      
      protected var _hitArea:Vector.<Point>;
      
      public function BitmapAsset(param1:BitmapData = null, param2:Scale9AssetPainter = null, param3:Vector.<Point> = null)
      {
         super();
         _dependencies = new Vector.<BitmapAssetReference>();
         _bitmapData = param1;
         _hasAnimation = false;
         _scalePainter = param2;
         _hitArea = param3;
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bitmapData;
      }
      
      public function get width() : int
      {
         return bitmapData == null ? 0 : bitmapData.width;
      }
      
      public function get height() : int
      {
         return bitmapData == null ? 0 : bitmapData.height;
      }
      
      public function get hasAnimation() : Boolean
      {
         return _hasAnimation;
      }
      
      public function get scalePainter() : ScalableAssetPainter
      {
         return _scalePainter;
      }
      
      public function get hitArea() : Vector.<Point>
      {
         return _hitArea;
      }
      
      public function get scalable() : Boolean
      {
         return _scalePainter != null;
      }
      
      public function get interactive() : Boolean
      {
         return scalable || _hitArea != null;
      }
      
      public function get dependencies() : Vector.<BitmapAssetReference>
      {
         return _dependencies;
      }
      
      public function addDependency(param1:BitmapAssetReference) : void
      {
         param1.addEventListener("change",onDependencyChange);
         _dependencies.push(param1);
      }
      
      public function get available() : Boolean
      {
         return _bitmapData != null;
      }
      
      public function get complete() : Boolean
      {
         for each(var _loc1_ in _dependencies)
         {
            if(!_loc1_.complete)
            {
               return false;
            }
         }
         return true;
      }
      
      protected function onDependencyChange(param1:Event) : void
      {
         update();
      }
      
      public function update() : void
      {
         dispatchEvent(new Event("change"));
      }
      
      public function updateFrame(param1:AssetContent) : void
      {
      }
   }
}

