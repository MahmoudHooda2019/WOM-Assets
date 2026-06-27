package wom.view.screen.windows.trainingchamber
{
   import feathers.controls.renderers.IListItemRenderer;
   import flash.geom.Rectangle;
   import peak.component.mobile.MPItemRenderer;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileTrainingChamberItemViewRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private var _mercenaryData:Object;
      
      private var _mercenaryView:MobileTrainingChamberItemView;
      
      private var _mercenaryInfoView:MobileTrainingChamberItemInfoView;
      
      private var assetRepository:MobileWomAssetRepository;
      
      public function MobileTrainingChamberItemViewRenderer(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         this.clipRect = new Rectangle(7,0,344,516);
      }
      
      override public function get data() : Object
      {
         return _mercenaryData;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _mercenaryData = param1;
            if(_mercenaryData.showMercenaryView)
            {
               mercenaryView.updateMercenaryData(_mercenaryData);
            }
            else
            {
               mercenaryInfoView.updateMercenaryData(_mercenaryData);
            }
            toggleViews();
         }
      }
      
      public function onHintButtonClicked() : void
      {
         mercenaryInfoView.updateMercenaryData(_mercenaryData);
         mercenaryView.updateMercenaryData(_mercenaryData);
         _mercenaryData.showMercenaryView = MobileWomUIComponentFactory.addFlipTween(mercenaryView,mercenaryInfoView,_mercenaryData.showMercenaryView,toggleViews);
      }
      
      private function toggleViews() : void
      {
         mercenaryView.visible = _mercenaryData.showMercenaryView;
         mercenaryInfoView.visible = !_mercenaryData.showMercenaryView;
      }
      
      public function get mercenaryView() : MobileTrainingChamberItemView
      {
         if(!_mercenaryView)
         {
            _mercenaryView = new MobileTrainingChamberItemView(assetRepository);
            addChild(_mercenaryView);
         }
         return _mercenaryView;
      }
      
      public function get mercenaryInfoView() : MobileTrainingChamberItemInfoView
      {
         if(!_mercenaryInfoView)
         {
            _mercenaryInfoView = new MobileTrainingChamberItemInfoView(assetRepository);
            addChild(_mercenaryInfoView);
         }
         return _mercenaryInfoView;
      }
   }
}

