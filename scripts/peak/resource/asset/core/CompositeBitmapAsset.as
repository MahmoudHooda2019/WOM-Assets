package peak.resource.asset.core
{
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import peak.resource.asset.display.AssetContent;
   import peak.resource.asset.display.Scale9AssetPainter;
   
   public class CompositeBitmapAsset extends BitmapAsset
   {
      
      protected var nodes:Vector.<CompositeBitmapAssetNode>;
      
      public function CompositeBitmapAsset(param1:Scale9AssetPainter = null, param2:Vector.<Point> = null)
      {
         super(null,param1,param2);
         nodes = new Vector.<CompositeBitmapAssetNode>();
      }
      
      private function addNode(param1:BitmapAssetNode) : void
      {
         nodes.push(param1);
         param1.addEventListener("change",onNodeChange);
         update();
      }
      
      public function addDynamicNode(param1:String, param2:Number = 0, param3:Number = 0) : void
      {
         var _loc4_:DynamicBitmapAssetReference = new DynamicBitmapAssetReference(param1);
         addDependency(_loc4_);
         addNode(new CompositeBitmapAssetNode(_loc4_,param2,param3));
      }
      
      public function addConcreteNode(param1:BitmapAsset, param2:Number = 0, param3:Number = 0) : void
      {
         addNode(new CompositeBitmapAssetNode(new BitmapAssetReference(param1),param2,param3));
         for each(var _loc4_ in param1.dependencies)
         {
            addDependency(_loc4_);
         }
      }
      
      private function onNodeChange(param1:Event) : void
      {
         update();
      }
      
      override public function updateFrame(param1:AssetContent) : void
      {
         if(_hasAnimation)
         {
            for each(var _loc2_ in nodes)
            {
               if(_loc2_.assetReference.resolved)
               {
                  _loc2_.assetReference.bitmapAsset.updateFrame(param1);
               }
            }
            draw();
         }
      }
      
      protected function draw() : void
      {
         var _loc1_:BitmapData = null;
         _bitmapData.lock();
         _bitmapData.fillRect(_bitmapData.rect,16777215);
         var _loc3_:Boolean = false;
         for each(var _loc2_ in nodes)
         {
            if(_loc2_.assetReference.available)
            {
               _loc1_ = _loc2_.assetReference.bitmapAsset.bitmapData;
               if(_loc1_ != null)
               {
                  _bitmapData.copyPixels(_loc1_,_loc1_.rect,_loc2_.position,null,null,_loc3_);
                  _loc3_ = true;
               }
            }
         }
         _bitmapData.unlock();
      }
      
      override public function update() : void
      {
         var _loc2_:Rectangle = new Rectangle();
         _hasAnimation = false;
         var _loc3_:Boolean = false;
         for each(var _loc1_ in nodes)
         {
            if(_loc1_.assetReference.resolved)
            {
               if(_loc1_.assetReference.complete)
               {
                  _loc2_ = _loc2_.union(_loc1_.bounds);
                  _loc3_ = true;
               }
               if(_loc1_.assetReference.bitmapAsset.hasAnimation)
               {
                  _hasAnimation = true;
               }
            }
         }
         if(_loc3_)
         {
            if(_bitmapData == null || _loc2_.width > _bitmapData.width || _loc2_.height > _bitmapData.height)
            {
               if(_bitmapData != null)
               {
                  _bitmapData.dispose();
               }
               _bitmapData = new BitmapData(_loc2_.width,_loc2_.height);
            }
            draw();
         }
         super.update();
      }
   }
}

