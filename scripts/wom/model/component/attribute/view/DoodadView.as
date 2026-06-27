package wom.model.component.attribute.view
{
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.resource.AssetRepository;
   
   public class DoodadView extends AssetView
   {
      
      public function DoodadView(param1:String, param2:AssetRepository)
      {
         super(3,param1);
      }
      
      override public function init() : void
      {
         super.init();
      }
   }
}

