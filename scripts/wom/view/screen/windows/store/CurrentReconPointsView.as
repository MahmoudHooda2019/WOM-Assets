package wom.view.screen.windows.store
{
   import peak.i18n.PText;
   
   public class CurrentReconPointsView extends CurrentProgressView
   {
      
      public function CurrentReconPointsView()
      {
         super();
      }
      
      override protected function getItemAssetId() : String
      {
         return "Rp";
      }
      
      override protected function getItemAssetScale() : Number
      {
         return 0.85;
      }
      
      override protected function getLabel() : String
      {
         var _loc1_:String = "ui.windows.store.currentrp2";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
   }
}

