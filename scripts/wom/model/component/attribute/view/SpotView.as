package wom.model.component.attribute.view
{
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.resource.AssetRepository;
   import peak.resource.asset.core.BitmapAssetReference;
   
   public class SpotView extends AssetView
   {
      
      private var passedSpotSource:BitmapAssetReference;
      
      public function SpotView(param1:AssetRepository)
      {
         super(3,"MapPin");
         passedSpotSource = param1.getBitmapAssetReference("MapPinPass");
      }
      
      override public function init() : void
      {
         super.init();
      }
      
      public function toggleSpotView(param1:Boolean) : void
      {
      }
   }
}

