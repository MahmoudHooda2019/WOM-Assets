package wom.view.screen.popups.league
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.view.screen.windows.league.mobile.MobileLeagueInfoMediumView;
   
   public class MobileLeagueStatusChangedPopUp extends MobileLeagueStatusDroppedPopUp
   {
      
      private var _leagueLevelDIO:LeagueLevelDIO;
      
      private var _leagueInfoView:MobileLeagueInfoMediumView;
      
      public function MobileLeagueStatusChangedPopUp(param1:LeagueLevelDIO)
      {
         super();
         _leagueLevelDIO = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _leagueInfoView = new MobileLeagueInfoMediumView(_leagueLevelDIO,false);
         addChild(_leagueInfoView);
         drawLayout();
      }
      
      override protected function getHeader() : String
      {
         var _loc1_:String = "ui.windows.league.changed.header";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      override protected function getTitle() : String
      {
         var _temp_1:* = "ui.windows.league.changed.title";
         var _loc1_:String = "domain.league.levels." + _leagueLevelDIO.id + ".name";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:String = _temp_1;
         return peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
      }
      
      override protected function getDesc() : String
      {
         var _loc1_:String = "ui.windows.league.changed.desc";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      override protected function getOkButtonLabel() : String
      {
         var _loc1_:String = "ui.windows.league.changed.done";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         if(_leagueInfoView)
         {
            MobileAlignmentUtil.alignMiddleOf(_leagueInfoView,_shieldBackground);
         }
      }
      
      public function get leagueLevelDIO() : LeagueLevelDIO
      {
         return _leagueLevelDIO;
      }
   }
}

