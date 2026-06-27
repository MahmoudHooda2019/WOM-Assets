package wom.view.screen.windows.league.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.league.LeagueMemberInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.alliance.coa.mobile.MobileCoatOfArmsView;
   import wom.view.screen.windows.rank.MobileRankView;
   
   public class MobileLeagueMemberRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private static const WIDTH:int = 948;
      
      private static const HEIGHT:int = 96;
      
      public var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var backgroundAssetId:String;
      
      private var rankView:MobileRankView;
      
      private var avatar:DisplayObject;
      
      private var starIcon:DisplayObject;
      
      private var levelTF:MPTextField;
      
      private var coatOfArmsView:MobileCoatOfArmsView = null;
      
      private var nameTextField:MPTextField;
      
      private var allianceNameTextField:MPTextField = null;
      
      private var numberOfWinsAsAttackerTextField:MPTextField;
      
      private var numberOfWinsAsDefenderTextField:MPTextField;
      
      private var _battlePointsIcon:DisplayObject;
      
      private var battlePointsTextField:MPTextField;
      
      private var _member:LeagueMemberInfo;
      
      private var _headerWidths:Dictionary;
      
      private var _ownUserId:String;
      
      public function MobileLeagueMemberRenderer(param1:MobileWomAssetRepository, param2:Dictionary, param3:String)
      {
         super();
         _headerWidths = param2;
         _ownUserId = param3;
         this.assetRepository = param1;
         drawBackground();
         rankView = new MobileRankView(param1);
         addChild(rankView);
         starIcon = param1.getDisplayObject("IconLevelM");
         starIcon.scaleX = starIcon.scaleY = 36 / starIcon.height;
         addChild(starIcon);
         levelTF = new MobileWomTextField();
         levelTF.textRendererProperties.textFormat = getCaptionTextFormat(27,"center");
         levelTF.width = starIcon.width;
         addChild(levelTF);
         nameTextField = new MobileWomTextField();
         nameTextField.textRendererProperties.textFormat = getCaptionTextFormat(30);
         addChild(nameTextField);
         coatOfArmsView = new MobileCoatOfArmsView(param1);
         addChild(coatOfArmsView);
         allianceNameTextField = new MobileWomTextField();
         allianceNameTextField.textRendererProperties.textFormat = getWomTextFormat(25);
         allianceNameTextField.visible = false;
         addChild(allianceNameTextField);
         numberOfWinsAsAttackerTextField = new MobileWomTextField();
         numberOfWinsAsAttackerTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         addChild(numberOfWinsAsAttackerTextField);
         numberOfWinsAsDefenderTextField = new MobileWomTextField();
         numberOfWinsAsDefenderTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         addChild(numberOfWinsAsDefenderTextField);
         _battlePointsIcon = param1.getDisplayObject("IconBPS");
         addChild(_battlePointsIcon);
         battlePointsTextField = new MobileWomTextField();
         battlePointsTextField.textRendererProperties.textFormat = getCaptionTextFormat(30);
         addChild(battlePointsTextField);
      }
      
      private function drawBackground() : void
      {
         var _loc1_:String = _member == null ? "MobileBeigeBackground" : (_member.rank == 1 ? "MobileYellowBackground" : (_member.rank == 2 ? "MobileGrayBackground" : (_member.rank == 3 ? "MobileBrownBackground" : (_member.profile.gameId == _ownUserId ? "MobileGreenBackground" : "MobileBeigeBackground"))));
         var _loc2_:Boolean = false;
         if(background != null)
         {
            if(backgroundAssetId != _loc1_ && contains(background))
            {
               removeChild(background);
               _loc2_ = true;
            }
         }
         else
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            background = assetRepository.getDisplayObject(_loc1_);
            background.width = 948;
            background.height = 96;
            addChildAt(background,0);
            backgroundAssetId = _loc1_;
         }
      }
      
      public function drawLayout() : void
      {
         var _loc2_:int = 2;
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(rankView,background,3);
         _loc2_ += _headerWidths["rank"] + 1;
         if(avatar)
         {
            levelTF.validate();
            MobileAlignmentUtil.alignAccordingToPositionOf(avatar,background,114,13);
            MobileAlignmentUtil.alignAccordingToPositionOf(starIcon,avatar,-12,-12);
            MobileAlignmentUtil.alignMiddleOf(levelTF,starIcon);
            levelTF.x -= 3;
            levelTF.y += 5;
            _loc2_ += _headerWidths["level"] + 1;
         }
         if(coatOfArmsView != null && coatOfArmsView.visible)
         {
            if(coatOfArmsView.height != 71)
            {
               coatOfArmsView.scaleX = coatOfArmsView.scaleY = 71 / coatOfArmsView.height;
            }
            coatOfArmsView.x = (_headerWidths["alliance"] - coatOfArmsView.width >> 1) + _loc2_;
            coatOfArmsView.y = 96 - coatOfArmsView.height >> 1;
         }
         _loc2_ += _headerWidths["alliance"] + 1;
         nameTextField.validate();
         if(allianceNameTextField != null && allianceNameTextField.visible)
         {
            nameTextField.x = _loc2_;
            nameTextField.y = 15;
            allianceNameTextField.validate();
            MobileAlignmentUtil.alignBelowOf(allianceNameTextField,nameTextField,0);
         }
         else
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(nameTextField,background,_loc2_);
         }
         _loc2_ += _headerWidths["name"] + 1;
         numberOfWinsAsAttackerTextField.validate();
         numberOfWinsAsDefenderTextField.validate();
         numberOfWinsAsAttackerTextField.x = 8 + _loc2_;
         numberOfWinsAsAttackerTextField.y = 96 - (numberOfWinsAsAttackerTextField.height + numberOfWinsAsDefenderTextField.height + 3) >> 1;
         MobileAlignmentUtil.alignBelowOf(numberOfWinsAsDefenderTextField,numberOfWinsAsAttackerTextField,3);
         _loc2_ += _headerWidths["history"] + 1;
         battlePointsTextField.validate();
         var _loc1_:int = _headerWidths["battle_points"] - battlePointsTextField.width - 25 >> 1;
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_battlePointsIcon,background,_loc2_ + _loc1_ - 5);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(battlePointsTextField,background,_loc2_ + _loc1_ + 20);
         battlePointsTextField.y += 3;
      }
      
      override public function set data(param1:Object) : void
      {
         coatOfArmsView.visible = false;
         allianceNameTextField.visible = false;
         if(param1)
         {
            _member = param1 as LeagueMemberInfo;
            drawBackground();
            levelTF.text = String(_member.level);
            rankView.updateWithRankInfo(_member.rank);
            updateAvatar();
            updateAllianceRelatedFields();
            nameTextField.text = _member.name;
            var _temp_3:* = numberOfWinsAsAttackerTextField;
            var _temp_2:* = "ui.windows.league.attackswon";
            var _loc2_:int = _member.numberOfWinsAsAttacker;
            var _loc3_:String = _temp_2;
            _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
            var _temp_5:* = numberOfWinsAsDefenderTextField;
            var _temp_4:* = "ui.windows.league.defenceswon";
            var _loc4_:int = _member.numberOfWinsAsDefender;
            var _loc5_:String = _temp_4;
            _temp_5.text = peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_);
            battlePointsTextField.text = String(_member.battlePoints);
            drawLayout();
         }
      }
      
      private function updateAvatar() : void
      {
         if(avatar && contains(avatar))
         {
            removeChild(avatar);
         }
         avatar = assetRepository.getAvatarByProfile(_member.profile);
         addChildAt(avatar,1);
      }
      
      private function updateAllianceRelatedFields() : void
      {
         if(_member.allianceSummary != null)
         {
            coatOfArmsView.visible = true;
            coatOfArmsView.updateWithCoatOfArmsInfo(_member.allianceSummary.coaInfo);
            allianceNameTextField.visible = true;
            allianceNameTextField.text = _member.allianceSummary.name;
         }
      }
      
      override public function get data() : Object
      {
         return _member;
      }
   }
}

