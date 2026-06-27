package wom.view.screen.popups.league
{
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.i18n.PText;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileLeagueStatusPlacedPopUp extends MobileLeagueStatusChangedPopUp
   {
      
      public function MobileLeagueStatusPlacedPopUp(param1:LeagueLevelDIO)
      {
         super(param1);
      }
      
      override protected function getHeader() : String
      {
         var _loc1_:String = "ui.windows.league.placed.header";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      override protected function getTitle() : String
      {
         var _temp_1:* = "ui.windows.league.placed.title";
         var _loc1_:String = "domain.league.levels." + leagueLevelDIO.id + ".name";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:String = _temp_1;
         return peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
      }
      
      override protected function getTitleTextFormat() : MPBitmapFontTextFormat
      {
         return getCaptionTextFormat(25,"center");
      }
      
      override protected function getDesc() : String
      {
         var _loc1_:String = "ui.windows.league.placed.desc";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      override protected function getDescTextFormat() : MPBitmapFontTextFormat
      {
         return getWomTextFormat(23,"center",16777215);
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

