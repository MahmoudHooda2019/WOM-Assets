package wom.view.screen.popups.league
{
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.view.component.WomTextFormats;
   
   public class LeagueStatusPlacedPopUp extends LeagueStatusChangedPopUp
   {
      
      public function LeagueStatusPlacedPopUp(param1:LeagueLevelDIO)
      {
         super(param1);
      }
      
      override protected function getHeader() : String
      {
         var _loc1_:String = "ui.windows.league.placed.header";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      override protected function getBackgroundAssetId() : String
      {
         return "LeagueReach";
      }
      
      override protected function getTitle() : String
      {
         var _temp_1:* = "ui.windows.league.placed.title";
         var _loc1_:String = "domain.league.levels." + leagueLevelDIO.id + ".name";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:String = _temp_1;
         return peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
      }
      
      override protected function getTitleTextFormat() : TextFormat
      {
         return WomTextFormats.CENTER_20;
      }
      
      override protected function getDesc() : String
      {
         var _loc1_:String = "ui.windows.league.placed.desc";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      override protected function getDescTextFormat() : TextFormat
      {
         return WomTextFormats.CENTER_BOLD_18_WHITE;
      }
      
      override protected function getOkButtonLabel() : String
      {
         var _loc1_:String = "ui.windows.league.placed.done";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
      }
   }
}

