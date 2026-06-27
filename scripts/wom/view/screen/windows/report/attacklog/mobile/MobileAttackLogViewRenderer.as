package wom.view.screen.windows.report.attacklog.mobile
{
   import feathers.controls.Button;
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.component.enum.ELOStarType;
   import wom.model.game.Profile;
   import wom.model.game.TutorialDefender;
   import wom.model.game.report.MobileAttackLog;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.ui.mainframe.combat.MobileBattlePointsSmallStarView;
   
   public class MobileAttackLogViewRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private static const WIDTH:int = 971;
      
      private static const HEIGHT:int = 114;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var _width:int;
      
      private var _height:int;
      
      private var background:DisplayObject;
      
      private var _opponentAvatar:DisplayObject;
      
      private var starIcon:DisplayObject;
      
      private var levelTF:MPTextField;
      
      private var attackInfoTF:MPTextField;
      
      private var timeOfAttackTextField:MPTextField;
      
      private var starViews:Vector.<MobileBattlePointsSmallStarView>;
      
      private var battlePointsTextField:MPTextField;
      
      private var _enterCityButton:Button;
      
      private var _reportButton:Button;
      
      private var _attackLog:MobileAttackLog;
      
      private var _opponent:Profile;
      
      private var _attackerIsMe:Boolean;
      
      public function MobileAttackLogViewRenderer(param1:MobileWomAssetRepository, param2:Boolean, param3:int = 971, param4:int = 114)
      {
         super();
         this.assetRepository = param1;
         _attackerIsMe = param2;
         _width = param3;
         _height = param4;
         background = param1.getDisplayObject("MobileBeigeBackground");
         background.width = _width;
         background.height = _height;
         addChild(background);
         starIcon = param1.getDisplayObject("IconLevelM");
         starIcon.scaleX = starIcon.scaleY = 36 / starIcon.height;
         addChild(starIcon);
         levelTF = new MPTextField();
         levelTF.textRendererProperties.textFormat = getCaptionTextFormat(27,"center");
         levelTF.width = starIcon.width;
         addChild(levelTF);
         attackInfoTF = new MPTextField();
         attackInfoTF.textRendererProperties.textFormat = getCaptionTextFormat(23);
         attackInfoTF.textRendererProperties.wordWrap = true;
         attackInfoTF.width = 275;
         addChild(attackInfoTF);
         starViews = new Vector.<MobileBattlePointsSmallStarView>(3,true);
         battlePointsTextField = new MPTextField();
         battlePointsTextField.textRendererProperties.textFormat = getCaptionTextFormat(23,"center");
         battlePointsTextField.width = 125;
         addChild(battlePointsTextField);
         timeOfAttackTextField = new MobileWomTextField();
         timeOfAttackTextField.textRendererProperties.textFormat = getWomTextFormat(19,"center");
         addChild(timeOfAttackTextField);
         _enterCityButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         var _temp_13:* = _enterCityButton;
         var _loc6_:String = "ui.windows.attacklog." + (_attackerIsMe ? "reattack" : "retaliate");
         _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _enterCityButton.width = 150;
         addChild(_enterCityButton);
         _reportButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         var _temp_15:* = _reportButton;
         var _loc7_:String = "ui.windows.attacklog.report";
         _temp_15.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         _reportButton.width = 150;
         addChild(_reportButton);
      }
      
      override public function get data() : Object
      {
         return _attackLog;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:String = null;
         if(param1)
         {
            _attackLog = param1 as MobileAttackLog;
            _loc2_ = DateTimeUtil.getFormattedTimeAndDateFromMilliseconds(_attackLog.attackStartInMillis,"/",":"," ");
            _loc2_ = _loc2_.substr(0,_loc2_.length - 3);
            timeOfAttackTextField.text = _loc2_;
            _opponent = _attackerIsMe ? _attackLog.defender : _attackLog.attacker;
            updateOpponentAvatar();
            starIcon.visible = (_opponent.npcClan == "NPC-6" || !_opponent.isNpc) && (_attackerIsMe ? _attackLog.defenderLevel != -1 : _attackLog.attackerLevel != -1);
            levelTF.text = _attackerIsMe ? _attackLog.defenderLevel.toString() : _attackLog.attackerLevel.toString();
            levelTF.visible = starIcon.visible;
            updateInfoText();
            updateStarViewsAndBattlePoints();
            _enterCityButton.visible = !(_attackerIsMe && (_attackLog.isQuickAttack || _attackLog.npcDefeated)) && !checkOpponentIsTutorialDefender();
            drawLayout();
         }
      }
      
      private function updateOpponentAvatar() : void
      {
         if(_opponentAvatar && contains(_opponentAvatar))
         {
            removeChild(_opponentAvatar);
         }
         if(_opponent)
         {
            _opponentAvatar = assetRepository.getAvatarByProfile(_opponent);
            addChildAt(_opponentAvatar,getChildIndex(starIcon));
         }
      }
      
      private function updateStarViewsAndBattlePoints() : void
      {
         var _loc5_:int = 0;
         var _loc3_:ELOStarType = null;
         var _loc4_:MobileBattlePointsSmallStarView = null;
         var _loc1_:int = int(_attackerIsMe ? _attackLog.star : 0 - _attackLog.star);
         if(_loc1_ == 1 && _opponent.isNpc)
         {
            _loc1_ = 2;
         }
         var _loc2_:int = int(_attackerIsMe ? _attackLog.battlePointDifference : 0 - _attackLog.battlePointDifference);
         battlePointsTextField.textRendererProperties.textFormat = getCaptionTextFormat(23,"center",_loc1_ > 0 ? 16777215 : 15016227);
         battlePointsTextField.text = _loc2_ > 0 ? "+" + _loc2_ : _loc2_.toString();
         battlePointsTextField.visible = _loc2_ != 0 || !_opponent.isNpc;
         clearStarsViews();
         _loc5_ = 0;
         while(_loc5_ < starViews.length)
         {
            _loc3_ = _loc1_ > _loc5_ ? ELOStarType.POSITIVE : ELOStarType.EMPTY;
            _loc4_ = new MobileBattlePointsSmallStarView(assetRepository.getDisplayObject(_loc3_.mobileSmallAssetName),_loc3_);
            addChild(_loc4_);
            starViews[_loc5_] = _loc4_;
            _loc5_++;
         }
         starViews[0].visible = starViews[2].visible = !_opponent.isNpc;
      }
      
      private function clearStarsViews() : void
      {
         for each(var _loc1_ in starViews)
         {
            if(_loc1_ && contains(_loc1_))
            {
               removeChild(_loc1_);
            }
         }
      }
      
      private function checkOpponentIsTutorialDefender() : Boolean
      {
         return _opponent.isNpc && _opponent.npcId == TutorialDefender.PROFILE.npcId;
      }
      
      public function drawLayout() : void
      {
         var _loc5_:int = 0;
         levelTF.validate();
         attackInfoTF.validate();
         battlePointsTextField.validate();
         timeOfAttackTextField.validate();
         _enterCityButton.paddingLeft = 0;
         _enterCityButton.validate();
         _reportButton.paddingLeft = 0;
         _reportButton.validate();
         if(_opponentAvatar)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_opponentAvatar,background,30,19);
            MobileAlignmentUtil.alignAccordingToPositionOf(starIcon,_opponentAvatar,-12,-12);
            MobileAlignmentUtil.alignMiddleOf(levelTF,starIcon);
            levelTF.x -= 3;
            levelTF.y += 5;
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(attackInfoTF,background,128,32);
         MobileAlignmentUtil.alignAccordingToPositionOf(timeOfAttackTextField,background,128,62);
         var _loc4_:int = (starViews.length > 0 ? starViews[0].height : 0) + battlePointsTextField.height + 3;
         var _loc3_:Number = background.height - _loc4_ >> 1;
         var _loc1_:Number = 454 + (122 - 3 * starViews[0].width >> 1);
         var _loc2_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < starViews.length)
         {
            starViews[_loc5_].x = _loc1_ + _loc5_ * (starViews[_loc5_].width + 1);
            starViews[_loc5_].y = _loc3_;
            _loc2_ += starViews[_loc5_].width;
            _loc5_++;
         }
         MobileAlignmentUtil.alignBelowOf(battlePointsTextField,starViews[0],3);
         battlePointsTextField.x = starViews[0].x + (_loc2_ >> 1) - (battlePointsTextField.width >> 1) - 2;
         MobileAlignmentUtil.alignAccordingToPositionOf(_enterCityButton,background,641,22);
         MobileAlignmentUtil.alignRightOf(_reportButton,_enterCityButton,10);
      }
      
      public function updateInfoText() : void
      {
         var _temp_1:*;
         var _temp_2:*;
         var _loc1_:String;
         var _loc2_:String;
         var _loc3_:String;
         var _loc4_:String;
         attackInfoTF.text = _attackerIsMe ? (_temp_1 = "m.ui.windows.inbox.attacktext",_loc1_ = _attackLog.defenderName,_loc2_ = _temp_1,peak.i18n.PText.INSTANCE.getText1(_loc2_,_loc1_)) : (_temp_2 = "m.ui.windows.inbox.defendtext",_loc3_ = _attackLog.attackerName,_loc4_ = _temp_2,peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_));
      }
      
      public function get enterCityButton() : Button
      {
         return _enterCityButton;
      }
      
      public function get reportButton() : Button
      {
         return _reportButton;
      }
      
      public function get opponent() : Profile
      {
         return _opponent;
      }
      
      public function get attackLog() : MobileAttackLog
      {
         return _attackLog;
      }
   }
}

