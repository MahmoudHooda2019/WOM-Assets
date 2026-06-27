package peak.cuckoo.game.attribute.view
{
   import peak.signal.Signal0;
   
   public class AssetView extends BaseView
   {
      
      public var assetId:String;
      
      public var assetLoaded:Signal0;
      
      public function AssetView(param1:int, param2:String, param3:Boolean = false)
      {
         super(param1,param3);
         this.assetId = param2;
         assetLoaded = new Signal0();
      }
      
      override public function init() : void
      {
         super.init();
         assetLoaded.dispatch();
      }
      
      public function changeAsset(param1:String) : void
      {
         this.assetId = param1;
         gpuImage.assetReady();
         resetTransformation();
      }
   }
}

