package wom.controller.event
{
   import flash.events.Event;
   import wom.model.resource.asset.AssetCategoryType;
   
   public class PreloadAssetsEvent extends Event
   {
      
      public static const PRELOAD:String = "createWindow";
      
      private var _assetCategory:AssetCategoryType;
      
      public function PreloadAssetsEvent(param1:String, param2:AssetCategoryType)
      {
         super(param1);
         _assetCategory = param2;
      }
      
      override public function clone() : Event
      {
         return new PreloadAssetsEvent(type,_assetCategory);
      }
      
      public function get assetCategory() : AssetCategoryType
      {
         return _assetCategory;
      }
   }
}

