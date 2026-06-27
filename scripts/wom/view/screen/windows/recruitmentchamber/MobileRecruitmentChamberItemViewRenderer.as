package wom.view.screen.windows.recruitmentchamber
{
   import feathers.controls.renderers.IListItemRenderer;
   import flash.geom.Rectangle;
   import peak.component.mobile.MPItemRenderer;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileRecruitmentChamberItemViewRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private var _mercenaryData:Object;
      
      private var _mercenaryView:MobileRecruitmentChamberItemView;
      
      private var _mercenaryInfoView:MobileRecruitmentChamberItemInfoView;
      
      private var assetRepository:MobileWomAssetRepository;
      
      public function MobileRecruitmentChamberItemViewRenderer(param1:MobileWomAssetRepository)
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
         if(mercenaryInfoView.data == null)
         {
            mercenaryInfoView.updateMercenaryData(_mercenaryData);
         }
         if(mercenaryView.data == null)
         {
            mercenaryView.updateMercenaryData(_mercenaryData);
         }
         _mercenaryData.showMercenaryView = MobileWomUIComponentFactory.addFlipTween(mercenaryView,mercenaryInfoView,_mercenaryData.showMercenaryView,toggleViews);
      }
      
      private function toggleViews() : void
      {
         mercenaryView.visible = _mercenaryData.showMercenaryView;
         mercenaryInfoView.visible = !_mercenaryData.showMercenaryView;
      }
      
      public function get mercenaryView() : MobileRecruitmentChamberItemView
      {
         if(!_mercenaryView)
         {
            _mercenaryView = new MobileRecruitmentChamberItemView(assetRepository);
            addChild(_mercenaryView);
         }
         return _mercenaryView;
      }
      
      public function get mercenaryInfoView() : MobileRecruitmentChamberItemInfoView
      {
         if(!_mercenaryInfoView)
         {
            _mercenaryInfoView = new MobileRecruitmentChamberItemInfoView(assetRepository);
            addChild(_mercenaryInfoView);
         }
         return _mercenaryInfoView;
      }
   }
}

