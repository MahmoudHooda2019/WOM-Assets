package wom.view.screen.popups.league
{
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.league.LeagueBonusAndRewardDTO;
   import wom.view.screen.windows.league.LeagueBonusAndRewardPanel;
   
   public class LeagueSeasonEndedSuccessPopUp extends LeagueSeasonEndedPopUp
   {
      
      private var _reward:int;
      
      private var _rewardPanel:LeagueBonusAndRewardPanel;
      
      private var _rpReward:Boolean;
      
      public function LeagueSeasonEndedSuccessPopUp(param1:Number, param2:int, param3:Number, param4:int, param5:Boolean)
      {
         super(param1,param2,param3);
         _reward = param4;
         _rpReward = param5;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:Vector.<LeagueBonusAndRewardDTO> = new Vector.<LeagueBonusAndRewardDTO>();
         _loc1_.push(new LeagueBonusAndRewardDTO(_rpReward ? "Rp" : "Gold27",null,String(_reward)));
         _rewardPanel = new LeagueBonusAndRewardPanel(null,false,_loc1_,true);
         addChild(_rewardPanel);
         drawLayout();
      }
      
      override protected function getHeader() : String
      {
         var _loc1_:String = "ui.windows.league.ended.success.header";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      override protected function getBackgroundAssetId() : String
      {
         return "SeasonEndWin";
      }
      
      override protected function getOkButtonLabel() : String
      {
         var _loc1_:String = "ui.windows.league.ended.success.done";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         if(_rewardPanel)
         {
            AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_rewardPanel,_background,_background.height - _rewardPanel.height - 35);
            AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(descTextField,_rewardPanel,-descTextField.height);
         }
      }
   }
}

