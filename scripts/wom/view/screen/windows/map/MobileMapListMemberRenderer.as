package wom.view.screen.windows.map
{
   import feathers.controls.Button;
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.dto.MapMemberInfo;
   import wom.model.game.Profile;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.alliance.coa.mobile.MobileCoatOfArmsView;
   import wom.view.ui.common.MobileIconLabelViewExtra;
   
   public class MobileMapListMemberRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private static const WIDTH:int = 999;
      
      private static const HEIGHT:int = 96;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var _mapMemberInfo:MapMemberInfo;
      
      private var background:DisplayObject;
      
      private var avatar:DisplayObject;
      
      private var levelIndicator:DisplayObject;
      
      private var levelTF:MPTextField;
      
      private var _coatOfArmsView:MobileCoatOfArmsView;
      
      private var _nameTextField:MPTextField;
      
      private var _allianceNameTextField:MPTextField;
      
      private var bpView:MobileIconLabelViewExtra;
      
      private var historyTextField:MPTextField;
      
      private var diplomacyTextField:MPTextField;
      
      private var _enterButton:Button;
      
      public function MobileMapListMemberRenderer(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         determineBackground();
         levelIndicator = param1.getDisplayObject("IconLevelM");
         levelIndicator.scaleX = levelIndicator.scaleY = 36 / levelIndicator.height;
         addChild(levelIndicator);
         levelTF = new MobileCaptionTextField();
         levelTF.textRendererProperties.textFormat = getCaptionTextFormat(27,"center");
         levelTF.width = levelIndicator.width;
         addChild(levelTF);
         _nameTextField = new MobileCaptionTextField();
         _nameTextField.width = 237;
         _nameTextField.textRendererProperties.textFormat = getCaptionTextFormat(27);
         _nameTextField.textRendererProperties.wordWrap = true;
         addChild(_nameTextField);
         _allianceNameTextField = new MobileWomTextField();
         _allianceNameTextField.width = 237;
         _allianceNameTextField.textRendererProperties.textFormat = getWomTextFormat(27);
         _allianceNameTextField.textRendererProperties.wordWrap = true;
         addChild(_allianceNameTextField);
         bpView = new MobileIconLabelViewExtra("IconBPM","");
         bpView.iconAlign = "left";
         bpView.textAlign = "left";
         bpView.textSize = 25;
         bpView.textMarginFromIconX = 39;
         bpView.textMarginFromIconY = 16;
         addChild(bpView);
         historyTextField = new MobileWomTextField();
         historyTextField.textRendererProperties.textFormat = getWomTextFormat(23,"center");
         historyTextField.width = 118;
         historyTextField.textRendererProperties.wordWrap = true;
         addChild(historyTextField);
         diplomacyTextField = new MobileWomTextField();
         diplomacyTextField.textRendererProperties.textFormat = getCaptionTextFormat(23,"center");
         diplomacyTextField.width = 143;
         addChild(diplomacyTextField);
         _enterButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _enterButton.width = 129;
         var _temp_10:* = _enterButton;
         var _loc3_:String = "ui.mainframe.city.friend.enter";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_enterButton);
      }
      
      override public function get data() : Object
      {
         return _mapMemberInfo;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _mapMemberInfo = param1 as MapMemberInfo;
            determineBackground();
            if(avatar && contains(avatar))
            {
               removeChild(avatar);
               avatar = null;
            }
            avatar = assetRepository.getAvatarByProfile(_mapMemberInfo.profileAccordingToTutorial ? _mapMemberInfo.profileAccordingToTutorial : _mapMemberInfo.profile);
            addChildAt(avatar,1);
            if(_mapMemberInfo.alliance)
            {
               if(!_coatOfArmsView)
               {
                  _coatOfArmsView = new MobileCoatOfArmsView(assetRepository);
               }
               _coatOfArmsView.visible = true;
               _coatOfArmsView.updateWithCoatOfArmsInfo(_mapMemberInfo.alliance.coaInfo);
               if(!contains(_coatOfArmsView))
               {
                  addChild(_coatOfArmsView);
               }
               if(_coatOfArmsView.height != 70)
               {
                  _coatOfArmsView.scaleX = _coatOfArmsView.scaleY = 70 / _coatOfArmsView.height;
               }
            }
            else if(_coatOfArmsView)
            {
               _coatOfArmsView.visible = false;
            }
            levelTF.text = "" + (_mapMemberInfo.profileAccordingToTutorial ? 1 : _mapMemberInfo.level);
            updateName();
            _allianceNameTextField.text = _mapMemberInfo.alliance != null ? _mapMemberInfo.alliance.name : "";
            historyTextField.text = _mapMemberInfo.numberOfWins + "/" + _mapMemberInfo.numberOfBattles;
            bpView.visible = !_mapMemberInfo.isEventNpc;
            historyTextField.visible = !_mapMemberInfo.isEventNpc;
            bpView.label = (_mapMemberInfo.profileAccordingToTutorial ? 0 : _mapMemberInfo.battlePoints) + "";
            setDiplomacyText();
         }
         drawLayout();
      }
      
      private function determineBackground() : void
      {
         if(background && contains(background))
         {
            removeChild(background);
         }
         background = assetRepository.getDisplayObject(determineBackgroundAsset());
         background.width = 999;
         background.height = 96;
         addChildAt(background,0);
      }
      
      private function determineBackgroundAsset() : String
      {
         return _mapMemberInfo == null ? "MobileBeigeBackground" : (_mapMemberInfo.isEventNpc ? "MobileYellowBackground" : (_mapMemberInfo.isRevanchist ? "MobileRedBackground" : (_mapMemberInfo.isAllianceEnemy ? "MobileRedBackground" : (_mapMemberInfo.isFriend ? "MobileGreenBackground" : "MobileBeigeBackground"))));
      }
      
      public function updateName() : void
      {
         _nameTextField.text = _mapMemberInfo.visibleName;
      }
      
      private function setDiplomacyText() : void
      {
         var _loc1_:int = 0;
         var _loc3_:String = "ui.windows.map.neutral";
         var _loc2_:String = peak.i18n.PText.INSTANCE.getText0(_loc3_) + " ";
         if(_mapMemberInfo.playerRelation == 8)
         {
            _loc1_ = 255;
            var _loc4_:String = "ui.windows.map.wipedout";
            _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc4_) + " ";
         }
         else if(_mapMemberInfo.playerRelation == 2)
         {
            if(_mapMemberInfo.isRevanchist)
            {
               _loc1_ = 16711680;
               var _loc5_:String = "ui.windows.map.revanchist";
               _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc5_) + " ";
            }
            else if(_mapMemberInfo.isAllianceEnemy)
            {
               _loc1_ = 16711680;
               var _loc6_:String = "ui.windows.map.allianceenemy";
               _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc6_) + " ";
            }
            else
            {
               _loc1_ = 16711680;
               var _loc7_:String = "ui.windows.map.hostile";
               _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc7_) + " ";
            }
         }
         else if(_mapMemberInfo.playerRelation == 6)
         {
            _loc1_ = 255;
            var _loc8_:String = "ui.windows.map.leveltoolow";
            _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc8_) + " ";
         }
         else if(_mapMemberInfo.playerRelation == 10)
         {
            _loc1_ = 255;
            var _loc9_:String = "ui.windows.map.leveltoohigh";
            _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc9_) + " ";
         }
         else if(_mapMemberInfo.playerRelation == 7)
         {
            _loc1_ = 255;
            var _loc10_:String = "ui.windows.map.underprotection";
            _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc10_) + " ";
         }
         else if(_mapMemberInfo.playerRelation == 9)
         {
            _loc1_ = 255;
            var _loc11_:String = "ui.windows.map.ally";
            _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc11_) + " ";
         }
         else if(_mapMemberInfo.isRevanchist)
         {
            _loc1_ = 16711680;
            var _loc12_:String = "ui.windows.map.revanchist";
            _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc12_) + " ";
         }
         else if(_mapMemberInfo.isAllianceEnemy)
         {
            _loc1_ = 16711680;
            var _loc13_:String = "ui.windows.map.allianceenemy";
            _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc13_) + " ";
         }
         diplomacyTextField.text = _loc2_;
         diplomacyTextField.textRendererProperties.textFormat = getWomTextFormat(23,"center",_loc1_);
      }
      
      public function drawLayout() : void
      {
         levelTF.validate();
         _nameTextField.validate();
         diplomacyTextField.validate();
         historyTextField.validate();
         _enterButton.paddingLeft = 0;
         _enterButton.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(avatar,background,13,11);
         MobileAlignmentUtil.alignAccordingToPositionOf(levelIndicator,avatar,-10,-11);
         MobileAlignmentUtil.alignMiddleOf(levelTF,levelIndicator);
         levelTF.x -= 3;
         levelTF.y += 5;
         if(_coatOfArmsView)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_coatOfArmsView,background,93,8);
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(_nameTextField,background,172,22);
         MobileAlignmentUtil.alignAccordingToPositionOf(_allianceNameTextField,background,172,49);
         MobileAlignmentUtil.alignAccordingToPositionOf(bpView,background,412 + (120 - bpView.width >> 1),18);
         diplomacyTextField.x = 381;
         MobileAlignmentUtil.alignAccordingToPositionOf(historyTextField,background,530,32);
         MobileAlignmentUtil.alignAccordingToPositionOf(diplomacyTextField,background,649,32);
         MobileAlignmentUtil.alignAccordingToPositionOf(_enterButton,background,854,14);
      }
      
      public function get enterButton() : Button
      {
         return _enterButton;
      }
      
      public function get mapMemberInfo() : MapMemberInfo
      {
         return _mapMemberInfo;
      }
   }
}

