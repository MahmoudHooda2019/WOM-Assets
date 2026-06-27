package wom.view.screen.windows.store
{
   import peak.i18n.PText;
   
   public class CurrentAmountOfGoldView extends CurrentProgressView
   {
      
      public function CurrentAmountOfGoldView()
      {
         super();
      }
      
      override protected function getItemAssetId() : String
      {
         return "Gold";
      }
      
      override protected function getItemAssetScale() : Number
      {
         return 0.65;
      }
      
      override protected function getLabel() : String
      {
         var _loc1_:String = "ui.windows.store.currentbalance2";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
   }
}

